//
//  KaiTongHuiYuanViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class KaiTongHuiYuanViewController: ShowNavibarViewController {
 
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var taocanCollectionView: UICollectionView!
    @IBOutlet weak var taocanHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "购买会员"
         
        initAdvertisementCollectionView(collectionView)
        initTaoCanCollectionView(taocanCollectionView)
    }
    
    func initAdvertisementCollectionView (_ collectionView : UICollectionView) {
        
        setupHorizontalCollectionFlowlayout(collectionView, zScreenWidth, 140)
        
        let tempArr = NSMutableArray()
        loadAdvertisementList(tempArr)
        
        let adapter = BaseCollectionCellViewAdapter(collectionView: collectionView, cellClass: CollectionViewCell_1.self, datas: tempArr, xib:true)
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func initTaoCanCollectionView (_ collectionView : UICollectionView) {
        
        setupHorizontalCollectionFlowlayout(collectionView, zScreenWidth / 2, 110)
        
        let tempArr = NSMutableArray()
        loadAdvertisementList(tempArr)

        taocanHeight.constant = CGFloat(110 * (tempArr.count / 2 + 1))
        if tempArr.count % 2 == 0 {
            // 0,2,4
            taocanHeight.constant = CGFloat(110 * tempArr.count / 2)
        }
        
        let adapter = BaseCollectionCellViewAdapter(collectionView: collectionView, cellClass: CollectionViewCell_2.self, datas: tempArr, xib:true)
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
}
