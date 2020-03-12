//
//  BaseCollectionCellViewAdapter.swift
//  qmkf
//
//  Created by Mac on 2020/1/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class BaseCollectionCellViewAdapter: BaseAdapter,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var datas : NSMutableArray?
    var collectionVeiw : UICollectionView?
    var cellClass : AnyClass?
    
    init(collectionView:UICollectionView, cellClass:AnyClass, datas:NSMutableArray, xib:Bool) {
        super.init()
        self.datas = datas
        self.collectionVeiw = collectionView
        self.cellClass = cellClass
        if xib {
            //XIB加载
            let className = (NSStringFromClass(cellClass ).self).components(separatedBy: ".").last!
            collectionView.register(UINib.init(nibName: className, bundle: nil), forCellWithReuseIdentifier: className)
        } else {
            collectionView.register(cellClass, forCellWithReuseIdentifier: NSStringFromClass(cellClass.self))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datas != nil ? self.datas!.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /****************** 标准写法 ******************
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionCell.reuseId, for: indexPath) as! ContentCollectionCell
        cell.model = self.arrayM[indexPath.row % self.arrayM.count]
        return cell
        ********************************************/
        let className = NSStringFromClass(self.cellClass!).components(separatedBy: ".").last!
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as! BaseCollectionViewCell
        cell.model = (self.datas![indexPath.row] as! HomeModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if baseIndexPathBlock != nil {
            baseIndexPathBlock!(indexPath)
        }
    }  

}
