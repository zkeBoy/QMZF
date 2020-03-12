//
//  WoDeQianBaoViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class WoDeQianBaoViewController: HideNavibarViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的钱包"
        initTable(tableView)
    }
    
    func initTable(_ table: UITableView) {
        
        let arr = advertiseDataModel!["data"]["records"];
        
        let adapter = BaseCellViewAdapter(tableView: table, cellClass: TableViewCell_6.self, datas: arr, xib:true)
        table.dataSource = adapter
        table.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in 
            switch indexPath.row {
            case 0:
                zPush(weakSelf!, "chongZhiJiLu", nil)
                break
            case 1:
                zPush(weakSelf!, "xiaoFeiMingXi", nil)
                break
            case 2:
                zPush(weakSelf!, "gouMaiZengZhi", nil)
                break
            case 3:
                zPush(weakSelf!, "zengZhiFuWu", nil)
                break
            default:
                break
            }
        }
        self.adapters.add(adapter)
    }
}
