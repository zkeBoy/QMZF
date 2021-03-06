//
//  CircleRingChartView.m
//  GCChartDemo
//
//  Created by 古创 on 2019/6/5.
//  Copyright © 2019年 GC. All rights reserved.
//

#import "CircleRingChartView.h"

@interface CircleRingChartView ()

@property (nonatomic,strong) UIView *legendBgView;
@property (nonatomic,strong) NSMutableArray *colorArray;

@end

@implementation CircleRingChartView

- (instancetype)initWithFrame:(CGRect)frame atPostiion:(LegendPosition)legendPostion withNameArray:(NSArray *)nameArray andDataArray:(NSArray *)dataArray andRadius:(CGFloat)radius andLineWidth:(CGFloat)lineWidth;{
    self = [super initWithFrame:frame];
    if (self) {
        self.legendPostion = legendPostion;
        self.legendNameArray = nameArray;
        self.pieDataArray = dataArray;
        self.radius = radius;
        self.lineWidth = lineWidth;
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    if (self.legendColorArray.count == 0 || self.legendColorArray.count < self.legendNameArray.count) {
        NSArray *arr = @[@"#308ff7",@"#fbca58",@"#f5447d",@"#a020f0",@"#00ffff",@"#00ff00"];
        self.colorArray = [NSMutableArray arrayWithArray:arr];
    } else {
        self.colorArray = [NSMutableArray arrayWithArray:self.legendColorArray];
    }
    if (self.radius == 0) {
        self.radius = 60;
    } else if (self.radius < 40) {
        self.radius = 40;
    } else if (self.radius * 2 > MIN(self.bounds.size.width, self.bounds.size.height) - 20 - 20 * 2) {// 极端情况 半径接近宽高较小值-20的时候 需要特殊处理 此时标注有可能超出范围而不显示或显示异常
        self.radius = (MIN(self.bounds.size.width, self.bounds.size.height) - 20 - 20 * 2) / 2;
    }  else {
        
    }
    if (self.lineWidth == 0) {
        self.lineWidth = 10;
    } else if (self.lineWidth < 5) {
        self.lineWidth = 5;
    } else if (self.lineWidth >= self.radius / 2) {
        self.lineWidth = self.radius / 2;
    } else {
        
    }
    
}

- (void)resetLegend {
    // 先移除之前创建的
    for (UIView *view in self.legendBgView.subviews) {
        [view removeFromSuperview];
    }
    self.legendBgView = nil;
    [self.legendBgView removeFromSuperview];
    if (self.legendPostion == LegendPositionNone) {// 无图例的时候
        self.legendBgView = nil;
    } else {
        self.legendBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 20)];
        [self addSubview:self.legendBgView];
        switch (self.legendPostion) {
            case LegendPositionTop:
                self.legendBgView.center = CGPointMake(self.bounds.size.width / 2, 10);
                break;
            case LegendPositionBottom:
                self.legendBgView.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - 10);
                break;
                
            default:
                break;
        }
        
        CGFloat width = UIScreen.mainScreen.bounds.size.width;
        CGFloat margin = (width - 85 * self.legendNameArray.count) / 2 * 1.3;
        for (int i = 0; i < self.legendNameArray.count; i++) {
            UIView *colorPoint = [[UIView alloc] initWithFrame:CGRectMake(margin + (2 + 65 + 10) * i, 5, 10, 10)];
//            colorPoint.center = CGPointMake(margin + (10 + 50 + 10) * i, 10);
            colorPoint.backgroundColor = [self colorWithHexString:self.colorArray[i]];
            colorPoint.layer.cornerRadius = 5;
            colorPoint.layer.masksToBounds = YES;
            [self.legendBgView addSubview:colorPoint];
            
            UILabel *legendTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorPoint.frame) + 2, 0, 65, 20)];
            legendTitle.text = self.legendNameArray[i];
            legendTitle.textColor = [UIColor blackColor];
            legendTitle.font = [UIFont systemFontOfSize:13];
            [self.legendBgView addSubview:legendTitle];
        }
    }
}

- (void)resetCircleRing {
    [self resetLegend];
    
    CGFloat pieCenterX = self.bounds.size.width / 2;
    CGFloat pieCenterY;
    if (self.legendPostion == LegendPositionTop) {
        pieCenterY = self.bounds.size.height / 2 + 10;
    } else if (self.legendPostion == LegendPositionBottom) {
        pieCenterY = self.bounds.size.height / 2 - 10;
    } else {
        pieCenterY = self.bounds.size.height / 2;
    }
    // 先移除之前创建的
    for (UIView *view in self.subviews) {
        if (view.tag == 101) {
            [view removeFromSuperview];
        }
    }
    UIView *pieView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - 20)];
    pieView.center = CGPointMake(pieCenterX, pieCenterY);
    pieView.tag = 101;
    pieView.backgroundColor = self.backgroundColor;//[UIColor whiteColor];
    [self addSubview:pieView];
    
    if (self.touchEnable) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [pieView addGestureRecognizer:tap];
    }
    float total = 0;
    for (NSString *str in self.pieDataArray) {
        total = total + [str floatValue];
    }
    
    CGFloat radius = MAX(pieView.bounds.size.width, pieView.bounds.size.height);//pieView.bounds.size.width > pieView.bounds.size.height ? pieView.bounds.size.height / 2 : pieView.bounds.size.width / 2;
    
    // 背景
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(pieView.bounds.size.width / 2, pieView.bounds.size.height / 2) radius:radius / 2 startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise:YES];
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.fillColor = [UIColor clearColor].CGColor;
    bgLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    bgLayer.strokeStart = 0;
    bgLayer.strokeEnd = 1;
    bgLayer.zPosition = 1;
    bgLayer.lineWidth = radius;
    bgLayer.path = bgPath.CGPath;
    
    
    CGFloat startAngle = 1.5 * M_PI;
    for (int i = 0; i < self.pieDataArray.count; i++) {
        NSString *num = self.pieDataArray[i];
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(pieView.bounds.size.width / 2, pieView.bounds.size.height / 2) radius:self.radius startAngle:startAngle endAngle:startAngle + [num floatValue] / total * M_PI * 2 clockwise:YES];
        //        path.lineWidth = 10;// 线宽与半径相同
        //        [path addLineToPoint:pieView.center];
        [[self colorWithHexString:self.colorArray[i]] setStroke];
        [[self colorWithHexString:self.colorArray[i]] setFill];
        [path stroke];
        [path fill];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.lineWidth = self.lineWidth;//self.radius / 6;
        layer.strokeColor = [self colorWithHexString:self.colorArray[i]].CGColor; // 圆环颜色
        layer.fillColor = [UIColor clearColor].CGColor; // 背景填充色
        //        layer.backgroundColor = [self colorWithHexString:self.colorArray[i]].CGColor;
        [pieView.layer addSublayer:layer];
        
        startAngle = startAngle + [num floatValue] / total * M_PI * 2 ;
        
    }
    
    // 标注
    CGFloat startAngle_p = 90;
    for (int i = 0; i < self.pieDataArray.count; i++) {
        NSString *num = self.pieDataArray[i];
        CGFloat angle = startAngle_p - [num floatValue] / 2 / total * 360;
        CGPoint pointInCenter = [self caculatePointAtCircleWithCenter:CGPointMake(pieView.bounds.size.width / 2, pieView.bounds.size.height / 2) andAngle:angle andRadius:self.radius + self.lineWidth / 2];
        CGPoint pointInCenter_2 = [self caculatePointAtCircleWithCenter:CGPointMake(pieView.bounds.size.width / 2, pieView.bounds.size.height / 2) andAngle:angle andRadius:self.radius + self.lineWidth / 2 + self.radius / 6];
        CGPoint pointAtLabel;
        if (cosf(angle * M_PI / 180) >= -0.01) { // 偏右侧
            pointAtLabel = CGPointMake(pointInCenter_2.x + self.radius / 3, pointInCenter_2.y);
        } else { // 偏左侧
            pointAtLabel = CGPointMake(pointInCenter_2.x - self.radius / 3, pointInCenter_2.y);
        }
        
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:pointInCenter];
        [linePath addLineToPoint:pointInCenter_2];
        [linePath addLineToPoint:pointAtLabel];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 0.5;
        layer.strokeColor = [self colorWithHexString:@"#dcdcdc"].CGColor;
        layer.fillColor = nil;
        layer.path = linePath.CGPath;
        [pieView.layer addSublayer:layer];
        
        UILabel *lblMark = [[UILabel alloc] init];
        if (cosf(angle * M_PI / 180) >= -0.01) { // 偏右侧
            lblMark.bounds = CGRectMake(0, 0, pieView.bounds.size.width - pointAtLabel.x - 2, 12);
        } else { // 偏左侧
            lblMark.bounds = CGRectMake(0, 0, pointAtLabel.x - 2, 12);
        }
        lblMark.textColor = [self colorWithHexString:@"#404040"];
        lblMark.font = [UIFont systemFontOfSize:10];
        lblMark.numberOfLines = 2;
        if (self.showPercentage) {
            NSString *num = self.pieDataArray[i];
            if (self.pieDataNameArray.count == 0 || self.pieDataNameArray.count != self.pieDataArray.count) {
                lblMark.text = [NSString stringWithFormat:@"%.2f%%",[num floatValue] / total * 100];
            } else {
                lblMark.text = [NSString stringWithFormat:@"%@:%.2f%%",self.pieDataNameArray[i],[num floatValue] / total * 100];
            }
        } else {
            if (!self.pieDataUnit) {
                self.pieDataUnit = @"";
            }
            if (self.pieDataNameArray.count == 0 || self.pieDataNameArray.count != self.pieDataArray.count) {
                lblMark.text = [NSString stringWithFormat:@"%@%@",self.pieDataArray[i],self.pieDataUnit];
            } else {
                lblMark.text = [NSString stringWithFormat:@"%@:%@%@",self.pieDataNameArray[i],self.pieDataArray[i],self.pieDataUnit];
            }
        }
        [lblMark sizeToFit];
        [pieView addSubview:lblMark];
        if (cosf(angle * M_PI / 180) >= -0.01) { // 偏右侧
            lblMark.center = CGPointMake(pointAtLabel.x + lblMark.bounds.size.width / 2 + 2, pointAtLabel.y);
        } else { // 偏左侧
            lblMark.center = CGPointMake(pointAtLabel.x - lblMark.bounds.size.width / 2 - 2, pointAtLabel.y);
        }
        
        startAngle_p = startAngle_p - [num floatValue] / total * 360 ;
    }
    
    UILabel *lblCenterTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 21)];
    lblCenterTitle.center = CGPointMake(pieView.bounds.size.width / 2, pieView.bounds.size.height / 2 - 20);
    lblCenterTitle.font = [UIFont systemFontOfSize:14];
    lblCenterTitle.textColor = [self colorWithHexString:@"#404040"];
    lblCenterTitle.text = self.centerTitle.length == 0 ? @"" : self.centerTitle;
    lblCenterTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lblCenterTitle];
    
    UILabel *lblCenterTotal = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(lblCenterTitle.frame), 80, 21)];
    lblCenterTotal.center = CGPointMake(pieView.bounds.size.width / 2, lblCenterTotal.center.y + 6);
    lblCenterTotal.font = [UIFont systemFontOfSize:22];
    lblCenterTotal.textColor = [UIColor redColor];
    lblCenterTotal.text = [NSString stringWithFormat:@"¥ %.2f",total];
    lblCenterTotal.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lblCenterTotal];
    lblCenterTotal.hidden = self.centerTitle.length == 0 ? YES : NO;
    
    pieView.layer.mask = bgLayer;
    // 动画
    CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeAnimation.fromValue = @0;// 起始值
    strokeAnimation.toValue = @1;// 结束值
    strokeAnimation.duration = 1;// 动画持续时间
    strokeAnimation.repeatCount = 1;// 重复次数
    strokeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeAnimation.removedOnCompletion = YES;
    [bgLayer addAnimation:strokeAnimation forKey:@"pieAnimation"];
    
    
}

- (void)resetDataLabel {
    float total = 0;
    for (NSString *str in self.pieDataArray) {
        total = total + [str floatValue];
    }
    UIView *pieView;
    for (UIView *view in self.subviews) {
        if (view.tag == 101) {
            pieView = view;
        }
    }
    CGFloat startAngle_p = 90;
    for (int i = 0; i < self.pieDataArray.count; i++) {
        NSString *num = self.pieDataArray[i];
        CGFloat angle = startAngle_p - [num floatValue] / 2 / total * 360;
        CGPoint pointInCenter = [self caculatePointAtCircleWithCenter:CGPointMake(pieView.bounds.size.width / 2, pieView.center.y) andAngle:angle andRadius:self.radius];
        CGPoint pointInCenter_2 = [self caculatePointAtCircleWithCenter:CGPointMake(pieView.bounds.size.width / 2, pieView.center.y) andAngle:angle andRadius:self.radius + 5];
        
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:pointInCenter];
        [linePath addLineToPoint:pointInCenter_2];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.lineWidth = 0.5;
        layer.strokeColor = [UIColor lightGrayColor].CGColor;
        layer.path = linePath.CGPath;
        [pieView.layer addSublayer:layer];
        
        startAngle_p = startAngle_p - [num floatValue] / total * 360 ;
    }
}

#pragma mark - resetData
- (void)resetData {
    [self config];
    
    [self resetCircleRing];
}

#pragma mark - tapAction
- (void)tapAction:(UITapGestureRecognizer *)tap {
    UIView *pieView = tap.view;
    CGPoint touchPoint = [tap locationInView:pieView];
//    NSLog(@"%f,%f",touchPoint.x,touchPoint.y);
    CGFloat distance = sqrt(pow(touchPoint.x - pieView.bounds.size.width / 2, 2) + pow(touchPoint.y - pieView.bounds.size.height / 2, 2));
    if (distance >= self.radius - self.lineWidth / 2 && distance <= self.radius + self.lineWidth / 2) {
        CGFloat angle = acos((pieView.bounds.size.height / 2 - touchPoint.y) / distance);
        if (touchPoint.x - pieView.bounds.size.width / 2 < 0) {
            angle = 2 * M_PI - angle;
        }
//        NSLog(@"%f",angle);
        float total = 0;
        for (NSString *str in self.pieDataArray) {
            total = total + [str floatValue];
        }
        CGFloat startAngle = 1.5 * M_PI;
        for (int i = 0; i < self.pieDataArray.count; i++) {
            // 因创建CAShapeLayer时,先添加的是圆环 所以在这里可以角标访问到对应的layer
//            CAShapeLayer *layer = pieView.layer.sublayers[i];
            NSString *num = self.pieDataArray[i];
            if (angle + 1.5 * M_PI >= startAngle && angle + 1.5 * M_PI < startAngle + [num floatValue] / total * M_PI * 2) {
                NSLog(@"%d",i);
                
            } else {
                
            }
            
            startAngle = startAngle + [num floatValue] / total * M_PI * 2;
        }
    }
}

#pragma mark - getter
- (NSArray *)legendNameArray {
    if (!_legendNameArray) {
        _legendNameArray = [NSArray array];
    }
    return _legendNameArray;
}

- (NSArray *)legendColorArray {
    if (!_legendColorArray) {
        _legendColorArray = [NSArray array];
    }
    return _legendColorArray;
}

- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [NSMutableArray array];
    }
    return _colorArray;
}

- (NSArray *)pieDataArray {
    if (!_pieDataArray) {
        _pieDataArray = [NSArray array];
    }
    return _pieDataArray;
}

- (NSArray *)pieDataNameArray {
    if (!_pieDataNameArray) {
        _pieDataNameArray = [NSArray array];
    }
    return _pieDataNameArray;
}

#pragma mark - other
- (UIColor *)colorWithHexString:(NSString *)color {
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
    
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1.0];
}

- (CGPoint)caculatePointAtCircleWithCenter:(CGPoint)center andAngle:(CGFloat)angle andRadius:(CGFloat)radius {
    CGFloat x = radius * cosf(angle * M_PI / 180);
    CGFloat y = radius * sinf(angle * M_PI / 180);
    return CGPointMake(center.x + x, center.y - y);
}

@end
