//
//  Weather.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/28.
//

import Foundation

struct WeatherWrapper: Codable {
    var daily: DailyWeather?
    var hourly: [HourlyWeather]?
}

struct DailyWeatherData: Codable {
    let data: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct HourlyWeatherData: Codable {
    let data: [HourlyWeather]
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct DailyWeather: Codable {
    var validDate: String
    var datetime: String
    var temp: Float
    var highTemp: Float
    var lowTemp: Float
    var windSpeed: Float
    var clouds: Int
    var snow: Int
    var weather: WeatherInfo
    
    enum CodingKeys: String, CodingKey {
        case validDate = "valid_date"
        case datetime = "datetime"
        case temp = "temp"
        case highTemp = "high_temp"
        case lowTemp = "low_temp"
        case windSpeed = "wind_spd"
        case clouds = "clouds"
        case snow = "snow"
        case weather = "weather"
    }
}

struct HourlyWeather: Codable {
    var timestamp: String
    var temp: Float
    var weather: WeatherInfo
    
    enum CodingKeys: String, CodingKey {
        case timestamp = "timestamp_local"
        case temp = "temp"
        case weather = "weather"
    }
}

struct WeatherInfo: Codable {
    var icon: String
    var code: Int
    var description: String
    
    enum CodingKeys: String, CodingKey {
        case icon = "icon"
        case code = "code"
        case description = "description"
    }
}
