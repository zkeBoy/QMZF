//
//  WoDeViewController.swift
//  qmkf
//
//  Created by Mac on 2019/12/30.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class WoDeViewController: HideNavibarViewController {
    
    @IBOutlet weak var setByUserTypeCollectionView: UICollectionView!
    @IBOutlet weak var setByUserTypeCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var commonCollectionView: UICollectionView!
    @IBOutlet weak var commonCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initFunction(setByUserTypeCollectionView)
        initCommonFunction(commonCollectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameLabel.text = username as! String
    }
    
    @IBAction func setting(_ sender: Any) {
        let vc = AISettingViewController() 
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initFunction(_ collectionView : UICollectionView) {
        
        let tempArr = NSMutableArray()
        var countPerLine = 3
        var heightPerLine = 99
        if userType() == .TypeUser {
            loadWoDeGeRenFunctionList(tempArr)
        } else {
            loadWoDeJinJiRenFunctionList(tempArr)
            countPerLine = 4
            heightPerLine = 85
        }
        
        for model in tempArr {
            (model as! HomeModel).textTheme.size = 14
        }
        
        setByUserTypeCollectionViewHeight.constant = CGFloat((tempArr.count / countPerLine + 1) * heightPerLine)
        if tempArr.count % countPerLine == 0{
            // 0,3,6...
            setByUserTypeCollectionViewHeight.constant = CGFloat(tempArr.count / countPerLine * heightPerLine)
        }
        setupVerticalCollectionFlowlayout(collectionView,zScreenWidth / CGFloat(countPerLine), CGFloat(heightPerLine))
        
        let adapter = FunctionCollectionAdapter(collectionView: collectionView,datas: tempArr , xib:true)
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            if userType() == .TypeJinJiRen {
                switch indexPath.row {
                case 0:
                    zPush(weakSelf!, "woDeFangYuan", nil)
                    break
                case 1:
                    zPush(weakSelf!, "jinJiRenRengZheng", nil)
                    break
                case 2:
                    zPush(weakSelf!, "gouMaiHuiYuan", nil)
                    break
                case 3:
                    zPush(weakSelf!, "woDeQianBao", nil)
                    break
                case 4:
                    zPush(weakSelf!, "keHuKu", nil)
                    break
                case 5:
                    zPush(weakSelf!, "keHuYueYu", nil)
                    break
                case 6:
                    zPush(weakSelf!, "qiangFangYuan", nil)
                    break
                case 7:
                    zPush(weakSelf!, "woDeXinXi", nil)
                    break
                case 8:
                    zPush(weakSelf!, "zengZhiFuWu", nil)
                    break
                case 10:
                    zPush(weakSelf!, "ziDongHuiFu", nil)
                    break
                default:
                    break
                }
            } else {
                switch indexPath.row {
                case 0:
                    zPush(weakSelf!, "woDeYuYue", nil)
                    break
                case 1:
                    zPush(weakSelf!, "woDeChuZu", nil)
                    break
                case 2:
                    zPush(weakSelf!, "woDeWeiTuo", nil)
                    break
                case 3:
                    zPush(weakSelf!, "jinJiRenRengZheng", nil)
                    break
                default:
                    break
                }
            }
        }
        self.adapters.add(adapter)
    }
    
    func initCommonFunction(_ collectionView : UICollectionView) {
        
        let tempArr = NSMutableArray()
        
        loadWoDeCommonFunctionList(tempArr)
        for model in tempArr {
            (model as! HomeModel).textTheme.size = 14
        }
        
        commonCollectionViewHeight.constant = CGFloat((tempArr.count / 3 + 1) * 85)
        if tempArr.count % 3 == 0{
            // 0,3,6...
            commonCollectionViewHeight.constant = CGFloat(tempArr.count / 3 * 85)
        }
        setupVerticalCollectionFlowlayout(collectionView,zScreenWidth / 3, 85)
        
        let adapter = FunctionCollectionAdapter(collectionView: collectionView,datas: tempArr , xib:true)
        collectionView.dataSource = adapter
        collectionView.delegate = adapter
        
        weak var weakSelf = self
        adapter.baseIndexPathBlock = {(indexPath) -> () in
            switch indexPath.row {
            case 0:
                zPush(weakSelf!, "woDeGuanZhu", nil)
                break
            case 1:
                zPush(weakSelf!, "woDeShouCang", nil)
                break
            case 2:
                zPush(weakSelf!, "woDeZuJi", nil)
                break
            case 3:
                zPush(weakSelf!, "lianXiPingTai", nil)
                break
            case 4:
                zPush(weakSelf!, "woDeZuJi", nil)
                break
            default:
                break
            }
        }
        self.adapters.add(adapter)
    }
}
