//
//  BaseTableView.swift
//  qmkf
//
//  Created by Mac on 2019/12/24.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.separatorStyle = .none
    }
}
