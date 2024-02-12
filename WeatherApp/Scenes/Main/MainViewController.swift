//
//  MainViewController.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/9/24.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    let tableView = UITableView()
    
    lazy var tabBarView: UIView = {
        let view = UIView()
        [mapButton, searchCityButton].forEach { view.addSubview($0) }
        return view
    }()
    
    let mapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "map")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    let searchCityButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "list.bullet")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureConstraints()
        configureUI()
        configureOthers()
        configureUserEvents()
        
        configureTableView()
    }
}

extension MainViewController {
    @objc func searchCityButtonTapped() {
        let searchCityVC = SearchCityViewController()
        navigationController?.pushViewController(searchCityVC, animated: true)
    }
}

extension MainViewController: UIViewControllerConfigurationProtocol {
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func configureConstraints() {
        [
            tableView,
            tabBarView
        ].forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tabBarView.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.height.equalTo(80.0)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
        
        mapButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.0)
            $0.leading.equalToSuperview().inset(16.0)
        }
        
        searchCityButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
    }
    
    func configureUI() {
        view.backgroundColor = .gray

        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tabBarView.backgroundColor = .darkGray
    }
    
    func configureOthers() {
    }
    
    func configureUserEvents() {
        searchCityButton.addTarget(self, action: #selector(searchCityButtonTapped), for: .touchUpInside)
    }
}

extension MainViewController: UITableViewConfigurationProtocol {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MainTableHeaderView.self, forCellReuseIdentifier: MainTableHeaderView.identifier)
        tableView.register(SecondSectionTableViewCell.self, forCellReuseIdentifier: SecondSectionTableViewCell.identifier)
        tableView.register(ThirdSectionTableViewCell.self, forCellReuseIdentifier: ThirdSectionTableViewCell.identifier)
        tableView.register(ForthSectionTableViewCell.self, forCellReuseIdentifier: ForthSectionTableViewCell.identifier)
        tableView.register(FifthSectionTableViewCell.self, forCellReuseIdentifier: FifthSectionTableViewCell.identifier)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 38 + 17 + 148 + 16
        } else if indexPath.section == 2 {
            return 38 + 17 + (48 * 5) + 16
        } else if indexPath.section == 3 {
                return 300
        } else if indexPath.section == 4 {
            return UIScreen.main.bounds.width - 32 + 64
        }
        return UITableView.automaticDimension
    }
}

extension MainViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableHeaderView.identifier, for: indexPath) as? MainTableHeaderView else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondSectionTableViewCell.identifier, for: indexPath) as? SecondSectionTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ThirdSectionTableViewCell.identifier, for: indexPath) as? ThirdSectionTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ForthSectionTableViewCell.identifier, for: indexPath) as? ForthSectionTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.mainVCInstance = self
            return cell
        } else if indexPath.section == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FifthSectionTableViewCell.identifier, for: indexPath) as? FifthSectionTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
