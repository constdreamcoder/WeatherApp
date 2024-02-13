//
//  SearchResultTableViewCell.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/12/24.
//

import UIKit
import SnapKit

final class SearchResultTableViewCell: UITableViewCell {
    
    let poundKeyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "number")
        imageView.tintColor = .white
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Heunghae"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18.0)
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.text = "KR"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 18.0)
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
    
    func doSomething(with keyword: String) {
        let nameAttributedString = NSMutableAttributedString(string: nameLabel.text ?? "")
        let countryAttributedString = NSMutableAttributedString(string: countryLabel.text ?? "")
        
        nameAttributedString.addAttribute(.foregroundColor, value: UIColor.yellow, range: ((nameLabel.text?.lowercased() ?? "") as NSString).range(of: keyword))
        countryAttributedString.addAttribute(.foregroundColor, value: UIColor.yellow, range: ((countryLabel.text?.lowercased() ?? "") as NSString).range(of: keyword))
        
        nameLabel.attributedText = nameAttributedString
        countryLabel.attributedText = countryAttributedString
    }
}

extension SearchResultTableViewCell:  UITableViewCellConfigurationProtocol {
    func configureTableViewCellConstraints() {
        [
            poundKeyImageView,
            nameLabel,
            countryLabel
        ].forEach { contentView.addSubview($0) }
        
        
        poundKeyImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.size.equalTo(20.0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16.0)
            $0.leading.equalTo(poundKeyImageView.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        countryLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nameLabel)
            $0.bottom.equalToSuperview().inset(8.0)
        }
    }
    
    func configureTableViewCellUI() {
        contentView.backgroundColor = .black
    }
}

