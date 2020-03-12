//
//  AdvertisementCollcetionAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/26.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class AdvertisementCollcetionAdapter: BaseCollectionCellAdapter {
     
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementCollectionCell.reuseId, for: indexPath) as! AdvertisementCollectionCell
        cell.model = (self.datas![indexPath.row] as! HomeModel)
        return cell
    }
    
    override func registerCellClasses() -> NSArray {
        return ["AdvertisementCollectionCell"]
    }
}


class AdvertisementCollectionCell : BaseCollectionViewCell {
    
    static let reuseId = "AdvertisementCollectionCell"
    @IBOutlet weak var imageView: UIImageView!
    
    override var model : Any? {
           didSet {
               let m = model as! HomeModel
            if let image = UIImage.init(named: (m.imgName)!) {
                imageView.image = image
            }
        }
    }
    
}
