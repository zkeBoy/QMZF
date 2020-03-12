
//
//  GouMaiZengZhiViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/4.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class GouMaiZengZhiViewController: ShowNavibarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView1: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "购买增值服务"
        initTable(tableView)
        initTable1(tableView1)
    }
    
    func initTable(_ table: UITableView) {
        
        let arr = advertiseDataModel!["data"]["records"];
        
        tableViewHeight.constant = CGFloat(arr.count * 100)
        
        let adapter = BaseCellViewAdapter(tableView: table, cellClass: TableViewCell_9.self, datas: arr, xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func initTable1(_ table: UITableView) {
        
        let arr = advertiseDataModel!["data"]["records"];
         
        let adapter = BaseCellViewAdapter(tableView: table, cellClass: TableViewCell_10.self, datas: arr, xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
}
