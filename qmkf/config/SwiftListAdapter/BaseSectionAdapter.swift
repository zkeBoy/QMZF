//
//  BaseSectionAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/24.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class BaseSectionAdapter: BaseAdapter, UITableViewDataSource,UITableViewDelegate {
    
//    var sections : [BaseCellAdapter]?
    var header : UIView?
    var headerHeight : CGFloat = 0
    var cellAdapter : BaseCellAdapter?
     
    init(cellAdapter:BaseCellAdapter, header:UIView, height:CGFloat) {
        super.init()
//        self.sections = (sections as! [BaseCellAdapter])
        self.cellAdapter = cellAdapter
        self.header = header
        self.headerHeight = height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        cellAdapter = self.sections![safe:section]
        return cellAdapter!.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        cellAdapter = self.sections![safe:indexPath.section]
        return cellAdapter!.tableView(tableView, cellForRowAt: indexPath)
    }
     
    func numberOfSections(in tableView: UITableView) -> Int {
//        sections != nil ? sections!.count : 0
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if baseIndexPathBlock != nil {
            baseIndexPathBlock!(indexPath)
        }
    }

    func registerCellClasses() -> NSArray {
        []
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.headerHeight
    }
    
}
