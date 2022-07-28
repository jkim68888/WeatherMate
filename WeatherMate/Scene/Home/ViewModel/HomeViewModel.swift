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
    
    var weatherdata: WeatherData? {
        didSet {self.didFinishFetch?()}
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
    
    var date: String?
    var temp: Float?
    
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
            
            if let wData = data?.data {
                for singleData in wData {
                    dump(singleData.temp)
                    self.temp = singleData.temp
                }
            }
        })
    }
}
