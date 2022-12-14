//
//  WeatherService.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/28.
//

import Foundation
import Alamofire

struct WeatherService {
    // MARK: - Singleton
    static let shared = WeatherService()
    
    // MARK: - headers
    private let headers: HTTPHeaders = [
        "X-RapidAPI-Key": "ecc6481f56msh84a0bf82c79660ap13cdd0jsnd694f5d40bdb",
        "X-RapidAPI-Host": "weatherbit-v1-mashape.p.rapidapi.com"
    ]
    
    // MARK: - baseUrl
    private let baseUrl = "https://weatherbit-v1-mashape.p.rapidapi.com"
    
    // MARK: - pathUrl
    private let dailyPath = "/forecast/daily"
    private let hourlyPath = "/forecast/hourly"
    
    // MARK: - Services
    func requestDaily(lat: Float, lon: Float, completion: @escaping (DailyWeatherData?, Error?) -> ()){
        
        let queryItems = [URLQueryItem(name: "lat", value: String(lat)), URLQueryItem(name: "lon", value: String(lon))]
        
        var urlComps = URLComponents(string: "\(baseUrl)\(dailyPath)")!
        
        urlComps.queryItems = queryItems
        
        AF.request(urlComps, headers: headers).responseDecodable(of: DailyWeatherData.self) { (response) in
            if let error = response.error {
                print("service error : ", error)
                completion(nil, error)
                return
            }

            if let dailyData = response.value {
                completion(dailyData, nil)
                return
            }
        }
    }
    
    func requestHourly(lat: Float, lon: Float, hours: String, completion: @escaping (HourlyWeatherData?, Error?) -> ()){
        
        let queryItems = [
            URLQueryItem(name: "lat", value: String(lat)),
            URLQueryItem(name: "lon", value: String(lon)),
            URLQueryItem(name: "hours", value: hours)
        ]
        
        var urlComps = URLComponents(string: "\(baseUrl)\(hourlyPath)")!
        
        urlComps.queryItems = queryItems
        
        AF.request(urlComps, headers: headers).responseDecodable(of: HourlyWeatherData.self) { (response) in
            if let error = response.error {
                print("service error : ", error)
                completion(nil, error)
                return
            }

            if let hourlyData = response.value {
                completion(hourlyData, nil)
                return
            }
        }
    }
}
