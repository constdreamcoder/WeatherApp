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
    
    var cityViewModelList: [CityViewModel] = []
    var sortedCityViewModelList: [CityViewModel] = []
    
    var transferSelectedCityClosure: ((CityViewModel) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let cityList = DataParsingManager.shared.parseData() else { return }
        cityViewModelList = cityList.map { city in
            return CityViewModel(
                id: city.id,
                name: city.name,
                country: city.country,
                coord: city.coord
            )
        }
        sortedCityViewModelList = cityViewModelList
        
        configureNavigationBar()
        configureConstraints()
        configureUI()
        configureOthers()
        
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
        searchBar.delegate = self
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let transferSelectedCityClosure = transferSelectedCityClosure else { return }
        transferSelectedCityClosure(sortedCityViewModelList[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

extension SearchCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedCityViewModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        
        let city = sortedCityViewModelList[indexPath.row]
        cell.nameLabel.text = city.name
        cell.countryLabel.text = city.country
        
        if let text = searchBar.text {
            let keyword = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            cell.doSomething(with: keyword)
        }
        
        return cell
    }
}

extension SearchCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let keyword = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        sortedCityViewModelList = cityViewModelList.filter { city in
            return city.name.lowercased().contains(keyword) || city.country.lowercased().contains(keyword)
        }

        tableView.reloadData()
    }
}
