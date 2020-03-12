//
//  BaiKeViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/26.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class BaiKeViewController: ShowNavibarViewController {

    @IBOutlet weak var advertisementCollectionView: UICollectionView!
    @IBOutlet weak var typeBannerCollectionView: UICollectionView!
    @IBOutlet weak var leftTypeTableView: UITableView!
    @IBOutlet weak var rightContentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "购房百科"
        
        self.createNavigationBarRightButton(withTitle: "添加",butonTitleColor:UIColor.black,buttonFont:UIFont.systemFont(ofSize: 15))
        
        initAdvertisementCollectionView()
        initTypeBannerCollectionView()
        initLeftTypeTableView()
        initRightContentTableView()
    }
    
    override func rightButtonAction(_ sender: Any) {
        zPush(self, "faBuBaiKe", nil)
    }
    
    func initTypeBannerCollectionView () {
        let arr = NSMutableArray()
        loadFakeModelData(arr,11)
        (arr[0] as! HomeModel).selected = true
        (arr[0] as! HomeModel).textTheme.size = 16
        setupHorizontalCollectionFlowlayout(self.typeBannerCollectionView, zScreenWidth / 4.3, 22)
        let adapter = TypeBannerColectionViewAdapter(collectionView: self.typeBannerCollectionView, datas: arr, xib: true)
        self.typeBannerCollectionView.delegate = adapter
        self.typeBannerCollectionView.dataSource = adapter
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func initLeftTypeTableView () {
           
        let adapter = TypeTableViewAdapter(tableView: self.leftTypeTableView, datas: zjsonModel["data"]["records"] ?? [], xib:true)
        self.leftTypeTableView.dataSource = adapter
        self.leftTypeTableView.delegate = adapter
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func initRightContentTableView () {
         
        let adapter = BaiKeContentTableViewAdapter(tableView: self.rightContentTableView, datas: zjsonModel["data"]["records"] ?? [], xib:true)
        self.rightContentTableView.dataSource = adapter
        self.rightContentTableView.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
            zPush(weakSelf!, "baiKeDetail", nil)
        }
        self.adapters.add(adapter)
    }

    func initAdvertisementCollectionView () {
        
        setupHorizontalCollectionFlowlayout(self.advertisementCollectionView, zScreenWidth, 140)
        
        let tempArr = NSMutableArray()
        loadAdvertisementList(tempArr)
        
        let adapter = AdvertisementCollcetionAdapter(collectionView: self.advertisementCollectionView,datas: tempArr , xib:true)
        self.advertisementCollectionView.dataSource = adapter
        self.advertisementCollectionView.delegate = adapter
        
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter) 
    }
}
