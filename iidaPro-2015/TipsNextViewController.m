//
//  TipsNextViewController.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/08.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "TipsNextViewController.h"

@interface TipsNextViewController()

@property (weak, nonatomic) IBOutlet UILabel *TipsNextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *TipsNextImage;
@end

@implementation TipsNextViewController{
    NSInteger tipsImageNum;
    NSString *tipsNo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    tipsNo=nil;
    tipsNo=[_tipsData valueForKey:@"id"];
    //NSLog(@"%@",tipsNo);
    self.view.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
        _TipsNextImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",tipsNo]];
    if(!_TipsNextImage.image){
        _TipsNextImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"tips1"]];
    }
    _TipsNextLabel.text = [_tipsData valueForKey:@"title"];
    _TipsNextText.text =[_tipsData valueForKey:@"detail"];
    _TipsNextLabel.textColor = [UIColor whiteColor];
    _TipsNextText.textColor = [UIColor whiteColor];
    _TipsNextText.backgroundColor = [UIColor clearColor];
    _TipsNextText.textAlignment = NSTextAlignmentCenter;
    _TipsNextText.editable = NO;
    [_TipsNextText flashScrollIndicators];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
