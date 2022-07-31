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
    
    var memberNameLabel = UILabel()
     
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
        
    func setUI() {
        contentView.addSubview(memberNameLabel)
        
        memberNameLabel.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        
        memberNameLabel.font = UIFont.systemFont(ofSize: 32)
        memberNameLabel.textAlignment = .center
    }
}
