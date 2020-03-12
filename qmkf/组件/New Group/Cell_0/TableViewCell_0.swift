//
//  TableViewCell_0.swift
//  qmkf
//
//  Created by Mac on 2019/12/31.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TableViewCell_0: BaseTableViewCell {
    @IBOutlet weak var imgView00: UIImageView!
    @IBOutlet weak var imgView10: UIImageView!
    @IBOutlet weak var label00: UILabel!
    @IBOutlet weak var label01: UILabel!
    @IBOutlet weak var label20: UILabel!
    @IBOutlet weak var label30: UILabel!
    @IBOutlet weak var label40: UILabel!
    @IBOutlet weak var label50: UILabel!
    @IBOutlet weak var label51: UILabel!
    @IBOutlet weak var label60: UILabel!
    @IBOutlet weak var label61: UILabel!
    @IBOutlet weak var label70: UIButton!
 
    override var model: Any? {
        didSet {
            let m = model as! ZJSON
            self.imgView00!.sd_setImage(with: URL(string: m["agentHeadPortrait"].string ?? ""), placeholderImage: UIImage.init(named: "img_04"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
            self.imgView10!.sd_setImage(with: URL(string: m["imgLink"].string ?? ""), placeholderImage: UIImage.init(named: "img_04"), options: SDWebImageOptions.delayPlaceholder, completed: nil)
            self.label00.text = m["agentName"].string ?? ""
            self.label20.text = m["storeName"].string ?? ""
            self.label30.text = m["title"].string ?? ""
            self.label40.text = m["price"].string ?? ""
            self.label50.text = m["status"].string ?? ""
            self.label51.text = m["location"].string ?? ""
            self.label60.text = (m["type"].string ?? "").components(separatedBy: ",").count > 0 ? (m["type"].string ?? "").components(separatedBy: ",")[0] : ""
            self.label61.text = (m["type"].string ?? "").components(separatedBy: ",").count > 1 ? (m["type"].string ?? "").components(separatedBy: ",")[1] : ""
            self.label70.setTitle(m["timeEnd"].string ?? "", for: .normal)
        }
    }
    
}
