//
//  XiaoXiViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/30.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class XiaoXiViewController: ShowNavibarWithOutBackButtonViewController {

    @IBOutlet var tableView: UITableView!
      
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息"
//        initTable(tableView)
    }
     
    func initTable(_ table: UITableView) {
        
        let arr = advertiseDataModel!["data"]["records"]
        
        let adapter = BaseCellViewAdapter(tableView: table, cellClass: XiaoXiListTableViewCell.self, datas: arr, xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }

}
