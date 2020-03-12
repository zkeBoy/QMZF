//
//  AppealDeblockingViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/7.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class AppealDeblockingViewController: ShowNavibarViewController {
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "申诉解封"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.createNavigationBarIsBackButton(true, isBackBarBackImage: false, withBarBackImageName: "")
    }
}

class Appealing: ShowNavibarViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "申诉中"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.createNavigationBarIsBackButton(true, isBackBarBackImage: false, withBarBackImageName: "")
    }
}

class SubmitAppealSuccess: ShowNavibarViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "提交成功"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.createNavigationBarIsBackButton(true, isBackBarBackImage: false, withBarBackImageName: "")
    }
}

class AppealFailed: ShowNavibarViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "申诉失败"
        
    }
}

class AppealSuccess: ShowNavibarViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "申诉成功"
        
    }
}
