//
//  SwiftBaseObject.swift
//  qmkf
//
//  Created by Mac on 2019/12/23.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class SwiftBaseObject: NSObject {
    
    typealias BaseBlock = () -> () //或者 () -> Void
    typealias BaseIndexPathBlock = (IndexPath) -> ()
    
    var baseBlock : BaseBlock?
    var baseIndexPathBlock : BaseIndexPathBlock?
}
