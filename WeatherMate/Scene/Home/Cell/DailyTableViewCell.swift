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
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    func setUI() {
        self.contentView.addSubViews([leftLabel])
        
        contentView.snp.makeConstraints{(make) in
            make.height.equalTo(80)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        leftLabel.snp.makeConstraints{(make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        contentView.backgroundColor = UIColor(hexString: "#6290E5")
    }

}
