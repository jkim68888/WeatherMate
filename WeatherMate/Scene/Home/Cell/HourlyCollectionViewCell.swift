//
//  HourlyCollectionViewCell.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/31.
//

import UIKit
import SnapKit

class HourlyCollectionViewCell: UICollectionViewCell {
    static let identifier = "hourlyCollectionViewCell"
    
    let hourlyCellContainerBg = UIView()
    let hourlyCellContainer = UIView()
    let timeLabel = UILabel()
    let weatherIcon = UIImageView()
    let tempLabel = UILabel()
     
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
        
    func setUI() {
        contentView.addSubViews([hourlyCellContainerBg, hourlyCellContainer])
        
        hourlyCellContainer.addSubViews([timeLabel, weatherIcon, tempLabel])
        
        hourlyCellContainerBg.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        
        hourlyCellContainer.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints{(make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(15)
        }
        
        weatherIcon.snp.makeConstraints{(make) in
            make.centerY.centerX.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        tempLabel.snp.makeConstraints{(make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        
        timeLabel.font = UIFont.systemFont(ofSize: 20)
        tempLabel.font = UIFont.systemFont(ofSize: 20)
        
        timeLabel.textAlignment = .center
        tempLabel.textAlignment = .center
        
        timeLabel.textColor = .white
        tempLabel.textColor = .white
        
        DispatchQueue.main.async() {
            self.hourlyCellContainerBg.setGradient(color1: UIColor(hexString: "#A1C7F6"), color2: UIColor(hexString: "#768EE9"), startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1), radius: 15)
        }
    }
}
