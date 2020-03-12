//
//  BaseCollectionCellAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/24.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class BaseCollectionCellAdapter: BaseAdapter,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var datas : NSMutableArray?
    var collectionVeiw : UICollectionView?
    
    init(collectionView:UICollectionView, datas:NSMutableArray, xib:Bool) {
        super.init()
        self.datas = datas
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datas != nil ? self.datas!.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /****************** 标准写法 ******************
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionCell.reuseId, for: indexPath) as! ContentCollectionCell
        cell.model = self.arrayM[indexPath.row % self.arrayM.count]
        return cell
        ********************************************/
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if baseIndexPathBlock != nil {
            baseIndexPathBlock!(indexPath)
        }
    }
    
    func registerCellClasses() -> NSArray {
        [UICollectionViewCell.self]
    }
    
}
