//
//  AlarmViewController.m
//  iidaPro-2015
//
//  Created by Rath on 07/02.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "AlarmViewController.h"
#import "DatePickerViewController.h"


@interface AlarmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *NightTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *MorningTimerLabel;
@end

@implementation AlarmViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - datePickerViewDelegate methods
-(void)sendDate:(NSDate *)date{
  NSLog(@"%@",date);
}
@end
