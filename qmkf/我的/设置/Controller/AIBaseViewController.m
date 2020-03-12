//
//  AIBaseViewController.m
//  AIAnimationDemo
//
//  Created by 艾泽鑫 on 2016/10/13.
//  Copyright © 2016年 艾泽鑫. All rights reserved.
//  最基础的viewcontroller

#import "AIBaseViewController.h"
#import <Masonry.h>
//#import <KMCGeigerCounter.h>
#define KStatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height

@interface AIBaseViewController ()

@end

@implementation AIBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:false];
    [self.navigationController.navigationBar setTranslucent:false];
//    self.navigationController?.setNavigationBarHidden(false, animated: animated)
//    self.navigationController?.navigationBar.isTranslucent = false
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
//    //检测是否流畅
//#if TARGET_IPHONE_SIMULATOR
//    [KMCGeigerCounter sharedGeigerCounter].enabled = YES;
//#endif
}
//-(void)dealloc {
////    NSLog(@"%@",@"%@--dealloc",NSStringFromClass([self class]));
//}
/**
 添加返回
 */
- (void)addbackBtn {
    
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"nav_icon_back"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(onClickBack:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.top.mas_equalTo(10 + KStatusBarHeight);
        make.width.height.mas_equalTo(24);
    }];
}


#pragma mark -Action
- (void)onClickBack:(UIButton*)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
