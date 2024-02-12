//
//  TodayWeatherConditionsCollectionViewCell.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/11/24.
//

import UIKit
import SnapKit

final class TodayWeatherConditionsCollectionViewCell: UICollectionViewCell {
    
    let containerView = CellContainerBaseView()
    
    let topContainerStackView: TitleBaseStackView = {
        let stackView = TitleBaseStackView()
        stackView.titleIconImageView.image = UIImage(systemName: "wind")
        stackView.titleIconImageView.tintColor = .lightGray
        stackView.titleLabel.textColor = .lightGray
        return stackView
    }()
        
    let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "1.35m/s"
        label.textColor = .white
        label.font = .systemFont(ofSize: 36.0)
        return label
    }()
    
    // TODO: - 이름 다시 정의하기
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "강풍: 4.42m/s"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18.0)
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

extension TodayWeatherConditionsCollectionViewCell: UICollectionViewCellConfigurationProtocol {
    
    func configureCollectionViewCellConstraints() {
        [
            topContainerStackView,
            valueLabel,
            bottomLabel
        ].forEach { containerView.addSubview($0) }
        
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        topContainerStackView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16.0)
        }
        
        topContainerStackView.titleLabel.snp.makeConstraints {
            $0.width.equalTo(56.0)
        }
        
        valueLabel.snp.makeConstraints {
            $0.top.equalTo(topContainerStackView.snp.bottom).offset(8.0)
            $0.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        bottomLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(valueLabel)
            $0.bottom.equalToSuperview().inset(16.0)
        }
    }
    
    func configureCollectionViewCellUI() {
        backgroundColor = .clear
    }
}
