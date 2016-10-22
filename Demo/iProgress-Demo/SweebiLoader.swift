//
//  SweebiLoader.swift
//  iProgress-Demo
//
//  Created by Antoine Cormery on 22/10/2016.
//  Copyright © 2016 iProgress. All rights reserved.
//

import Foundation
import iProgress

class SweebiLoader: iLoaderAnimatable {
    
    required init(){
    }
    
    func configureWithStyle(_ style: iProgressStyle) -> (view: UIView, completion: () -> Void) {
        let v: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 75, height: 85))
        let sweebiLogo: CAShapeLayer = CAShapeLayer()
        sweebiLogo.bounds = v.bounds
        sweebiLogo.position = v.center
        sweebiLogo.lineWidth = 6
        sweebiLogo.strokeColor = style.mainColor.cgColor
        sweebiLogo.fillColor = UIColor.clear.cgColor
        sweebiLogo.strokeStart = 0
        sweebiLogo.strokeEnd = 1
        
        let bezier: UIBezierPath = UIBezierPath()
        bezier.move(to: CGPoint(x: 45, y: 28))
        bezier.addLine(to: CGPoint(x: 45, y: 0))
        bezier.addLine(to: CGPoint(x: 5, y: 0))
        bezier.addLine(to: CGPoint(x: 5, y: 40))
        bezier.addLine(to: CGPoint(x: 68, y: 40))
        bezier.addLine(to: CGPoint(x: 68, y: 80))
        bezier.addLine(to: CGPoint(x: 28, y: 80))
        bezier.addLine(to: CGPoint(x: 28, y: 52))
        
        sweebiLogo.path = bezier.cgPath
        v.layer.addSublayer(sweebiLogo)
        
        let firstStepAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        firstStepAnimation.fromValue = 0
        firstStepAnimation.toValue = 1
        firstStepAnimation.beginTime = 0
        firstStepAnimation.duration = 1
        
        let secondStepAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeStart")
        secondStepAnimation.fromValue = 0
        secondStepAnimation.toValue = 1
        secondStepAnimation.beginTime = 1
        secondStepAnimation.duration = 1
        
        let animations: CAAnimationGroup = CAAnimationGroup()
        animations.animations = [firstStepAnimation, secondStepAnimation]
        animations.duration = 2
        animations.autoreverses = false
        animations.repeatCount = HUGE //infinite
        
        sweebiLogo.add(animations, forKey: nil)
        
        let completion: () -> Void = { () -> Void in
            sweebiLogo.removeAllAnimations()
        }
        
        return (v, completion)
    }
}
