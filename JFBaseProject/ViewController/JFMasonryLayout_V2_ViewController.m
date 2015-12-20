//
//  JFMasonryLayout_V2_ViewController.m
//  JFBaseProject
//
//  Created by JohnFighting on 15/12/20.
//  Copyright © 2015年 john. All rights reserved.
//

#import "JFMasonryLayout_V2_ViewController.h"

@interface JFMasonryLayout_V2_ViewController ()
/** 绿色视图,4个边缘距离屏幕边缘20像素 */
@property(nonatomic,strong) UIView *greenView;
/** 红色视图,在屏幕中心,宽高100 */
@property(nonatomic,strong) UIView *redView;
/** 紫色视图,屏幕右上角20, 宽高是红色视图的1.5倍 */
@property(nonatomic,strong) UIView *purpleView;

/** 蓝色视图,右边缘与红色视图对齐, 宽=紫.高, 高=紫.宽, 在红色视图上方50像素 */
@property(nonatomic,strong) UIView *blueView;

@end

@implementation JFMasonryLayout_V2_ViewController
- (UIView *)blueView {
    if(_blueView == nil) {
        _blueView = [[UIView alloc] init];
        _blueView.backgroundColor=[UIColor blueColor];
        [self.view addSubview:_blueView];
        [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.purpleView.mas_height);
            make.height.mas_equalTo(self.purpleView.mas_width);
            //  蓝色视图下底距离红色视图的上 向上移动50像素
            make.bottom.mas_equalTo(self.redView.mas_top).mas_equalTo(-50);
            //  蓝色 红色视图 右边缘对齐---margin:边缘...有错误,不推荐
            /*
             make.rightMargin.mas_equalTo(self.redView.mas_rightMargin);
             ⬇️*/
            make.right.mas_equalTo(self.redView.mas_right);
        }];
    }
    return _blueView;
}

- (UIView *)purpleView {
    if(_purpleView == nil) {
        _purpleView = [[UIView alloc] init];
        _purpleView.backgroundColor = [UIColor purpleColor];
        [self.view addSubview:_purpleView];
        [_purpleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            //紫色视图的宽高是红色视图的1.5倍
            /*
             multipliedBy: 乘法运算
             priority: 优先级. 优先级高的生效,当约束冲突时
             */
            make.size.mas_equalTo(self.redView).multipliedBy(1.5).priorityLow();
            //紫色视图的宽度小于等于80
            make.width.mas_lessThanOrEqualTo(80);
        }];
    }
    return _purpleView;
}

- (UIView *)redView {
    if(_redView == nil) {
        _redView = [[UIView alloc] init];
        _redView.backgroundColor=[UIColor redColor];
        [self.view addSubview:_redView];
        [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            //如果值等于0,可以不写后面的equal
            /*
             make.centerX.mas_equalTo(self.view).mas_equalTo(50);
             make.centerY.mas_equalTo(self.view);
             */
            /*
             make.center.mas_equalTo(CGPointMake(50, 0));
             */
            
            //            如果正好居中
            make.center.mas_equalTo(self.view);
        }];
    }
    return _redView;
}

- (UIView *)greenView {
    if(_greenView == nil) {
        _greenView = [[UIView alloc] init];
        _greenView.backgroundColor=[UIColor greenColor];
        [self.view addSubview:_greenView];
        [_greenView mas_makeConstraints:^(MASConstraintMaker *make) {
            /*
             make.left.top.mas_equalTo(20);
             make.right.bottom.mas_equalTo(-20);
             */
            /*
             make.edges.mas_equalTo(UIEdgeInsetsMake(20, 20, 20, 20));
             */
            //如果让绿色视图充满整个父视图,即上下左右距离都为0
            make.edges.mas_equalTo(0);
        }];
    }
    return _greenView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.greenView.hidden = NO;
    self.redView.hidden = NO;
    self.purpleView.hidden = NO;
    self.blueView.hidden = NO;
    //直接调用方法,立刻根据约束更新所有视图
    [self.view layoutIfNeeded];
    /*
     使用Masonry添加约束的方式有3种:
     makeConstraint:多次调用 是累加的效果
     remakeConstraint:删除之前约束,添加新的约束
     updateConstraint:更新之前的约束
     */
    
    //使用Masonry做动画,把紫色视图10秒钟,移动到屏幕下方,宽高变为50,50
    [UIView animateWithDuration:10 animations:^{
        //   重新添加约束
        [self.purpleView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
#warning 如果是AutoLayout模式,做移动位置或者大小的动画,一定要通知视图 实时根据新的约束 刷新位置和大小
        //        [self.view layoutIfNeeded];
        //只想更新紫色的,需要先标记要更新的视图
        [self.purpleView setNeedsLayout];
        [self.purpleView layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
