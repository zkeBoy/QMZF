//
//  QuanBuTuPianViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/18.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class QuanBuTuPianViewController: ShowNavibarViewController {

    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerContentCollectionView: UICollectionView!
    @IBOutlet weak var left: UIImageView!
    @IBOutlet weak var right: UIImageView!
    @IBOutlet weak var imageIndexLabel: UILabel!
    
    let quanBuTuPianImageTypeCollectionController = QuanBuTuPianImageTypeCollectionController()
    let quanBuTuPianImageCollectionController = QuanBuTuPianImageCollectionController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "相册"
        
        self.addChild(quanBuTuPianImageCollectionController)
        self.addChild(quanBuTuPianImageTypeCollectionController)
        
        // 设置图片类型
        quanBuTuPianImageTypeCollectionController.setFuncCollection(bannerCollectionView)
        
        // 设置相册
        quanBuTuPianImageCollectionController.setFuncCollection(bannerContentCollectionView)
    }
}

// MARK: 图片类型分栏 collection
class QuanBuTuPianImageTypeCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
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
        for _ in 0..<5 {
            let dict = ["name":"呵呵",
            "imgName":"呵呵",
            "index":"0",]
            let model = HomeModel.init(dict: dict as [String : Any])
            temArr.append(model)
        }
        self.arrayM = temArr
    }
    
    func setFuncCollection(_ collectionView : UICollectionView) {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: QuanBuTuPianImageTypeCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: QuanBuTuPianImageTypeCollectionCell.reuseId)
         
        
        loadData()
    }
    
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: zScreenWidth/3.7, height: zSetWidth(28))
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuanBuTuPianImageTypeCollectionCell.reuseId, for: indexPath) as! QuanBuTuPianImageTypeCollectionCell
        cell.model = self.arrayM[indexPath.row]
        zViewBorderRadius(View: cell.titleLabel, Radius: 8, Width: 0.4, Color: zHEX(hexValue: 0x666666))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! QuanBuTuPianImageTypeCollectionCell
        zViewBorderRadius(View: cell.titleLabel, Radius: 8, Width: 0.4, Color: zHEX(hexValue: 0xFF1A76))
        cell.titleLabel.textColor = zHEX(hexValue: 0xFF1A76)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        zViewBorderRadius(View: (cell as! QuanBuTuPianImageTypeCollectionCell).titleLabel, Radius: 8, Width: 0.4, Color: zHEX(hexValue: 0x666666))
        (cell as! QuanBuTuPianImageTypeCollectionCell).titleLabel.textColor = zHEX(hexValue: 0x666666)
    }
}

class QuanBuTuPianImageTypeCollectionCell : BaseCollectionViewCell {
    
    static let reuseId = "QuanBuTuPianImageTypeCollectionCell"
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

// MARK: 图片类型分栏 collection
class QuanBuTuPianImageCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate {
    
    var collectionView : UICollectionView!
    var arrayM : [HomeModel] = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.zAutoConstant()
        }
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
    
    func setFuncCollection(_ collectionView : UICollectionView) {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView = collectionView
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: QuanBuTuPianImageCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: QuanBuTuPianImageCollectionCell.reuseId)
          
        loadData()
        
        (self.parent as! QuanBuTuPianViewController).imageIndexLabel.text = NSString(format: "1/%d",self.arrayM.count) as String
    }
    
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: zScreenWidth, height: zSetWidth(440))
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayM.count
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        (self.parent as! QuanBuTuPianViewController).imageIndexLabel.text = NSString(format: "%.0f/%d", scrollView.contentOffset.x / zScreenWidth + 1,self.arrayM.count) as String
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuanBuTuPianImageCollectionCell.reuseId, for: indexPath) as! QuanBuTuPianImageCollectionCell
        cell.model = self.arrayM[indexPath.row]
        return cell
    }
}

class QuanBuTuPianImageCollectionCell : BaseCollectionViewCell {
    
    static let reuseId = "QuanBuTuPianImageCollectionCell"
    
    @IBOutlet weak var imageView: UIImageView!
    
    override var model : Any? {
           didSet {
               let m = model as! HomeModel
            if let image = UIImage.init(named: (m.name)!) {            
                imageView.image = image
            }
        }
    }
}
