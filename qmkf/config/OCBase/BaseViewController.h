//
//  BaseViewController.h
//  Notarization
//
//  Created by Hui Wang on 2019/6/5.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h> 
#import "IDInputKeyboard.h"
#import "UIViewController+Present.h"
#import "Utils.h"
#import "zOCMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

@property(nonatomic,copy)void (^baseBlock)(id baseData);
@property(nonatomic,strong)IDInputKeyboard * idCardBoard;
@property(nonatomic,strong)UIActivityIndicatorView *activityIndicatorView;//加载转圈

//导航延迟返回
-(void)popDelay;
//正常返回
- (void)popVC;
//模态返回
- (void)dismiss;
//返回到根控制器
- (void)popToRootVC;
- (UIViewController *)getCurrentVC;
-(void)rightButtonAction:(id)sender;

-(void)createNavigationBarRightButtonWithTitle:(NSString *)butonTitle butonTitleColor:(UIColor *)butonTitleColor buttonFont:(nonnull UIFont *)buttonFont;
-(void)createNavigationBarRightButtonWithImage:(UIImage *)buttonImage tintColor:(UIColor *)tintColor;
-(void)createNavigationBarIsBackButton:(BOOL)isBackButton isBackBarBackImage:(BOOL)isBackBarBackImage withBarBackImageName:(NSString *)barBackImageName;

@end

NS_ASSUME_NONNULL_END
