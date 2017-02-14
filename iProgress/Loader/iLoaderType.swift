//
//  iLoaderTypes.swift
//  iProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 iProgress. All rights reserved.
//

import Foundation

/**
 Specify the loader rendering
 
 - Default: use the default loader
 - AndroidStyle: use an Android Style loader
 - Custom: your can create your own loader by using this enum, you must specify a iLoaderAnimatable.Type
 */
public enum iLoaderType {
    case `default`()
    case androidStyle()
    case custom(cl: iLoaderAnimatable.Type)
    
    func getInstance(_ style: iProgressStyle, frame: CGRect = CGRect.zero) -> (UIView, () -> Void) {
        switch self {
        case .default:
            let loader: FlatCircleLoader = FlatCircleLoader.init()
            return loader.configure(with: style)
        case .androidStyle():
            let loader: AndroidStyleLoader = AndroidStyleLoader.init()
            return loader.configure(with: style)
        case .custom(let cl):
            let loader: iLoaderAnimatable = cl.init()
            return loader.configure(with: style)
        }
    }
}
