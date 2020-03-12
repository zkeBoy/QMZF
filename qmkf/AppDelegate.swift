//
//  AppDelegate.swift
//  qmkf
//
//  Created by Mac on 2019/12/5.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

@UIApplicationMain
@objcMembers class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        AppDelegate.createRootVC()
        testHttp()
        
        return true
    }
    
    class func createRootVC() {
        let rootVC = UIApplication.shared.delegate as! AppDelegate
        if loginStauts() {
            // 主页
            var tab : UITabBarController?
            
            let vcClassArr = [["HomeNav","首页","icon_home","icon_home_selected"],["TuiJianNav","推荐","icon_tuij","icon_tuij_selected"],["ZiXunNav","资讯","icon_zx","icon_zx_selected"],["XiaoXiNav","消息","icon_msg","icon_msg_selected"],["WoDeNav","我的","icon_mine","icon_mine_selected"]]
            var vcArr = [UIViewController]()
            for index in 0..<vcClassArr.count {
                let type = vcClassArr[index]
                
                var vcNav : UINavigationController?
                
                switch index {
                case 0:
                    vcNav = (zHomeStoryboard(type[0] as NSString) as! UINavigationController)
                    break
                case 1:
                    vcNav = (zTuiJianStoryboard(type[0] as NSString) as! UINavigationController)
                    break
                case 2:
                    vcNav = (zZiXunStoryboard(type[0] as NSString) as! UINavigationController)
                    break
                case 3:
                    vcNav = (zXiaoXiStoryboard(type[0] as NSString) as! UINavigationController)
                    break
                case 4:
                    vcNav = (zWoDeStoryboard(type[0] as NSString) as! UINavigationController)
                    break
                default:
                    vcNav = (zTuiJianStoryboard(type[0] as NSString) as! UINavigationController)
                    break
                }
                
                let defaultImg = UIImage(named: type[2])?.withRenderingMode(.alwaysOriginal)
                let selectImg = UIImage(named: type[3])?.withRenderingMode(.alwaysOriginal)
                
                let item = UITabBarItem(title: type[1], image: defaultImg, selectedImage: selectImg)
                
                item.setTitleTextAttributes([.foregroundColor:zHEX(hexValue: 0xFF1A76)], for: .selected)
                
                vcNav!.tabBarItem = item
                
                vcArr.add(vcNav)
            }
            
            tab = UITabBarController()
            tab?.tabBar.isTranslucent = false
            tab?.viewControllers = vcArr
            
            // 解决进入页面后tab变色的问题
            tab!.tabBar.tintColor = zHEX(hexValue: 0xFF1A76)
            tab!.tabBar.barTintColor = zHEX(hexValue: 0xFFFFFF)
               

            rootVC.window?.rootViewController = tab!
        } else {
            // 登录
            let loginVC = zLoginStoryboard("")
            rootVC.window?.rootViewController = loginVC as! UIViewController
        }
    }
    
}

