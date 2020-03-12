//
//  ZuFangViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/24.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ZuFangViewController: HideNavibarViewController {
    
    @IBOutlet weak var funcCollectionView: UICollectionView!
    @IBOutlet weak var advertisementCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerContentBackView: UIView!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initFunction()
        initPuzzleAdvertisement()
        initSortBanner()
        initTable()
    
        mj_refresh(self.tableView, self, #selector(refreshData))
    }
        
        @objc func refreshData() {

        let parameters : ZParameters = [
//                "apartmentType": [
//                  ""
//                ],
//                "curPage": 0,
//                "pageSize": 10,
//                "priceCap": 0,
//                "priceLower": 0,
//                "regionId": [
//                  ""
//                ],
//                "residentialId": ""
            "pageSize": 0,
            "name": "string",
            "curPage": 0
            ]
        weak var weakSelf = self
//        post("hou-sell/secondHouse/list", parameters: parameters, true, false) {(result) in
        post("hou-sell/newHouse/list", parameters: parameters, true, false) {(result) in
            weakSelf!.zjsonModel = ZJSON(result)
            weakSelf!.initTable()
        }
        self.tableView.mj_header?.endRefreshing()
    }

    
    func initTable() {
        
        self.tableHeaderView.frame = CGRect(x: 0, y: 0, width: zScreenWidth, height: zSetWidth(280))
        tableView.tableHeaderView = self.tableHeaderView
        
        let cellAdapter = ZuFangCellAdapter(tableView: tableView, datas: zjsonModel["data"]["records"] ?? ["":""], xib:true)
        let adapter = BaseSectionAdapter(cellAdapter: cellAdapter, header: bannerCollectionView,height: zSetWidth(32))
        self.tableView.dataSource = adapter
        self.tableView.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            zPush(weakSelf!, "zuFangDetail", nil)
        }
        self.adapters.add(adapter)
        //        self.tableView.reloadData()
    }
    
    func initSortBanner() { 
        let adapter = SortBannerCollectionAdapter(collectionView: self.bannerCollectionView, datas: ["区域","面积","租金","更多"], xib: true)
        self.bannerCollectionView.delegate = adapter
        self.bannerCollectionView.dataSource = adapter
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func initPuzzleAdvertisement() {
        let advertisementFrame = advertisementCollectionView.frame
        advertisementCollectionView.frame = CGRect(x: advertisementFrame.origin.x, y: advertisementFrame.origin.y + zSetWidth(5), width: zScreenWidth, height: zSetWidth(190))
        setupHorizontalCollectionFlowlayout(self.advertisementCollectionView, zScreenWidth, zSetWidth(190))
        
        let tempArr = NSMutableArray()
        tempArr.add(advertiseDataModel)
        
        let adapter = PuzzleAdvertisementCollectionAdapter(collectionView: self.advertisementCollectionView,datas: tempArr , xib:true)
        self.advertisementCollectionView.dataSource = adapter
        self.advertisementCollectionView.delegate = adapter
        
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    func initFunction() {
        
        let funcCollectionFrame = funcCollectionView.frame
        funcCollectionView.frame = CGRect(x: funcCollectionFrame.origin.x, y: funcCollectionFrame.origin.y + zSetWidth(5), width: zScreenWidth, height: funcCollectionFrame.size.height)
        
        setupHorizontalCollectionFlowlayout(self.funcCollectionView,zScreenWidth / 5.5, 72)
        
        let tempArr = NSMutableArray()
        loadZuFangFunctionList(tempArr)
        
        let adapter = FunctionCollectionAdapter(collectionView: self.funcCollectionView,datas: tempArr , xib:true)
        self.funcCollectionView.dataSource = adapter
        self.funcCollectionView.delegate = adapter
        
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            switch indexPath.row {
            case 0:
                zPush(weakSelf!, "zhengZu", nil)
                break
            case 1:
                zPush(weakSelf!, "zhengZu", nil)
                break
            case 2:
                zPush(weakSelf!, "chuZhu", nil)
                break
            default:
                break
            }
        }
        self.adapters.add(adapter)
    }
    
    
}
