//
//  UITableViewCell+Extension.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/9/24.
//

import UIKit

extension UITableViewCell: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
