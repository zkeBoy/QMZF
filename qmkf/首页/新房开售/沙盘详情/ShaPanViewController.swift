//
//  ShaPanViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/17.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ShaPanViewController: HideNavibarViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
     
    override func viewDidLoad() {
        super.viewDidLoad()
         
        // collection
        setFuncCollection(collectionView)
        
    }
    var arrayM : [HomeModel] = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.zAutoConstant()
        }
    }
    
    // 从polist中加载数据
    func loadData() {
        
        print(qmkfSubPath ?? "空")
        
        let stemp: NSArray = NSArray(contentsOfFile: Bundle.main.path(forResource: "FunctionData.plist", ofType: nil)!)!
        var temArr = [HomeModel]()
        for dict in stemp {
            let model = HomeModel.init(dict: dict as! [String : Any])
            temArr.append(model)
        }
        self.arrayM = temArr
    }
    
    func setFuncCollection(_ collectionView : UICollectionView) {
        
        let margin = CGFloat(zNaviBar_Height) + zSetWidth(260) + CGFloat(zTabBar_Height - 44)
        self.collectionViewHeight.constant = zScreenHeight - margin
        
        self.collectionView = collectionView
        self.collectionView.collectionViewLayout = self.setupCollectionFlowlayout()
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: ShaPanCollectionCell.reuseId, bundle: nil), forCellWithReuseIdentifier: ShaPanCollectionCell.reuseId)
        
        loadData()
    }
    
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: zScreenWidth/2, height: zSetWidth(75))
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        return flowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayM != nil ? self.arrayM.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShaPanCollectionCell.reuseId, for: indexPath) as! ShaPanCollectionCell
        cell.model = self.arrayM[indexPath.row]
        for i in 0..<cell.subviews.count {
            i == 1 ? cell.subviews[safe:i]?.removeFromSuperview() : nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        homeNav?.pushViewController(zXinFangStoryboard("") as! UIViewController, animated: true)
    }
} 

class ShaPanCollectionCell : BaseCollectionViewCell {
    
    static let reuseId = "ShaPanCollectionCell"
    
    override var model : Any? {
           didSet {
               let m = model as! HomeModel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
