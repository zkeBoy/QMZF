//
//  BaiKeContentTableViewAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/26.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class BaiKeContentTableViewAdapter: BaseCellAdapter {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaiKeContentTableViewCell.reuseId) as! BaiKeContentTableViewCell
//        cell.model = (self.datas![indexPath.row] as! HomeModel)
        cell.backgroundColor = .clear
        return cell
    }

    override func registerCellClasses() -> NSArray {
        return [BaiKeContentTableViewCell.reuseId]
    }
}
 
class BaiKeContentTableViewCell : BaseTableViewCell {
    
    static let reuseId = "BaiKeContentTableViewCell"
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override var model : Any? {
           didSet {
               let m = model as! HomeModel
            if let image = UIImage.init(named: (m.name)!) {
                imgView.image = image
            }
            if let title = m.name {
                titleLabel.text = title
            }
        }
    }
}
