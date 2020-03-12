//
//  CountForbidViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/7.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class CountForbidViewController: HideNavibarViewController {

    var appealStatus = 0
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    } 

    @IBAction func appeal(_ sender: Any) {
        let toAppeal = "toAppeal"
        let appealing = "appealing"
        let appealFailed = "appealFailed"
        let appealSuccess = "appealSuccess"
        
        let index = appealStatus % 4
        switch index {
        case 0:
            self.performSegue(withIdentifier: toAppeal, sender: "")
            break
        case 1:
            self.performSegue(withIdentifier: appealing, sender: "")
            break
        case 2:
            self.performSegue(withIdentifier: appealFailed, sender: "") 
            break
        case 3:
            self.performSegue(withIdentifier: appealSuccess, sender: "")
            break
        default:
            break
        }
        appealStatus += 1
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss()
    }
}
