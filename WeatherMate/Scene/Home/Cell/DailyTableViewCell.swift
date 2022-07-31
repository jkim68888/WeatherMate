//
//  DailyTableViewCell.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/30.
//

import UIKit
import SnapKit

class DailyTableViewCell: UITableViewCell {
    static let identifier = "dailyTableViewCell"
    
    let dailyCellContainerBg = UIView()
    let dailyCellContainer = UIView()
    let weekdayLabel = UILabel()
    let tempContainer = UIView()
    let lowTempLabel = UILabel()
    let tempDivisionLabel = UILabel()
    let highTempLabel = UILabel()
    let weatherImg = UIImageView()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    func setUI() {
        self.contentView.addSubViews([dailyCellContainerBg, dailyCellContainer])
        
        dailyCellContainer.addSubViews([weekdayLabel, weekdayLabel, tempContainer, weatherImg])
        
        tempContainer.addSubViews([lowTempLabel, tempDivisionLabel, highTempLabel])
        
        dailyCellContainerBg.snp.makeConstraints{(make) in
            make.height.equalTo(85)
            make.edges.equalToSuperview()
        }
        
        dailyCellContainer.snp.makeConstraints{(make) in
            make.height.equalTo(85)
            make.edges.equalToSuperview()
        }
        
        weekdayLabel.snp.makeConstraints{(make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
        }
        
        tempContainer.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
        }
        
        lowTempLabel.snp.makeConstraints{(make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        tempDivisionLabel.snp.makeConstraints{(make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        highTempLabel.snp.makeConstraints{(make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        weatherImg.snp.makeConstraints{(make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-30)
            make.width.height.equalTo(50)
        }
        
        tempDivisionLabel.text = "|"
        weekdayLabel.textColor = .white
        lowTempLabel.textColor = .white
        tempDivisionLabel.textColor = .white
        highTempLabel.textColor = .white
        weekdayLabel.font = UIFont.boldSystemFont(ofSize: 20)
        lowTempLabel.font = UIFont.boldSystemFont(ofSize: 18)
        highTempLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        DispatchQueue.main.async() {
            self.dailyCellContainerBg.setGradient(color1: UIColor(hexString: "#A3CAF6"), color2: UIColor(hexString: "#738BE8"), startPoint: CGPoint(x: 0.0, y: 0.5), endPoint: CGPoint(x: 1.0, y: 0.5), radius: 12)
        }
    }
}
