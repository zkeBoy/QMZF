//
//  FuckViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/23.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class FuckViewController: ShowNavibarViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
//        initTable()
    }
    
    func initTable() {
        let adapter = ZuFangCellAdapter(tableView: tableView, datas: ["1","2"], xib:false)
        self.tableView.reloadData()
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
    }
     
}
