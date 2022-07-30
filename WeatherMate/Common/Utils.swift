//
//  Utils.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/30.
//

import Foundation

class Utils {
    static func getDayOfWeek(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE"
        formatter.locale = Locale(identifier:"ko_KR")
        let convertStr = formatter.string(from: date)
        return convertStr
    }
}
