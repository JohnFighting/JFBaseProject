//
//  JFNewsNetManager.h
//  JFBaseProject
//
//  Created by JohnFighting on 15/12/19.
//  Copyright © 2015年 john. All rights reserved.
//

#import "JFBaseNetManager.h"

@interface JFNewsNetManager : JFBaseNetManager
//http://c.m.163.com/nc/video/home/1-10.html
//1-10, 从第一条数据开始获取,共获取10条, 11-10, 21-10
+ (id)getNewsListWithStartIndex:(NSInteger)index kCompletionHandle
@end
