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
  /*書かなくても動く？*/

  NSDate *AlarmTime;
  NSString *AlarmTimeStr;
  NSString *NightOrMoning;
  
  /*ここまで*/
}

@property (strong, nonatomic) UIWindow *window;


/*ここよりHiraiが実装した部分*/
/*書かなくても動く？*/

@property (strong, nonatomic) NSDate *AlarmTime;
@property (strong, nonatomic) NSString *AlarmTimeStr;
@property (strong, nonatomic) NSString *NightOrMorning;

/*↑夜と昼用どちらのタイマーかを示す。とる値はNightかNightOrMorningのみ*/

/*ここまで*/
@end

