//
//  JFRefreshViewController.m
//  JFBaseProject
//
//  Created by JohnFighting on 15/12/20.
//  Copyright © 2015年 john. All rights reserved.
//

#import "JFRefreshViewController.h"

@interface JFRefreshViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation JFRefreshViewController
- (UITableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(20, 0, 0, 0));
        }];
        //去掉多余Cell
        _tableView.tableFooterView = [UIView new];
        //模拟刷新5秒返回操作
        //_tableView.mj_header 最新的框架要这样写
        //        _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //            dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //                sleep(5);
        //                dispatch_async(dispatch_get_main_queue(), ^{
        //                    [_tableView.header endRefreshing];
        //                });
        //            });
        //        }];
        __weak UITableView *tb = _tableView;
        [_tableView addHeaderRefresh:^{
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                sleep(5);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [tb endHeaderRefresh];
                });
            });
        }];
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
