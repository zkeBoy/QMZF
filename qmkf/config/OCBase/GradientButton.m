//
//  GradientButton.m
//  Notarization
//
//  Created by Hui Wang on 2019/6/10.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import "GradientButton.h"

#define HexStringColor(_hexString)\
[GradientButton colorWithHexString:_hexString]

@interface GradientButton () {
    UIView *btnShadow;
}
@property(nonatomic,strong)CAGradientLayer *gl;

@end

@implementation GradientButton

- (void)createNoenableButton {
    [self.gl removeFromSuperlayer];
    self.backgroundColor = HexStringColor(@"DDDDDD");
    [self setTitleColor:HexStringColor(@"888888") forState:UIControlStateNormal];
}

- (void)createGradientButton{
    
    [self setTitleColor:HexStringColor(@"FFFFFF") forState:UIControlStateNormal];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = self.bounds;
    gl.startPoint = CGPointMake(0, 0.5);
    gl.endPoint = CGPointMake(1, 0.5);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:218/255.0 green:37/255.0 blue:28/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:254/255.0 green:103/255.0 blue:69/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    gl.cornerRadius = self.cornerRadius;
    
    [self.gl removeFromSuperlayer];
    self.gl = gl;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.layer insertSublayer:gl atIndex:0];        
    });
    
}

- (void)addShashow {
    if (!btnShadow) {
        btnShadow = [[UIView alloc] init];
        btnShadow.frame = self.frame;
        btnShadow.backgroundColor = UIColor.whiteColor;
        [self.superview addSubview:btnShadow];
        [self.superview insertSubview:btnShadow belowSubview:self];

        btnShadow.layer.shadowColor = [UIColor colorWithRed:218/255.0 green:37/255.0 blue:28/255.0 alpha:1].CGColor;
        btnShadow.layer.shadowOffset = CGSizeMake(0,5);
        btnShadow.layer.shadowOpacity = 1;
        btnShadow.layer.shadowRadius = 15;
        btnShadow.layer.cornerRadius = 22.5;
    }
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
     
    dispatch_async(dispatch_get_main_queue(), ^{
        if (enabled == YES) {
            [self createGradientButton];
            //        btnShadow.layer.shadowColor = [UIColor colorWithRed:218/255.0 green:37/255.0 blue:28/255.0 alpha:0.3].CGColor;
        } else {
            [self createNoenableButton];
            //        btnShadow.layer.shadowColor = [UIColor colorWithRed:218/255.0 green:37/255.0 blue:28/255.0 alpha:0].CGColor;
//            [self drawRect:self.frame];
        }
    });
}

- (void)didMoveToSuperview {
//    [self addShashow];
    [self.superview setNeedsDisplay];
}

//- (void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
////    if (!self.isStopGradient) {
////        [self createGradientButton];
////    }
//}

- (void)setSelectedStatus:(BOOL)isSelected{
    self.selected = isSelected;
    if (isSelected) {
        [self createGradientButton]; 
    }else{
        [self.gl removeFromSuperlayer];
        [self setTitleColor:HexStringColor(@"#888888") forState:UIControlStateNormal];
        [self setTitleColor:HexStringColor(@"#FFFFFF") forState:UIControlStateSelected];
    }
}


+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

@end
