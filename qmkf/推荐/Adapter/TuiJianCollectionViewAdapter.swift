//
//  TuiJianCollectionViewAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/27.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TuiJianCollectionViewAdapter: BaseCollectionCellAdapter {
 
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = NSString(format: "%@%.0f", TuiJianCollectionViewCell.reuseId,indexPath.row)
        collectionView.register(TuiJianCollectionViewCell.self, forCellWithReuseIdentifier: identifier as String)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier as String, for: indexPath) as! TuiJianCollectionViewCell
        cell.model = (self.datas![indexPath.row] as! UITableView)
        return cell
    }

    override func registerCellClasses() -> NSArray {
        [TuiJianCollectionViewCell.self]
    }
}

class TuiJianCollectionViewCell : BaseCollectionViewCell {
    
    static let reuseId = "TuiJianCollectionViewCell"
    
    var contentTable: UITableView! {
        didSet {
            self.contentTable.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            self.contentView.addSubview(self.contentTable)
        }
    }
    
    override var model : Any? {
           didSet {
                let m = model as! UITableView
                self.contentTable = m
        }
    }
}
