//
//  UICollectionViewCell+Extension.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/9/24.
//

import UIKit

extension UICollectionViewCell: IdentifierProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
