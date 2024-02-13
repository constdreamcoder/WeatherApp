//
//  MainTableHeaderView.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/9/24.
//

import UIKit
import SnapKit

final class MainTableHeaderView: UITableViewCell {
    
    lazy var currentWeatherInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2.0
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        [
            cityNameLabel,
            currentTemperatureLabel,
            currentWeatherConditionLabel,
            highLowTemperatureOfTodayLabel
        ].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    let cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jeju City"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 36.0)
        return label
    }()
    
    let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "5.9°"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 96.0, weight: .thin)
        return label
    }()
    
    let currentWeatherConditionLabel: UILabel = {
        let label = UILabel()
        label.text = "Broken Clouds"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20.0)
        return label
    }()
    
    let highLowTemperatureOfTodayLabel: UILabel = {
        let label = UILabel()
        label.text = "최고: 7.0°  |  최저: -4.2°"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22.0)
        return label
    }()
    
    var firstSectionViewModel: FirstSectionViewModel? {
        willSet {
            guard let newValue = newValue else { return }
            cityNameLabel.text = newValue.cityName
            currentTemperatureLabel.text = newValue.curremtTemp.convertToStringWithTheFirstDecimalPlace + "°"
            currentWeatherConditionLabel.text = newValue.weatherDes
            highLowTemperatureOfTodayLabel.text = "최고: \(newValue.highestTemp.convertToStringWithTheFirstDecimalPlace)°  |  최저: \(newValue.lowestTemp.convertToStringWithTheFirstDecimalPlace)°"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureConstraints()
        configureOthers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        contentView.addSubview(currentWeatherInfoStackView)
        
        currentWeatherInfoStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40.0)
            $0.bottom.equalToSuperview().inset(50.0)
            $0.centerX.equalToSuperview()
        }
        
        [
            cityNameLabel,
            currentTemperatureLabel,
            currentWeatherConditionLabel,
            highLowTemperatureOfTodayLabel
        ].forEach {
            $0.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
        
        currentTemperatureLabel.snp.makeConstraints {
            $0.height.equalTo(84.0)
        }
    }
    
    private func configureOthers() {
        contentView.backgroundColor = .gray
    }
}
