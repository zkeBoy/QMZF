


//
//  KeHuYueYuViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/5.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class KeHuYueYuViewController: ShowNavibarViewController {
 
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "客户预约"
         
        initTypeCollectionView(collectionView)
        initTable(tableView)
    }
    
    func initTable(_ table: UITableView) {
        
        let arr = advertiseDataModel!["data"]["records"];
        
        let adapter = BaseCellViewAdapter(tableView: table, cellClass: TableViewCell_0.self, datas: arr, xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func initTypeCollectionView (_ collectionView : UICollectionView) {
        
        setupHorizontalCollectionFlowlayout(collectionView, zScreenWidth / 3, 50)
        
        let tempArr = NSMutableArray()
        loadFakeModelData(tempArr, 3)
        for model in tempArr {
            (model as! HomeModel).textTheme.size = 20
            (model as! HomeModel).textTheme.desSize = 20
        }
        (tempArr[0] as! HomeModel).selected = true
        
        let adapter = TypeBannerColectionViewAdapter(collectionView: collectionView, datas: tempArr, xib: true)
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
}
