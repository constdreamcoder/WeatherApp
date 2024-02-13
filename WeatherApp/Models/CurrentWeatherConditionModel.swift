//
//  CurrentWeatherConditionModel.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/13/24.
//

import Foundation

struct CurrentWeatherConditionModel: Decodable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let id: Int
    let name: String
}

struct Coord: Codable {
    let lon, lat: Double
}
