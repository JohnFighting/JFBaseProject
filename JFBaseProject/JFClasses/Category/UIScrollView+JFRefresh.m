//
//  UIScrollView+JFRefresh.m
//  JFBaseProject
//
//  Created by JohnFighting on 15/12/20.
//  Copyright © 2015年 john. All rights reserved.
//

#import "UIScrollView+JFRefresh.h"

@implementation UIScrollView (JFRefresh)
/** 添加头部刷新 */
-(void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)refreshBlock{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshBlock];
};

/** 开始头部刷新 */
-(void)beginHeaderRefresh{
    [self.mj_header beginRefreshing];
};

/** 结束头部刷新 */
-(void)endHeaderRefresh{
    [self.mj_header endRefreshing];
};

/** 添加脚步刷新 */
-(void)addFooterRefresh:(MJRefreshComponentRefreshingBlock)refreshBlock{
    self.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:refreshBlock];
};

/** 开始脚步刷新 */
-(void)beginFooterRefresh{
    [self.mj_footer beginRefreshing];
};

/** 结束脚步刷新 */
-(void)endFooterRefresh{
    [self.mj_footer endRefreshing];
};

@end
