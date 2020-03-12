//
//  LuntanViewController.swift
//  qmkf
//
//  Created by Mac on 2020/1/13.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class LuntanViewController: ShowNavibarViewController {
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "论坛"
        
        initTypeBannerCollectionView(bannerCollectionView)
        initContentHorizontalCollectionView(contentCollectionView)
    }
    
    @IBAction func caculate(_ sender: Any) {
        zPush(self, "jieGuo", nil)
    }
    
    func initContentHorizontalCollectionView(_ collectionView: UICollectionView) {
        
        let arr = NSMutableArray()
        
        for i in 0 ..< 4 {
            
            let table = UITableView()
            table.tag = i + 11115
            table.showsVerticalScrollIndicator = false
            table.separatorStyle = .none
            
            let arrIn = advertiseDataModel!["data"]["records"];
            
            let adapter = BaseCellViewAdapter(tableView: table, cellClass: TableViewCell_15.self, datas: arrIn, xib: true)
            table.dataSource = adapter
            table.delegate = adapter
            table.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: zScreenWidth, height: 64))
            //            weak var weakSelf = self
            weak var weakSelf = self
            adapter.baseIndexPathBlock = {(indexPath) -> () in
                print(indexPath.row) 
            }
            self.adapters.add(adapter)
            
            //XIB加载
            table.register(UINib.init(nibName: ContentTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ContentTableViewCell.reuseId)
            arr.add(table)
        }
        
        setupHorizontalCollectionFlowlayout(collectionView, zScreenWidth, zScreenHeight - zNaviBar_Height - 52)
//        let adapter = TuiJianCollectionViewAdapter(collectionView: collectionView, datas: arr, xib: false)
        let adapter = BaseHrizontalCollectionAdapter(collectionView: collectionView, views: arr, xib: false)
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func initTypeBannerCollectionView(_ collectionView: UICollectionView) {
        let arr = NSMutableArray()
        loadFakeModelData(arr,4)
        (arr[0] as! HomeModel).selected = true
        (arr[0] as! HomeModel).textTheme.size = 20
        setupHorizontalCollectionFlowlayout(collectionView, zScreenWidth / 5, 43)
        let adapter = TypeBannerColectionViewAdapter(collectionView: collectionView, datas: arr, xib: true)
        collectionView.delegate = adapter
        collectionView.dataSource = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row) 
        }
        self.adapters.add(adapter)
    }
    
    
}
