//
//  AISettingViewController.m
//  AIAnimationDemo
//
//  Created by 艾泽鑫 on 2016/11/10.
//  Copyright © 2016年 艾泽鑫. All rights reserved.
//

#import "AIBaseSettingViewController.h"
#import "AISettingTableViewCell.h"
#import "zOCMacro.h"

@interface AIBaseSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic)UITableView *tableView;
/** 数据源 */
@property (strong,nonatomic)NSMutableArray<NSMutableArray<AISettingCellAdapter*> *> *dataSource;

@end

@implementation AIBaseSettingViewController


#pragma mark -lazy

-(NSMutableArray<NSMutableArray<AISettingCellAdapter *> *> *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:[self getDataSource]];
    }
    return _dataSource;
}

-(NSMutableArray <NSMutableArray<AISettingCellAdapter*> *>*)getDataSource{
    return nil;
}

#define MainSize [UIScreen mainScreen].bounds.size
//导航栏高度
#define AINavgationBarH 64

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView                 =\
        [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainSize.width, MainSize.height - k_StatusBarAndNavigationBarHeight) style:(UITableViewStylePlain)];
        [_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.rowHeight       = 49;
        _tableView.tableFooterView = [self getFootView];
        _tableView.backgroundColor = [UIColor colorWithRed:0.9412 green:0.9412 blue:0.9412 alpha:1.0];
        //添加收键盘手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.cancelsTouchesInView =NO;
        [_tableView addGestureRecognizer:tap];
    }
    return _tableView;
}

- (UIView *)getFootView {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_width, 110)];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = HexStringColor_Alpha(@"FF1A76", 0.1);
    btn.layer.cornerRadius = 6;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setTitleColor:HexStringColor(@"FF1A76") forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 260, 36);
    [view addSubview:btn];
    
    btn.center = view.center;
    return view;
}

- (void)viewDidLoad {
    [super viewDidLoad]; 
    [self.view addSubview:self.tableView];
}

#pragma mark -UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AISettingTableViewCell *cell      = [AISettingTableViewCell createTableViewCellWithTableView:tableView];
    AISettingCellAdapter *cellAdapter = self.dataSource[indexPath.section][indexPath.row];
    cell.data                         = cellAdapter;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource[section].count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section == 0 ? 50:49;
}

#pragma mark --UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AISettingCellAdapter *cellAdapter = self.dataSource[indexPath.section][indexPath.row];
    if (cellAdapter.destVC) {//如果有目标控制器
        [self.navigationController pushViewController:[[cellAdapter.destVC alloc]init] animated:YES];
    }else if(cellAdapter.optionBlock){
        cellAdapter.optionBlock();
    }
}

#pragma mark --Action

- (void)loginOut {
    NSLog(@"%@",@"点击退出");
}

-(void)onClickSwitch{
    NSLog(@"%@",@"点击switch");
}
- (void)tap:(UITapGestureRecognizer*)tap{
    [self.view endEditing:YES];
}

@end
