//
//  GradientButton.h
//  Notarization
//
//  Created by Hui Wang on 2019/6/10.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GradientButton : UIButton

@property(nonatomic,assign)CGFloat cornerRadius;
@property(nonatomic,assign)BOOL isStopGradient;

- (void)setSelectedStatus:(BOOL)isSelected;
@end

NS_ASSUME_NONNULL_END
