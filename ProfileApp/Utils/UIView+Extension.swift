//
//  UIView+Extension.swift
//  ProfileApp
//
//  Created by Pilar Prospero on 20/11/20.
//  Copyright © 2020 Pilar Prospero. All rights reserved.
//

import Foundation

extension UIView {
    
    func AddBottomCurve(curve: CGFloat) {
        let offset: CGFloat = self.frame.width / curve
        let bounds: CGRect = self.bounds
        
        let rectBounds: CGRect = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height / 2)
        let rectPath: UIBezierPath = UIBezierPath(rect: rectBounds)
        let ovalBounds: CGRect = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath: UIBezierPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        self.layer.mask = maskLayer
    }
}
import UIKit
