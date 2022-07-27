//
//  ViewController.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/27.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let locationSearchContainer = UIView()
    private let locationSearchInput = UITextField()
    private let locationSearchButton = UIButton()
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    private let todayWeatherContainer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI() {
        self.view.addSubViews([locationSearchContainer, locationLabel, dateLabel, todayWeatherContainer])
        
        locationSearchContainer.addSubViews([locationSearchInput, locationSearchButton])
        
        locationSearchContainer.snp.makeConstraints{(make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(70)
        }
        
        locationSearchInput.snp.makeConstraints{(make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        locationSearchButton.snp.makeConstraints{(make) in
            make.leading.equalTo(locationSearchInput.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
        
        locationLabel.snp.makeConstraints{(make) in
            make.top.equalTo(locationSearchContainer.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        dateLabel.snp.makeConstraints{(make) in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        self.view.backgroundColor = .white
        
        locationSearchContainer.backgroundColor = .red
        
        locationSearchInput.backgroundColor = .black
        
        locationSearchButton.backgroundColor = .gray
        
        locationLabel.backgroundColor = .orange
        locationLabel.text = "대한민국"
        locationLabel.textAlignment = .center
        locationLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
        
        dateLabel.backgroundColor = .yellow
        dateLabel.text = "2022년 7월 27일 수요일"
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        todayWeatherContainer.backgroundColor = .green
    }

}

