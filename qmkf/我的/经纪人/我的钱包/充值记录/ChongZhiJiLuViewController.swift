//
//  ChongZhiJiLuViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/4.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ChongZhiJiLuViewController: ShowNavibarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "充值记录"
        initTable(tableView)
    }
    
    func initTable(_ table: UITableView) {
        
        let arr = advertiseDataModel!["data"]["records"];
        
        let adapter = BaseSectionViewAdapter(tableView: table, sectionHeader: nil, sectionFooter: UIView.loadView(nibName:"TableFooterView_0"), cellClass: TableViewCell_7.self, datas: arr, xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
}
