//
//  Location.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/08/01.
//

import Foundation

struct LocationData: Codable {
    let city: String
    let country: String
    let lat: Float
    let lon: Float
    
    enum CodingKeys: String, CodingKey {
        case city
        case country
        case lat
        case lon
    }
}
