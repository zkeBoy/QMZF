//
//  LouPanDetailViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/18.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LouPanDetailViewController: ShowNavibarViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "楼盘详情"
        //XIB加载
        tableView.register(UINib.init(nibName: LouPanDetailTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: LouPanDetailTableViewCell.reuseId)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: LouPanDetailTableViewCell.reuseId, for: indexPath)
        cell.selectionStyle = .none
        return cell
    }
     
}

class LouPanDetailTableViewCell : UITableViewCell {
    
    static let reuseId = "LouPanDetailTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var model : [String : Any]! {
        didSet {
        }
    }
}
