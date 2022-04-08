//
//  UIViewExtension.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 2/4/2022.
//

import UIKit

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11, *) {
            var cornerMask = CACornerMask()
            if(corners.contains(.topLeft)){
                cornerMask.insert(.layerMinXMinYCorner)
            }
            if(corners.contains(.topRight)){
                cornerMask.insert(.layerMaxXMinYCorner)
            }
            if(corners.contains(.bottomLeft)){
                cornerMask.insert(.layerMinXMaxYCorner)
            }
            if(corners.contains(.bottomRight)){
                cornerMask.insert(.layerMaxXMaxYCorner)
            }
            self.layer.cornerRadius = radius
            self.layer.maskedCorners = cornerMask
            self.clipsToBounds = true
            
        } else {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
        }
    }
    
    func addBorder(_ color: UIColor){
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    
    func dropShadow(color: UIColor = UIColor.black) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.shadowOpacity = 0.6
    }
    
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.isHidden = true
            self.alpha = 0.0
        }, completion: completion)
    }

}

