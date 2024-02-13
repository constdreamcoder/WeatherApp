//
//  ForthSectionTableViewCell.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/12/24.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

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
        
    var mainVCInstance: MainViewController?
    
    var selectedCity: CityViewModel? {
        didSet {
            let newSelectedCity = UserDefaults.standard.recentlySelectedCity
            setRegionAndAnnotation(
                center: .init(latitude: newSelectedCity.coord.lat,
                              longitude: newSelectedCity.coord.lon),
                title: newSelectedCity.name)
        }
    }
    
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
    }
}

extension ForthSectionTableViewCell {
    func setRegionAndAnnotation(center: CLLocationCoordinate2D, title: String) {
        mapView.removeAnnotations(mapView.annotations)
        
        let region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: 650_000,
            longitudinalMeters: 650_000
        )
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = title
        
        mapView.addAnnotation(annotation)        
    }
}
