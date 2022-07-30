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
    
    private var dailyWeather: [DailyWeather] = []
    
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
            self.dailyWeather = Array(self.viewModel.dailyWeatherData[0...7])
            
            self.dailyTableView.reloadData()
        }
    }

    // MARK: - UI
    private func setUI() {
        // add views
        self.view.addSubViews([dailyTableView])
        
        self.dailyTableView.delegate = self
        self.dailyTableView.dataSource = self
        
        self.dailyTableView.register(DailyTableViewCell.self, forCellReuseIdentifier: DailyTableViewCell.identifier)
        self.dailyTableView.register(HomeTableHeaderCell.self, forCellReuseIdentifier: HomeTableHeaderCell.identifier)
        
        // constraints
        dailyTableView.snp.makeConstraints{(make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        // fontSize
      
        
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

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: HomeTableHeaderCell = tableView.dequeueReusableCell(withIdentifier: HomeTableHeaderCell.identifier, for: indexPath) as! HomeTableHeaderCell
            cell.setData(weather: dailyWeather[indexPath.row])
            return cell
        } else {
            let cell: DailyTableViewCell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as! DailyTableViewCell
                    
            cell.weekdayLabel.text = "\(dailyWeather[indexPath.row].validDate)"
            cell.lowTempLabel.text = "\(dailyWeather[indexPath.row].lowTemp)°C"
            cell.highTempLabel.text = "\(dailyWeather[indexPath.row].highTemp)°C"
    //        cell.weatherImg.image = UIImage(named: "\(dailyWeather[indexPath.row].weather.icon)")
            cell.weatherImg.image = UIImage(named: "t01d")
            cell.selectionStyle = .none
                    
            return cell
        }

    }
    
    
}
