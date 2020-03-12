//
//  MiddleFilterObject.h
//  qmkf
//
//  Created by Mac on 2020/1/6.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHFilterMenuView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MiddleFilterObject : NSObject

@property (nonatomic, assign) FilterType filterType;
@property (nonatomic, strong) ZHFilterMenuView *menuView;
- (UIView*)getXinFangMenu;

@end

NS_ASSUME_NONNULL_END
