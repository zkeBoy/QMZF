//
//  WoDeFangYuanViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class WoDeFangYuanViewController: ShowNavibarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的房源"
        
        initFunction(collectionView)
        mj_refresh(self.tableView, self, #selector(refreshData))
    }
    
    @objc func refreshData() {

           var parameters : ZParameters = [
                   "curPage": 0,
                   "name": "",
                   "newOrSecond": "",
                   "pageSize": 0,
                   "status": ""
               ]
           weak var weakSelf = self
           post("hou-sell/list", parameters: parameters, true, false) {(result) in
            weakSelf?.zjsonModel = ZJSON(result)
            weakSelf?.initTable(weakSelf!.tableView)
           }
           self.tableView.mj_header?.endRefreshing()
    }
    
    func initTable(_ table: UITableView) {
         
        let adapter = BaseCellViewAdapter(tableView: table, cellClass: TableViewCell_5.self, datas: zjsonModel["data"]["records"] ?? [], xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func initFunction(_ collectionView : UICollectionView) {
        
        let tempArr = NSMutableArray()
        
        loadWoDeCommonFunctionList(tempArr)
        setupHorizontalCollectionFlowlayout(collectionView,zScreenWidth / 4, 22)
        
        let adapter = BaseCollectionCellViewAdapter(collectionView: collectionView, cellClass: CollectionViewCell_0.self, datas: tempArr, xib:true)
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            switch indexPath.row {
            default:
                break
            }
        }
        self.adapters.add(adapter)
    }
}

