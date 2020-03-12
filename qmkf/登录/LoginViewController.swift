//
//  LoginViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/6.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LoginViewController: HideNavibarViewController {

    @IBOutlet weak var passwordLoginView: UIView!
    @IBOutlet weak var codeLoginView: UIView!
    @IBOutlet weak var userProtocalBtn: UIButton!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var phoneForPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var loginStatus = true
    let bindPhone = "bindPhone"
    
    override func viewDidLoad() {
        super.viewDidLoad()

         
    }

    @IBAction func userProtocal(_ sender: Any) {
        userProtocalBtn.isSelected = !userProtocalBtn.isSelected
    }
    
    @IBAction func getCode(_ sender: Any) {
        getCode_pub(phone.text ?? "")
    }
    
    @IBAction func login(_ sender: Any) {
 
        var parameters : ZParameters
        if passwordLoginView.isHidden == false {
            // 密码登录
            parameters = [
                "account": phoneForPassword.text ?? "",
                "password": password.text ?? "",
            ]
            post("user/accountLogin", parameters: parameters, true, true) {(result) in
                setLoginStauts(true)
                UserDefaults.standard.setValue(ZJSON(result)["data"]["token"].string, forKey: "token")
                UserDefaults.standard.setValue(ZJSON(result)["data"]["ucUserDto"]["nickName"].string, forKey: "username")
                print(ZJSON(result)["data"]["ucUserDto"]["nickName"].string)
                if "uc_user_member" == ZJSON(result)["data"]["ucUserDto"]["type"].string {
                    setUserType(.TypeUser)
                } else {
                    setUserType(.TypeJinJiRen)
                }
                AppDelegate.createRootVC()
            }
        } else {
            parameters = [
                "code": code.text ?? "", 
                "phone": phone.text ?? "",
                "simplify": "test_template"
            ]
            post("user/phoneLogin", parameters: parameters, true, true) {(result) in
                setLoginStauts(true)
                UserDefaults.standard.setValue(ZJSON(result)["data"]["token"].string, forKey: "token")
                UserDefaults.standard.setValue(ZJSON(result)["data"]["ucUserDto"]["nickName"].string, forKey: "username")
                if "uc_user_member" == ZJSON(result)["data"]["ucUserDto"]["type"].string {
                    setUserType(.TypeUser)
                } else {
                    setUserType(.TypeJinJiRen)
                }
                AppDelegate.createRootVC()
            }
        }
        
//        if loginStatus {
//            let loginVCNav = zLoginStoryboard("CountForbidNavigation") as! UINavigationController
//            loginVCNav.modalTransitionStyle = .crossDissolve
//            self.navigationController?.present(loginVCNav , animated: true, completion: nil)
//            loginStatus = false
//        } else {
//            self.performSegue(withIdentifier: bindPhone, sender: "")
//            loginStatus = true
//        }
  
    }
    
    @IBAction func switchPasswordOrCodeLogin(_ sender: Any) {
        if (sender as! UIButton).tag == 1008610 {
            // 密码登录
            passwordLoginView.isHidden = false
            codeLoginView.isHidden = true
        } else {
            passwordLoginView.isHidden = true
            codeLoginView.isHidden = false
        }
    }
}
