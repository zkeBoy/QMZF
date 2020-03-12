//
//  ZZNavigationController.m
//  Notarization
//
//  Created by mac on 2019/7/19.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import "ZZNavigationController.h"

@interface ZZNavigationController ()

@end

@implementation ZZNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/// 能拦截所有push进来的子控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
    if (self.viewControllers.count > 0){
        // 统一隐藏底部tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // push 
    [super pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    UIViewController * vc = [super popViewControllerAnimated:animated];
//    [vc.view endEditing:YES];
    return vc;
}

@end
