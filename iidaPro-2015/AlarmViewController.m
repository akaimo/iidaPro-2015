//
//  AlarmViewController.m
//  iidaPro-2015
//
//  Created by Rath on 07/02.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "AlarmViewController.h"
#import "AppDelegate.h"

@interface AlarmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *NightTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *MorningTimerLabel;
@end

@implementation AlarmViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
  if ([appDelegate.NightOrMorning isEqualToString: @"Night"]) {
    /*夜のタイマーの時間を反映させる(あとで実装)*/
  }
  if([appDelegate.NightOrMorning isEqualToString: @"Morning"]){
    /*朝のタイマーの時間を反映させる(あとで実装)*/
  }
  /*必要そうなら使う
  [appDelegate setNightOrMorning: NULL];
   一度反映させたらリセットしておく
  */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)NightTimerSetting:(id)sender {
  AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
  [appDelegate setNightOrMorning: @"Night"];
  
  /*コードでDatePickerVCに遷移(あとで実装)*/
}
- (IBAction)MorningTimerSetting:(id)sender {
  AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
  [appDelegate setNightOrMorning: @"Morning"];
  
  /*コードでDatePickerVCに遷移(あとで実装)*/
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
