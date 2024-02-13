//
//  TodayWeatherConditionsTableViewCell.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/11/24.
//

import UIKit
import SnapKit

final class FifthSectionTableViewCell: UITableViewCell {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(TodayWeatherConditionsCollectionViewCell.self, forCellWithReuseIdentifier: TodayWeatherConditionsCollectionViewCell.identifier)
        
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    let separatorView = SeparatorView()
    
    var fifthSectionViewModel: FifthSectionViewModel? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let weatherConditionIconList: [String] = ["wind", "drop.fill", "thermometer.medium", "humidity"]
    
    private let weatherConditionTitleList: [String] = ["바람 속도", "구름", "기압", "습도"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureTableViewCellConstraints()
        configureTableViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FifthSectionTableViewCell: UITableViewCellConfigurationProtocol {
    func configureTableViewCellConstraints() {
        contentView.addSubview(collectionView)
        contentView.addSubview(separatorView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func configureTableViewCellUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
}

extension FifthSectionTableViewCell: UICollectionViewConfigurationProtocol {
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        
        let spacing: CGFloat = 16
        
        let layout = UICollectionViewFlowLayout()
        let itemSize = (UIScreen.main.bounds.width - 32) - spacing
        layout.itemSize = CGSize(width: itemSize / 2, height: (itemSize / 2))
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return layout
    }
}

extension FifthSectionTableViewCell: UICollectionViewDelegate {
    
}

extension FifthSectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherConditionIconList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayWeatherConditionsCollectionViewCell.identifier, for: indexPath) as? TodayWeatherConditionsCollectionViewCell else { return UICollectionViewCell() }
    
        cell.topContainerStackView.titleIconImageView.image = UIImage(systemName: weatherConditionIconList[indexPath.item])
            cell.topContainerStackView.titleIconImageView.tintColor = .lightGray
        cell.topContainerStackView.titleLabel.text = weatherConditionTitleList[indexPath.item]
            cell.topContainerStackView.titleLabel.textColor = .lightGray
        
        guard let fifthSectionViewModel = fifthSectionViewModel else { return UICollectionViewCell() }
        cell.bottomLabel.isHidden = true
        if weatherConditionTitleList[indexPath.item] == "바람 속도" {
            cell.valueLabel.text = "\(fifthSectionViewModel.windSpeed.convertToStringWithTheSecondDecimalPlace)m/s"
            if fifthSectionViewModel.windGust != 0 {
                cell.bottomLabel.isHidden = false
                cell.bottomLabel.text = "강풍: \(fifthSectionViewModel.windGust)m/s"
            }
        } else if weatherConditionTitleList[indexPath.item] == "구름" {
            cell.valueLabel.text = "\(fifthSectionViewModel.cloudiness)%"
        } else if weatherConditionTitleList[indexPath.item] == "기압" {
            cell.valueLabel.text = "\(fifthSectionViewModel.pressure)hpa"
        } else if weatherConditionTitleList[indexPath.item] == "습도" {
            cell.valueLabel.text = "\(fifthSectionViewModel.humidity)%"
        }
        return cell
    }
}
