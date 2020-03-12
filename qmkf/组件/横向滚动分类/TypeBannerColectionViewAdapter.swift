//
//  TypeBannerColectionViewAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/26.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TypeBannerColectionViewAdapter: BaseCollectionCellAdapter {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = NSString(format: "%@%.0f", TypeBannerColectionViewCell.reuseId,indexPath.row)
        collectionView.register(UINib.init(nibName: TypeBannerColectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: identifier as String)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier as String, for: indexPath) as! TypeBannerColectionViewCell 
        cell.model = (self.datas![indexPath.row] as! HomeModel)
        return cell
    }
    
    lazy var onceCode: Void = {
        // 写下想要执行一次的代码
        (self.datas![0] as! HomeModel).selected = false
        (self.datas![0] as! HomeModel).textTheme.size = (self.datas![0] as! HomeModel).textTheme.desSize
        let indexPath = IndexPath(row: 0, section: 0)
        self.collectionVeiw!.reloadItems(at: [indexPath])
    }()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, didSelectItemAt: indexPath)
        (self.datas![indexPath.row] as! HomeModel).selected = true
        UIView.performWithoutAnimation {
            collectionView.reloadItems(at: [indexPath])
        }
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally)
        if indexPath.row != 0 {
            _ = onceCode
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        (self.datas![indexPath.row] as! HomeModel).selected = false
        (self.datas![indexPath.row] as! HomeModel).textTheme.size = (self.datas![indexPath.row] as! HomeModel).textTheme.desSize
        collectionView.reloadItems(at: [indexPath])
    }
    
    override func registerCellClasses() -> NSArray {
        [TypeBannerColectionViewCell.reuseId]
    }
}

class TypeBannerColectionViewCell : BaseCollectionViewCell {
    
    static let reuseId = "TypeBannerColectionViewCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    override var model : Any? {
          didSet {
           let m = model as! HomeModel
            if let title = m.name {
                titleLabel.text = title
            }
            if let textTheme = m.textTheme {
                self.titleLabel.textColor = textTheme.color
                self.titleLabel.font = UIFont.systemFont(ofSize:textTheme.size!)
            }
            if m.selected == true {
                self.titleLabel.textColor = .black
                self.statusView.isHidden = false
            } else {
                self.titleLabel.textColor = .lightGray
                self.statusView.isHidden = true
            }
        }
    }
}
