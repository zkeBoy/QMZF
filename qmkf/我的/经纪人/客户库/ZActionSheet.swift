

//
//  ZActionSheet.swift
//  qmkf
//
//  Created by Mac on 2020/1/5.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ZActionSheet: UIView {
    
    let tableView = UITableView()
    let backActionView = UIView()
    let wrapperView = UIView()
    let triangleView = UIView()
    var adapters = NSMutableArray(capacity: 2)
    
    class func show(_ sender: UIView, _ data:[String]) {
        let sheet = ZActionSheet.init(data: data, frame: CGRect(x: 0, y: 0, width: 0, height: 36))
        let point = zCovertToWindowFrame(sender)
        sheet.tableView.x = -point.x - sheet.tableView.width / 1.7
        sheet.tableView.y = -point.y + sender.frame.size.height
        
        sheet.triangleView.x = sheet.tableView.x + sheet.tableView.width - sheet.triangleView.width - 3
        sheet.triangleView.y = sheet.tableView.y - 8
        
        sheet.setShadow()
        sheet.zPathView([
            CGPoint(x: sheet.triangleView.width / 2, y: 0),
            CGPoint(x: 0, y: sheet.triangleView.height),
            CGPoint(x: sheet.triangleView.width, y: sheet.triangleView.height),
        ], in: sheet.triangleView)
        sheet.zPathShadow([
            CGPoint(x: sheet.triangleView.width / 2, y: 0),
            CGPoint(x: 0, y: sheet.triangleView.height),
            CGPoint(x: sheet.triangleView.width, y: sheet.triangleView.height),
        ], in: sheet.triangleView)
        
        UIApplication.shared.keyWindow?.addSubview(sheet)
    }
    
    func zPathView(_ pathPoint:[CGPoint], in view: UIView) {
        let path = UIBezierPath()
        path.move(to: pathPoint[0])
        for point in pathPoint {
            path.addLine(to: point)
        }
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.white.cgColor
        layer.path = path.cgPath
        
        view.layer.addSublayer(layer)
    }
    
    func zPathShadow(_ pathPoint:[CGPoint], in view: UIView) {
        let path = UIBezierPath()
        path.move(to: pathPoint[0])
        for point in pathPoint {
            path.addLine(to: point)
        }
        
        view.layer.shadowColor = UIColor.gray.cgColor;
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 4
        view.layer.cornerRadius = 4
        view.layer.shadowPath = path.cgPath
    }
    
    func setShadow() {
        
        wrapperView.layer.shadowColor = UIColor.gray.cgColor;
        wrapperView.layer.shadowOpacity = 0.3
        wrapperView.layer.shadowRadius = 4
        wrapperView.layer.cornerRadius = 4
        wrapperView.layer.shadowOffset = CGSize(width: 0, height: 0)
        wrapperView.backgroundColor = .white
        wrapperView.frame = self.tableView.frame
        self.insertSubview(wrapperView, belowSubview: self.tableView)
    }
    
    deinit {
        print("**********",ZActionSheet.self,"deinit","**********")
    }
    
    @objc func tap() {
        UIView.animate(withDuration: 0.2, animations: { 
            self.alpha = 0
        }) { (result) in
            self.removeFromSuperview()
        }
    }
    
    convenience init(data:[String], frame: CGRect) {
         
        var longest = 0
        for str in data {
            str.count > longest ? (longest = str.count) : (longest = longest)
        }
        
        let size = frame.size
        self.init(frame: CGRect(x: 0, y: 0, width: zScreenWidth, height: zScreenHeight))
        
        backActionView.frame = self.frame
        backActionView.addTapAction(self, #selector(tap))
        
        self.addSubview(backActionView)
        
        tableView.frame = CGRect(x: 0, y: 0, width: longest * 15 + 20, height: Int(size.height * CGFloat(data.count)))
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.layer.cornerRadius = 3
        
        self.addSubview(tableView)
        
        triangleView.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
        triangleView.backgroundColor = .clear
        self.addSubview(triangleView)
        
        let adapter = ZActionSheetCellViewAdapter(tableView: tableView, cellClass: ZActionSheetCell.self, datas: data, xib:false)
        tableView.dataSource = adapter
        tableView.delegate = adapter
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            print(indexPath.row)
        }
        self.adapters.add(adapter)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

class ZActionSheetCell : UITableViewCell {
    
    static let reuseId = "ZActionSheetCell"
    let label = UILabel()
    let line = UIView()
      
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.textAlignment = .center
        
        line.backgroundColor = zHEX(hexValue: 0xEEEEEE)
        
        self.addSubview(label)
        self.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var model : String! {
        didSet {
            if let _ = model {
                label.text = model
            }
        }
    }
}

class ZActionSheetCellViewAdapter: NSObject, UITableViewDataSource,UITableViewDelegate {
    
    typealias BaseBlock = () -> () //或者 () -> Void
    typealias BaseIndexPathBlock = (IndexPath) -> ()
    
    var baseBlock : BaseBlock?
    var baseIndexPathBlock : BaseIndexPathBlock?
    
    var datas : [String]?
    var tableView : UITableView?
    var cellClass : AnyClass?
    
    init(tableView:UITableView, cellClass:AnyClass, datas:[String], xib:Bool) {
        self.datas = datas
        self.tableView = tableView
        self.cellClass = cellClass
        let className = (NSStringFromClass(cellClass ).self).components(separatedBy: ".").last!
        if xib {
            //XIB加载
            tableView.register(UINib.init(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        } else {
            tableView.register(cellClass, forCellReuseIdentifier: className)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas != nil ? self.datas!.count : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.tableView!.frame.size.height / CGFloat(self.datas!.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let className = NSStringFromClass(self.cellClass!).components(separatedBy: ".").last!
        let cell = tableView.dequeueReusableCell(withIdentifier: className) as! ZActionSheetCell
        let height = self.tableView!.frame.size.height / CGFloat(self.datas!.count)
        cell.label.frame = CGRect(x: 0, y: 0, width: self.tableView!.frame.size.width, height: height)
        cell.line.frame = CGRect(x: 0, y: height - 0.5, width: self.tableView!.frame.size.width, height: 0.5)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        cell.model = (self.datas![indexPath.row] as! String)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if baseIndexPathBlock != nil {
            baseIndexPathBlock!(indexPath)
        }
    }
    
}
