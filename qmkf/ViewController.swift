//
//  ViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/5.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: KeyboardHiddenController {
    
    
    
    let tb = UITableView()
    let tb1 = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
          
        self.view.addSubview(setList())
        self.view.addSubview(setList1())
        
        tb.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(zNaviBar_Height)
            make.left.equalTo(self.view.snp.left).offset(30)
            make.width.height.equalTo(200)
        }
        tb1.snp.makeConstraints { (make) in
            make.top.equalTo(tb.snp.bottom).offset(20)
            make.left.equalTo(tb.snp.left).offset(30)
            make.width.height.equalTo(200)
        }
        
        let arr = ["1","2"]
        zDLog(arr[safe:1])
        zDLog(arr[safe:5])
         
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let loginVC = UIStoryboard.init(name: "LoginModule", bundle: nil).instantiateInitialViewController()
        self.navigationController?.present(loginVC as! UINavigationController, animated: true, completion: nil)
    }
    
    func setList() -> UITableView {
        tb.backgroundColor = UIColor.red
        tb.frame = CGRect.init(x: 0, y: 66, width: 100, height: 100)
        return tb
    }
    func setList1() -> UITableView {
        tb1.backgroundColor = UIColor.gray
        tb1.frame = CGRect.init(x: 0, y: 366, width: 100, height: 100)
        return tb1
    }

}

