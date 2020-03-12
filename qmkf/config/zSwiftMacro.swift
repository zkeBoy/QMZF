//
//  Z_Swift_Macro.swift
//  qmkf
//
//  Created by Mac on 2019/12/5.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import UIKit

let MainUIStoryboard = UIStoryboard(name: "Main", bundle:nil)

enum zAppConstants {
    
    //MARK: - 是否是测试环境
    static let NetDebug: Bool = true
    
    //MARK: - 随机颜色
    static let ColorDebug: Bool = false
    
    //MARK: - 日志输出
    static let LogDebug: Bool = true
    
    //存储-用户信息-键
    static let CurrentLoginUserInfo: String = ""
    
    static let KeyChainService: String = ""
    
    //存储-网络请求token-键
    static let NetworkToken: String = "NetworkToken"
    
    //MARK: - 协议（http/https）（含“//”后缀，不能为空）
    enum AppURLProtocol {
        
        //测试
        static let DebugProtocol = "https://"
        
        //生产
        static let ProduceProtocol = "https://"
    }
    
    //MARK: - 地址(host) （不能为空）
    enum AppURLHOST {
        
        //测试
        static let DebugHOST = "项目测试域名"
        
        //生产
        static let ProduceHOST = "项目生产域名"
    }
    
    //MARK: - 端口（port），（含“:”前缀，如果 URL_PORT 为空，则不含）
    enum AppURLPort {
        
        //测试
        static let DebugPort = ""
        
        //生产
        static let ProducePort = ""
    }
    
    //MARK: - 接口地址
    enum AppInterfaceAddress {
        
        //登录
        static let Login = "接口地址路由"
        
    }
    
    
    //MARK: - APP的key
    enum AppKey {
        
        static let UMeng = "三方Key"
        
        //......
        
    }
    
    //MARK: - APP的密钥
    enum AppSecret {
        
        static let UMeng = "三方密钥"
        
        //......
        
    }
    
    //MARK: - 错误类型
    enum ErrorType {
        
        static let ServerError = "服务器异常"
        
    }

}

//MARK: - 日志输出
// <T>: 为泛型，外界传入什么就是什么
func zDLog<T>(_ message: T, file: String = #file, method: String = #function, line: Int = #line) {
    
    if zAppConstants.LogDebug {
        
        print("\(method)[\(line)]:\(message)")
        
    }
    
}

//MARK: - frame 相关
/************************  屏幕尺寸  ***************************/

public enum zAppFrame {
    
    static let ScreenBounds = UIScreen.main.bounds
    
    // 屏幕宽度
    static let ScreenWidth = ScreenBounds.size.width
    
    // 屏幕高度
    static let ScreenHeight = ScreenBounds.size.height
    
    // iPhone4
    static let iPhone4 = ScreenHeight  < 568 ? true : false
    
    // iPhone 5
    static let iPhone5 = ScreenHeight  == 568 ? true : false
    
    // iPhone 6
    static let iPhone6 = ScreenHeight  == 667 ? true : false
    
    // iphone 6P
    static let iPhone6P = ScreenHeight == 736 ? true : false
    
    // iphone X
    static let iPhoneX = ScreenHeight == 812 ? true : false
    
    // navigationBarHeight
    static let kNavigationBarHeight : CGFloat = iPhoneX ? 88 : 64
    
    // tabBarHeight
    static let kTabBarHeight : CGFloat = iPhoneX ? 49 + 34 : 49
    
    /** 如果是iPhoneX按照Plus 尺寸计算比例 */
    static let Scale_Height = iPhoneX ? 736.0/667.0 : ScreenHeight / 667
    static let Scale_Width = ScreenWidth / 375
    
}

func zSetWidth(x:CGFloat) -> CGFloat {
    
    return zAppFrame.Scale_Width * x
    
}

func zSetHeight(y:CGFloat) -> CGFloat {
    
    return zAppFrame.Scale_Height * y
    
}
//屏高

let zScreenHeight = UIScreen.main.bounds.size.height

//屏宽

let zScreenWidth = UIScreen.main.bounds.size.width

//iPhonex以上判断

let zIS_IPhoneX_All = (zScreenHeight ==  812.0 || zScreenHeight == 896.0)

//导航栏高

let zNaviBar_Height = CGFloat(zIS_IPhoneX_All ? 88.0 : 64.0)

//状态栏高

let zStatusBar_Height = CGFloat(zIS_IPhoneX_All ? 44.0 : 20.0)

//选项卡高

let zTabBar_Height = CGFloat(zIS_IPhoneX_All ? 83.0 : 49.0)

//安全区高

let zSafeArea_BottomHeight = CGFloat(zIS_IPhoneX_All ? 34.0 : 0.0)

/**宽度比例*/

func zScaleWidth(_ font:CGFloat) -> (CGFloat) {

   return (zScreenWidth/375)*font

}

/**高度比例*/

func zScaleHeight(_ font:CGFloat) -> (CGFloat) {

  return  zScreenHeight/667*font

}

/**字体比例*/

func zScaleFont(_ font:CGFloat) -> (CGFloat) {

    return  zScreenWidth/375*font

}

//MARK: - AppColor 相关
public enum zAppColor {
    
    static let clear = UIColor.clear
    
    //APP主题色
    static let themeRed = zRGB0X(hexValue: 0xfd2e2e)
    //APP红色
    static let red = zRGB0X(hexValue: 0xff2323)
    //APP蓝色
    static let blue = zRGB0X(hexValue: 0x488ff0)
    //APP黑色
    static let black = zRGB0X(hexValue: 0x333333)
    //APP深灰色
    static let darkgGray = zRGB0X(hexValue: 0x666666)
    //APP灰色
    static let gray = zRGB0X(hexValue: 0xf9f9f9)
    //APP轻灰色
    static let lightGray = zRGB0X(hexValue: 0xf5f5f5)
}

/// RGBA的颜色设置
func zRGB(_ r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    
}

func zRGBA(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    
}

func zHEXA(hexValue: Int, a: CGFloat) -> (UIColor) {
    
    return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                   alpha: a)
    
}

func zHEX(hexValue: Int) -> (UIColor) {
    
    return UIColor(red: ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0,
                   green: ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0,
                   blue: ((CGFloat)(hexValue & 0xFF)) / 255.0,
                   alpha: 1)
    
}

func zRGB0X(hexValue: Int) -> (UIColor) {
    
    return zHEXA(hexValue: hexValue, a: 1.0)
    
}

func zFONT(font: CGFloat) -> UIFont {
    
    return UIFont.systemFont(ofSize: font)
    
}

func zSetWidth(_ width: CGFloat) -> CGFloat {
    return  zScreenWidth / 375 * width
}

func zImage(_ name: String) -> UIImage {
    UIImage(named: name) ?? UIImage()
}

extension UIView {
    
    func zAutoConstant() {
        for layout in self.constraints {
            if (layout.identifier != nil) && ((layout.identifier) == "auto") {
                let value = zSetWidth(layout.constant)
                layout.identifier = "autoSetted"
                layout.constant = value
                continue
            }
        }
        
        self.setSubConstant(self, 1)
    }
    
    func updateSubViewConstant(_ sub: UIView) {
        if sub.constraints.count != 0 {
            for subLayout in sub.constraints {
//                print(subLayout.identifier ?? "sub无")
                if (subLayout.identifier != nil) && ((subLayout.identifier) == "auto") {
                    let value = zSetWidth(subLayout.constant)
                    subLayout.constant = value
                    subLayout.identifier = "autoSetted"
                    continue
                }
            }
        }
    }
    
    func setSubConstant(_ rSub: UIView,_ level: NSInteger) {
        let subviews = rSub.subviews
        if subviews.count != 0 {
            for sub in subviews {
                if sub.isKind(of: UILabel.self)
                    || sub.isKind(of: UIImageView.self)
                    || sub.isKind(of: UIView.self)
                    || sub.isKind(of: UICollectionView.self) {
                    self.updateSubViewConstant(sub)
                }
                self.setSubConstant(sub,level + 1)
            }
        }
    }
}

//View 圆角和加边框
func zViewBorderRadius(View:UIView, Radius:CGFloat, Width:CGFloat, Color:UIColor) -> () {
 
    View.layer.cornerRadius = Radius
    View.layer.masksToBounds = true
    View.layer.borderWidth = Width
    View.layer.borderColor = Color.cgColor
}

// View 圆角
func ViewRadius(View:UIView, Radius:CGFloat) -> () {
    View.layer.cornerRadius = Radius
    View.layer.masksToBounds = true
}
