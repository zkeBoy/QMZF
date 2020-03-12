//
//  LouPanZiXunViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/30.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LouPanZiXunViewController: ShowNavibarViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "楼盘资讯"
        initTable()
    }
    
    func initTable() {
         
         
        let adapter = ZuFangCellAdapter(tableView: tableView, datas: zjsonModel, xib:true)
        self.tableView.dataSource = adapter
        self.tableView.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            zPush(weakSelf!, "ziXunDetail", nil)
        }
        self.adapters.add(adapter)
    }
}
