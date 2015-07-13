//
//  AlarmViewController.m
//  iidaPro-2015
//
//  Created by Rath on 07/02.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "AlarmViewController.h"
#import "AppDelegate.h"
#import "DatePickerViewController.h"

@interface AlarmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nightAlarmLabel;
@property (weak, nonatomic) IBOutlet UILabel *morningAlarmLabel;
@property (weak, nonatomic) IBOutlet UISwitch *nightAlarmSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *morningAlarmSwitch;

@end

@implementation AlarmViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    _nightAlarmLabel.text = [appDelegate getNightAlarmTimeStr];
    _morningAlarmLabel.text = [appDelegate getMorningAlarmTimeStr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nightAlarmSetting:(id)sender {
 
  AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
  [appDelegate setNightOrMorning: @"night"];
 
  //コードでDatePickerVCに遷移するはずなんだけど・・・できない
  DatePickerViewController *dPVC = [[DatePickerViewController alloc] init];
  dPVC.modalPresentationStyle = UIModalPresentationCurrentContext;
  [self presentViewController:dPVC animated:YES completion:nil];
  
}

- (IBAction)morningAlarmSetting:(id)sender {
  AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
  [appDelegate setNightOrMorning: @"morning"];
  
  //コードでDatePickerVCに遷移するはずなんだけど・・・できない
  DatePickerViewController *dPVC = [[DatePickerViewController alloc] init];
  dPVC.modalPresentationStyle = UIModalPresentationCurrentContext;
  [self presentViewController:dPVC animated:YES completion:nil];
}


- (IBAction)nightAlarmSwitchChanged:(id)sender {
  AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
  [appDelegate setNightAlarmOnOff: _nightAlarmSwitch];
  _nightAlarmLabel.enabled = _nightAlarmSwitch;
}

- (IBAction)morningAlarmSwitchChanged:(id)sender {
  AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
  [appDelegate setMorningAlarmOnOff: _nightAlarmSwitch];
  _morningAlarmLabel.enabled = _morningAlarmSwitch;
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
