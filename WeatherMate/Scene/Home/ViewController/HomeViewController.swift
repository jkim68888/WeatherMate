//
//  HomeViewController.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/27.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    private let dailyTableView = UITableView()
    
    private var weatherWrapperList: [WeatherWrapper] = []
    
    // MARK: - View Model
    let viewModel = HomeViewModel(weatherService: WeatherService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        requestApi()
    }
    
    // MARK: - Networking
    private func requestApi() {
        viewModel.fetchWeatherDaily(lat: 35.5, lon: -78.5)
        viewModel.fetchWeatherHourly(lat: 35.5, lon: -78.5, hours: "24")
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                print(error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            self.weatherWrapperList = self.viewModel.weatherWrapperList
            
            self.dailyTableView.reloadData()
        }
    }

    // MARK: - UI
    private func setUI() {
        // add views
        self.view.addSubViews([dailyTableView])
        
        self.dailyTableView.delegate = self
        self.dailyTableView.dataSource = self
        
        self.dailyTableView.register(HomeTableHeaderCell.self, forCellReuseIdentifier: HomeTableHeaderCell.identifier)
        self.dailyTableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        self.dailyTableView.register(HourlyTableViewCell.self, forCellReuseIdentifier: HourlyTableViewCell.identifier)
        
        // constraints
        dailyTableView.snp.makeConstraints{(make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
      
        // backgroundColor
        self.view.backgroundColor = .white
        
        // etc
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

// MARK: - talbe view
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherWrapperList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: HomeTableHeaderCell = tableView.dequeueReusableCell(withIdentifier: HomeTableHeaderCell.identifier, for: indexPath) as! HomeTableHeaderCell
            
            if let daily = weatherWrapperList[indexPath.row].daily {
                cell.setData(weather: daily)
            }
            
            return cell
            
        } else if indexPath.row == 1 {
            let cell: HourlyTableViewCell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            
            if let hourly = weatherWrapperList[indexPath.row].hourly {
                cell.setData(weather: hourly)
            }
            
            return cell
            
        } else {
            let cell: DailyTableViewCell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as! DailyTableViewCell
                    
            cell.weekdayLabel.text = "\(weatherWrapperList[indexPath.row].daily!.validDate)"
            cell.lowTempLabel.text = "\(weatherWrapperList[indexPath.row].daily!.lowTemp)°C"
            cell.highTempLabel.text = "\(weatherWrapperList[indexPath.row].daily!.highTemp)°C"
    //        cell.weatherImg.image = UIImage(named: "\(dailyWeather[indexPath.row].weather.icon)")
            cell.weatherImg.image = UIImage(named: "t01d")
            cell.selectionStyle = .none
                    
            return cell
        }
    }
}
