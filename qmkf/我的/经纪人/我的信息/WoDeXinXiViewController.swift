

//
//  WoDeXinXiViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/5.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class WoDeXinXiViewController: HideNavibarViewController {
    @IBOutlet weak var headerImageViewTop: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerImageViewTop.constant = -zNaviBar_Height + zStatusBar_Height
    }
    
}
