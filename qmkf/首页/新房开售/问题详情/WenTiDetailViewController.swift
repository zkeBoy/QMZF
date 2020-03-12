//
//  WenTiDetailViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class WenTiDetailViewController: ShowNavibarViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "问题详情"
        
        //XIB加载
        tableView.register(UINib.init(nibName: WenTiDetailDaTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: WenTiDetailDaTableViewCell.reuseId)
        tableView.register(UINib.init(nibName: WenTiDetailWenTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: WenTiDetailWenTableViewCell.reuseId)
         
        let zeroHeader = UIView(frame: CGRect(x: 0, y: 0, width: 0.01, height: 0.01))
        tableView.tableHeaderView = zeroHeader
        
        tableView.backgroundColor = zHEX(hexValue: 0xF7F7F7)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 11
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        8
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = zHEX(hexValue: 0xF7F7F7)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 26
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let imageView = UIImageView.init(image: UIImage.init(named: "icon_a"))
        imageView.frame = CGRect(x: 12, y: 11, width: 15, height: 15)
        view.addSubview(imageView)
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WenTiDetailWenTableViewCell.reuseId, for: indexPath)
                    cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WenTiDetailDaTableViewCell.reuseId, for: indexPath)
                    cell.selectionStyle = .none 
            return cell
        }
    }
    
    
}

class WenTiDetailDaTableViewCell : UITableViewCell {
    
    static let reuseId = "WenTiDetailDaTableViewCell"
    
    var model : [String : Any]! {
        didSet {
        }
    }
}

class WenTiDetailWenTableViewCell : UITableViewCell {
    
    static let reuseId = "WenTiDetailWenTableViewCell"
    
    var model : [String : Any]! {
        didSet {
        }
    }
}
