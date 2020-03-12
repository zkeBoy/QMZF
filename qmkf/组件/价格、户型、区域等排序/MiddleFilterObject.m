//
//  MiddleFilterObject.m
//  qmkf
//
//  Created by Mac on 2020/1/6.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "MiddleFilterObject.h"
#import "zOCMacro.h"

@interface MiddleFilterObject ()<ZHFilterMenuViewDelegate,ZHFilterMenuViewDetaSource>
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation MiddleFilterObject
 
- (instancetype)init {
    if (self = [super init]) {

        self.filterType = FilterTypeIsNewHouse;
        //便于演示房源展示数据源暂时是写在本地，可根据自身情况，如果需从接口请求可自行做下调整
        FilterDataUtil *dataUtil = [[FilterDataUtil alloc] init];
        self.menuView.filterDataArr = [dataUtil getTabDataByType:self.filterType];
    }
    return self;
}


/** 确定回调 */
- (void)menuView:(ZHFilterMenuView *)menuView didSelectConfirmAtSelectedModelArr:(NSArray *)selectedModelArr
{
    NSArray *dictArr = [ZHFilterItemModel mj_keyValuesArrayWithObjectArray:selectedModelArr];
    NSLog(@"结果回调：%@",dictArr.mj_JSONString);
}

/** 警告回调(用于错误提示) */
- (void)menuView:(ZHFilterMenuView *)menuView wangType:(ZHFilterMenuViewWangType)wangType
{
    if (wangType == ZHFilterMenuViewWangTypeInput) {
        NSLog(@"请输入正确的价格区间！");
    }
}

/** 返回每个 tabIndex 下的确定类型 */
- (ZHFilterMenuConfirmType)menuView:(ZHFilterMenuView *)menuView confirmTypeInTabIndex:(NSInteger)tabIndex
{
    if (tabIndex == 4) {
        return ZHFilterMenuConfirmTypeSpeedConfirm;
    }
    return ZHFilterMenuConfirmTypeBottomConfirm;
}

/** 返回每个 tabIndex 下的下拉展示类型 */
- (ZHFilterMenuDownType)menuView:(ZHFilterMenuView *)menuView downTypeInTabIndex:(NSInteger)tabIndex
{
    if (tabIndex == 0) {
        return ZHFilterMenuDownTypeTwoLists;
    } else if (tabIndex == 1) {
        if (self.filterType == FilterTypeISRent) {
            return ZHFilterMenuDownTypeOnlyItem;
        } else {
            return ZHFilterMenuDownTypeItemInput;
        }
    } else if (tabIndex == 2) {
        if (self.filterType == FilterTypeISRent) {
            return ZHFilterMenuDownTypeItemInput;
        } else {
            return ZHFilterMenuDownTypeOnlyItem;
        }
    } else if (tabIndex == 3) {
        return ZHFilterMenuDownTypeOnlyItem;
    } else if (tabIndex == 4) {
        return ZHFilterMenuDownTypeOnlyList;
    }
    return ZHFilterMenuDownTypeOnlyList;
}


- (ZHFilterMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[ZHFilterMenuView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 32) maxHeight:CGRectGetHeight([UIScreen mainScreen].bounds) - 32 - k_StatusBarAndNavigationBarHeight];
        _menuView.zh_delegate = self;
        _menuView.zh_dataSource = self;
        if (self.filterType == FilterTypeIsNewHouse) {
            _menuView.titleArr = @[@"区域",@"价格",@"户型",@"更多",@"排序"];
            _menuView.imageNameArr = @[@"x_arrow",@"x_arrow",@"x_arrow",@"x_arrow",@"x_arrow"];
        } else if (self.filterType == FilterTypeSecondHandHouse) {
            _menuView.titleArr = @[@"区域",@"价格",@"房型",@"更多",@"排序"];
            _menuView.imageNameArr = @[@"x_arrow",@"x_arrow",@"x_arrow",@"x_arrow",@"x_arrow"];
        } else if (self.filterType == FilterTypeISRent) {
            _menuView.titleArr = @[@"位置",@"方式",@"租金",@"更多",@""];
            _menuView.imageNameArr = @[@"x_arrow",@"x_arrow",@"x_arrow",@"x_arrow",@"x_px"];
        }
//        [self.view addSubview:_menuView];
    }
    return _menuView;
}

 
- (UIView*)getXinFangMenu {
    //开始显示
    [self.menuView beginShowMenuView];
    return self.menuView;
}


@end
