//
//  WoDeChuZuViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class WoDeChuZuViewController: ShowNavibarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的出租"
        
        initTable(tableView)
    }
    
    func initTable(_ table: UITableView) {
        
        let arr = advertiseDataModel!["data"]["records"];
        
        let adapter = BaseCellViewAdapter(tableView: table, cellClass: TableViewCell_3.self, datas: arr, xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
}
