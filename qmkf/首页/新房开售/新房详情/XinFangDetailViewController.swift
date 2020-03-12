//
//  XinFangDetailViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/13.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class XinFangDetailViewController: HideNavibarViewController {
    
    @IBOutlet weak var backScrollView: MFAllowGestureEventPassTableView!
    @IBOutlet weak var imageTypeCollectionWidth: NSLayoutConstraint!
    @IBOutlet weak var imageTypeCollectionView: UICollectionView! 
    @IBOutlet weak var lineChartBackView: UIView! 
    
    var imgArray : Array<Any>? // resourcesList "type pictureUrl name"
    /****基本信息****/
    @IBOutlet weak var ztitle: UILabel! // title加residentiaName
    @IBOutlet weak var type: UILabel! // houseType
    @IBOutlet weak var price: UILabel! // hopePrice
    @IBOutlet weak var unitPrice: UILabel! // unitPrice
    @IBOutlet weak var quanshu: UILabel! // ownershipType
    @IBOutlet weak var time: UILabel! // openDate
    @IBOutlet weak var direction: UILabel! // houseOrientation
    @IBOutlet weak var year: UILabel! // buildingYear
    @IBOutlet weak var itemType1: UILabel! // corePoint
    
    let xinFangDetailImageTypeCollectionController = XinFangDetailImageTypeCollectionController()
    
    @objc func refreshData() {
        var parameters : ZParameters = [
                "id": houseID
            ]
        weak var weakSelf = self
        post("hou-sell/detailById", parameters: parameters, true, false) {(result) in
//            weakSelf!.advertiseDataModel = ZJSON(result)
//            weakSelf!.advertisementCollectionController.arrayM = weakSelf!.advertiseDataModel!
            let m = ZJSON(result)["data"]
            weakSelf!.ztitle.text = "\(m["title"].string ?? "") \(m["residentiaName"].string ?? "")";
            weakSelf!.type.text = m["houseType"].string;
            weakSelf!.price.text = "\(m["hopePrice"].int!)万";
            weakSelf!.unitPrice.text = m["unitPrice"].string;
            weakSelf!.quanshu.text = m["ownershipType"].string;
            weakSelf!.time.text = "发布时间：\(m["openDate"].string ?? "")";
            weakSelf!.direction.text = "朝向：\(m["houseOrientation"].string ?? "")";
            weakSelf!.year.text = "年份：\(m["buildingYear"].string ?? "")年";
            weakSelf!.itemType1.text = m["corePoint"].string;
        }

        parameters = [
                "curPage": 0,
                "typeName": "string",
                "pageSize": 10,
                "residentialId": "string",
                "salesStatus": "string"
            ]
        post("hou-properties/apartment/list", parameters: parameters, true, false) {(result) in
//            weakSelf!.advertiseDataModel = ZJSON(result)
//            weakSelf!.advertisementCollectionController.arrayM = weakSelf!.advertiseDataModel!
        }
        self.backScrollView.mj_header?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = detailTitle
        
        backScrollView.zAutoConstant()
        
        // 设置图片类型
        xinFangDetailImageTypeCollectionController.setFuncCollection(imageTypeCollectionView,imageTypeCollectionWidth as! Any)
        
        setLineChartView(lineChartBackView)
        
        mj_refresh(self.backScrollView, self, #selector(refreshData))
    }
    
    func setLineChartView(_ view : UIView) {
        let lineChart = LineChartView(frame: CGRect(x: 0, y: 0, width: zScreenWidth, height: view.height))
        lineChart.backgroundColor = .white
        lineChart.showDataHorizontalLine = true
        lineChart.lineWidth = 1
        lineChart.isSmooth = false
        lineChart.isSingleLine = false
        lineChart.dataArray = [["121","137","215","258","65","78","47"],["150","167","168","120","100","20","179"],["50","67","68","20","10","10","79"]]
        lineChart.dataNameArray = ["一工区","二工区","三工区","项目部","一大队","二中队","三小队"]
        lineChart.legendPostion = LegendPosition.top
        lineChart.legendNameArray = ["收入","支出","总收支"]
        lineChart.showDataLabel = true
        
        view.addSubview(lineChart)
        lineChart.resetData()
    }
}

// MARK: 图片类型分栏 collection
class XinFangDetailImageTypeCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var collectionView : UICollectionView!
    var arrayM : [HomeModel] = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.zAutoConstant()
        }
    }
    
    // 从polist中加载数据
    func loadData() {
        var temArr = [HomeModel]()
        for _ in 0..<3 {
            let dict = ["name":"呵呵",
            "imgName":"呵呵",
            "index":"0",]
            let model = HomeModel.init(dict: dict as [String : Any])
            temArr.append(model)
        }
        self.arrayM = temArr
    }
    
    func setFuncCollection(_ collectionView : UICollectionView, _ whatever: Any) {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        self.collectionView = collectionView
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: XinFangDetailImageTypeCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: XinFangDetailImageTypeCollectionCell.reuseId)
         
        loadData()
         
        (whatever as! NSLayoutConstraint).constant = CGFloat(self.arrayM.count * 70)
    }
    
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 70, height: zSetWidth(28))
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XinFangDetailImageTypeCollectionCell.reuseId, for: indexPath) as! XinFangDetailImageTypeCollectionCell
        cell.model = self.arrayM[indexPath.row]
        return cell
    }
}

class XinFangDetailImageTypeCollectionCell : BaseCollectionViewCell {
    
    static let reuseId = "XinFangDetailImageTypeCollectionCell"
    @IBOutlet weak var titleLabel: UILabel!
    
    override var model : Any? {
           didSet {
               let m = model as! HomeModel
            if let imgName : String = m.imgName {            
                self.titleLabel?.text = imgName
            }
        }
    }
}
