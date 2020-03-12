//
//  ZiDongHuiFuViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/5.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ZiDongHuiFuViewController: ShowNavibarViewController {

    @IBOutlet weak var inputTextView: PlaceholderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "自动回复"
    }

}
