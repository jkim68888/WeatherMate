//
//  Weather.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/28.
//

import Foundation

struct WeatherData: Codable {
    let data: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct Weather: Codable {
    let validDate: String?
    let temp: Float?
    let highTemp: Float?
    let lowTemp: Float?
    let weather: [WeatherInfo]?
    
    enum CodingKeys: String, CodingKey {
        case validDate = "valid_date"
        case temp = "temp"
        case highTemp = "high_temp"
        case lowTemp = "low_temp"
        case weather = "weather"
    }
}

struct WeatherInfo: Codable {
    let icon: String?
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case icon = "icon"
        case description = "description"
    }
}
