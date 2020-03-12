//
//  ChuZhuViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/25.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ChuZhuViewController: ShowNavibarViewController {
    
    @IBOutlet weak var uploadImageCollectionView: UICollectionView!

    let pickImageArray = NSMutableArray()
    @IBOutlet weak var pickImageHeight: NSLayoutConstraint!
    @IBOutlet weak var textView: PlaceholderTextView!
    @IBOutlet weak var ztitle: UITextField!
    @IBOutlet weak var zname: UITextField!
    @IBOutlet weak var znumber: UITextField!
    @IBOutlet weak var ztype: UITextField!
    @IBOutlet weak var zmianji: UITextField!
    @IBOutlet weak var zlouCengMin: UITextField!
    @IBOutlet weak var zlouCengMax: UITextField!
    @IBOutlet weak var zprice: UITextField!
    @IBOutlet weak var zdetail: PlaceholderTextView!
    @IBOutlet weak var zUname: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我要出租"
        
        initFunction()
        
        textView.placeholder = "详细的房源资料描述更能吸引找房者"
        textView.placeholderFont =  UIFont.systemFont(ofSize: 12)
    }
    
    @IBAction func zinput(_ sender: Any) {
        z_input(sender, self)
    }
    
    @IBAction func submmit(_ sender: Any) {

            let parameters : ZParameters = [
                    "idcardFront": "string"
//                    "idcardRear": "string",
//                    "name": name.text!,
//                    "phone": phone.text!,
//                    "storeId": shop.text!
                ]
    //        weak var weakSelf = self
            post("user/agentAuth", parameters: parameters, true, false) {(result) in
                advertiseDataModel = ZJSON(result)
            }
    }
    
    func initFunction() {
        
        setupVerticalCollectionFlowlayout(self.uploadImageCollectionView,(zScreenWidth - 10) / 4, 80)

        let dict = ["name":"呵呵",
        "imgName":"add",
        "index":"0",]
        let model = HomeModel.init(dict: dict as [String : Any])
        pickImageArray.add(model) 
        
        let adapter = UploadImageCollectionAdapter(collectionView: self.uploadImageCollectionView,datas: pickImageArray , xib:true)
        self.uploadImageCollectionView.dataSource = adapter
        self.uploadImageCollectionView.delegate = adapter

        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            weakSelf!.pickImageArray.add(model)
            if weakSelf!.pickImageArray.count > 0 && weakSelf!.pickImageArray.count % 4 == 0 {
                weakSelf!.pickImageHeight.constant = CGFloat(weakSelf!.pickImageArray.count / 4) * 80
            } else {
                weakSelf!.pickImageHeight.constant = CGFloat(weakSelf!.pickImageArray.count / 4 + 1) * 80
            } 
            weakSelf!.uploadImageCollectionView.reloadData()
        }
        self.adapters.add(adapter)
    }
    
    deinit {
        pickImageArray.removeAllObjects()
    }
    
}
