//
//  UserDefaults+Extension.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/14/24.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case recentlySelectedCity
    }
    
    var recentlySelectedCity: CityViewModel {
        get {
            guard let data = UserDefaults.standard.data(forKey: UserDefaults.Key.recentlySelectedCity.rawValue),
                  let recentlySelectedCity = try? PropertyListDecoder().decode(CityViewModel.self, from: data) else {
                return CityViewModel(id: 1835847, name: "Seoul", country: "KR", coord: Coord(lon: 127.049696, lat: 37.654165))
            }
            return recentlySelectedCity
        }
        set {
            UserDefaults.standard.set(
                try? PropertyListEncoder().encode(newValue),
                forKey: UserDefaults.Key.recentlySelectedCity.rawValue
            )
        }
    }
    
}

