//
//  ErShouFangDetailViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/23.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ErShouFangDetailViewController: HideNavibarViewController {
    
    @IBOutlet weak var backScrollView: MFAllowGestureEventPassTableView!
    @IBOutlet weak var imageTypeCollectionWidth: NSLayoutConstraint!
    @IBOutlet weak var imageTypeCollectionView: UICollectionView!
    @IBOutlet weak var imageBottomCollectionView: UICollectionView!
    
    let xinFangDetailImageTypeCollectionController = XinFangDetailImageTypeCollectionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backScrollView.zAutoConstant()
        
        // 设置图片类型
        xinFangDetailImageTypeCollectionController.setFuncCollection(imageTypeCollectionView,imageTypeCollectionWidth as! Any)
    }
}
