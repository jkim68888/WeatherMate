//
//  HomeTableHeaderCell.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/30.
//

import Foundation
import SnapKit
import DropDown

class HomeTableHeaderCell: UITableViewCell {
    var parentVC: HomeViewController?
    
    static let identifier = "HomeTableHeaderCell"

    let dropDown = DropDown()
    
    var dropDownData: [String] = []
    
    var dropDownIndex: Int = 0

    private let dropDownButton = UIButton()
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    private let todayWeatherContainerBg = UIView()
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
 
    private func setUI() {
        // add views
        self.contentView.addSubViews([dropDownButton, locationLabel, dateLabel, todayWeatherContainerBg, todayWeatherContainer])
        
        todayWeatherContainer.addSubViews([todayWeatherTitle, todayWeatherIcon, todayWeatherTemp, todayWeatherDescript, todayWeatherWindSpeedIcon, todayWeatherWindSpeed, todayWeatherCloudsIcon, todayWeatherClouds, todayWeatherSnowIcon, todayWeatherSnow])
        
        // constraints
        dropDownButton.snp.makeConstraints{(make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(70)
        }
        
        locationLabel.snp.makeConstraints{(make) in
            make.top.equalTo(dropDownButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        dateLabel.snp.makeConstraints{(make) in
            make.top.equalTo(locationLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        todayWeatherContainerBg.snp.makeConstraints{(make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(25)
            make.bottom.equalToSuperview().offset(-20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(320)
        }
        
        todayWeatherContainer.snp.makeConstraints{(make) in
            make.top.equalTo(dateLabel.snp.bottom).offset(25)
            make.bottom.equalToSuperview().offset(-20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(320)
        }
        
        todayWeatherTitle.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview()
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
        
        // fontSize
        locationLabel.font = UIFont.boldSystemFont(ofSize: 28)
        dateLabel.font = UIFont.boldSystemFont(ofSize: 22)
        todayWeatherTitle.font = UIFont.boldSystemFont(ofSize: 30)
        todayWeatherTemp.font = UIFont.systemFont(ofSize: 34)
        todayWeatherDescript.font = UIFont.systemFont(ofSize: 18)
        todayWeatherWindSpeed.font = UIFont.systemFont(ofSize: 20)
        todayWeatherClouds.font = UIFont.systemFont(ofSize: 20)
        todayWeatherSnow.font = UIFont.systemFont(ofSize: 20)
        dropDownButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        
        // fontColor
        todayWeatherTitle.textColor = .white
        todayWeatherTemp.textColor = .white
        todayWeatherDescript.textColor = .white
        todayWeatherWindSpeed.textColor = .white
        todayWeatherClouds.textColor = .white
        todayWeatherSnow.textColor = .white
        
        // textAlign
        locationLabel.textAlignment = .center
        dateLabel.textAlignment = .center
        todayWeatherTitle.textAlignment = .center
        
        // etc
        dropDownButton.backgroundColor = UIColor(hexString: "#5F9CF5")
        dropDownButton.layer.cornerRadius = 10
        dropDownButton.semanticContentAttribute = .forceRightToLeft
        
        // dispatchQueue : 맨 마지막에 실행되는 속성이 있음
        DispatchQueue.main.async() {
            self.todayWeatherContainerBg.setGradient(color1: UIColor(hexString: "#9CC1F4"), color2: UIColor(hexString: "#6290E5"), startPoint: CGPoint(x: 0.5, y: 0.0), endPoint: CGPoint(x: 0.5, y: 1.0), radius: CGFloat(20))
        }
    }
    
    func setData(weather: DailyWeather) {
        guard let parentVC = self.parentVC else { return }
        self.dateLabel.text = weather.datetime
        self.todayWeatherTitle.text = "오늘"
        self.todayWeatherIcon.image = UIImage(named: "t01d")
        self.todayWeatherTemp.text = "\(weather.temp)°C"
        self.todayWeatherDescript.text = weather.weather.description
        self.todayWeatherWindSpeedIcon.image = UIImage(named: "wind")
        self.todayWeatherWindSpeed.text = "\(weather.windSpeed) km/h"
        self.todayWeatherCloudsIcon.image = UIImage(named: "clouds")
        self.todayWeatherClouds.text = "\(weather.clouds)%"
        self.todayWeatherSnowIcon.image = UIImage(named: "snow")
        self.todayWeatherSnow.text = "\(weather.snow)%"
        
        dropDownButton.addTarget(self, action: #selector(dropdownClicked), for: .touchUpInside)
        dropDownIndex = parentVC.viewModel.selectedNumber
        dropDownData = parentVC.viewModel.locationData.map{ location in return location.city }
        dropDown.dataSource = dropDownData
        dropDownButton.setTitle(dropDownData[dropDownIndex], for: .normal)
        locationLabel.text = parentVC.viewModel.selectedLocationData?.country
    }
    
    func setDropDown() {
        guard let parentVC = self.parentVC else { return }
        
        dropDown.show()
        dropDown.cornerRadius = 8
        dropDown.anchorView = dropDownButton
        dropDown.selectionBackgroundColor = UIColor(hexString: "#5F9CF5")
        dropDown.selectedTextColor = .white
        dropDown.bottomOffset = CGPoint(x: 0, y:70)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            dropDownButton.setTitle("\(item)", for: .normal)
            dropDownIndex = index
            parentVC.viewModel.changeSelectedLocationData(selectedNumber: index)
        }
    }
    
    @objc func dropdownClicked(_ sender: UIButton) {
        setDropDown()
    }
}
