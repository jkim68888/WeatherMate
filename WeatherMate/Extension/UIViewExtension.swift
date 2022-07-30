//
//  UIViewExtension.swift
//  WeatherMate
//
//  Created by 김지현 on 2022/07/27.
//

import Foundation
import UIKit

extension UIView {
    func addSubViews(_ views: [UIView]) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = bounds
        gradient.cornerRadius = 20
//        layer.insertSublayer(layer, at: 0)
        layer.addSublayer(gradient)
    }
}
