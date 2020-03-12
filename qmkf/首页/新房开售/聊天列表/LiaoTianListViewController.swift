//
//  LiaoTianListViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/20.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class LiaoTianListViewController: ShowNavibarViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "消息"
        // XIB注册
        zRegister(tableView,LiaoTianListTableViewCell.reuseId as NSString)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        13
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: LiaoTianListTableViewCell.reuseId, for: indexPath)
                cell.selectionStyle = .none 
        return cell
    }
    

}

class LiaoTianListTableViewCell : UITableViewCell {
    
    static let reuseId = "LiaoTianListTableViewCell"
    
    var model : [String : Any]! {
        didSet {
        }
    }
}
