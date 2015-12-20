//
//  AppDelegate.m
//  JFBaseProject
//
//  Created by JohnFighting on 15/12/19.
//  Copyright © 2015年 john. All rights reserved.
//
#warning 推送分为本地推送和远程推送
/**
 本地推送: 一般用来制作闹钟, 行程安排提醒, 区域变化提醒......
 远程推送: 服务器人员给客户端发送消息
 1. 必须到苹果开发者网站(developer.apple.com -> member center)去申请, $99 : ￥680 一年资格, 2小时能申请下来
 需要visa, master(万事达, 八达通)
 2. 需要到网站上通过应用的唯一标识(bundle id), 向苹果公司申请推送服务
 3. 还需要同时申请一个推送证书给服务器人员
 4. 用户运行起来应用之后, 会在协议方法中返回用户设备的唯一标识, 称为deviceToken
 5. 通过服务器人员给你的网络接口, 把deviceToken传递给服务器
 6. 服务器人员开始推送: 构建推送对象(不用了解) -> 拿着deviceToken + 苹果的证书 -> 通知苹果服务器 推送消息给对应Token的手机
 上方整体操作: 官方名称 APNs -> Apple Push Notification service
 苹果推送通知服务
 
 推送包含: 声音提示, 文字提示, icon的标记提示
 
 */

#import "AppDelegate.h"
#import "AppDelegate+JFCategory.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
#pragma mark - 远程推送服务协议
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    //当收到远程推送消息时触发
}
//启动后立刻触发. 返回的是当前设备在苹果服务器上的唯一标识
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
}
//如果是模拟器会注册失败, 假的iPhone
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#warning 推送服务需要获取用户的许可才可以, 需要在程序启动时获取用户的许可, iOS8之前和之后获取许可的代码不同
    //     1. 获取当前系统版本号, "9.0.1" -> 9.01
    float version = [UIDevice currentDevice].systemVersion.floatValue;
    if (version < 8.0) {
        [application registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeAlert|
         UIRemoteNotificationTypeSound|
         UIRemoteNotificationTypeBadge];
    }else{// >= 8.0
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:
                                                UIUserNotificationTypeAlert|
                                                UIUserNotificationTypeSound|
                                                UIUserNotificationTypeBadge categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    //在10秒钟以后, 为我发送一个通知
    //1. 创建本地通知
    UILocalNotification *localNoti = [UILocalNotification new];
    //设置提示内容
    localNoti.alertBody = @"alertBody";
    //设置操作提示
    localNoti.alertAction = @"解锁";
    //设置推送时的提示音, mp3格式, 小于30秒
    localNoti.soundName = @"lingsheng.mp3";
    //设置图标上的数字
    localNoti.applicationIconBadgeNumber = 9;
    //安排当前时间10秒钟以后触发此操作
    localNoti.fireDate = [[NSDate date]dateByAddingTimeInterval:10];
    //安排通知操作
    [application scheduleLocalNotification:localNoti];
    //运行 ---> 按cmd+L 锁屏 ==> 等10秒钟. 打开电脑声音

    return YES;
}
#pragma 下方协议方法会在推送消息被点击(桌面从屏幕上方弹出消息),(锁屏)右滑打开, 当前程序就在前台 时触发
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"notification %@", notification);
}


@end
