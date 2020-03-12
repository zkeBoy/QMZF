//
//  TuiJianViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/26.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TuiJianViewController: HideNavibarViewController {

    @IBOutlet weak var typeBannerCollectionView: UICollectionView!
    @IBOutlet weak var contentHorizontalCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        initTypeBannerCollectionView()
        initContentHorizontalCollectionView()
    }
    
    func initContentHorizontalCollectionView() {
        
        let arr = NSMutableArray()
        
        for i in 0 ..< 4{
            
            let table = UITableView()
            table.tag = i + 10115
            table.showsVerticalScrollIndicator = false
            table.separatorStyle = .none
 
            let adapter = ZuFangCellAdapter(tableView: table, datas: zjsonModel["data"]["records"] ?? [], xib:true)
            table.dataSource = adapter
            table.delegate = adapter
//            weak var weakSelf = self
            adapter.baseIndexPathBlock = {(indexPath) -> () in
                print(indexPath.row)
            }
            self.adapters.add(adapter)
            
            //XIB加载
            table.register(UINib.init(nibName: ContentTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ContentTableViewCell.reuseId)
            arr.add(table)
        }
         
        setupHorizontalCollectionFlowlayout(self.contentHorizontalCollectionView, zScreenWidth, zScreenHeight - zNaviBar_Height - zTabBar_Height)
        let adapter = TuiJianCollectionViewAdapter(collectionView: self.contentHorizontalCollectionView, datas: arr, xib: false)
        self.contentHorizontalCollectionView.delegate = adapter
        self.contentHorizontalCollectionView.dataSource = adapter
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func initTypeBannerCollectionView() {
        let arr = NSMutableArray()
        loadFakeModelData(arr,4)
        (arr[0] as! HomeModel).selected = true
        (arr[0] as! HomeModel).textTheme.size = 20
        setupHorizontalCollectionFlowlayout(self.typeBannerCollectionView, zScreenWidth / 5.3, 42)
        let adapter = TypeBannerColectionViewAdapter(collectionView: self.typeBannerCollectionView, datas: arr, xib: true)
        self.typeBannerCollectionView.delegate = adapter
        self.typeBannerCollectionView.dataSource = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
            (arr[indexPath.row] as! HomeModel).textTheme.size = 20
            weakSelf?.contentHorizontalCollectionView.scrollToItem(at: IndexPath(row: indexPath.row, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false)
        }
        self.adapters.add(adapter)
    }
 

}
