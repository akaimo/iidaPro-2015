//
//  TipsNextViewController.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/08.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "TipsNextViewController.h"
#import "TipsClassification.h"

@interface TipsNextViewController()

@property (weak, nonatomic) IBOutlet UILabel *TipsNextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *TipsNextImage;
@end

@implementation TipsNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TipsNextImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_TipsNextImageName]];
    /*
    _TipsNextLabel.text =self.linkingObjecctsOfClass@"title" valueForKey:@"id",_TipsNextNum;
    _TipsNextText.text =self.linkingObjectsOfClass:@"detail" valueForKey:@"id",_TipsNextNum;
   */
    _TipsNextImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@", @""]];
    _TipsNextText.textColor = [UIColor blackColor];
    _TipsNextText.backgroundColor = [UIColor whiteColor];
    _TipsNextText.textAlignment = NSTextAlignmentCenter;
    _TipsNextText.editable = NO;
    [_TipsNextText flashScrollIndicators];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
