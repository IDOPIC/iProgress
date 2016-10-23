//
//  iProgress+Error.swift
//  iProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 iProgress. All rights reserved.
//

import Foundation

extension iProgress {
    //MARK: - Methods
    /**
     If your loading fails, you can display a message that gives information about what happened to the user
     
     - Parameters:
        - status: specify a text to display
        - successImage: specify an image to be displayed instead of the default image
        - style: specify a style using iProgressStyle enum
        - action: it's a tuple that contains a label and a closure. If you specify this parameter, the label will be use to generate a button while the closure will be executed when the user presses the button
        - duration: duration to display message
     */
    public static func showErrorWithStatus(_ status: String? = .none, andErrorImage errorImage: UIImage? = .none, andStyle style: iProgressStyle? = .none, andAction action: (label: String, closure: ((Void) -> Void))? = .none, withDuration duration: Double? = .none, completion: (() -> Void)? = .none) -> Void {
        let instance: iProgress = iProgress.sharedInstance
        let f: () -> Void = { () -> Void in
            var views: [UIView] = []
            let ei: UIImage = errorImage ?? instance.errorImage
            let errorImageView: UIImageView = UIImageView(frame: CGRect(x: instance.center.x - ei.size.width / 2, y: instance.center.y - ei.size.height / 2, width: ei.size.width, height: ei.size.height))
            errorImageView.image = ei
            errorImageView.tintColor = (style ?? instance.style).mainColor
            views.insert(errorImageView, at: 0)
            
            if let s = status {
                let sLabel: UILabel = iProgress.generateStatusLabelWithInstance(instance, andStatus: s, andStyle: style ?? instance.style)
                let v: UIView = views[views.count - 1]
                sLabel.frame = CGRect(x: instance.center.x - (sLabel.frame.width / 2), y: v.frame.origin.y + v.frame.height + 30, width: sLabel.frame.width, height: sLabel.frame.height)
                views.insert(sLabel, at: views.count)
            }
            
            if let act = action {
                let button: UIButton = UIButton(type: .system)
                button.setTitle(act.label, for: UIControlState())
                button.sizeToFit()
                button.actionHandleWithAction(act.closure)
                let v: UIView = views[views.count - 1]
                button.frame = CGRect(x: instance.center.x - (button.frame.width / 2), y: v.frame.origin.y + v.frame.height + 50, width: button.frame.width, height: button.frame.height)
                
                views.insert(button, at: views.count)
            }
            
            iProgress.showWithInstance(instance, andVisibleType: visibleType.error(), andViews: views, andStyle: style, completion: completion)
            
            if let s = status , action == nil {
                Timer.scheduledTimer(timeInterval: duration ?? iProgress.displayDurationForString(s), target: self, selector: #selector(sdismiss), userInfo: nil, repeats: false)
            }
        }
        
        OperationQueue.main.addOperation() { () -> Void in
            if instance.isVisible {
                iProgress.dismiss { () -> Void in
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(0.25 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)) { () -> Void in
                        f()
                    }
                }
            } else {
                f()
            }
        }
    }
}
