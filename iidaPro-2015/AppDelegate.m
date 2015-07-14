//
//  AppDelegate.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/06/19.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/*↓無くても動くけど注意が出るので一応・・・*/
@synthesize appDlgDict = _appDlgDict;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  /*以下Hiraiが実装した部分*/
  self.appDlgDict = [[NSMutableDictionary alloc] init];
  [self.appDlgDict setValue:@"21:00" forKey:@"nightAlarmTimeStr"];
  [self.appDlgDict setValue:@"09:00" forKey:@"morningAlarmTimeStr"];
  [self.appDlgDict setValue:@"on" forKey:@"nightAlarmOnOff"];
  [self.appDlgDict setValue:@"on" forKey:@"morningAlarmOnOff"];
  /**/
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
    // Called when the application is about to terminate. Save data if appropriate. Seealso applicationDidEnterBackground:.
}

/*ここよりHIRAIが実装した部分*/


-(void)setNightAlarmTime:(NSDate *)date{
  [self.appDlgDict setValue:date forKey:@"nightAlarmTime"];
}
-(NSDate *)getNightAlarmTime{
  return [self.appDlgDict objectForKey:@"nightAlarmTime"];
}

-(void)setMorningAlarmTime:(NSDate *)date{
  [self.appDlgDict setValue:date forKey:@"morningAlarmTime"];
}
-(NSDate *)getMorningAlarmTime{
  return [self.appDlgDict objectForKey:@"morningAlarmTime"];
}

-(void)setNightAlarmTimeStr:(NSString *)str{
  [self.appDlgDict setValue:str forKey:@"nightAlarmTimeStr"];
}
-(NSString *)getNightAlarmTimeStr{
  return [self.appDlgDict objectForKey:@"nightAlarmTimeStr"];
}

-(void)setMorningAlarmTimeStr:(NSString *)str{
  [self.appDlgDict setValue:str forKey:@"morningAlarmTimeStr"];
}
-(NSString *)getMorningAlarmTimeStr{
  return [self.appDlgDict objectForKey:@"morningAlarmTimeStr"];
}

-(void)setNightOrMorning:(NSString *)str{
  [self.appDlgDict setValue:str forKey:@"nightOrMorning"];
}
-(NSString *)getNightOrMorning{
  return [self.appDlgDict objectForKey:@"nightOrMorning"];
}


 
-(void)setNightAlarmOnOff:(BOOL)onOff{
  [self.appDlgDict setValue:[NSNumber numberWithBool:onOff] forKey:@"nightAlarmOnOff"];
}

-(BOOL)getNightAlarmOnOff{
  return  [[self.appDlgDict objectForKey:@"nightAlarmOnOff"] boolValue];
}

-(void)setMorningAlarmOnOff:(BOOL)onOff{
  [self.appDlgDict setValue:[NSNumber numberWithBool:onOff] forKey:@"morningAlarmOnOff"];
}

-(BOOL)getMorningAlarmOnOff{
  return  [[self.appDlgDict objectForKey:@"morningAlarmOnOff"] boolValue];
}
/*ここまで*/


@end
