//
//  WeatherForecastForTheNextFiveDaysTableViewCell.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/11/24.
//

import UIKit
import SnapKit

final class ThirdSectionTableViewCell: UITableViewCell {
    
    let containerView = CellContainerBaseView()
    
    let titleStackView: TitleBaseStackView = {
        let stackView = TitleBaseStackView()
        stackView.titleIconImageView.image = UIImage(systemName: "calendar")
        stackView.titleLabel.text = "5일 간의 일기 예보"
        return stackView
    }()
    
    let dividerView = DividerView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.register(WeatherForecastForTheNextFiveDaysTableViewCell.self, forCellReuseIdentifier: WeatherForecastForTheNextFiveDaysTableViewCell.identifier)
        
        tableView.rowHeight = 48
        tableView.backgroundColor = .clear
        
        return tableView
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

extension ThirdSectionTableViewCell: UITableViewCellConfigurationProtocol {
    func configureTableViewCellConstraints() {
        [
            titleStackView,
            dividerView,
            tableView
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
            $0.top.equalTo(titleStackView.snp.bottom).offset(8.0)
            $0.horizontalEdges.equalToSuperview().inset(16.0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16.0)
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

extension ThirdSectionTableViewCell: UITableViewConfigurationProtocol {
    func configureTableView() {
        
    }
}

extension ThirdSectionTableViewCell: UITableViewDelegate {
    
}

extension ThirdSectionTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherForecastForTheNextFiveDaysTableViewCell.identifier, for: indexPath) as? WeatherForecastForTheNextFiveDaysTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
}
