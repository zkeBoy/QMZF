//
//  CollectionViewCell_2.swift
//  qmkf
//
//  Created by Mac on 2020/1/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class CollectionViewCell_2: BaseCollectionViewCell {

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
