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
    
    lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var tempContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    lazy var lowTempLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var tempDivisionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var highTempLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var weatherImg: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    func setUI() {
        self.contentView.addSubViews([weekdayLabel, weekdayLabel, tempContainer, weatherImg])
        tempContainer.addSubViews([lowTempLabel, tempDivisionLabel, highTempLabel])
        
        contentView.snp.makeConstraints{(make) in
            make.height.equalTo(85)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        weekdayLabel.snp.makeConstraints{(make) in
            make.centerY.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(30)
        }
        
        tempContainer.snp.makeConstraints{(make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-5)
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
            make.centerY.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-30)
            make.width.height.equalTo(50)
        }
        
        contentView.backgroundColor = UIColor(hexString: "#6290E5")
        contentView.layer.cornerRadius = 12
        tempDivisionLabel.text = "|"
        weekdayLabel.textColor = .white
        lowTempLabel.textColor = .white
        tempDivisionLabel.textColor = .white
        highTempLabel.textColor = .white
        weekdayLabel.font = UIFont.boldSystemFont(ofSize: 20)
        lowTempLabel.font = UIFont.boldSystemFont(ofSize: 18)
        highTempLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }

}
