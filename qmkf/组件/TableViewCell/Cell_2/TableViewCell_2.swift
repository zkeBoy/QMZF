//
//  TableViewCell_1.swift
//  qmkf
//
//  Created by Mac on 2019/12/31.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TableViewCell_2: BaseTableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var label00: UILabel!
    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label10: UILabel!
    @IBOutlet weak var label20: UILabel!
    @IBOutlet weak var label21: UILabel!
    @IBOutlet weak var label30: UILabel!
    @IBOutlet weak var label31: UILabel!
    @IBOutlet weak var label40: UIButton!
      
    override var model: Any? {
        didSet {
            let m = model as! ZJSON
            self.imgView!.sd_setImage(with: URL(string: m["imgLink"].string ?? ""), placeholderImage: UIImage.init(named: "img_04"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
            self.label00.text = m["residentiaName"].string ?? ""
            self.label01.text = m["houseType"].string ?? ""
            self.label10.text = m["hopePrice"].string ?? ""
            self.label20.text = m["status"].string ?? ""
            self.label21.text = m["location"].string ?? ""
            self.label30.text = (m["tagsType"].string ?? "").components(separatedBy: ",").count > 0 ? (m["tagsType"].string ?? "").components(separatedBy: ",")[0] : ""
            self.label31.text = (m["tagsType"].string ?? "").components(separatedBy: ",").count > 1 ? (m["tagsType"].string ?? "").components(separatedBy: ",")[1] : ""
            self.label40.setTitle(m["releaseTime"].string ?? "", for: .normal) 
        }
    }
}
