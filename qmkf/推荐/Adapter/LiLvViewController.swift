//
//  LiLvViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/7.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class LiLvViewController: ShowNavibarViewController {
 
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "贷款计算"
         
        initTable(tableView)
    }
    
    func initTable(_ table: UITableView) {
        
        let arr = advertiseDataModel!["data"]["records"];
        
        let adapter = BaseCellViewAdapter(tableView: table, cellClass: TableViewCell_11.self, datas: arr, xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
}
