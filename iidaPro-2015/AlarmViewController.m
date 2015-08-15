//
//  AlarmViewController.m
//  iidaPro-2015
//
//  Created by Rath on 07/02.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "AlarmViewController.h"

@interface AlarmViewController ()

@property (weak, nonatomic) IBOutlet UILabel *morningAlarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightAlarmLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UISwitch *morningAlarmSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *nightAlarmSwitch;
@property (weak, nonatomic) IBOutlet UIView *dPView;

@property (weak, nonatomic) NSString *morningOrNight;
@property (weak, nonatomic) NSDate *morningAlarmTime;
@property (weak, nonatomic) NSDate *nightAlarmTime;
@property (weak, nonatomic) NSNumber *morningAlarmActivity;
@property (weak, nonatomic) NSNumber *nightAlarmActivity;

@end

@implementation AlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
  
  //初期化処理
  _morningOrNight = @"neither";

  _morningAlarmLabel.enabled = _morningAlarmActivity;
  _nightAlarmLabel.enabled = _nightAlarmActivity;
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"HH:mm";
  
  _morningAlarmLabel.text = [dateFormatter stringFromDate:_morningAlarmTime];
  _nightAlarmLabel.text = [dateFormatter stringFromDate:_nightAlarmTime];
  
}

- (IBAction)morningAlarmEdit:(id)sender {
  _morningOrNight = @"morning";
  _dPView.hidden = false;
  
  //ここにDP展開アニメーション
  
}
- (IBAction)nightAlarmEdit:(id)sender {
  _morningOrNight = @"night";
  _dPView.hidden = false;
  
   //ここにDP展開アニメーション
}

- (IBAction)morningAlarmOnOff:(id)sender {
  _morningAlarmActivity = [NSNumber numberWithBool: _morningAlarmSwitch.on];
  _morningAlarmLabel.enabled = _morningAlarmSwitch.on;
  if (_morningAlarmSwitch.on){
    [self setMorningAlarm: _morningAlarmTime];
  }else{
    [self deleteMorningAlarm];
  }
}
- (IBAction)nightAlarmOnOff:(id)sender {
  _nightAlarmActivity = [NSNumber numberWithBool: _nightAlarmSwitch.on];
  _nightAlarmLabel.enabled = _nightAlarmSwitch.on;
  if (_nightAlarmSwitch.on){
    [self setNightAlarm: _nightAlarmTime];
  }else{
    [self deleteNightAlarm];
  }
}

- (IBAction)dPValueChanged:(id)sender {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"HH:mm";
  
  if ([_dPView isEqual:@"morning"]) {
    _morningAlarmTime = _datepicker.date;
    _morningAlarmLabel.text = [dateFormatter stringFromDate:_datepicker.date];
    
    [self setMorningAlarm: _datepicker.date];
  }
  if ([_dPView isEqual:@"night"]) {
    _nightAlarmTime = _datepicker.date;
    _nightAlarmLabel.text = [dateFormatter stringFromDate:_datepicker.date];
    
    [self setNightAlarm: _datepicker.date];
  }
}

- (IBAction)quitDP:(id)sender {
  
  //ここにDP格納アニメーション
  
  _dPView.hidden = true;
  _morningOrNight = @"neither";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMorningAlarm:(NSDate*)date {
  
  if (date != nil && [date timeIntervalSinceNow] >0){
  
  //朝の通知がすでにある場合、削除する
  [self deleteMorningAlarm];
  
  
  //ここで朝の通知を設定
  UILocalNotification *morningNote = [[UILocalNotification alloc] init];
  morningNote.fireDate = date;
  [morningNote.userInfo setValue:@"morning" forKey:@"id"];
  morningNote.alertBody = @"朝のアラーム";
  
  }
  
}
- (void)deleteMorningAlarm{
  //朝の通知を消す設定。スイッチがOnOffされた時など用
  
  for(UILocalNotification *notification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
    if([[notification.userInfo objectForKey:@"id"] isEqual: @"morning"]) {
      [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
  }
  
}

- (void)setNightAlarm:(NSDate*)date {
  //ここで夜の通知を設定
  if (date != nil && [date timeIntervalSinceNow] >0){
  
  [self deleteNightAlarm];
  
  UILocalNotification *nightNote = [[UILocalNotification alloc] init];
  nightNote.fireDate = date;
  [nightNote.userInfo setValue:@"night" forKey:@"id"];
  nightNote.alertBody = @"夜のアラーム";

  }
}
- (void)deleteNightAlarm{
  //夜の通知を消す設定。スイッチがOnOffされた時など用
  
  for(UILocalNotification *notification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
    if([[notification.userInfo objectForKey:@"id"] isEqual: @"night"]) {
      [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
  }

}




@end
