//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/13/24.
//

import Foundation

struct ForecastModel: Decodable {
    let list: [List]
}

struct List: Decodable {
    let dt: Double
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind
        case dtTxt = "dt_txt"
    }
    
    var convertedDtTxt: String {
        let date = Date(timeIntervalSince1970: dt)
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "HH"
        return outputDateFormatter.string(from: date)
    }
}
