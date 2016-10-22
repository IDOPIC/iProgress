//
//  iProgressAnimatable.swift
//  iProgress
//
//  Created by Cédric Eugeni on 05/05/2016.
//  Copyright © 2016 iProgress. All rights reserved.
//

import Foundation

public protocol iProgressAnimatable: iLoaderAnimatable {
    func updateProgress(_ progress: Double) -> Void
}
