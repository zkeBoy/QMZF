//
//  UIView+Frame.h
//  qmkf
//
//  Created by Mac on 2020/1/5.
//  Copyright © 2020 Mac. All rights reserved.
// 
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@end

NS_ASSUME_NONNULL_END
