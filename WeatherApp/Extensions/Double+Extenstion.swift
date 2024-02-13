//
//  Double+Extenstion.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/13/24.
//

import Foundation

extension Double {
    var convertToStringWithTheFirstDecimalPlace: String {
        return String(format: "%.1f", self)
    }
    
    var convertToStringWithTheSecondDecimalPlace: String {
        return String(format: "%.2f", self)
    }
}
