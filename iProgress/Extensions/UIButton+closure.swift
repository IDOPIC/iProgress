//
//  UIButton+closure.swift
//  iProgress
//
//  Created by Cédric Eugeni on 09/05/2016.
//  Copyright © 2016 iProgress. All rights reserved.
//

import Foundation

extension UIButton {
    fileprivate func actionHandleBlock(_ action:(() -> Void)? = nil) {
        struct __ {
            static var action: (() -> Void)?
        }
        if action != nil {
            __.action = action
        } else {
            __.action?()
        }
    }
    
    @objc fileprivate func triggerActionHandleBlock() -> Void {
        self.actionHandleBlock()
    }
    
    public func actionHandleWithAction(_ action: @escaping (() -> Void)) -> Void {
        self.actionHandleBlock(action)
        if #available(iOS 9.0, *) {
            self.addTarget(self, action: #selector(triggerActionHandleBlock), for: UIControlEvents.primaryActionTriggered)
        }
    }
}
