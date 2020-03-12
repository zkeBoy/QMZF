//
//  BaseView.h
//  Notarization
//
//  Created by Hui Wang on 2019/6/5.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zOCMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView

@property(nonatomic,copy) void (^baseBlock)(id baseData);
@property(nonatomic,copy) id baseProperty;
- (void)addGestureTarget:(id)target action:(nullable SEL)action forView:(UIView *)aView;
- (void)zCreateSubviews;
  
@end

NS_ASSUME_NONNULL_END
