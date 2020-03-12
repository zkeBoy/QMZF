//
//  PublicBaiKeViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/26.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class PublicBaiKeViewController: ShowNavibarViewController, UITextViewDelegate{
    
    @IBOutlet weak var uploadImageCollectionView: UICollectionView!
    @IBOutlet weak var pickImageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var inputTextView: PlaceholderTextView!
    
    let pickImageArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "发布资讯"
        initFunction()
        
        self.inputTextView.delegate = self
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
}
