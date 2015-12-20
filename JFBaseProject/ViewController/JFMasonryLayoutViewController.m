//
//  JFMasonryLayoutViewController.m
//  JFBaseProject
//
//  Created by JohnFighting on 15/12/20.
//  Copyright © 2015年 john. All rights reserved.
//

#import "JFMasonryLayoutViewController.h"

/** 注释使用此方式,前2星, 后1星. 当用到注释代码时,会有提示 */
/*
 推荐:使用懒加载方式初始化各种属性, 可以让代码以分块的形式存在, 维护起来更加的方便, 便于阅读和修改.
 */

/*
 Xcode插件的使用:
 1. 可以百度搜索  Xcode插件  获取各种常用插件名称, 拿到名称以后, 到github去下载
 2. 安装方法: 运行下载下来的插件包中的工程文件, 等待运行完毕.  有的运行完会弹出提示框, 有的插件不弹
 3.如果弹出提示框, 一定要选择load Bundle, 表示加载插件
 4.插件安装完毕 需要大退(右键退出 , cmd+q) Xcode,重新打开
 5.如果安装不上-> 可能是xcode原因, 需要删除xcode到垃圾桶, 清空垃圾桶, 拷贝新的xcode进入应用
 6.如果更新了新版Xcode,插件会失效..  通过重新安装来解决这个问题, 或者...百度 "Xcode更新插件失效"
 
 插件1:懒加载自动生成, DCLazyInstantiate.  安装完成的标志是 Xcode->菜单->Edit->多了一个 DCLazyInstantiate的功能项
 通过setting选项 可以修改生成的快捷键, 注意修改完毕以后按回车确认
 操作:把光标挪到要生成的属性行,按生成快捷键
 */


/*
 Masonry的引入:
 1.Cocoapods引入
 2.通过在Github下载zip文件, 需要拖拽文件中的Masonry文件夹. 一定要选择Copy,即1 2 4选项
 
 */

@interface JFMasonryLayoutViewController ()
/** 添加一个红色的视图,在右上,距离20. 宽高80,80*/
@property(nonatomic,strong) UIView *redView;
/** 添加紫色视图,左下角,距离20. 宽高100,100 */
@property(nonatomic,strong) UIView *purpleView;
/** 添加一个灰色视图,左上方20, 宽高90 90 */
@property(nonatomic,strong) UIView *grayView;
/** 添加一个绿色视图,右下角20, 宽高与红色视图相等 */
@property(nonatomic,strong) UIView *greenView;
@end

@implementation JFMasonryLayoutViewController
- (UIView *)greenView {
    if(_greenView == nil) {
        _greenView = [[UIView alloc] init];
        _greenView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_greenView];
        [_greenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(-20);
            //绿色视图 与 红色视图 宽高相等
#warning self.redView还是_redView, 必须使用self.redView, 防止redView没有初始化,一定要调用它的懒加载
            /*
             make.width.mas_equalTo(self.redView.mas_width);
             make.height.mas_equalTo(self.redView.mas_height);
             */
            //          简写: 当A的c属性 等于 B的c属性,如果等于的是同一个属性, 则可以简写
            /*
             make.width.mas_equalTo(self.redView);
             make.height.mas_equalTo(self.redView);
             */
            make.size.mas_equalTo(self.redView);
        }];
    }
    return _greenView;
}

- (UIView *)grayView {
    if(_grayView == nil) {
        _grayView = [[UIView alloc] init];
        _grayView.backgroundColor=[UIColor grayColor];
        [self.view addSubview:_grayView];
        [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            /*
             make.top.mas_equalTo(20);
             make.left.mas_equalTo(20);
             */
            //   通过提取公因数 20 ,简写
            make.top.mas_equalTo(80);
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(90, 90));
        }];
    }
    return _grayView;
}

- (UIView *)purpleView {
    if(_purpleView == nil) {
        _purpleView = [[UIView alloc] init];
        _purpleView.backgroundColor=[UIColor purpleColor];
        [self.view addSubview:_purpleView];
        [_purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
            //视图左边缘距离父视图所边缘向右移动20
#warning 什么时候用left...什么使用用 带mas_前缀的???,凡是在equalTo()中的,用mas_前缀的,或者说 只有make才能用没有前缀的
#warning 如果是距离父视图,例如 上对上,下对下,宽度对宽度 等等... 这些可以不写,默认
            //            make.left.mas_equalTo(self.view.mas_left).mas_equalTo(+20);
            make.left.mas_equalTo(20);
            make.bottom.mas_equalTo(-20);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    return _purpleView;
}

- (UIView *)redView {
    if(_redView == nil) {
#warning AutoLayout是取代frame的布局方式, 可以说autoLayout和frame是冲突的
        _redView = [[UIView alloc] init];
        _redView.backgroundColor=[UIColor redColor];
#warning 在添加AutoLayout属性之前,必须把对应控件添加到父视图中,否则崩溃Crash
        [self.view addSubview:_redView];
        //使用Masonry来添加约束
#warning 关于方向,以+ -号代表方向,相对于参照物向下+向右移动为正+, 向上+向左移动为负-
        [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
            //block中的make代表的就是当前控件
            make.top.mas_equalTo(80);
            make.right.mas_equalTo(-20);
            /*
             make.width.mas_equalTo(80);
             make.height.mas_equalTo(80);
             */
            //            简化⬆️
            make.size.mas_equalTo(CGSizeMake(80, 80));
            
        }];
    }
    return _redView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //只是为了调用懒加载
    //    [self redView];
    //偏爱
    self.redView.hidden = NO;
    self.purpleView.hidden = NO;
    self.grayView.hidden = NO;
    self.greenView.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
