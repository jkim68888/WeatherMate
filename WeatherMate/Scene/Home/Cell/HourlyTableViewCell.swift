//
//  HourlyTableViewCell.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/31.
//

import UIKit
import SnapKit

class HourlyTableViewCell: UITableViewCell {
    static let identifier = "hourlyTableViewCell"
    
    lazy var hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    private var hourlyWeatherList: [HourlyWeather] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        registerCollectionView()
        collectionViewDelegate()
        setUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 15, right: 15))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    func registerCollectionView() {
        hourlyCollectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
    }
        
    func collectionViewDelegate() {
        hourlyCollectionView.delegate = self
        hourlyCollectionView.dataSource = self
    }
    
    func setUI() {
        contentView.addSubview(hourlyCollectionView)
        
        hourlyCollectionView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    func setData(weather: [HourlyWeather]) {
        self.hourlyWeatherList = weather
        
        hourlyCollectionView.reloadData()
    }
}

// MARK: - collection view
extension HourlyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 135)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HourlyCollectionViewCell = hourlyCollectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as! HourlyCollectionViewCell
                
        cell.timeLabel.text = "\(hourlyWeatherList[indexPath.row].timestamp)시"
        cell.weatherIcon.image = UIImage(named: "\(hourlyWeatherList[indexPath.row].weather.icon)")
        cell.tempLabel.text = "\(hourlyWeatherList[indexPath.row].temp)°C"
        
        return cell
    }
    
}
