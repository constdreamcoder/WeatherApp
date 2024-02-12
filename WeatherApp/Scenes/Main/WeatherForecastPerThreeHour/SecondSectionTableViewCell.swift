//
//  WeatherForecastPerThreeHourTableViewCell.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/9/24.
//

import UIKit
import SnapKit

final class SecondSectionTableViewCell: UITableViewCell {
    
    let containerView = CellContainerBaseView()
    
    let titleStackView: TitleBaseStackView = {
        let stackView = TitleBaseStackView()
        stackView.titleIconImageView.image = UIImage(systemName: "calendar")
        stackView.titleLabel.text = "3시간 간격의 일기예보"
        return stackView
    }()
    
    let dividerView = DividerView()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(WeatherForecastPerThreeHourCollectionViewCell.self, forCellWithReuseIdentifier: WeatherForecastPerThreeHourCollectionViewCell.identifier)
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    let separatorView = SeparatorView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureTableViewCellConstraints()
        configureTableViewCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SecondSectionTableViewCell: UITableViewCellConfigurationProtocol {
    func configureTableViewCellConstraints() {
        [
            titleStackView,
            dividerView,
            collectionView
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
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(16.0)
            $0.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(8.0)
            $0.horizontalEdges.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(8.0)
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

extension SecondSectionTableViewCell: UICollectionViewConfigurationProtocol {
    
    func configureCollectionViewLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 16
        
        let layout = UICollectionViewFlowLayout()
        let itemSize = (UIScreen.main.bounds.width - 32 - 32) - (spacing * 4)
        layout.itemSize = CGSize(width: itemSize / 5, height: 140)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}

extension SecondSectionTableViewCell: UICollectionViewDelegate {
    
}

extension SecondSectionTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherForecastPerThreeHourCollectionViewCell.identifier, for: indexPath) as? WeatherForecastPerThreeHourCollectionViewCell else { return UICollectionViewCell() }
                
        return cell
    }
}
