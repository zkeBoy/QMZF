//
//  ForgetPasswordViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/10.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: ShowNavibarViewController {
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "忘记密码"
    }
    
    @IBAction func getCode(_ sender: Any) {
        getCode_pub(phone.text ?? "")
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        let parameters : ZParameters = [
            "code": code.text ?? "",
            "newPwd": password.text ?? "",
            "phone": phone.text ?? "",
            "simplify": "test_template"
            ]
        post("user/resetPassword", parameters: parameters, true, true) {(result) in
            print(result)
        }
    }
    
    
}
