//
//  DataParsingManager.swift
//  WeatherApp
//
//  Created by SUCHAN CHANG on 2/13/24.
//

import Foundation

final class DataParsingManager {
    static let shared = DataParsingManager()
    
    private init() {}
    
    func parseData() -> [CityModel]? {
        let fileNm: String = "CityList"
        let extensionType = "json"
        
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let cityList = try JSONDecoder().decode([CityModel].self, from: data)
            return cityList
        } catch {
            print(error)
            return nil
        }
    }
}
