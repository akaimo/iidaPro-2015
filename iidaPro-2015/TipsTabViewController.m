//
//  TipsTabViewController.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/15.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "TipsTabViewController.h"

@interface TipsTabViewController ()
- (IBAction)returnScreen:(id)sender;

@end

@implementation TipsTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *alphaColor = [self.view.backgroundColor colorWithAlphaComponent:0.8]; //透過率
    self.view.backgroundColor = alphaColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)viewDidAppear:(BOOL)animated {
    
    CGFloat h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    [UIView beginAnimations:nil context:nil];
    [self.view setFrame:CGRectMake(0, h, w, h)];
    [UIView setAnimationDuration:0.3f];
    [self.view setFrame:CGRectMake(0, 0, w, h)];
    [UIView commitAnimations];
}

- (IBAction)returnScreen:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}
@end