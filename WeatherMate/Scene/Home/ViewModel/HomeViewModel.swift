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
    private var locationService: LocationService?
    
    var selectedNumber: Int = 0
    
    var locationData: [LocationData] = []
    
    var selectedLocationData: LocationData?
    
    var weatherWrapperList: [WeatherWrapper] = []
    
    var dailyWeatherData: [DailyWeather] = [] {
        didSet {
           dataAllSet()
        }
    }
    
    var hourlyWeatherData: [HourlyWeather] = [] {
        didSet {
            dataAllSet()
        }
    }
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
    init(weatherService: WeatherService, locationService: LocationService) {
        self.weatherService = weatherService
        self.locationService = locationService
    }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    func dataAllSet() {
        guard dailyWeatherData.count != 0 && hourlyWeatherData.count != 0 else { return }
        for i in 0..<dailyWeatherData.count {
            if i == 0 {
                weatherWrapperList.append(WeatherWrapper(daily: dailyWeatherData[i], hourly: nil))
                weatherWrapperList.append(WeatherWrapper(daily: nil, hourly: hourlyWeatherData))
            } else {
                weatherWrapperList.append(WeatherWrapper(daily: dailyWeatherData[i], hourly: nil))
            }
                
        }
        self.didFinishFetch?()
    }
    
    // MARK: - Network Call
    func fetchLocationData(selectedNumber: Int?) {
        self.locationService?.requestLocationData(selectedNumber: selectedNumber, completion: {(data, error) in
            if let error = error {
                print("viewmodel error : ", error)
                self.error = error
                return
            }
            
            if let lData = data{
                self.locationData = lData
                self.selectedLocationData = lData[selectedNumber ?? 0]
                if let selectedLocationData = self.selectedLocationData {
                    self.fetchWeatherDaily(lat: selectedLocationData.lat, lon: selectedLocationData.lon)
                    self.fetchWeatherHourly(lat: selectedLocationData.lat, lon: selectedLocationData.lon, hours: "24")
                }
                
                return
            }
        })
    }
    
    func changeSelectedLocationData(selectedNumber: Int) {
        dailyWeatherData = []
        hourlyWeatherData = []
        weatherWrapperList = []
        self.selectedNumber = selectedNumber
        selectedLocationData = locationData[selectedNumber]
        if let selectedLocationData = selectedLocationData {
            fetchWeatherDaily(lat: selectedLocationData.lat, lon: selectedLocationData.lon)
            fetchWeatherHourly(lat: selectedLocationData.lat, lon: selectedLocationData.lon, hours: "24")
        }
    }
    
    func fetchWeatherDaily(lat: Float, lon: Float) {
        self.weatherService?.requestDaily(lat: lat, lon: lon, completion: { (data, error) in
            if let error = error {
                print("viewmodel error : ", error)
                self.error = error
                return
            }
            
            if var wData = data?.data {
                wData = wData.map{ weather in
                    var tempData = weather
                    
                    switch tempData.weather.code {
                        case 200, 201, 202:
                            tempData.weather.description = "비, 천둥번개"
                            tempData.weather.icon = "t01d"
                            break
                        case 230, 231, 232, 233:
                            tempData.weather.description = "먹구름, 천둥번개"
                            tempData.weather.icon = "t04d"
                            break
                        case 300, 301, 302:
                            tempData.weather.description = "이슬비"
                            tempData.weather.icon = "d01d"
                            break
                        case 500, 501, 511, 520, 522, 900:
                            tempData.weather.description = "비"
                            tempData.weather.icon = "r01d"
                            break
                        case 502:
                            tempData.weather.description = "비 많음, 강풍"
                            tempData.weather.icon = "r03d"
                            break
                        case 521:
                            tempData.weather.description = "소나기, 맑음"
                            tempData.weather.icon = "r05d"
                            break
                        case 600, 601, 602, 610, 621, 622, 623:
                            tempData.weather.description = "눈"
                            tempData.weather.icon = "s02d"
                            break
                        case 611, 612:
                            tempData.weather.description = "바람"
                            tempData.weather.icon = "s05d"
                            break
                        case 700, 711, 721, 731, 741, 751:
                            tempData.weather.description = "안개, 미세먼지"
                            tempData.weather.icon = "a06d"
                            break
                        case 801, 802:
                            tempData.weather.description = "맑음, 구름 조금"
                            tempData.weather.icon = "c02d"
                            break
                        case 803, 804:
                            tempData.weather.description = "구름 많음"
                            tempData.weather.icon = "c04d"
                            break
                        default:
                            tempData.weather.description = "맑음"
                            tempData.weather.icon = "c01d"
                            break
                    }
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "ko_KR")
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    let date = dateFormatter.date(from: tempData.validDate)!
                    
                    tempData.validDate = "\(Utils.getDayOfWeek(date: date))요일"
                    
                    return tempData
                    
                }
                
                self.dailyWeatherData = Array(wData[0...7])
            }
        })
    }
    
    func fetchWeatherHourly(lat: Float, lon: Float, hours: String) {
        self.weatherService?.requestHourly(lat: lat, lon: lon, hours: hours, completion: { (data, error) in
            if let error = error {
                print("viewmodel error : ", error)
                self.error = error
                return
            }
            
            if var wData = data?.data {
                wData = wData.map{ weather in
                    var tempData = weather
                    
                    switch tempData.weather.code {
                        case 200, 201, 202:
                            tempData.weather.description = "비, 천둥번개"
                            tempData.weather.icon = "t01d"
                            break
                        case 230, 231, 232, 233:
                            tempData.weather.description = "먹구름, 천둥번개"
                            tempData.weather.icon = "t04d"
                            break
                        case 300, 301, 302:
                            tempData.weather.description = "이슬비"
                            tempData.weather.icon = "d01d"
                            break
                        case 500, 501, 511, 520, 522, 900:
                            tempData.weather.description = "비"
                            tempData.weather.icon = "r01d"
                            break
                        case 502:
                            tempData.weather.description = "비 많음, 강풍"
                            tempData.weather.icon = "r03d"
                            break
                        case 521:
                            tempData.weather.description = "소나기, 맑음"
                            tempData.weather.icon = "r05d"
                            break
                        case 600, 601, 602, 610, 621, 622, 623:
                            tempData.weather.description = "눈"
                            tempData.weather.icon = "s02d"
                            break
                        case 611, 612:
                            tempData.weather.description = "바람"
                            tempData.weather.icon = "s05d"
                            break
                        case 700, 711, 721, 731, 741, 751:
                            tempData.weather.description = "안개, 미세먼지"
                            tempData.weather.icon = "a06d"
                            break
                        case 801, 802:
                            tempData.weather.description = "맑음, 구름 조금"
                            tempData.weather.icon = "c02d"
                            break
                        case 803, 804:
                            tempData.weather.description = "구름 많음"
                            tempData.weather.icon = "c04d"
                            break
                        default:
                            tempData.weather.description = "맑음"
                            tempData.weather.icon = "c01d"
                            break
                    }
                    
                    let hour = tempData.timestamp
                    let startIndex = hour.index(hour.startIndex, offsetBy: 12)
                    let endIndex = hour.index(hour.startIndex, offsetBy: 13)
                    let slicedHour = hour[startIndex..<endIndex]
                    tempData.timestamp = String(slicedHour)
                    
                    return tempData
                    
                }
                
                self.hourlyWeatherData = wData
            }
        })
    }
}
