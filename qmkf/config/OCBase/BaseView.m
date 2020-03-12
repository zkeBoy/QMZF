//
//  BaseView.m
//  Notarization
//
//  Created by Hui Wang on 2019/6/5.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import "BaseView.h"


@interface BaseView ()<UIGestureRecognizerDelegate>

@end

@implementation BaseView

-(instancetype)initWithFrame:(CGRect)frame{
 
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self zCreateSubviews];
    }
    return self;
}

- (void)zCreateSubviews{
    
}

- (void)addGestureTarget:(id)target action:(nullable SEL)action forView:(UIView *)aView {
    //创建点击手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    //设置点击的次数，默认是1
    tap.numberOfTapsRequired = 1;
    //设置需要触摸的手指，默认是1
    tap.numberOfTouchesRequired = 1;
    //指定代理
    tap.delegate = self;
    
    [aView addGestureRecognizer:tap];
}

- (void)dealloc {
    NSLog(@"**********%@ dealloc ************",self.class);
}

@end
