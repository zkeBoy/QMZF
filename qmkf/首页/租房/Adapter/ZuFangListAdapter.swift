//
//  ZuFangCellAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/23.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ZuFangCellAdapter: BaseCellAdapter {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZuFangTableViewCell") as! ZuFangTableViewCell
//        cell.backgroundColor = .red
        cell.model = self.datas![indexPath.row]
        return cell
    }

    override func registerCellClasses() -> NSArray {
        return ["ZuFangTableViewCell"]
    }
}

//class ZuFangSectionAdapter: BaseSectionAdapter {
//     
//}
 
class ZuFangTableViewCell : BaseTableViewCell {
     
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mianji: UILabel!
    @IBOutlet weak var xiaoqu: UILabel!
    @IBOutlet weak var houseType: UILabel!
    @IBOutlet weak var saleStatus: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var type1: UILabel!
    @IBOutlet weak var type2: UILabel!
    @IBOutlet weak var jijiren: UILabel!
    @IBOutlet weak var jinjirenImg: UIImageView!
    @IBOutlet weak var shop: UILabel!
    
    override var model : Any? {
           didSet {
               let m = model as! ZJSON
               titleLabel.text = m["title"].string
               mianji.text = "\(m["inArea"].int ?? 0)m²"
               xiaoqu.text = m["residentiaName"].string ?? m["name"].string
   //            houseType.text = m["buildingType"].string
               saleStatus.text = m["status"].string ?? m["salesStatus"].string
               location.text = m["title"].string
               type1.text = m["label"].string ?? ""
               type2.text = m["title"].string
               jijiren.text = m["title"].string
               shop.text = m["title"].string
        }
    }
} 
