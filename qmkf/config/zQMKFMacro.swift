//
//  zQMKFMacro.swift
//  qmkf
//
//  Created by Mac on 2019/12/7.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import SwiftyJSON
import MJRefresh

let Z_DEBUG = true

public typealias ZParameters = [String: Any]
public typealias ZJSON = JSON

var advertiseDataModel : ZJSON?
var houseID = "2d93acd7be3b503a23dd3ef0eece2214"
var detailTitle = "新房"
var token = UserDefaults.standard.object(forKey: "token") ?? ""
var username = UserDefaults.standard.object(forKey: "username") ?? "点击登录/注册"

enum LouPanListType: String {
    case TypeAll = "全部"
    case TypeNew = "最新"
    case TypeSale = "在售"
}

enum UserType: String {
    case TypeUser = "用户"
    case TypeJinJiRen = "经纪人"
}

func UserTypeString(_ type: UserType) -> String {
    var typeStr = ""
    switch type {
    case .TypeUser:
        typeStr = "用户"
        break
    case .TypeJinJiRen:
        typeStr = "经纪人"
        break
    default:
        typeStr = "用户"
    }
    return typeStr
}

var loupanType : LouPanListType!

let xinPanDetail = "xinPanDetail"
let zhaoJinJiRen = "zhaoJinJiRen"
let louPanList = "louPanList"
let shaPan = "shaPan"
let wenTiDetail = "wenTiDetail"
let erShouDetail = "erShouDetail" 

func zLoginStoryboard(_ name: NSString) -> Any {
    
    if name.isEqual(to: "") {
        return getInitialVC(name: "Login")
    }
    return getSBVC(name as String, "Login")
}

func zHomeStoryboard(_ name: NSString) -> Any {
    
    if name.isEqual(to: "") {
        return getInitialVC(name: "Home")
    }
    return getSBVC(name as String, "Home")
}

func zXinFangStoryboard(_ name: NSString) -> Any {
    
    if name.isEqual(to: "") {
        return getInitialVC(name: "XinFang")
    }
    return getSBVC(name as String, "XinFang")
}

func zErShouFangStoryboard(_ name: NSString) -> Any {
    
    if name.isEqual(to: "") {
        return getInitialVC(name: "ErShouFang")
    }
    return getSBVC(name as String, "ErShouFang")
}

func zZuFangStoryboard(_ name: NSString) -> Any {
    
    if name.isEqual(to: "") {
        return getInitialVC(name: "ZuFang")
    }
    return getSBVC(name as String, "ZuFang")
}

func zBaiKeStoryboard(_ name: NSString) -> Any {
    
    if name.isEqual(to: "") {
        return getInitialVC(name: "BaiKe")
    }
    return getSBVC(name as String, "BaiKe") 
}

func zTuiJianStoryboard(_ name: NSString) -> Any {
    
    if name.isEqual(to: "") {
        return getInitialVC(name: "TuiJian")
    }
    return getSBVC(name as String, "TuiJian")
}

func zZiXunStoryboard(_ name: NSString) -> Any {
    
    if name.isEqual(to: "") {
        return getInitialVC(name: "ZiXun")
    }
    return getSBVC(name as String, "ZiXun")
}

func zXiaoXiStoryboard(_ name: NSString) -> Any {
    
    if name.isEqual(to: "") {
        return getInitialVC(name: "XiaoXi")
    }
    return getSBVC(name as String, "XiaoXi")
}

func zWoDeStoryboard(_ name: NSString) -> Any {
    
    if name.isEqual(to: "") {
        return getInitialVC(name: "WoDe")
    }
    return getSBVC(name as String, "WoDe")
}

func getSBVC(_ defaultName : String,_ vcName : String) -> Any {
    
    if #available(iOS 13.0, *) {
        return UIStoryboard.init(name: vcName, bundle: nil).instantiateViewController(identifier: defaultName as String)
    } else {
        
        return UIStoryboard(name: vcName, bundle: nil).instantiateViewController(withIdentifier: defaultName as String)
    }
}

func getInitialVC(name : NSString) -> UIViewController {
    return UIStoryboard.init(name: name as String, bundle: nil).instantiateInitialViewController()!
}

func setupHorizontalCollectionFlowlayout(_ collectionView : UICollectionView, _ width : CGFloat, _ height : CGFloat) {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: width, height: height)
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
    flowLayout.scrollDirection = .horizontal
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    collectionView.collectionViewLayout = flowLayout
}

func setupVerticalCollectionFlowlayout(_ collectionView : UICollectionView, _ width : CGFloat, _ height : CGFloat) {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.itemSize = CGSize(width: width, height: height)
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
    flowLayout.scrollDirection = .vertical
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    collectionView.collectionViewLayout = flowLayout
}

func loadFunctionList(_ array : NSMutableArray) {
    loadPList(array, "FunctionData.plist")
}

func loadZuFangFunctionList(_ array : NSMutableArray) {
    loadPList(array, "ZuFangFunction.plist")
}

func loadZiXunFunctionList(_ array : NSMutableArray) {
    loadPList(array, "ZiXun.plist")
}

func loadWoDeCommonFunctionList(_ array : NSMutableArray) {
    loadPList(array, "WoDeCommon.plist")
}

func loadWoDeJinJiRenFunctionList(_ array : NSMutableArray) {
    loadPList(array, "WoDeJinJiRen.plist")
}

func loadWoDeGeRenFunctionList(_ array : NSMutableArray) {
    loadPList(array, "WoDeGeRen.plist")
}

func loadErShouFunctionList(_ array : NSMutableArray) {
    loadPList(array, "ErShouFunction.plist")
}


func loadAdvertisementList(_ array : NSMutableArray) {
    loadPList(array, "AdvertisementData.plist")
}

func loadPList(_ array : NSMutableArray, _ fileName : String) {
    
    let stemp: NSArray = NSArray(contentsOfFile: Bundle.main.path(forResource: fileName, ofType: nil)!)!
    for dict in stemp {
        let model = HomeModel.init(dict: dict as! [String : Any])
        array.add(model)
    }
}

func loadFakeModelData(_ array : NSMutableArray, _ count : Int) {
    for _ in 0..<count {
        let dict = ["name":"呵呵",
                    "imgName":"img_00",
                    "index":"0",]
        let model = HomeModel.init(dict: dict as [String : Any])
        model.textTheme = zTextTheme()
        array.add(model)
    }
}
