//
//  QuanBuLouPanViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/16.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
 
class LouPanListViewController : HideNavibarViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerContentBackView: UIView!
    
    let contentCollectionController = QuanBuLouPanContentCollectionController()
    let bannerCollectionController = QuanBuLouPanBannerCollectionController()
    
    var canBackScroll = true
    var myTable : UITableView!
    var canContentScroll = false
    var backStopOffset = CGFloat(0)
    var segmentV : UserOrderSegmentView?
    let filter = MiddleFilterObject()
    var bannerBack = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 横向滚动分类
        bannerCollectionController.setFuncCollection(bannerCollectionView)
        
        initTable()
        mj_refresh(self.myTable, self, #selector(refreshData))
        
        
        bannerBack.addSubview(filter.getXinFangMenu())
        weak var weakSelf = self
        filter.menuView.baseBlock = {(Any)->() in
            
        }
        filter.menuView.y = 0
     }
         
     @objc func refreshData() {

        var parameters : ZParameters = [
                "buildingType": "",
                "curPage": 0,
                "isNewest": loupanType == .TypeNew ? true : false ,
                "name": "string",
                "pageSize": 10,
                "salesStatus": "string"
            ]
        weak var weakSelf = self
        post("hou-sell/properties/list", parameters: parameters, true, false) {(result) in
            weakSelf?.zjsonModel = ZJSON(result)
            weakSelf!.myTable.reloadData()
        }
        self.myTable.mj_header?.endRefreshing()
     }
    
    func initTable() {
        myTable = UITableView(frame: CGRect(x: 0, y: 0, width: zScreenWidth, height: zScreenHeight-CGFloat(zNaviBar_Height)), style: .plain)
        myTable.delegate = self
        myTable.dataSource = self
        myTable.showsVerticalScrollIndicator = false 
        myTable.separatorStyle = .none
        
        //XIB加载
        myTable.register(UINib.init(nibName: XinFangContentTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: XinFangContentTableViewCell.reuseId)
          
        bannerContentBackView.addSubview(myTable)
    } 
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return bannerBack
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    } 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.zjsonModel["data"]["records"].count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XinFangContentTableViewCell.reuseId, for: indexPath) as! XinFangContentTableViewCell
        cell.selectionStyle = .none
        cell.model = self.zjsonModel["data"]["records"][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        if loupanType == LouPanListType.TypeNew {
            self.performSegue(withIdentifier: xinPanDetail, sender: "")
        }
    } 
}

// MARK: 分栏内容 collection
class QuanBuLouPanContentCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    //无参无返回值
    typealias baseBlock = (Int) -> () //或者 () -> Void
    var baseBlock : baseBlock?
    var collectionView : UICollectionView!
    var tableArray : [UITableView?] = []
    var arrayM : [HomeModel] = [] {
        didSet {
            self.collectionView.reloadData()
            //            self.collectionView.zAutoConstant()
        }
    }
    
    func setFuncCollection(_ collectionView : UICollectionView,_ tmpTableArray : [UITableView?]) {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView = collectionView
        
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: XinFangContentCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: XinFangContentCollectionCell.reuseId)
        
        tableArray = tmpTableArray
        
        // 加载数据
        loadData()
    }
    
    // 从polist中加载数据
    func loadData() {
        let stemp: NSArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "AdvertisementData.plist", ofType: nil)!)!
        var temArr = [HomeModel]()
        for dict in stemp {
            let model = HomeModel.init(dict: dict as! [String : Any])
            temArr.append(model)
        }
        self.arrayM = temArr
    }
    
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: zScreenWidth, height: collectionView.frame.size.height)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XinFangContentCollectionCell.reuseId, for: indexPath) as! XinFangContentCollectionCell
        cell.model = self.arrayM[indexPath.row % self.arrayM.count]
        cell.contentTable = tableArray[safe:indexPath.row]!!
        return cell
    }
}

class QuanBuLouPanContentCollectionCell : BaseCollectionViewCell {
    
    var contentTable: UITableView! {
        didSet {
            self.contentTable.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            self.contentView.addSubview(self.contentTable)
        }
    }
    static let reuseId = "QuanBuLouPanContentCollectionCell"
    
    override var model : Any? {
           didSet {
               let m = model as! HomeModel
            guard let image = UIImage.init(named: (m.name)!) else {
                return
            }
        }
    }
    
}

// MARK: 分栏排序 collection
class QuanBuLouPanBannerCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var collectionView : UICollectionView!
    var arrayM : [HomeModel] = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.zAutoConstant()
        }
    }
    
    // 从polist中加载数据
    func loadData() {
        let stemp: NSArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "FunctionData.plist", ofType: nil)!)!
        var temArr = [HomeModel]()
        for dict in stemp {
            let model = HomeModel.init(dict: dict as! [String : Any])
            temArr.append(model)
        }
        self.arrayM = temArr
    }
    
    func setFuncCollection(_ collectionView : UICollectionView) {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        self.collectionView = collectionView
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: SortBannerCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: SortBannerCollectionCell.reuseId)
        
        loadData()
    }
    
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: zScreenWidth/4, height: zSetWidth(28))
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortBannerCollectionCell.reuseId, for: indexPath) as! SortBannerCollectionCell
        cell.title = (self.arrayM[indexPath.row] as HomeModel).name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
