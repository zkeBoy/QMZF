//
//  FunctionCollectionAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/24.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class FunctionCollectionAdapter: BaseCollectionCellAdapter {
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FunctionCollectionCell.reuseId, for: indexPath) as! FunctionCollectionCell
        cell.model = (self.datas![indexPath.row] as! HomeModel)
        return cell
    }
    
    override func registerCellClasses() -> NSArray {
        [FunctionCollectionCell.reuseId]
    }
}
 
class FunctionCollectionCell : BaseCollectionViewCell {
    
    static let reuseId = "FunctionCollectionCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override var model : Any? {
           didSet {
               let m = model as! HomeModel
            if let image = UIImage.init(named: (m.name)!) {
                imageView.image = image
            }
            if let textTheme = m.textTheme {
                self.titleLabel.textColor = textTheme.color
                self.titleLabel.font = UIFont.systemFont(ofSize:textTheme.size!)
            }
            if let title = m.name {
                titleLabel.text = title
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
