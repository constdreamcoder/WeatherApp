//
//  WeatherForecastForTheNextFiveDaysTableViewCell.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/11/24.
//

import UIKit
import SnapKit

final class WeatherForecastForTheNextFiveDaysTableViewCell: UITableViewCell {
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20.0)
        return label
    }()
    
    lazy var middleContainerView: UIView = {
        let view = UIView()
        [weatherConditionImageView, lowestTemperatureLabel].forEach { view.addSubview($0)}
        return view
    }()
    
    let weatherConditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.sun.rain")
        imageView.tintColor = .white
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let lowestTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "최저 -14°"
        label.textColor = .lightGray
        label.font  = .systemFont(ofSize: 20.0)
        return label
    }()
    
    let highestTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "최고 32°"
        label.textColor = .white
        label.font  = .systemFont(ofSize: 20.0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureTableViewCellConstraints()
        configureTableViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherForecastForTheNextFiveDaysTableViewCell: UITableViewCellConfigurationProtocol {
    func configureTableViewCellConstraints() {
        [
            dateLabel,
            weatherConditionImageView,
            lowestTemperatureLabel,
            highestTemperatureLabel
        ].forEach { contentView.addSubview($0) }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16.0)
            $0.width.equalTo(35.0)
        }
        
        weatherConditionImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20.0)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(28.0)
        }
        
        lowestTemperatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(weatherConditionImageView.snp.trailing).offset(16.0)
            $0.trailing.equalTo(highestTemperatureLabel.snp.leading).offset(-28.0)
        }
        
        highestTemperatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16.0)
            $0.width.equalTo(72.0)
        }
    }
    
    func configureTableViewCellUI() {
        backgroundColor = .clear
    }
}
