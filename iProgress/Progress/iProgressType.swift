//
//  iProgressTypes.swift
//  iProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 iProgress. All rights reserved.
//

import Foundation

/**
 Specify the progress animation rendering

 - FlatCircle: use the default progress animation
 - Custom: you can create your own progress animation by using this enum, you must specify a iProgressAnimatable.Type
 */
public enum iProgressType {
    case flatCircle()
    case custom(cp: iProgressAnimatable.Type)
    
    var getInstance: iProgressAnimatable {
        switch self {
        case .flatCircle:
            return FlatCircleProgress()
        case .custom(let cp):
            return cp.init()
        }
    }
}
