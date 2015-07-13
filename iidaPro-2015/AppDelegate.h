//
//  AppDelegate.h
//  iidaPro-2015
//
//  Created by akaimo on 2015/06/19.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

{
  /*ここよりHiraiが実装した部分*/
 
  NSMutableDictionary *appDlgDict;
  
  /*ここまで*/
}

@property (strong, nonatomic) UIWindow *window;


/*ここよりHiraiが実装した部分*/

@property (strong, nonatomic) NSMutableDictionary *appDlgDict;

-(void)setNightAlarmTime:(NSDate *)date;
-(NSDate *)getNightAlarmTime;

-(void)setMorningAlarmTime:(NSDate *)date;
-(NSDate *)getMorningAlarmTime;

-(void)setNightAlarmTimeStr:(NSString * )str;
-(NSString *)getNightAlarmTimeStr;

-(void)setMorningAlarmTimeStr:(NSString * )str;
-(NSString *)getMorningAlarmTimeStr;

-(void)setNightOrMorning:(NSString *)str;
-(NSString *)getNightOrMorning;

//内部的にはNSNumberで管理している
-(void)setNightAlarmOnOff:(BOOL)onOff;
-(BOOL)getNightAlarmOnOff;

-(void)setMorningAlarmOnOff:(BOOL)onOff;
-(BOOL)getMorningAlarmOnOff;

/*ここまで*/
@end

