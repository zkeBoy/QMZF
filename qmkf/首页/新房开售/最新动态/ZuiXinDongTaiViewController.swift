//
//  ZuiXinDongTaiViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/18.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ZuiXinDongTaiViewController: ShowNavibarViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "最新动态"
        //XIB加载
        tableView.register(UINib.init(nibName: ZuiXinDongTaiTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ZuiXinDongTaiTableViewCell.reuseId)
        tableView.separatorStyle = .none
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 18
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZuiXinDongTaiTableViewCell.reuseId, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
     
}

class ZuiXinDongTaiTableViewCell : UITableViewCell {
    
    static let reuseId = "ZuiXinDongTaiTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var model : [String : Any]! {
        didSet {
        }
    }
}
