//
//  DatePickerViewController.m
//  iidaPro-2015
//
//  Created by Tatsuhito Hirai on 07/08.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property(nonatomic,assign) NSDate *selectedDate;
@end

@implementation DatePickerViewController
@synthesize delegate;

-(void)send{
  if([self.delegate respondsToSelector:@selector(sendDate:)]){
    [self.delegate sendDate: _selectedDate];
  }
}


#pragma mark - Lifecycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction method

- (IBAction)valueChanged:(id)sender {
  _selectedDate = _datePicker.date;
  self.send;
}

@end
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



