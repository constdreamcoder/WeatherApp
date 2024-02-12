//
//  SearchCityViewController.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/11/24.
//

import UIKit
import SnapKit

final class SearchCityViewController: UIViewController {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for a city."
        searchBar.barTintColor = .clear
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.tintColor = .white
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search for a city.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        searchBar.searchTextField.textColor = .white
        return searchBar
    }()
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        configureConstraints()
        configureUI()
        
        configureTableView()
    }
}

extension SearchCityViewController {
    @objc func navigationItemRightBarButtonItemTapped() {
        print("눌림")
    }
}

extension SearchCityViewController: UIViewControllerConfigurationProtocol {
    func configureNavigationBar() {
        navigationItem.title = "City"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.standardAppearance = appearance
        } else {
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(navigationItemRightBarButtonItemTapped))
    }
    
    func configureConstraints() {
        [
            searchBar,
            tableView
        ].forEach { view.addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }
    
    func configureUI() {
        view.backgroundColor = .black
        
        tableView.backgroundColor = .clear
    }
    
    func configureOthers() {
        
    }
    
    func configureUserEvents() {
        
    }
}

extension SearchCityViewController: UITableViewConfigurationProtocol {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
    }
}

extension SearchCityViewController: UITableViewDelegate {
    
}

extension SearchCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
