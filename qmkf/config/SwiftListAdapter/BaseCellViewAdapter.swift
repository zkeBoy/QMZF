//
//  BaseCellViewAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/30.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class BaseCellViewAdapter: BaseAdapter, UITableViewDataSource,UITableViewDelegate {
    
    var datas : ZJSON?
    var tableView : UITableView?
    var cellClass : AnyClass?
    
    init(tableView:UITableView, cellClass:AnyClass, datas:ZJSON, xib:Bool) {
        self.datas = datas
        self.tableView = tableView
        self.cellClass = cellClass
        if xib {
            //XIB加载
            let className = (NSStringFromClass(cellClass ).self).components(separatedBy: ".").last!
            tableView.register(UINib.init(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        } else {
            tableView.register(cellClass, forCellReuseIdentifier: NSStringFromClass(cellClass.self))
        }
        if datas.count == 0 {
//            getCurrentWindow()?.makeToast("   无数据   ", duration: 0.6, position: NSValue.init(cgPoint: getCurrentWindow()!.center))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas != nil ? self.datas!.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let className = NSStringFromClass(self.cellClass!).components(separatedBy: ".").last!
        let cell = tableView.dequeueReusableCell(withIdentifier: className) as! BaseTableViewCell
        cell.model = self.datas?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if baseIndexPathBlock != nil {
            baseIndexPathBlock!(indexPath)
        }
    }
    
}
