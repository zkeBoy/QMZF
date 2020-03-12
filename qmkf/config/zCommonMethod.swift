//
//  zCommonMethond.swift
//  qmkf
//
//  Created by Mac on 2019/12/6.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import MJRefresh

//查找第一响应者
func findFirstResponder(_ view: UIView?) -> UIView? {
    if view?.isFirstResponder ?? false {
        return view
    }
    for subView in view?.subviews ?? [] {
        let firstResponder = findFirstResponder(subView)
        if firstResponder != nil {
            return firstResponder
        }
    }
    return nil
}

func mj_refresh(_ v : UIScrollView, _ vc : UIViewController, _ refreshingAction : Selector) {
    
    // 顶部刷新
    let header = MJRefreshNormalHeader() 
    header.setRefreshingTarget(vc, refreshingAction: refreshingAction)
    header.setTitle("下拉刷新", for: .idle)
    header.setTitle("释放刷新", for: .pulling)
    header.setTitle("正在刷新...", for: .refreshing)
    v.mj_header = header
    header.beginRefreshing()
}

func z_input(_ sender : Any, _ vc : UIViewController) {
    let tf = sender as! UITextField
    tf.endEditing(true)
    let inputVC = InputViewController()
    inputVC.baseBlock = {(str)->() in
        
        tf.text = (str as! String)
    }
    vc.present(inputVC, animated: true, completion: nil)
}

func getCurrentWindow() -> UIWindow? {
    let rootVC = UIApplication.shared.delegate as! AppDelegate
    return rootVC.window
}

// 注册xib
func zRegister(_ tableView: UITableView, _ identifier: NSString) {

    tableView.register(UINib.init(nibName: identifier as String, bundle: nil), forCellReuseIdentifier: identifier as String)
}

// 跳转新页面
func zPush(_ from: UIViewController, _ identifier: NSString, _ sender : Any?) {
    from.performSegue(withIdentifier: identifier as String, sender: sender)
}
