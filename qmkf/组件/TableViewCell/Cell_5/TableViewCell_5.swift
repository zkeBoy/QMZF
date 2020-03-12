//
//  TableViewCell_5.swift
//  qmkf
//
//  Created by Mac on 2020/1/2.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class TableViewCell_5: BaseTableViewCell {
     
   @IBOutlet weak var title: UILabel!
   @IBOutlet weak var img: UIImageView!
   @IBOutlet weak var houseName: UILabel!
   @IBOutlet weak var privice: UILabel!
   @IBOutlet weak var mianji: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var lianxirenHedianjiliang: UILabel!
    @IBOutlet weak var houseType: UILabel!
    
   override var model : Any? {
       didSet {
           let m = model as! ZJSON
           houseName.text = m["resourcesList"]["name"].string
           title.text = m["title"].string
           privice.text = m["hopePrice"].string
           mianji.text = m["floorSpace"].string
           houseType.text = m["buildingType"].string
           location.text = m["inArea"].string 
           self.imageView!.sd_setImage(with: URL(string: m["resourcesList"]["pictureUrl"].string ?? ""), placeholderImage: UIImage.init(named: "img_04"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
       }
   }
}
