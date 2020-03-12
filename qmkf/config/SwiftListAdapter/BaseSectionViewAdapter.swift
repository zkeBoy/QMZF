//
//  BaseSectionViewAdapter.swift
//  qmkf
//
//  Created by Mac on 2020/1/4.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class BaseSectionViewAdapter: BaseCellViewAdapter {
 
 var sectionHeader : UIView?
 var sectionFooter : UIView?
    
    init(tableView: UITableView, sectionHeader: UIView? = nil,sectionFooter: UIView!,cellClass: AnyClass, datas: ZJSON, xib: Bool) {
        super.init(tableView: tableView, cellClass: cellClass, datas: datas, xib: xib)
        self.sectionHeader = sectionHeader
        self.sectionFooter = sectionFooter
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.sectionHeader != nil ? self.sectionHeader!.frame.size.height : 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.sectionHeader != nil ? self.sectionHeader! : UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        self.sectionFooter != nil ? self.sectionFooter!.frame.size.height : 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        self.sectionFooter != nil ? self.sectionFooter! : UIView()
    }
}
