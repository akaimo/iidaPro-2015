//
//  AppDelegate.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/06/19.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "AppDelegate.h"
#import "RealmController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    RealmController *rc = [[RealmController alloc] init];
//    [rc createTestTable];
//    [rc deleteTestTable];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    // ex. 多摩区のデータ
    NSArray *tama = @[@{@"title":@"普通ごみ1",
                        @"date":@"水"},
                      @{@"title":@"普通ごみ2",
                        @"date":@"土"},
                      @{@"title":@"びん・缶・ペットボトル",
                        @"date":@"金"},
                      @{@"title":@"ミックスペーパー",
                        @"date":@"月"},
                      @{@"title":@"プラスチック製容器包装",
                        @"date":@"火"},
                      @{@"title":@"小物金属",
                        @"date":@"第１・３月"}];
    // default alarm
    NSArray *alarm = @[@{@"title":@"普通ごみ1",
                         @"time":@"08:30"},
                       @{@"title":@"普通ごみ2",
                         @"time":@"08:00"},
                       @{@"title":@"びん・缶・ペットボトル",
                         @"time":@"08:00"},
                       @{@"title":@"ミックスペーパー",
                         @"time":@"08:00"},
                       @{@"title":@"プラスチック製容器包装",
                         @"time":@"08:00"},
                       @{@"title":@"小物金属",
                         @"time":@"08:00"}];
    NSArray *myAlarm = @[@{@"title":@"アラーム1",
                           @"time":@"12/24 08:30"},
                         @{@"title":@"アラーム2",
                           @"time":@"12/25 08:45"}];
    [ud setObject:tama forKey:@"trash"];
    [ud setObject:alarm forKey:@"defaultAlarm"];
    [ud setObject:myAlarm forKey:@"myAlarm"];
    [ud synchronize];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
