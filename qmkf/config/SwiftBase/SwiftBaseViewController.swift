//
//  SwiftBaseViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/18.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class SwiftBaseViewController: BaseViewController {
    
    typealias baseBlock = (Any) -> () //或者 () -> Void
     
    var qmkfSubPath : NSString?
    var zjsonModel = ZJSON()
    
    var adapters : [BaseAdapter] = NSMutableArray() as! [BaseAdapter]

    deinit {
        print("**********",object_getClass(self)!,"deinit","**********")
    }
}
