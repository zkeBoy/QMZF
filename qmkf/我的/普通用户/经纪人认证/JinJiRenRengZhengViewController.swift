//
//  JinJiRenRengZhengViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/31.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit 

class JinJiRenRengZhengViewController: ShowNavibarViewController {
    
    @IBOutlet weak var cardAImg: UIImageView!
    @IBOutlet weak var cardBImg: UIImageView!
    @IBOutlet weak var company: UITextField!
    @IBOutlet weak var shop: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "经纪人认证"
        
    }
    
    @IBAction func inputCompany(_ sender: Any) {
        
        z_input(sender,self)
    }
    
    @IBAction func addCardA(_ sender: Any) {
        let btn = sender as! BaseButton
        btn.takePic()
        weak var weakSelf = self
        btn.baseBlock = {(data) -> () in
            weakSelf?.cardAImg.image = data as! UIImage
            btn.alpha = 0.1
        }
    }
    
    @IBAction func addCardB(_ sender: Any) {
        let btn = sender as! BaseButton
        btn.takePic()
        weak var weakSelf = self
        btn.baseBlock = {(data) -> () in
            weakSelf?.cardBImg.image = data as! UIImage
            btn.alpha = 0.1
        }
    }
    
    @IBAction func submmit(_ sender: Any) {
        
        let parameters : ZParameters = [
                "idcardFront": "string",
                "idcardRear": "string",
                "name": name.text!,
                "phone": phone.text!,
                "storeId": shop.text!
            ]
//        weak var weakSelf = self
        post("user/agentAuth", parameters: parameters, true, false) {(result) in
            advertiseDataModel = ZJSON(result)
        }
    }
}
