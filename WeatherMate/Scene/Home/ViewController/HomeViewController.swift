//
//  HomeViewController.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/27.
//

import UIKit
import SnapKit
import Toast_Swift

class HomeViewController: UIViewController {
    private let dailyTableView = UITableView()
    
    private var weatherWrapperList: [WeatherWrapper] = []
    
    var selectedNumber: Int = 0
    
    // MARK: - View Model
    let viewModel = HomeViewModel(weatherService: WeatherService(), locationService: LocationService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        requestApi()
    }
    
    // MARK: - Networking
    private func requestApi() {
        viewModel.fetchLocationData(selectedNumber: selectedNumber)
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                print(error.localizedDescription)
                self.view.makeToast("데이터를 로드할 수 없습니다. 사용중인 Rapid api는 하루에 100번까지만 호출 가능합니다. 내일 다시 이용해주세요.", duration: 60.0, position: .top)
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
        
        dailyTableView.snp.makeConstraints{(make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        dailyTableView.separatorStyle = .none
      
        self.view.backgroundColor = .white
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
            cell.parentVC = self
            if let daily = weatherWrapperList[indexPath.row].daily {
                cell.setData(weather: daily)
            }
            
            cell.dropDownIndex = self.selectedNumber
            cell.selectionStyle = .none
            
            return cell
            
        } else if indexPath.row == 1 {
            let cell: HourlyTableViewCell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            
            if let hourly = weatherWrapperList[indexPath.row].hourly {
                cell.setData(weather: hourly)
            }
            
            cell.selectionStyle = .none
            
            return cell
            
        } else {
            let cell: DailyTableViewCell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as! DailyTableViewCell
                    
            cell.weekdayLabel.text = "\(weatherWrapperList[indexPath.row].daily!.validDate)"
            cell.lowTempLabel.text = "\(weatherWrapperList[indexPath.row].daily!.lowTemp)°C"
            cell.highTempLabel.text = "\(weatherWrapperList[indexPath.row].daily!.highTemp)°C"
            cell.weatherImg.image = UIImage(named: "\(weatherWrapperList[indexPath.row].daily!.weather.icon)")
            cell.selectionStyle = .none
                    
            return cell
        }
    }
}
