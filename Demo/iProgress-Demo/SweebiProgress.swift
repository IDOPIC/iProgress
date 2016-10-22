//
//  SweebiProgress.swift
//  iProgress-Demo
//
//  Created by Antoine Cormery on 22/10/2016.
//  Copyright © 2016 iProgress. All rights reserved.
//

import Foundation
import iProgress

class SweebiProgress: iProgressAnimatable {
    
    let sweebiLogo: CAShapeLayer = CAShapeLayer()
    
    required init() {
    }
    
    func configureWithStyle(_ style: iProgressStyle) -> (view: UIView, completion: () -> Void) {
        let v: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 85))
        self.sweebiLogo.bounds = v.bounds
        self.sweebiLogo.position = v.center
        self.sweebiLogo.lineWidth = 6
        self.sweebiLogo.strokeColor = style.mainColor.cgColor
        self.sweebiLogo.fillColor = UIColor.clear.cgColor
        self.sweebiLogo.strokeStart = 0
        self.sweebiLogo.strokeEnd = 0
        
        let bezier: UIBezierPath = UIBezierPath()
        bezier.move(to: CGPoint(x: 45, y: 28))
        bezier.addLine(to: CGPoint(x: 45, y: 0))
        bezier.addLine(to: CGPoint(x: 5, y: 0))
        bezier.addLine(to: CGPoint(x: 5, y: 40))
        bezier.addLine(to: CGPoint(x: 68, y: 40))
        bezier.addLine(to: CGPoint(x: 68, y: 80))
        bezier.addLine(to: CGPoint(x: 28, y: 80))
        bezier.addLine(to: CGPoint(x: 28, y: 52))
        
        self.sweebiLogo.path = bezier.cgPath
        v.layer.addSublayer(self.sweebiLogo)
        
        let completion: () -> Void = { () -> Void in
            self.sweebiLogo.removeAllAnimations()
        }
        
        return (v, completion)
    }
    
    func updateProgress(_ progress: Double) {
        let anim: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        anim.toValue = progress
        anim.beginTime = 0
        anim.duration = 0.25
        anim.fillMode = kCAFillModeForwards
        anim.isRemovedOnCompletion = false
        
        self.sweebiLogo.add(anim, forKey: nil)
    }
}
