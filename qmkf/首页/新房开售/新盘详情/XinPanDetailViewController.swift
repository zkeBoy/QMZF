//
//  XinPanDetailViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/17.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class XinPanDetailViewController: HideNavibarViewController,MAMapViewDelegate {
    
    @IBOutlet weak var backScrollView: MFAllowGestureEventPassTableView!
    @IBOutlet weak var imageTypeCollectionWidth: NSLayoutConstraint!
    @IBOutlet weak var imageTypeCollectionView: UICollectionView! 
    @IBOutlet weak var mapBackView: UIView!
    
    let xinPanDetailImageTypeCollectionController = XinPanDetailImageTypeCollectionController()
      
    override func viewDidLoad() {
        super.viewDidLoad() 
        backScrollView.zAutoConstant()
        
        // 设置图片类型
        xinPanDetailImageTypeCollectionController.setFuncCollection(imageTypeCollectionView,imageTypeCollectionWidth as Any)
        
        addMapView(mapBackView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func addMapView(_ view : UIView) {
        let mapView = MAMapView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height))
        mapView.backgroundColor = .white
        mapView.isRotateEnabled = false
        mapView.isRotateCameraEnabled = false
        mapView.showsCompass = false
        mapView.showsUserLocation = false
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    // 在init之后调用，此时controller已经被实例化
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == shaPan {
            let controller = segue.destination as! ShaPanViewController
            controller.qmkfSubPath = "request/shapan"
        }
    }
}

// MARK: 图片类型分栏 collection
class XinPanDetailImageTypeCollectionController : UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
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
