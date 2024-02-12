//
//  UIViewControllerConfigurationProtocol.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/9/24.
//

import UIKit

protocol UIViewControllerConfigurationProtocol: AnyObject {
    func configureNavigationBar()
    func configureConstraints()
    func configureUI()
    func configureOthers()
    func configureUserEvents()
}
