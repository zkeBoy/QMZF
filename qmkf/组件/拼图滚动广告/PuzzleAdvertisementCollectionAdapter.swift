//
//  PuzzleAdvertisement.swift
//  qmkf
//
//  Created by Mac on 2019/12/26.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class PuzzleAdvertisementCollectionAdapter: BaseCollectionCellAdapter {
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PuzzleAdvertisementCollectionCell.reuseId, for: indexPath) as! PuzzleAdvertisementCollectionCell
        cell.model = ZJSON(self.datas![0])["data"]["records"]
        return cell
    }

    override func registerCellClasses() -> NSArray {
        [PuzzleAdvertisementCollectionCell.reuseId]
    }
}

class PuzzleAdvertisementCollectionCell: BaseCollectionViewCell {
    static let reuseId = "PuzzleAdvertisementCollectionCell"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imgview01: UIImageView!
    @IBOutlet weak var imgView02: UIImageView!
    
    override var model : Any? {
        didSet {
            let m = model as! ZJSON
        //            self.imageView!.sd_setImage(with: URL(string: m["imgLink"].string!), completed: nil)
            self.imageView!.sd_setImage(with: URL(string: m["imgLink"].string ?? ""), placeholderImage: UIImage.init(named: "img_04"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
            self.imgview01!.sd_setImage(with: URL(string: m["imgLink"].string ?? ""), placeholderImage: UIImage.init(named: "img_04"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
            self.imgView02!.sd_setImage(with: URL(string: m["imgLink"].string ?? ""), placeholderImage: UIImage.init(named: "img_04"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
        }
    }
}
