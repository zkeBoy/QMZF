//
//  UserOrderSegmentView.h
//  Notarization
//
//  Created by mac on 2019/7/16.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserOrderSegmentView : BaseView

@property(nonatomic,copy)void (^clickedBlock) (NSInteger tag);
- (void)setSelectedIndex:(NSInteger)index_x;

@end

NS_ASSUME_NONNULL_END
