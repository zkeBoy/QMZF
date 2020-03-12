//
//  WoDeZuJiViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/31.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class WoDeZuJiViewController: ShowNavibarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的足迹"
        self.initTable(self.tableView)
        mj_refresh(self.tableView, self, #selector(refreshData))
    }
       
   @objc func refreshData() {

      let parameters : ZParameters = [
              "name": "string"
          ]
      weak var weakSelf = self
      post("user/footprintList", parameters: parameters, true, false) {(result) in
          weakSelf?.zjsonModel = ZJSON(result)
          weakSelf!.initTable(weakSelf!.tableView)
          weakSelf!.tableView.reloadData()
      }
      self.tableView.mj_header?.endRefreshing()
   }
    
    func initTable(_ table: UITableView) {
        
        let adapter = BaseCellViewAdapter(tableView: table, cellClass: TableViewCell_2.self, datas: self.zjsonModel["data"] ?? ZJSON(), xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
}

