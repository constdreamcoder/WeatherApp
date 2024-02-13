//
//  OpenWeatherManager.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/13/24.
//

import Foundation
import Alamofire

final class OpenWeatherManager {
    static let shared = OpenWeatherManager()
    
    private init() {}
    
    func getImageURL(iconName: String) -> String {
        return "https://openweathermap.org/img/wn/\(iconName)@2x.png"
    }
    
    func fetchCurrentWeatherConditions(lat: Double, lon: Double, completionHandler: @escaping (CurrentWeatherConditionModel) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather"
        
        let parameters: Parameters = [
            "lat": lat,
            "lon": lon,
            "appid": APIKeys.openWeather
        ]
        
        AF.request(
            urlString,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding(destination: .queryString)
        ).responseDecodable(of: CurrentWeatherConditionModel.self) { response in
            switch response.result {
            case .success(let success):
//                print(success)
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchWeatherForecast(lat: Double, lon: Double, completionHandler: @escaping ([List]) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast"
        
        let parameters: Parameters = [
            "lat": lat,
            "lon": lon,
            "appid": APIKeys.openWeather,
        ]
        
        AF.request(
            urlString,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding(destination: .queryString)
        ).responseDecodable(of: ForecastModel.self) { response in
            switch response.result {
            case .success(let success):
//                print(success.list)
                completionHandler(success.list)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
