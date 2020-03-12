
//
//  KeHuKuViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/5.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class KeHuKuViewController: ShowNavibarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "客户库"
        initTable(tableView) 
        self.createNavigationBarRightButton(with: zImage("icon_nav_more"), tintColor: UIColor())
    }
    
    override func rightButtonAction(_ sender: Any) {
        ZActionSheet.show(sender as! UIView, ["服务套餐","优选数据"])
    }
    
    func initTable(_ table: UITableView) {
        
        let arr = advertiseDataModel!["data"]["records"];
        
        let adapter = BaseCellViewAdapter(tableView: table, cellClass: TableViewCell_12.self, datas: arr, xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
}
