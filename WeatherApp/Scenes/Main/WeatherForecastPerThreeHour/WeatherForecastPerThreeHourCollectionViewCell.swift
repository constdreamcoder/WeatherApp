//
//  WeatherForecastPerThreeHourCollectionViewCell.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/9/24.
//

import UIKit
import SnapKit

final class WeatherForecastPerThreeHourCollectionViewCell: UICollectionViewCell {
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        [
            timeLabel,
            weatherForecastImageView,
            temperatureLabel
        ].forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12시"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()
    
    let weatherForecastImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "cloud.sun.rain.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "17°"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCollectionViewCellConstraints()
        configureCollectionViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherForecastPerThreeHourCollectionViewCell: UICollectionViewCellConfigurationProtocol {
    
    func configureCollectionViewCellConstraints() {
        contentView.addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16.0)
            $0.horizontalEdges.equalToSuperview()
        }
        
        weatherForecastImageView.snp.makeConstraints {
            $0.size.equalTo(36.0)
        }
    }
    
    func configureCollectionViewCellUI() {
        backgroundColor = .clear
    }
}
