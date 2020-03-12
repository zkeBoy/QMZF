//
//  BindPhoneViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/7.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class BindPhoneViewController: ShowNavibarViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "绑定手机号"
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.createNavigationBarIsBackButton(true, isBackBarBackImage: false, withBarBackImageName: "")
    }

}
