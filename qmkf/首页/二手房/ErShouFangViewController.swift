//
//  ErShouFangViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/23.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ErShouFangViewController: HideNavibarViewController,UITableViewDelegate,UITableViewDataSource {
     
    @IBOutlet weak var funcCollectionView: UICollectionView!
    @IBOutlet weak var advertisementCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerContentBackView: UIView!
    @IBOutlet weak var tableHeaderView: UIView!
    var contentCollectionView: UICollectionView!
    
    let functionCollectionController = XinFangFunctionCollectionController()
    let advertisementCollectionController = XinFangAdvertisementCollectionController()
    let bannerCollectionController = XinFangBannerCollectionController()
     
    var myTable : UITableView!
    var canBackScroll = true
    var canContentScroll = false
    var backStopOffset = CGFloat(0)
    var segmentV : UserOrderSegmentView?
    var dataModel : ZJSON = [] {
        didSet {
            self.myTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        self.addChild(advertisementCollectionController)
        self.addChild(bannerCollectionController)
        self.addChild(functionCollectionController)
         
        // 购房，计算器等功能 collection
//        functionCollectionController.setFuncCollection(funcCollectionView)
        initFunction()
        
        // 广告轮播图 collection
        advertisementCollectionController.setFuncCollection(advertisementCollectionView)
        
        // 横向滚动分类
        bannerCollectionController.setFuncCollection(bannerCollectionView)
        
        // 内容
        initTable()
        mj_refresh(self.myTable, self, #selector(refreshData))
        }
            
            @objc func refreshData() {

            let parameters : ZParameters = [
                    "apartmentType": [ // 户型类型
                      "string"
                    ],
                    "characteristicTags": [ // 特色服务标签
                      "string"
                    ],
                    "curPage": 0,
                    "pageSize": 10,
                    "priceCap": 0, // 价格上限
                    "priceLower": 0, // 价格下限
                    "regionId": [ // 地区id集合
                      "string"
                    ],
                    "residentialId": "string", // 小区id
                    "tagsTypes": [
                      "string"
                    ],
                    "totalpriceCap": 0, // 总价格上限
                    "totalpriceLower": 0 // 总价格下限
                ]
            weak var weakSelf = self
            post("hou-sell/secondHouse/list", parameters: parameters, true, false) {(result) in
                weakSelf?.zjsonModel = ZJSON(result)
                weakSelf?.myTable.reloadData()
            }
            self.myTable.mj_header?.endRefreshing()
        }
    
    func initFunction() {
        
        let funcCollectionFrame = funcCollectionView.frame
        funcCollectionView.frame = CGRect(x: funcCollectionFrame.origin.x, y: funcCollectionFrame.origin.y + zSetWidth(5), width: zScreenWidth, height: funcCollectionFrame.size.height)
        
        setupHorizontalCollectionFlowlayout(self.funcCollectionView,zScreenWidth / 5.5, 72)
        
        let tempArr = NSMutableArray()
        loadErShouFunctionList(tempArr)
        
        let adapter = FunctionCollectionAdapter(collectionView: self.funcCollectionView,datas: tempArr , xib:true)
        self.funcCollectionView.dataSource = adapter
        self.funcCollectionView.delegate = adapter
        
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            
            switch indexPath.row {
            case 0:
                homeNav?.pushViewController(zXinFangStoryboard("QuanBuLouPanViewController") as! UIViewController, animated: true)
                break
            case 1:
                homeNav?.pushViewController(zXinFangStoryboard("ZhaoJinJiRenViewController") as! UIViewController, animated: true)
                break
            case 2:
//                zPush(weakSelf!, "chuZhu", nil)
                break
            default:
                break
            }
        }
        self.adapters.add(adapter)
    }
    
    func getHeight(_ view : UIView) -> CGFloat {
        return view.frame.size.height
    }
    
    func initTable() {
        myTable = UITableView(frame: CGRect(x: 0, y: 0, width: zScreenWidth, height: zScreenHeight-CGFloat(zNaviBar_Height)), style: .plain)
        myTable.delegate = self
        myTable.dataSource = self
        myTable.showsVerticalScrollIndicator = false
        myTable.separatorStyle = .none
        
        let advertisementFrame = advertisementCollectionView.frame
        advertisementCollectionView.frame = CGRect(x: advertisementFrame.origin.x, y: advertisementFrame.origin.y + zSetWidth(5), width: advertisementFrame.size.width, height: zSetWidth(190))
        
        let frame = tableHeaderView.frame
        tableHeaderView.frame = CGRect(x: frame.origin.x, y: frame.origin.y , width: frame.size.width, height: zSetWidth(275))
        
        myTable.tableHeaderView = self.tableHeaderView
        
        //XIB加载
        myTable.register(UINib.init(nibName: XinFangContentTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: XinFangContentTableViewCell.reuseId)
        
        bannerContentBackView.addSubview(myTable)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.bannerCollectionView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.zjsonModel["data"]["records"].count > 0 ? self.zjsonModel["data"]["records"].count : 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XinFangContentTableViewCell.reuseId, for: indexPath) as! XinFangContentTableViewCell
        cell.selectionStyle = .none
        cell.model = self.zjsonModel["data"]["records"][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let erShouDetail = "erShouDetail"
        houseID = ZJSON(self.zjsonModel["data"]["records"][indexPath.row])["id"].string ?? "2d93acd7be3b503a23dd3ef0eece2214"
        self.performSegue(withIdentifier: erShouDetail, sender: "")
    }
}
 
