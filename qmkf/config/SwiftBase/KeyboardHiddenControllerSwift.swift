//
//  KeyboardHiddenControllerSwift.swift
//  qmkf
//
//  Created by Mac on 2019/12/6.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation

class KeyboardHiddenController : SwiftBaseViewController {
      
    override func viewDidLoad() {
        super.viewDidLoad()
         
        //通知中心
        let center = NotificationCenter.default
        //当键盘将要弹起时候执行方法UIKeyboardWillShowNotification
        center.addObserver(self, selector: #selector(willChange(notice:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //键盘将要收起时执行方法UIKeyboardWillHideNotification
        center.addObserver(self, selector: #selector(willChange(notice:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //键盘出现的方法,此处比较难得地方是如何获取通知里的内容，
    @objc func willChange(notice : NSNotification) {
        
        let originRect = self.view.frame
        if notice.name.rawValue == UIResponder.keyboardWillShowNotification.rawValue {
            //            //1.获取动画执行的时间
            //            let duration = notice.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! Double
            //2. 获取键盘最终的Y值
            let endFrame = (notice.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue).cgRectValue
            let y = endFrame.origin.y
            //       //3.计算键盘顶部距离屏幕顶部的间距
            //       let margin =  UIScreen.main.bounds.height - y
            
            //获取输入框焦点
            let view  = findFirstResponder(self.view)
            
            var window : Any//: UIWindow? // = GetCurrentWindow;
            weak var delegate = UIApplication.shared.delegate
            if delegate?.responds(to: #selector(getter: UIApplicationDelegate.window)) ?? false {
                window = delegate?.perform(#selector(getter: UIApplicationDelegate.window))?.retain().takeRetainedValue() ?? UIWindow()
            } else {
                window = UIApplication.shared.keyWindow ?? UIWindow()
            }
            
            //计算响应者到和屏幕的绝对位置
            do {
                let point = zCovertToWindowFrame(view ?? UIView())
//            if let windowObj = window as? UIWindow {
//                point = windowObj.convert(CGPoint(x: 0, y: 0), to: view)
                
                //cell的maxY值
                let cellMaxY = (-point.y + (view?.frame.size.height ?? 0)) - y
                
                if cellMaxY > 0 {
                    UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                        self.view.frame = CGRect.init(x: 0, y: -cellMaxY - 5, width: originRect.size.width, height: originRect.size.height)
                    }, completion: nil)
                }
            }
        } else {
            let navHeight : CGFloat
            navHeight = getCurrentVC().view!.frame.size.height == CGFloat(zScreenHeight) - CGFloat(zNaviBar_Height) ? CGFloat(zNaviBar_Height) : 0
            
            UIView.animate(withDuration: 0.25, delay: 0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.view.frame = CGRect.init(x: 0, y: navHeight, width: originRect.size.width, height: originRect.size.height)
            }, completion: nil)
        }
        
        //       // toolBarBottomCons
    }
}

func zCovertToWindowFrame(_ view: UIView) -> CGPoint {
    var window : Any//: UIWindow? // = GetCurrentWindow;
    weak var delegate = UIApplication.shared.delegate
    if delegate?.responds(to: #selector(getter: UIApplicationDelegate.window)) ?? false {
        window = delegate?.perform(#selector(getter: UIApplicationDelegate.window))?.retain().takeRetainedValue() ?? UIWindow()
    } else {
        window = UIApplication.shared.keyWindow ?? UIWindow()
    }
    
    //计算响应者到和屏幕的绝对位置
    var point = CGPoint(x: 0, y: 0)
    if let windowObj = window as? UIWindow {
        point = windowObj.convert(CGPoint(x: 0, y: 0), to: view)
    }
    return point
}
