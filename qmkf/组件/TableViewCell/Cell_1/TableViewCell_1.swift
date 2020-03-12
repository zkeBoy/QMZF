//
//  TableViewCell_1.swift
//  qmkf
//
//  Created by Mac on 2019/12/31.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TableViewCell_1: BaseTableViewCell {

    @IBOutlet weak var img: UIImageView!
     @IBOutlet weak var shop: UILabel!
     @IBOutlet weak var name: UILabel!
     @IBOutlet weak var numOfHouse: UILabel!
     
    override var model : Any? {
        didSet {
            let m = model as! ZJSON
            name.text = m["name"].string
//            type.text = m["showType"].string
            shop.text = m["storeName"].string
            numOfHouse.text = m["status"].string
              
            self.imageView!.sd_setImage(with: URL(string: m["resourcesList"]["pictureUrl"].string ?? ""), placeholderImage: UIImage.init(named: "img_04"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
        }
    }
}
