//
//  PuzzleAdvertisement.swift
//  qmkf
//
//  Created by Mac on 2019/12/24.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class PuzzleAdvertisementCollectionAdapter: BaseCollectionCellAdapter {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PuzzleAdvertisementCollectionCell.reuseId, for: indexPath) as! PuzzleAdvertisementCollectionCell
        cell.model = (self.datas![indexPath.row] as! HomeModel)
        return cell
    }
    
    override func registerCellClasses() -> NSArray {
        [PuzzleAdvertisementCollectionCell.reuseId]
    }
    
}

class PuzzleAdvertisementCollectionCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    static let reuseId = "PuzzleAdvertisementCollectionCell"
    
    var model : HomeModel? {
        didSet {
            if let image = UIImage.init(named: (model?.name)!) {
                imageView.image = image
            }  
        }
    }
}
