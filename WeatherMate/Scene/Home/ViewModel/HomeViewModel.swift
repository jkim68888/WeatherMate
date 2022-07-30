//
//  HomeViewModel.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/28.
//

import Foundation

class HomeViewModel {
    // MARK: Properties
    private var weatherService: WeatherService?
    
    var weatherdata: [Weather] = [] {
        didSet {
            self.didFinishFetch?()
            
        }
    }
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Network Call
    func fetchWeatherDaily(lat: Float, lon: Float) {
        self.weatherService?.requestDaily(lat: lat, lon: lon, completion: { (data, error) in
            if let error = error {
                print("viewmodel error : ", error)
                self.error = error
                self.isLoading = false
                return
            }
            
            if var wData = data?.data {
                wData = wData.map{ weather in
                    var tempData = weather
                    
                    switch tempData.weather.code {
                        case 200:
                            tempData.weather.description = "천둥번개, 비 적음"
                            break
                        case 500:
                            tempData.weather.description = "비 적음"
                            break
                        default:
                            tempData.weather.description = "맑음"
                            break
                    }
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "ko_KR")
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from: tempData.validDate)!
                    
                    tempData.validDate = "\(Utils.getDayOfWeek(date: date))요일"
                    
                    return tempData
                    
                }
                
                self.weatherdata = Array(wData[0...7])
            }
        })
    }
}
