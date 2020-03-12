//
//  QuanBuHuXingViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class QuanBuHuXingViewController: ShowNavibarViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var arrayM : [HomeModel] = [] {
        didSet {
            self.collectionView.reloadData()
            self.collectionView.zAutoConstant()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "全部户型"
        //XIB加载
        tableView.register(UINib.init(nibName: TypeTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: TypeTableViewCell.reuseId)
        
        //XIB加载
        self.collectionView?.register(UINib.init(nibName: QuanBuHuXingTypeCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: QuanBuHuXingTypeCollectionViewCell.reuseId)
        
        tableView.separatorStyle = .none
        
        self.collectionView.collectionViewLayout =  self.setupCollectionFlowlayout()
        
        // 加载数据
        loadData()
    }
     
    func setupCollectionFlowlayout() -> (UICollectionViewFlowLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (zScreenWidth-120)/2, height: 180)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return flowLayout
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TypeTableViewCell.reuseId, for: indexPath)
        cell.selectionStyle = .none
//        cell.model = self.arrayM[indexPath.row % self.arrayM.count]
        cell.zAutoConstant()
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuanBuHuXingTypeCollectionViewCell.reuseId, for: indexPath) as! QuanBuHuXingTypeCollectionViewCell
        cell.model = self.arrayM[indexPath.row % self.arrayM.count]
        return cell
    }
    
}
 

class QuanBuHuXingTypeCollectionViewCell : BaseCollectionViewCell {
    
    static let reuseId = "QuanBuHuXingTypeCollectionViewCell"
    
    override var model : Any? {
           didSet {
               let m = model as! HomeModel
            guard let image = UIImage.init(named: (m.name)!) else {
                return
            }
        }
    }
}
