//
//  WoDeGuanZhuViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/31.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class WoDeGuanZhuViewController: ShowNavibarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的关注"

        self.initTable(self.tableView)
      mj_refresh(self.tableView, self, #selector(refreshData))
     }
         
         @objc func refreshData() {

            let parameters : ZParameters = [
                    "name": "string"
                ]
            weak var weakSelf = self
            post("user/followList", parameters: parameters, true, false) {(result) in
                weakSelf?.zjsonModel = ZJSON(result)
                weakSelf!.initTable(weakSelf!.tableView)
                weakSelf!.tableView.reloadData()
            }
            self.tableView.mj_header?.endRefreshing()
         }
    
    func initTable(_ table: UITableView) {
          
        let adapter = BaseCellViewAdapter(tableView: table, cellClass: TableViewCell_1.self, datas: zjsonModel["data"]["records"] ?? ["" : ""], xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
}
