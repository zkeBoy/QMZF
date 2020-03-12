//
//  ZhaoJinJiRenViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/16.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class ZhaoJinJiRenViewController : HideNavibarViewController,UITableViewDelegate,UITableViewDataSource {
     
    @IBOutlet weak var myTable: UITableView!
    var dataModel : ZJSON? {
        didSet {
            self.myTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTable()
        getData()
    }
    
    func getData() {

        let parameters : ZParameters = [
                "curPage": 0,
                "name": "string",
                "pageSize": 0
            ]
        weak var weakSelf = self
        post("user/agent/list", parameters: parameters, true, false) {(result) in
            weakSelf!.dataModel = ZJSON(result)
        }
    }
    
    func initTable() {
        myTable.delegate = self
        myTable.dataSource = self
        myTable.showsVerticalScrollIndicator = false
        myTable.separatorStyle = .none
        
        //XIB加载
        myTable.register(UINib.init(nibName: ZhaoJinJiRenTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: ZhaoJinJiRenTableViewCell.reuseId)
         
    } 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModel?["data"]["records"].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ZhaoJinJiRenTableViewCell.reuseId, for: indexPath) as! ZhaoJinJiRenTableViewCell
        cell.selectionStyle = .none
        cell.model = self.dataModel!["data"]["records"][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let xinFangDetail = "xinFangDetail"
//        self.performSegue(withIdentifier: xinFangDetail, sender: "")
    }
}

class ZhaoJinJiRenTableViewCell : UITableViewCell {
    
    static let reuseId = "ZhaoJinJiRenTableViewCell"
    @IBOutlet weak var imgT: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var shop: UILabel!
    @IBOutlet weak var numOfHouse: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func call(_ sender: Any) {
    }
    @IBAction func send(_ sender: Any) {
    }
    
    var model : Any! {
        didSet {
            let m = ZJSON(model)
            name.text = m["name"].string
//            type.text = m["showType"].string
            shop.text = m["storeName"].string
            numOfHouse.text = m["status"].string
//            self.imgT!.sd_setImage(with: URL(string: m["headPortrait"].string!), completed: nil)
        }
    }
}
