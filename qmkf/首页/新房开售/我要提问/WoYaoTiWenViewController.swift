//
//  WoYaoTiWenViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class WoYaoTiWenViewController: ShowNavibarViewController {
    
    @IBOutlet weak var textView: PlaceholderTextView!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我要提问"
        
        self.textView.placeholder = "你想问什么"
    }
     

}
