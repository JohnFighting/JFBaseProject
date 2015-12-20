//
//  JFNewsNetManager.m
//  JFBaseProject
//
//  Created by JohnFighting on 15/12/19.
//  Copyright © 2015年 john. All rights reserved.
//

#import "JFNewsNetManager.h"
#import "NewsPath.h"

@implementation JFNewsNetManager
+(id)getNewsListWithStartIndex:(NSInteger)index completionHandle:(void (^)(id, NSError *))completionHandle{
    NSString *path = [NSString stringWithFormat:kNewsPath, index];
    return [self GET:path parameters:nil completionHandle:^(id responseObj, NSError *error) {
        completionHandle(responseObj, error);
    }];
}
@end
