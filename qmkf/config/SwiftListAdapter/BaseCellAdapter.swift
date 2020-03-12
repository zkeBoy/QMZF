//
//  BaseCellAdapter.swift
//  qmkf
//
//  Created by Mac on 2019/12/23.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class BaseCellAdapter: BaseAdapter, UITableViewDataSource,UITableViewDelegate {
    
    var datas : ZJSON?
    var tableView : UITableView?
    
    init(tableView:UITableView, datas:ZJSON, xib:Bool) {
        super.init()
        self.datas = datas
        self.tableView = tableView
        for claz in registerCellClasses() {
            if xib {
                //XIB加载
                let className = claz as! String 
                tableView.register(UINib.init(nibName: className, bundle: nil), forCellReuseIdentifier: className)
            } else {
                tableView.register((claz as! AnyClass), forCellReuseIdentifier: NSStringFromClass((claz as! AnyClass).self))
            }
        }
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas != nil ? self.datas!.count : 0
    } 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { 
        if baseIndexPathBlock != nil {
            baseIndexPathBlock!(indexPath)
        }
    }

    func registerCellClasses() -> NSArray {
        []
    }
}
