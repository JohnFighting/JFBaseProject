//
//  JFCustomTabBarViewController.m
//  JFBaseProject
//
//  Created by JohnFighting on 15/12/20.
//  Copyright © 2015年 john. All rights reserved.
//

#import "JFCustomTabBarViewController.h"
/*
 自定义TabBar的原理:
 1.隐藏掉系统自带的tabbar
 2.使用自定义的视图,代替tabbar
 3.当选中按钮时 执行 selectIndex的切换操作
 */
@interface JFCustomTabBarViewController ()
/** 自定义tabbar所在视图, 全屏宽,距离上方20(让出电池条), 高度与原生tabbar高度一样*/
@property(nonatomic,strong) UIView *customTBView;

@end

@implementation JFCustomTabBarViewController
- (UIView *)customTBView {
    if(_customTBView == nil) {
        _customTBView = [[UIView alloc] init];
        _customTBView.backgroundColor=[UIColor lightGrayColor];
        [self.view addSubview:_customTBView];
        [_customTBView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(self.tabBar.mas_height);
        }];
        /*
         4个按钮,上下边缘都距离父视图0
         4个按钮宽高相等
         第一个按钮,左侧距离父视图左侧0
         剩余按钮左侧距离上一个按钮右侧0
         最后一个按钮,右侧距离父视图右侧0
         */
        NSArray *btnColors=@[[UIColor yellowColor],
                             [UIColor brownColor],
                             [UIColor cyanColor],
                             [UIColor blueColor]];
        //        指针->指向上一个按钮
        UIButton *lastBtn = nil;
        for (int i = 0; i<btnColors.count; i++) {
            UIButton *btn=[UIButton buttonWithType:0];
            [_customTBView addSubview:btn];
            btn.backgroundColor=btnColors[i];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                if (i == 0) {
                    make.left.mas_equalTo(0);
                }else{
                    make.left.mas_equalTo(lastBtn.mas_right);
                    make.width.mas_equalTo(lastBtn);
                    if (i == btnColors.count-1) {
                        make.right.mas_equalTo(0);
                    }
                }
            }];
            lastBtn = btn;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            //通过按钮的tag值来区分当前是哪个按钮触发的点击事件
            btn.tag = 100+i;
        }
    }
    return _customTBView;
}
- (void)clickBtn:(UIButton *)sender{
    //  100,101,102,103
    NSInteger tag = sender.tag;
    //控制器的索引值是 0~3
    self.selectedIndex = tag - 100;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    self.customTBView.hidden = NO;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 180, 200, 40)];
    [self.view addSubview:label];
    label.font = [UIFont systemFontOfSize:35];
    label.textColor = [UIColor blackColor];
    //从File.strings文件中, 获取hello 这个key所对应的值, 把值显示在标签中, 根据中英文环境, 来选择不同的文件..
    label.text = NSLocalizedStringFromTable(@"hello", @"File", nil);
    //特殊文件名: Localizable.strings --> 有优化
    label.text = NSLocalizedString(@"name", nil);
    //定义国际化图片: 两张图片, 中文环境显示A, 英文环境显示B
#warning 如果安装了KSImage那个插件, imageName方法将不出现代码提示
    NSString *imageName = NSLocalizedString(@"imageName", nil);
    UIImage *img = [UIImage imageNamed:imageName];
    
    //国际化应用程序的桌面名称, 国际化info.plist文件, 新建一个InfoPlist.strings文件
}
@end