//
//  LocationService.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/08/01.
//

import Foundation

struct LocationService {
    static let shared = LocationService()
        
    func requestLocationData(selectedNumber: Int?, completion: @escaping ([LocationData]?, Error?) -> ()) {
        guard let path = Bundle.main.path(forResource: "LocationData", ofType: "json") else {
           return
        }
       
        guard let jsonString = try? String(contentsOfFile: path) else {
           return
        }
        
        let decoder = JSONDecoder()
        
        let data = jsonString.data(using: .utf8)
        
        if let data = data,
           let location = try? decoder.decode([LocationData].self, from: data) {
            completion(location, nil)
            return
        }
    }
}
