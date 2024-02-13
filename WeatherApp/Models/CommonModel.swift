//
//  CommonModel.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/13/24.
//

import Foundation

struct Main: Decodable {
    private let absoluteTemp: Double = 273.15
    
    let temp, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
    
    var currentTemp: Double {
        return temp - absoluteTemp
    }
    
    var lowestTemp: Double {
        return tempMin - absoluteTemp
    }
    
    var highestTemp: Double {
        return tempMax - absoluteTemp
    }
}

struct Weather: Decodable {
    let id: Int
    let main, description, icon: String
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
    
    enum CodingKeys: CodingKey {
        case speed
        case deg
        case gust
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.speed = try container.decode(Double.self, forKey: .speed)
        self.deg = try container.decode(Int.self, forKey: .deg)
        self.gust = try container.decodeIfPresent(Double.self, forKey: .gust) ?? 0
    }
}

struct Clouds: Decodable {
    let all: Int
}
