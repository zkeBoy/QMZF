//
//  ZiXunViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/30.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ZiXunViewController: HideNavibarViewController {
    
    @IBOutlet weak var funcCollectionView: UICollectionView!
    @IBOutlet weak var advertisementCollectionView: UICollectionView! 
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var sectionHeaderView: UIView!
    @IBOutlet weak var bannerContentBackView: UIView!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initFunction()
        initAdvertisement()
        initTable()
    }
    
    func initTable() { 
         
        self.tableHeaderView.frame = CGRect(x: 0, y: 0, width: zScreenWidth, height: zSetWidth(220))
        tableView.tableHeaderView = self.tableHeaderView
        
        let cellAdapter = ZuFangCellAdapter(tableView: tableView, datas: zjsonModel["data"]["records"] ?? [], xib:true)
        let adapter = BaseSectionAdapter(cellAdapter: cellAdapter, header: sectionHeaderView,height: zSetWidth(32))
        self.tableView.dataSource = adapter
        self.tableView.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            zPush(weakSelf!, "ziXunDetail", nil)
        }
        self.adapters.add(adapter)
    } 
    
    func initAdvertisement() {
        let advertisementFrame = advertisementCollectionView.frame
        advertisementCollectionView.frame = CGRect(x: advertisementFrame.origin.x, y: advertisementFrame.origin.y + zSetWidth(15), width: zScreenWidth, height: zSetWidth(120))
        setupHorizontalCollectionFlowlayout(self.advertisementCollectionView, zScreenWidth, zSetWidth(120))
        
        let tempArr = NSMutableArray()
        loadAdvertisementList(tempArr)
        
        let adapter = AdvertisementMarginCollcetionAdapter(collectionView: self.advertisementCollectionView,datas: tempArr , xib:true)
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
        loadZiXunFunctionList(tempArr)
        
        let adapter = FunctionCollectionAdapter(collectionView: self.funcCollectionView,datas: tempArr , xib:true)
        self.funcCollectionView.dataSource = adapter
        self.funcCollectionView.delegate = adapter
        
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            switch indexPath.row {
            case 0:
                zPush(weakSelf!, "louPanZiXun", nil)
                break
            default:
                break
            }
        }
        self.adapters.add(adapter)
    }
    
    
}
