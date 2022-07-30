//
//  HomeViewController.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/27.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    private let locationSearchContainer = UIView()
    private let locationSearchInput = UITextField()
    private let locationSearchIcon = UIImageView()
    private let locationSearchButton = UIButton()
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
//    private let todayWeatherContainer = UIView(frame: CGRect(x: 0, y: 0, width: 350, height: 320))
    private let todayWeatherContainer = UIView()
    private let todayWeatherTitle = UILabel()
    private let todayWeatherIcon = UIImageView()
    private let todayWeatherTemp = UILabel()
    private let todayWeatherDescript = UILabel()
    private let todayWeatherWindSpeedIcon = UIImageView()
    private let todayWeatherWindSpeed = UILabel()
    private let todayWeatherCloudsIcon = UIImageView()
    private let todayWeatherClouds = UILabel()
    private let todayWeatherSnowIcon = UIImageView()
    private let todayWeatherSnow = UILabel()
    private let dailyTableView = UITableView()
    
    private var dailyWeather: [Weather] = []
    
    // MARK: - View Model
    let viewModel = HomeViewModel(weatherService: WeatherService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setWeatherDailyData()
    }
    
    // MARK: - Networking
    private func setWeatherDailyData() {
        viewModel.fetchWeatherDaily(lat: 35.5, lon: -78.5)
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                print(error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            let todayWeather = self.viewModel.weatherdata.first
            self.dailyWeather = Array(self.viewModel.weatherdata[1...7])
            
            self.dateLabel.text = todayWeather?.datetime
            self.todayWeatherTitle.text = "오늘"
            self.todayWeatherIcon.image = UIImage(named: "t01d")
            self.todayWeatherTemp.text = "\(todayWeather?.temp ?? 0)°C"
            self.todayWeatherDescript.text = todayWeather?.weather.description
            self.todayWeatherWindSpeedIcon.image = UIImage(named: "wind")
            self.todayWeatherWindSpeed.text = "\(todayWeather?.windSpeed ?? 0) km/h"
            self.todayWeatherCloudsIcon.image = UIImage(named: "clouds")
            self.todayWeatherClouds.text = "\(todayWeather?.clouds ?? 0)%"
            self.todayWeatherSnowIcon.image = UIImage(named: "snow")
            self.todayWeatherSnow.text = "\(todayWeather?.snow ?? 0)%"
            
            self.dailyTableView.reloadData()
        }
    }

    // MARK: - UI
    private func setUI() {
        // add views
        self.view.addSubViews([locationSearchContainer, locationLabel, dateLabel, todayWeatherContainer, dailyTableView])
        
        locationSearchContainer.addSubViews([locationSearchInput, locationSearchIcon, locationSearchButton])
        
        todayWeatherContainer.addSubViews([todayWeatherTitle, todayWeatherIcon, todayWeatherTemp, todayWeatherDescript, todayWeatherWindSpeedIcon, todayWeatherWindSpeed, todayWeatherCloudsIcon, todayWeatherClouds, todayWeatherSnowIcon, todayWeatherSnow])
        
        self.dailyTableView.delegate = self
        self.dailyTableView.dataSource = self
        
        self.dailyTableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        
        // constraints
        locationSearchContainer.snp.makeConstraints{(make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(80)
        }
        
        locationSearchInput.snp.makeConstraints{(make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        locationSearchIcon.snp.makeConstraints{(make) in
            make.leading.equalToSuperview()
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
        
        locationSearchButton.snp.makeConstraints{(make) in
            make.leading.equalTo(locationSearchInput.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints{(make) in
            make.top.equalTo(locationSearchContainer.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        dateLabel.snp.makeConstraints{(make) in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        todayWeatherContainer.snp.makeConstraints{(make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(320)
        }
        
        todayWeatherTitle.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        todayWeatherIcon.snp.makeConstraints{(make) in
            make.top.equalTo(todayWeatherTitle.snp.bottom)
            make.leading.equalToSuperview().offset(60)
        }

        todayWeatherTemp.snp.makeConstraints{(make) in
            make.top.equalTo(todayWeatherTitle.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(190)
        }

        todayWeatherDescript.snp.makeConstraints{(make) in
            make.top.equalTo(todayWeatherTemp.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(190)
        }

        todayWeatherWindSpeedIcon.snp.makeConstraints{(make) in
            make.top.equalTo(todayWeatherIcon.snp.bottom)
            make.width.height.equalTo(80)
        }

        todayWeatherWindSpeed.snp.makeConstraints{(make) in
            make.top.equalTo(todayWeatherWindSpeedIcon.snp.bottom).offset(8)
            make.centerX.equalTo(todayWeatherWindSpeedIcon.snp.centerX)
        }

        todayWeatherCloudsIcon.snp.makeConstraints{(make) in
            make.top.equalTo(todayWeatherIcon.snp.bottom)
            make.width.height.equalTo(80)
            make.leading.equalTo(todayWeatherWindSpeedIcon.snp.trailing).offset(20)
            make.centerX.equalToSuperview()
        }

        todayWeatherClouds.snp.makeConstraints{(make) in
            make.top.equalTo(todayWeatherCloudsIcon.snp.bottom).offset(8)
            make.centerX.equalTo(todayWeatherCloudsIcon.snp.centerX)
        }

        todayWeatherSnowIcon.snp.makeConstraints{(make) in
            make.top.equalTo(todayWeatherIcon.snp.bottom)
            make.width.height.equalTo(80)
            make.leading.equalTo(todayWeatherCloudsIcon.snp.trailing).offset(20)
        }

        todayWeatherSnow.snp.makeConstraints{(make) in
            make.top.equalTo(todayWeatherSnowIcon.snp.bottom).offset(8)
            make.centerX.equalTo(todayWeatherSnowIcon.snp.centerX)
        }
        
        dailyTableView.snp.makeConstraints{(make) in
            make.top.equalTo(todayWeatherContainer.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        // fontSize
        locationLabel.font = UIFont.boldSystemFont(ofSize: 28)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 22)
        todayWeatherTitle.font = UIFont.boldSystemFont(ofSize: 30)
        todayWeatherTemp.font = UIFont.systemFont(ofSize: 34)
        todayWeatherDescript.font = UIFont.systemFont(ofSize: 18)
        
        // fontColor
        todayWeatherTitle.textColor = .white
        todayWeatherTemp.textColor = .white
        todayWeatherDescript.textColor = .white
        todayWeatherWindSpeed.textColor = .white
        todayWeatherClouds.textColor = .white
        todayWeatherSnow.textColor = .white
        
        // backgroundColor
        self.view.backgroundColor = .white
        todayWeatherContainer.backgroundColor = UIColor(hexString: "#6290E5")
//        todayWeatherContainer.setGradient(color1: UIColor(hexString: "#9CC1F4"), color2: UIColor(hexString: "#6290E5"))
        
        // textAlign
        locationLabel.textAlignment = .center
        dateLabel.textAlignment = .center
        todayWeatherTitle.textAlignment = .center
        
        // etc
        todayWeatherContainer.layer.cornerRadius = 20
        
        // MARK: 삭제할 부분
//        locationSearchContainer.backgroundColor = .red
//        locationSearchInput.backgroundColor = .black
//        locationSearchIcon.backgroundColor = .red
//        locationSearchButton.backgroundColor = .gray
        locationLabel.text = "대한민국"
        dateLabel.text = "2022-07-29"
        todayWeatherTitle.text = "오늘"
        todayWeatherIcon.image = UIImage(named: "t01d")
        todayWeatherTemp.text = "30°C"
        todayWeatherDescript.text = "구름 많음"
        todayWeatherWindSpeedIcon.image = UIImage(named: "wind")
        todayWeatherWindSpeed.text = "1.3 km/h"
        todayWeatherCloudsIcon.image = UIImage(named: "clouds")
        todayWeatherClouds.text = "86%"
        todayWeatherSnowIcon.image = UIImage(named: "snow")
        todayWeatherSnow.text = "0%"
    }
    
    private func activityIndicatorStart() {
        // Code for show activity indicator view
        // ...
        print("start")
    }
    
    private func activityIndicatorStop() {
        // Code for stop activity indicator view
        // ...
        print("stop")
    }

}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DailyTableViewCell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as! DailyTableViewCell
                
        cell.leftLabel.text = "\(dailyWeather[indexPath.row].validDate)"
        cell.selectionStyle = .none
                
        return cell
    }
    
    
}
