//
//  ZuFangDetailViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/25.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ZuFangDetailViewController: HideNavibarViewController {
    
    @IBOutlet weak var backScrollView: MFAllowGestureEventPassTableView!
    @IBOutlet weak var imageTypeCollectionWidth: NSLayoutConstraint!
    @IBOutlet weak var imageTypeCollectionView: UICollectionView!
    @IBOutlet weak var imageBottomCollectionView: UICollectionView!
    
    var imgArray : Array<Any>? // resourcesList "type pictureUrl name"
    /****基本信息****/
    @IBOutlet weak var ztitle: UILabel! // title加residentiaName
    @IBOutlet weak var type: UILabel! // houseType
    @IBOutlet weak var price: UILabel! // hopePrice
    @IBOutlet weak var unitPrice: UILabel! // unitPrice
    @IBOutlet weak var quanshu: UILabel! // ownershipType
    @IBOutlet weak var time: UILabel! // openDate
    @IBOutlet weak var direction: UILabel! // houseOrientation
    @IBOutlet weak var year: UILabel! // buildingYear
    @IBOutlet weak var itemType1: UILabel! // corePoint
    
    let xinFangDetailImageTypeCollectionController = XinFangDetailImageTypeCollectionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backScrollView.zAutoConstant()
        
        // 设置图片类型
        xinFangDetailImageTypeCollectionController.setFuncCollection(imageTypeCollectionView,imageTypeCollectionWidth as! Any)
        mj_refresh(self.backScrollView, self, #selector(refreshData))
    }
                
    @objc func refreshData() {
        var parameters : ZParameters = [
                "id": houseID
            ]
        weak var weakSelf = self
        post("hou-sell/detailById", parameters: parameters, true, false) {(result) in
    //            weakSelf!.advertiseDataModel = ZJSON(result)
    //            weakSelf!.advertisementCollectionController.arrayM = weakSelf!.advertiseDataModel!
            let m = ZJSON(result)["data"]
            weakSelf!.ztitle.text = "\(m["title"].string!) \(m["residentiaName"].string!)";
            weakSelf!.type.text = m["houseType"].string;
            weakSelf!.price.text = "\(m["hopePrice"].int!)万";
            weakSelf!.unitPrice.text = m["unitPrice"].string;
            weakSelf!.quanshu.text = m["ownershipType"].string;
            weakSelf!.time.text = "发布时间：\(m["openDate"].string!)";
            weakSelf!.direction.text = "朝向：\(m["houseOrientation"].string!)";
            weakSelf!.year.text = "年份：\(m["buildingYear"].string!)年";
            weakSelf!.itemType1.text = m["corePoint"].string;
        }

        parameters = [
                "curPage": 0,
                "typeName": "string",
                "pageSize": 10,
                "residentialId": "string",
                "salesStatus": "string"
            ]
        post("hou-properties/apartment/list", parameters: parameters, true, false) {(result) in
    //            weakSelf!.advertiseDataModel = ZJSON(result)
    //            weakSelf!.advertisementCollectionController.arrayM = weakSelf!.advertiseDataModel!
        }
        self.backScrollView.mj_header?.endRefreshing()
    }

}

