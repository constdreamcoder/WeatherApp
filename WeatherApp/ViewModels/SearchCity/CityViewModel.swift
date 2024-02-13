//
//  CityViewModel.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/13/24.
//

import Foundation

struct CityViewModel: Codable {
    let id: Int
    let name: String
    let country: String
    let coord: Coord
}
