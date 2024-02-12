//
//  ForthSectionTableViewCell.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/12/24.
//

import UIKit
import SnapKit
import CoreLocation
import MapKit

final class ForthSectionTableViewCell: UITableViewCell {
    
    let containerView = CellContainerBaseView()
    
    let titleStackView: TitleBaseStackView = {
        let stackView = TitleBaseStackView()
        stackView.titleIconImageView.image = UIImage(systemName: "thermometer.medium")
        stackView.titleLabel.text = "위치"
        return stackView
    }()
        
    let mapView = MKMapView()

    let separatorView = SeparatorView()
    
    let locationManager = CLLocationManager()
    
    var mainVCInstance: MainViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureTableViewCellConstraints()
        configureTableViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ForthSectionTableViewCell: UITableViewCellConfigurationProtocol {
    func configureTableViewCellConstraints() {
        
        [
            titleStackView,
            mapView
        ].forEach { containerView.addSubview($0) }
        
        [
            containerView,
            separatorView
        ].forEach { contentView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(8.0)
            $0.horizontalEdges.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(16.0)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func configureTableViewCellUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        locationManager.delegate = self
    }
}

extension ForthSectionTableViewCell {
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
                
            } else {
                print("위치 서비스가 꺼져 있어서, 위치 권한 요청을 할 수 없어요.")
            }
        }
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            self.showLocationSettingAlert()
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default:
            print("Error")
        }
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기 '설정>개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            } else {
                print("설정으로 가주세여~~~~~!!")
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        mainVCInstance?.present(alert, animated: true, completion: nil)
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: 650_000,
            longitudinalMeters: 650_000
        )
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "내 위치"
        
        mapView.addAnnotation(annotation)
    }
}

extension ForthSectionTableViewCell: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            print(coordinate.latitude)
            print(coordinate.longitude)
            
            setRegionAndAnnotation(center: coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치를 가져오지 못하였습니다. \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }
}
