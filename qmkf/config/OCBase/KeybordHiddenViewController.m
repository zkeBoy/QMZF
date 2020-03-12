//
//  KeybordHiddenViewController.m
//  Notarization
//
//  Created by mac on 2019/7/23.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import "KeybordHiddenViewController.h"

@interface KeybordHiddenViewController ()

@end

@implementation KeybordHiddenViewController

//查找第一响应者
+ (UIView *)findFirstResponder:(UIView *)view {
    if (view.isFirstResponder) {
        return view;
    }
    for (UIView *subView in view.subviews) {
        UIView *firstResponder = [KeybordHiddenViewController findFirstResponder:subView];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}

// 键盘监听事件
- (void)keyboardAction:(NSNotification*)sender{
    NSDictionary *useInfo = [sender userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //键盘高度
    CGFloat keyboardHeight = [value CGRectValue].size.height;
    //获取输入框焦点
    UIView *view  = [KeybordHiddenViewController findFirstResponder:self.view];
    CGRect originRect = self.view.frame;
    ((UITextField *)view).autocorrectionType = UITextAutocorrectionTypeNo;
    if ([sender.name isEqualToString:UIKeyboardWillShowNotification]) {
        //键盘弹出时
        UIWindow *window;// = GetCurrentWindow;
        id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
        if ([delegate respondsToSelector:@selector(window)]) {
            window = [delegate performSelector:@selector(window)];
        } else {
            window = [[UIApplication sharedApplication] keyWindow];
        }
        CGPoint point = [window convertPoint:CGPointMake(0, 0) toView:view];//计算响应者到和屏幕的绝对位置
         
        CGFloat keyboardY = Screen_height - k_TabbarSafeBottomMargin - keyboardHeight;
        
        if (view) {
            //cell的maxY值
            CGFloat cellMaxY = (-point.y + view.frame.size.height) - keyboardY;
            if (cellMaxY > 0) {
                [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.view.frame = CGRectMake(0, -cellMaxY-5, originRect.size.width, originRect.size.height);
                } completion:nil];
            }
        }
    } else {
        //键盘收起时
        NSInteger navHeight;
        if ([self getCurrentVC].view.frame.size.height == Screen_height - k_StatusBarAndNavigationBarHeight) {
            // 有nav
            navHeight = k_StatusBarAndNavigationBarHeight;
        } else {
            navHeight = 0;
        }
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.view.frame = CGRectMake(0, navHeight, originRect.size.width, originRect.size.height);
        } completion:nil];
    }
    
}
@end
