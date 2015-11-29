//
//  AppDelegate.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/06/19.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import <Realm/Realm.h>
#import "AppDelegate.h"
#import "RealmController.h"
#import "LocalNotificationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // permit local notification
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    }
    
    _categoryArray = @[@"普通ごみ1", @"普通ごみ2", @"びん・缶・ペットボトル",
                       @"ミックスペーパー", @"プラスチック製容器包装", @"小物金属"];
    _categoryDict = @{@"普通ごみ1":@"normal_1",
                      @"普通ごみ2":@"normal_2",
                      @"びん・缶・ペットボトル":@"bottle",
                      @"ミックスペーパー":@"mixedPaper",
                      @"プラスチック製容器包装":@"plastic",
                      @"小物金属":@"bigRefuse"};
    
    // userDefault all delete
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    if ([self isFirstRun]) {
        NSLog(@"first");
        // アラームの初期設定
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSDictionary *alarm = @{@"normal_1":@{@"time":@"08:00",
                                              @"switch":@"off"},
                                @"normal_2":@{@"time":@"08:00",
                                              @"switch":@"off"},
                                @"bottle":@{@"time":@"08:00",
                                            @"switch":@"off"},
                                @"mixedPaper":@{@"time":@"08:00",
                                                @"switch":@"off"},
                                @"plastic":@{@"time":@"08:00",
                                             @"switch":@"off"},
                                @"bigRefuse":@{@"time":@"08:00",
                                               @"switch":@"off"}};
        NSArray *myAlarm = @[@{@"title":@"マイアラームを設定しよう",
                               @"time":@"01/01 08:30",
                               @"switch":@"off"}];
        [ud setObject:alarm forKey:@"defaultAlarm"];
        [ud setObject:myAlarm forKey:@"myAlarm"];
        [ud synchronize];
        
        // メインスレッドでの地域情報の同期
        RealmController *rc = [[RealmController alloc] init];
        [rc districtTableMain];
        
        // サブスレッドでその他のDBを同期
        
        // 地域設定のページへ
    }
    
//    NSLog(@"Realm: %@", [RLMRealmConfiguration defaultConfiguration].path);
//    RealmController *rc = [[RealmController alloc] init];
//    [rc createTestTable];
//    [rc deleteTestTable];
    
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSDictionary *alarm = @{@"normal_1":@{@"time":@"08:00",
//                                          @"switch":@"on"},
//                            @"normal_2":@{@"time":@"08:00",
//                                          @"switch":@"off"},
//                            @"bottle":@{@"time":@"08:00",
//                                        @"switch":@"off"},
//                            @"mixedPaper":@{@"time":@"08:00",
//                                            @"switch":@"off"},
//                            @"plastic":@{@"time":@"08:00",
//                                         @"switch":@"off"},
//                            @"bigRefuse":@{@"time":@"08:00",
//                                           @"switch":@"off"}};
//    NSArray *myAlarm = @[@{@"title":@"アラーム1",
//                           @"time":@"12/24 08:30",
//                           @"switch":@"on"},
//                         @{@"title":@"アラーム2",
//                           @"time":@"12/25 08:45",
//                           @"switch":@"off"}];
//    [ud setObject:alarm forKey:@"defaultAlarm"];
//    [ud setObject:myAlarm forKey:@"myAlarm"];
//    [ud synchronize];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // set alarm
    LocalNotificationManager *notificationManager = [[LocalNotificationManager alloc] init];
    [notificationManager scheduleLocalNotifications];
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

- (BOOL)isFirstRun
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults objectForKey:@"firstRunDate"]) {
        return NO;
    }
    
    [userDefaults setObject:[NSDate date] forKey:@"firstRunDate"];
    [userDefaults synchronize];
    
    return YES;
}

@end
