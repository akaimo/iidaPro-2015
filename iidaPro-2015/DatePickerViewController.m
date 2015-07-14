//
//  DatePickerViewController.m
//  iidaPro-2015
//
//  Created by Tatsuhito Hirai on 07/08.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "DatePickerViewController.h"
#import "AppDelegate.h"
//#import "AlarmViewController.h"




@interface DatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DatePickerViewController


- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  }

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)valueChanged:(id)sender {
  
  AppDelegate *appDelegete = [[UIApplication sharedApplication]delegate];
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"HH:mm";
  
  if ([[appDelegete getNightOrMorning] isEqualToString: @"night"]) {
    [appDelegete setNightAlarmTime: _datePicker.date];
    [appDelegete setNightAlarmTimeStr: [dateFormatter stringFromDate:_datePicker.date]];
    
  }
  if ([[appDelegete getNightOrMorning] isEqualToString: @"morning"]) {
    [appDelegete setMorningAlarmTime: _datePicker.date];
    [appDelegete setMorningAlarmTimeStr: [dateFormatter stringFromDate:_datePicker.date]];

  }
}
- (IBAction)closeDP:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
*/

@end