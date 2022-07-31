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
    
    func setGradient(color1: UIColor, color2: UIColor, startPoint: CGPoint, endPoint: CGPoint, radius: CGFloat){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = bounds
        gradient.cornerRadius = radius
        layer.addSublayer(gradient)
    }
}
