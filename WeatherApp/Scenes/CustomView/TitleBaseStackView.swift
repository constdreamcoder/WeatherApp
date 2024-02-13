//
//  TitleBaseView.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/12/24.
//

import UIKit
import SnapKit

final class TitleBaseStackView: UIStackView {
    
    let titleIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wind")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16.0)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        [
            titleIconImageView,
            titleLabel
        ].forEach { addArrangedSubview($0) }
        
        titleIconImageView.snp.makeConstraints {
            $0.size.equalTo(22.0)
        }
    }
    
    private func configureUI() {
        axis = .horizontal
        spacing = 4.0
        distribution = .fillProportionally
        alignment = .leading
        backgroundColor = .gray
    }
}
