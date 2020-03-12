//
//  ZuFangViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/24.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ZhengZuViewController: HideNavibarViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initBanner()
        initTable()
    }
    
    func initBanner() {
        let adapter = SortBannerCollectionAdapter(collectionView: self.bannerCollectionView, datas: ["区域","面积","租金","更多"], xib: true)
        self.bannerCollectionView.delegate = adapter
        self.bannerCollectionView.dataSource = adapter
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func initTable() { 
        let cellAdapter = ZuFangCellAdapter(tableView: tableView, datas: zjsonModel["data"]["records"] ?? [], xib:true)
        let adapter = BaseSectionAdapter(cellAdapter: cellAdapter, header: bannerCollectionView,height: 32)
        self.tableView.dataSource = adapter
        self.tableView.delegate = adapter
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            zPush(self, "zuFangDetail", nil)
        }
        self.adapters.add(adapter)
        //        self.tableView.reloadData()
    }
    
    
}
