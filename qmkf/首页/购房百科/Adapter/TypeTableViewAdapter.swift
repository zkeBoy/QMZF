//
//  TypeTableViewCell.swift
//  qmkf
//
//  Created by Mac on 2019/12/26.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class TypeTableViewAdapter: BaseCellAdapter {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTableViewCell") as! TypeTableViewCell
        cell.model = (self.datas![indexPath.row] as! HomeModel)
        return cell
    }
    
    lazy var onceCode: Void = {
        // 写下想要执行一次的代码
        (self.datas![0] as! HomeModel).selected = false
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView!.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        (self.datas![indexPath.row] as! HomeModel).selected = true
        if indexPath.row != 0 {
            _ = onceCode
        }
        UIView.performWithoutAnimation {
            self.tableView!.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        }
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.none)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        (self.datas![indexPath.row] as! HomeModel).selected = false
        self.tableView!.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }
    
    override func registerCellClasses() -> NSArray {
        return ["TypeTableViewCell"]
    }
}

class TypeTableViewCell : BaseTableViewCell {
    static let reuseId = "TypeTableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    override var model : Any? {
        didSet {
            let m = model as! HomeModel
            if let title = m.name {
                titleLabel.text = title
            }
            if m.selected == true {
                self.titleLabel.textColor = zHEX(hexValue: 0xFF1A76)
                self.statusView.isHidden = false
            } else {
                self.titleLabel.textColor = .black
                self.statusView.isHidden = true
            }
        }
    }
}
