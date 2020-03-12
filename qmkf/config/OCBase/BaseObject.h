//
//  BaseObject.h
//  qmkf
//
//  Created by Mac on 2020/2/24.
//  Copyright © 2020 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseObject : NSObject

- (void)takePic;
@property(nonatomic,copy)void (^baseBlock)(id baseData);

@end

NS_ASSUME_NONNULL_END
