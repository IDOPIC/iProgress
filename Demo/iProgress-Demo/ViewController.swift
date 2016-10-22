//
//  ViewController.swift
//  iProgress-Demo
//
//  Created by Cédric Eugeni on 03/06/2016.
//  Copyright © 2016 iProgress. All rights reserved.
//

import UIKit
import iProgress

class ViewController: UIViewController {
    //MARK: - IBOutlet
    @IBOutlet weak var contentViewOutlet: UIView!
    
    //MARK: - IBActions
    @IBAction func showAction(_ sender: AnyObject) {
        iProgress.show()
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showWithStatusAction(_ sender: AnyObject) {
        iProgress.show("Loading ...")
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showWithStyleAction(_ sender: AnyObject) {
        iProgress.show(style: iProgressStyle.dark)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showWithStatusAndStyleAction(_ sender: AnyObject) {
        iProgress.show("Loading ...", style: iProgressStyle.dark)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showAndroidStyleAction(_ sender: AnyObject) {
        iProgress.show(loaderType: iLoaderType.androidStyle(), style: iProgressStyle.dark)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func customLoaderButtonAction(_ sender: AnyObject) {
        iProgress.show(loaderType: iLoaderType.custom(cl: SweebiLoader.self), style: iProgressStyle.dark)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showSuccessMessageAction(_ sender: AnyObject) {
        iProgress.showSuccessWithStatus("This is a success")
    }
    
    @IBAction func showErrorMessageAction(_ sender: AnyObject) {
        iProgress.showErrorWithStatus("This is an error")
    }
    
    @IBAction func showSuccessWithActionAction(_ sender: AnyObject) {
        iProgress.showSuccessWithStatus("This is a success with Action !", andAction: ("Execute action", { () in
            debugPrint("Yeah!")
            iProgress.dismiss()
        }))
    }
    
    var progress: Int = -1
    
    @IBAction func showOnContentViewAction(_ sender: AnyObject) {
        iProgress.show(.none, contentView: self.contentViewOutlet, loaderType: iLoaderType.default(), style: iProgressStyle.light, withBlurView: false)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(5), target: self, selector: #selector(dismissAction), userInfo: nil, repeats: false)
    }
    
    @IBAction func showProgressAction(_ sender: AnyObject) {
        if self.progress < 0 {
            self.progress = 0
            iProgress.showProgress(0, style: .dark)
            Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(self.progressFu), userInfo: nil, repeats: false)
        }
    }
    
    @IBAction func showCustomProgressAction(_ sender: AnyObject) {
        if self.progress < 0 {
            self.progress = 0
            iProgress.showProgress(status: "0%", progressType: iProgressType.custom(cp: SweebiProgress.self), style: .dark)
            Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(self.progressFu), userInfo: nil, repeats: false)
        }
    }
    
    func progressFu() -> Void {
        self.progress += 10
        if self.progress <= 100 {
            iProgress.showProgress(Double(self.progress) / 100, status: "\(self.progress)%")
        }
        
        if self.progress <= 100 {
            Timer.scheduledTimer(timeInterval: TimeInterval((self.progress <= 80) ? 0.5 : 0.25), target: self, selector: #selector(self.progressFu), userInfo: nil, repeats: false)
        } else {
            iProgress.dismiss()
            self.progress = -1
        }
    }
    
    func dismissAction() {
        debugPrint("dismiss")
        iProgress.dismiss()
    }
}
