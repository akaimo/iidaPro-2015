//
//  LocalNotificationManager.m
//  iidaPro-2015
//
//  Created by akaimo on 11/10/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "LocalNotificationManager.h"
#import "AppDelegate.h"

@implementation LocalNotificationManager

#pragma mark - Scheduler
- (void)scheduleLocalNotifications {
    // 一度通知を全てキャンセルする
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // 通知を設定していく...
    [self scheduleWeeklyWork];
}

- (void)scheduleWeeklyWork {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSArray *defaultAlarmArray = [ud objectForKey:@"defaultAlarm"];
    NSArray *myAlarm = [ud objectForKey:@"myAlarm"];
    for (NSDictionary *dic in defaultAlarmArray) {
        if ([[dic valueForKey:@"switch"]  isEqual: @"on"]) {
            // TODO: register alarm
            // http://ios-practice.readthedocs.org/en/latest/docs/notification/
            NSLog(@"on");
        }
    }
    for (NSDictionary *dic in myAlarm) {
        if ([[dic valueForKey:@"switch"]  isEqual: @"on"]) {
            // TODO: register alarm
            NSLog(@"on");
        }
    }
}

#pragma mark - helper
- (void)makeNotification:(NSDate *) fireDate alertBody:(NSString *) alertBody userInfo:(NSDictionary *) userInfo {
    // 現在より前の通知は設定しない
    if (fireDate == nil || [fireDate timeIntervalSinceNow] <= 0) {
        return;
    }
    [self schedule:fireDate alertBody:alertBody userInfo:userInfo];
}

- (void)schedule:(NSDate *) fireDate alertBody:(NSString *) alertBody userInfo:(NSDictionary *) userInfo {
    // ローカル通知を作成する
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    [notification setFireDate:fireDate];
    [notification setTimeZone:[NSTimeZone systemTimeZone]];
    [notification setAlertBody:alertBody];
    [notification setUserInfo:userInfo];
    [notification setSoundName:UILocalNotificationDefaultSoundName];
    [notification setAlertAction:@"Open"];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
