//
//  SignUpViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/7.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class SignUpViewController: ShowNavibarViewController {

    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "注册"
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.createNavigationBarIsBackButton(true, isBackBarBackImage: false, withBarBackImageName: "")
    }
    
    @IBAction func register(_ sender: Any) {
        
        let parameters : ZParameters = [
            "account": account.text ?? "",
            "code": code.text ?? "",
            "password": password.text ?? "",
            "phone": phone.text ?? "",
            "simplify": "test_template"
            ]
        post("user/register", parameters: parameters, true, true) {(result) in
            print(result)
        }
    }
    
    @IBAction func getCode(_ sender: Any) {
        
        getCode_pub(phone.text ?? "") 
    }
    
}
