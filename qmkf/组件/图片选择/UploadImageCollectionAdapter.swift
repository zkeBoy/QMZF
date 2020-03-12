
//
//  UploadImageCollectionAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/25.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class UploadImageCollectionAdapter: BaseCollectionCellAdapter {
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddImageCollectionCell.reuseId, for: indexPath) as! AddImageCollectionCell
        cell.model = (self.datas![indexPath.row] as! HomeModel)
        return cell
    }
    
    override func registerCellClasses() -> NSArray {
        [AddImageCollectionCell.reuseId]
    }
}

class AddImageCollectionCell : BaseCollectionViewCell {
    
    static let reuseId = "AddImageCollectionCell"
    @IBOutlet weak var imageView: UIImageView!
    
    override var model : Any? {
        didSet {
            if let image = UIImage.init(named: ((model as! HomeModel).imgName)!) {
                imageView.image = image
            }
        }
    }
     
}
