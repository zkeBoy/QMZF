//
//  ShowNavibarViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/7.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class ShowNavibarViewController : KeyboardHiddenController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.isTranslucent = false
 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNavigationBarIsBackButton(true, isBackBarBackImage: false, withBarBackImageName: "")
    }
         
}
