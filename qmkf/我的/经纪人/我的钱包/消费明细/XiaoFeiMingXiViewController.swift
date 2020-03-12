//
//  XiaoFeiMingXiViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/4.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class XiaoFeiMingXiViewController: ShowNavibarViewController {
    
    @IBOutlet weak var tableView: UITableView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "消费明细"
        initTable(tableView)
    }
    
    func initTable(_ table: UITableView) {
        
        let arr = advertiseDataModel!["data"]["records"];
        
        let adapter = BaseSectionViewAdapter(tableView: table, sectionHeader: nil, sectionFooter: UIView.loadView(nibName:"TableFooterView_0"), cellClass: TableViewCell_8.self, datas: arr, xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
}

