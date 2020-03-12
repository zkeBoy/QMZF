//
//  BaseButton.h
//  qmkf
//
//  Created by Mac on 2020/2/24.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseButton : UIButton

- (void)takePic;
@property(nonatomic,copy)void (^baseBlock)(id baseData);

@end

NS_ASSUME_NONNULL_END
