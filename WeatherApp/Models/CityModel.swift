//
//  CityModel.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/13/24.
//

import Foundation

struct CityModel: Decodable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: Coord
}
