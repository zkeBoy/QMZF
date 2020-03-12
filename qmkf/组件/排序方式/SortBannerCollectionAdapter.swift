//
//  ZuFangBannerCollectionView.swift
//  qmkf
//
//  Created by Mac on 2019/12/24.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class SortBannerCollectionAdapter: BaseCollectionCellAdapter {

    override init(collectionView: UICollectionView, datas: NSMutableArray, xib: Bool) {
        super.init(collectionView: collectionView, datas: datas, xib: xib)
        self.setupCollectionFlowlayout(collectionView)
    }
    
    func setupCollectionFlowlayout(_ collectionView : UICollectionView) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: zScreenWidth / 4, height: 22)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = flowLayout
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SortBannerCollectionCell.reuseId, for: indexPath) as! SortBannerCollectionCell
        cell.title = self.datas?[indexPath.row] as? String
        return cell
    }
    
    override func registerCellClasses() -> NSArray {
        [SortBannerCollectionCell.reuseId]
    }
}

class SortBannerCollectionCell : BaseCollectionViewCell {
    
    static let reuseId = "SortBannerCollectionCell"
    @IBOutlet weak var titleLabel: UILabel!
    
    var title : String? {
        didSet {
            self.titleLabel?.text = title
        }
    }
}
