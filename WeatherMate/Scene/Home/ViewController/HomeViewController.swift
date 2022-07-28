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
    private let todayWeatherContainer = UIView()
    
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
//            dateLabel.text = viewModel.titleString
//            self.subtitleLabel.text = self.viewModel.albumIdString
//            self.headerImageView.sd_setImage(with: self.viewModel.photoUrl, completed: nil)
        }
    }

    // MARK: - UI
    private func setUI() {
        self.view.addSubViews([locationSearchContainer, locationLabel, dateLabel, todayWeatherContainer])
        
        locationSearchContainer.addSubViews([locationSearchInput, locationSearchIcon, locationSearchButton])
        
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
        
        self.view.backgroundColor = .white
        
        locationSearchContainer.backgroundColor = .red
        
        locationSearchInput.backgroundColor = .black
        
        locationSearchIcon.backgroundColor = .red
        
        locationSearchButton.backgroundColor = .gray
        
        locationLabel.backgroundColor = .orange
        locationLabel.text = "대한민국"
        locationLabel.textAlignment = .center
        locationLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
        
        dateLabel.backgroundColor = .yellow
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        todayWeatherContainer.backgroundColor = .green
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

