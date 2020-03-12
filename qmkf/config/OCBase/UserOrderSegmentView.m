//
//  SegmentView.m
//  Notarization
//
//  Created by Hui Wang on 2019/6/5.
//  Copyright © 2019 Hui Wang. All rights reserved.
//

#import "UserOrderSegmentView.h"

@interface UserOrderSegmentView () <UIScrollViewDelegate>

@property(nonatomic,strong)NSMutableArray *buttonArr;
@property(nonatomic,strong)NSMutableArray *bottomViewArr;

@property(nonatomic,strong)UIScrollView *scrollV;

@end

@implementation UserOrderSegmentView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
    }
    
    return self;
}

- (void)zCreateSubviews{
    
    NSArray *_btnTitleArr;// = [OrderModel instance].userOrderTypeArray;
    CGFloat _spacing = 10;//默认，随意设置
    _btnTitleArr = @[@"新房",@"二手房",@"租房",@"商铺办公",@"小区",@"百科",@"论坛"];
    
    //scrollV
    CGFloat _cHeight = self.frame.size.height;
    CGFloat _scroolWidth = _spacing; // 起始默认一个_spacing
    self.scrollV.delegate = self;
//    self.scrollV.bounces = NO;
    self.scrollV.backgroundColor = UIColor.clearColor;
    [self addSubview:self.scrollV];
    
    for (NSInteger i = 0; i < _btnTitleArr.count; i++) {
        CGFloat _width = [_btnTitleArr[i] length] * 14 + 20;
        
        UIButton *_continueButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _continueButton.frame = CGRectMake(_scroolWidth, 0, _width, _cHeight*0.8);
        
        UIView * btnBottomView = [[UIView alloc] init];
        btnBottomView.backgroundColor = UIColor.whiteColor;
        btnBottomView.frame = CGRectMake(_scroolWidth+_width*0.1, _cHeight*0.53, _width*0.8, 6);
        
        
        _scroolWidth += _width+_spacing;
        _continueButton.tag = 6666 + i;
        //继续
        [_continueButton setTitle:_btnTitleArr[i] forState:UIControlStateNormal];
        if (i == 0) {
            [_continueButton setTitleColor:HexStringColor(@"#222222") forState:UIControlStateNormal];
            [_continueButton setBackgroundColor:HexStringColor(@"#FFFFFF")];
            _continueButton.titleLabel.font=[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0];
            _continueButton.alpha = 1;
            btnBottomView.backgroundColor = HexStringColor(@"#FE6745");
        }else{
            [_continueButton setTitleColor:HexStringColor(@"#666666") forState:UIControlStateNormal];
            [_continueButton setBackgroundColor:UIColor.clearColor];
            _continueButton.titleLabel.font=[UIFont fontWithName:@"PingFang-SC-Regular" size:15.0];
            _continueButton.alpha = 0.7;
            btnBottomView.backgroundColor = UIColor.whiteColor;
        }
        [_continueButton setBackgroundColor:UIColor.clearColor];
        
        _continueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _continueButton.titleLabel.adjustsFontSizeToFitWidth=YES;
        [_continueButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        ViewRadius(_continueButton, 15);
        ViewRadius(btnBottomView, 2);
        [self.scrollV addSubview:btnBottomView];
        [self.scrollV addSubview:_continueButton];
        
        [self.bottomViewArr addObject:btnBottomView];
        [self.buttonArr addObject:_continueButton];
    }
    
    self.scrollV.contentSize = CGSizeMake(_scroolWidth, _cHeight);
    self.scrollV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
- (void)buttonClicked:(id)sender{
    UIButton *btn = (UIButton *)sender;
    NSInteger _tag = btn.tag;
    [self setButtonBeSelected:_tag];
    
    if (self.clickedBlock) {
        self.clickedBlock(_tag - 6666);
    }
}
- (void)setSelectedIndex:(NSInteger)index_x{
    if (index_x < 0) {
        return;
    }
    [self setButtonBeSelected:6666 + index_x];
}
- (void)setButtonBeSelected:(NSInteger)tag{
    
    for (UIButton *_btn in self.buttonArr) {
        if (tag == _btn.tag) {
            [_btn setTitleColor:HexStringColor(@"#222222") forState:UIControlStateNormal];
//            [_btn setBackgroundColor:HexStringColor(@"#FFFFFF")];
            _btn.titleLabel.font=[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0];
            _btn.alpha = 1;
            CGRect frame = _btn.frame;
            frame.size.width += 300;
            frame.origin.x -= 150;
            ((UIView*)self.bottomViewArr[_btn.tag-6666]).backgroundColor = HexStringColor(@"#FE6745");
            [self.scrollV scrollRectToVisible:frame animated:YES];
        }else{
            [_btn setTitleColor:HexStringColor(@"#666666") forState:UIControlStateNormal];
            
            _btn.titleLabel.font=[UIFont fontWithName:@"PingFang-SC-Regular" size:15.0];
            _btn.alpha = 0.7;
            ((UIView*)self.bottomViewArr[_btn.tag-6666]).backgroundColor = UIColor.whiteColor;
        }
    }
    
}
#pragma mark - UIScrollView 的 delagate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:self.scrollV]) {
//        self.index_x = scrollView.contentOffset.x / Screen_width;
//        [self.segmentV setSelectedIndex:self.index_x];
//        [self clicked:NO];
    }
}

#pragma mark - getter
-(NSMutableArray *)buttonArr{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}
-(NSMutableArray *)bottomViewArr{
    if (!_bottomViewArr) {
        _bottomViewArr = [NSMutableArray array];
    }
    return _bottomViewArr;
}
 - (UIScrollView *)scrollV{
     if (!_scrollV) {
         _scrollV=[[UIScrollView alloc] init];
         _scrollV.pagingEnabled = NO;
         _scrollV.showsVerticalScrollIndicator = NO;
         _scrollV.showsHorizontalScrollIndicator = NO;
         _scrollV.contentOffset=CGPointZero;
     }
     return _scrollV;
 }
     
@end
