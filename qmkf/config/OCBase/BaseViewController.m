//
//  BaseViewController.m
//  Notarization
//
//  Created by Hui Wang on 2019/6/5.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate,IDInputKeyboardDelegate>

@end

@implementation BaseViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;//重新设置代理
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
       
}

- (void)loadData {
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
     
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self zCreateSubviews];
      
}


-(void)zCreateSubviews{
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

-(void)createNavigationBarRightButtonWithImage:(UIImage *)buttonImage tintColor:(UIColor *)tintColor {
    
    UIButton *_rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    
    _rightButton.frame=CGRectMake(0,0,38,36);
    _rightButton.tintColor = tintColor;
    [_rightButton setImage:buttonImage forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightButtonAction:)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)createNavigationBarRightButtonWithTitle:(NSString *)butonTitle butonTitleColor:(UIColor *)butonTitleColor buttonFont:(nonnull UIFont *)buttonFont{
    
    UIButton *_rightButton= [UIButton buttonWithType:UIButtonTypeCustom];
    
    _rightButton.frame=CGRectMake(0,0,38,36);
    [_rightButton setTitle:butonTitle forState:UIControlStateNormal];
    [_rightButton setTitleColor:butonTitleColor forState:UIControlStateNormal];
    _rightButton.titleLabel.font=buttonFont;
    [_rightButton addTarget:self action:@selector(rightButtonAction:)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)rightButtonAction:(id)sender{
    
}

-(void)createNavigationBarIsBackButton:(BOOL)isBackButton isBackBarBackImage:(BOOL)isBackBarBackImage withBarBackImageName:(NSString *)barBackImageName{
    
    if (isBackButton) {
        [self createBackButton];
    }else{
        //        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
    if (isBackBarBackImage) {
        if ([Utils getSafeString:barBackImageName].length > 0) {//自定义背景图
            //按比例显示图片  必须设置拉伸属性，否则导航条的背景图会过早显示完，使得背景图显示出现偏差
            UIImage *backGroundImage = [UIImage imageNamed:barBackImageName];
            backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
            [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarMetrics:UIBarMetricsDefault];
        }else{//默认背景图
            
            //按比例显示图片  必须设置拉伸属性，否则导航条的背景图会过早显示完，使得背景图显示出现偏差
            UIImage *backGroundImage = [UIImage imageNamed:@"渐变背景-750-x-300"];
            backGroundImage = [backGroundImage resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch];
            [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarMetrics:UIBarMetricsDefault];
        }
    }else{
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setShadowImage:[UIImage new]];//去掉导航栏底部黑线
    }
}

-(void)createBackButton{
    
    UIButton *backButton= [UIButton buttonWithType:UIButtonTypeSystem];
    
    backButton.frame = CGRectMake(16, k_StatusBarAndNavigationBarHeight + 12, 21, 21);
    if (@available(iOS 13.0, *)) {
        [backButton setImage:[UIImage systemImageNamed:@"chevron.left"] forState:UIControlStateNormal];
    } else {
        [backButton setImage:[UIImage imageNamed:@"backButton"] forState:UIControlStateNormal];
    }
    backButton.tintColor = UIColor.blackColor;
    
    [backButton addTarget:self action:@selector(backButtonAction:)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
} 

-(void)backButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//获取当前屏幕显示的viewcontroller
 - (UIViewController *)getCurrentVC
 {
     
     UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
     UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
     return currentVC;
 }

 - (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
 {
     UIViewController *currentVC;
     if ([rootVC presentedViewController]) {
         // 视图是被presented出来的
         rootVC = [rootVC presentedViewController];
     }
     if ([rootVC isKindOfClass:[UITabBarController class]]) {
         // 根视图为UITabBarController
         currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
     } else if ([rootVC isKindOfClass:[UINavigationController class]]){
         // 根视图为UINavigationController
         currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
     } else {
         // 根视图为非导航类
         currentVC = rootVC;
     }
     return currentVC;
 }

- (IDInputKeyboard *)idCardBoard {
    if (!_idCardBoard) {
        CGFloat width = Screen_width;
        CGFloat height = Screen_width / 300 * 216;
        if (height > 300) height = 300;//计算一个合适的高度
        _idCardBoard = [[IDInputKeyboard alloc]initWithFrame:CGRectMake(0, 0, width, height)];
        _idCardBoard.delegate = self;
    }
    return _idCardBoard;
}

-(void)popDelay{
    [self.navigationController performSelector:@selector(popViewControllerAnimated:) withObject:@YES afterDelay:2.0];
}
- (void)popVC{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)popToRootVC{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(UIActivityIndicatorView *)activityIndicatorView{
    if (!_activityIndicatorView) {
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        //设置小菊花的frame
        _activityIndicatorView.frame= CGRectMake(GetCurrentWindow.center.x-15, GetCurrentWindow.center.y-15, 30, 30);
        //设置小菊花颜色
        _activityIndicatorView.color = [UIColor blackColor];
        //设置背景颜色
        _activityIndicatorView.backgroundColor = [UIColor clearColor];
        //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
        _activityIndicatorView.hidesWhenStopped = YES;
        
    }
    return _activityIndicatorView;
}
 
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES]; 
}

- (void)dealloc
{
//    NSLog(@"**********%@ dealloc ************",self.class);
}

@end
