//
//  IDInputKeyboard.h
//  Notarization
//
//  Created by mac on 2019/9/5.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import "IDInputKeyboard.h"
#import "qmkf-Bridging-Header.h"

@implementation IDInputKeyboard
{
    NSMutableArray *_buttons;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        NSArray *items = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"X",@"0",@"删除"];
        _buttons = [NSMutableArray array];
        for (NSInteger i = 0; i < items.count; i++)
        {
            UIButton *button = [[UIButton alloc]init];
            button.tag = i;
            [button setTitle:items[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            if (i < 11)  button.titleLabel.font = [UIFont systemFontOfSize:25];
            if (i == 9 || i == 11)
            {
                //生成纯色的背景图片imageWithColor和colorWithHexString都是YYKit中的方法
                [button setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:200 green:200 blue:200 alpha:1]] forState:UIControlStateNormal];
                [button setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:240 green:240 blue:240 alpha:1]] forState:UIControlStateHighlighted];
            }else
            {
                [button setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:240 green:240 blue:240 alpha:1]] forState:UIControlStateNormal];
                [button setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:200 green:200 blue:200 alpha:1]] forState:UIControlStateHighlighted];
            }
            [button addTarget:self action:@selector(didItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [_buttons addObject:button];
        }
    }
    return self;
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = (self.frame.size.width - 1) / 3;
    CGFloat height = (self.frame.size.height - 1.5) / 4;
    for (NSInteger i = 0; i < _buttons.count; i++)
    {
        UIButton *button = _buttons[i];
        button.frame = CGRectMake((width + 0.5) * (i % 3), (height + 0.5) * (i / 3), width, height);
    }
}

- (void)didItemClicked:(UIButton *)sender
{
    if (_delegate)
    {
        if (sender.tag == 11 && [_delegate respondsToSelector:@selector(didKeyboardDeletedClicked)])
            [_delegate didKeyboardDeletedClicked];
        else if([_delegate respondsToSelector:@selector(didKeyboardItemSelected:)])
            [_delegate didKeyboardItemSelected:[sender titleForState:UIControlStateNormal]];
    }
}

@end
