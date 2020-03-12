
//
//  BaseHrizontalCollectionAdapter.swift
//  qmkf
//
//  Created by Mac on 2020/1/7.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class BaseHrizontalCollectionAdapter: BaseAdapter,UICollectionViewDelegate,UICollectionViewDataSource {

    var collectionVeiw : UICollectionView?
    var views : NSMutableArray?
    
    init(collectionView:UICollectionView, views:NSMutableArray, xib:Bool) {
        super.init()
        self.views = views
        self.collectionVeiw = collectionView
        for claz in registerCellClasses() {
            if xib {
                //XIB加载
                let className = claz as! String
                collectionView.register(UINib.init(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
            } else {
                collectionView.register((claz as! AnyClass), forCellWithReuseIdentifier: NSStringFromClass((claz as! AnyClass).self))
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = NSString(format: "%@%.0f", BaseHorizontalCollectionViewCell.reuseId,indexPath.row)
        collectionView.register(BaseHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: identifier as String)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier as String, for: indexPath) as! BaseHorizontalCollectionViewCell
        cell.selfView = (self.views![indexPath.row] as! UIView)
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.views != nil ? self.views!.count : 0
    }
     
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if baseIndexPathBlock != nil {
            baseIndexPathBlock!(indexPath)
        }
    }
    
    func registerCellClasses() -> NSArray {
        [BaseHorizontalCollectionViewCell.self]
    }
}

class BaseHorizontalCollectionViewCell : BaseCollectionViewCell {
    
    static let reuseId = "BaseHorizontalCollectionViewCell"
    
    var selfContentView: UIView! {
        didSet {
            self.selfContentView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            self.addSubview(self.selfContentView)
        }
    }
    
    var selfView : Any? {
           didSet {
            if let m = selfView {
                self.selfContentView = (m as! UIView)
            }
        }
    }
}
