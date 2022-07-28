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
        "X-RapidAPI-Key": "53d628cd7amsh3b0d9201920ec3dp12dc7bjsnaee18bdcc9b6",
        "X-RapidAPI-Host": "weatherbit-v1-mashape.p.rapidapi.com"
    ]
    
    // MARK: - baseUrl
    private let baseUrl = "https://weatherbit-v1-mashape.p.rapidapi.com"
    
    // MARK: - pathUrl
    private let dailyPath = "/forecast/daily"
    
    // MARK: - Services
    func requestDaily(lat: Float, lon: Float, completion: @escaping (WeatherData?, Error?) -> ()){
        
        let queryItems = [URLQueryItem(name: "lat", value: String(lat)), URLQueryItem(name: "lon", value: String(lon))]
        
        var urlComps = URLComponents(string: "\(baseUrl)\(dailyPath)")!
        
        urlComps.queryItems = queryItems
        
        AF.request(urlComps, headers: headers).responseDecodable(of: WeatherData.self) { (response) in
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
}
