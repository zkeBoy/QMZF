//
//  AdvertisementMarginCollcetionAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/30.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class AdvertisementMarginCollcetionAdapter: BaseCollectionCellAdapter {
     
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertisementMarginCollcetionCell.reuseId, for: indexPath) as! AdvertisementMarginCollcetionCell
        cell.model = (self.datas![indexPath.row] as! HomeModel)
        return cell
    }
    
    override func registerCellClasses() -> NSArray {
        return ["AdvertisementMarginCollcetionCell"]
    }
}


class AdvertisementMarginCollcetionCell : BaseCollectionViewCell {
    
    static let reuseId = "AdvertisementMarginCollcetionCell"
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
