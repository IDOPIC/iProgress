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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        iProgress.show(style: iProgressStyle.dark)
    }
}

