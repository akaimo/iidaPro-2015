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

@implementation TipsNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.TipsNextImage.image = [UIImage imageNamed:_TipsNextImageName];
    self.TipsNextLabel.text = _TipsNextTitle;
    
    if([_TipsNextImageName isEqual: @"trashicon1"]){
        _TipsNextText.text = @"豆知識の中身を変゛え゛た゛い゛";
    }
    _TipsNextText.textColor = [UIColor blackColor];
    _TipsNextText.backgroundColor = [UIColor yellowColor];
    _TipsNextText.textAlignment = NSTextAlignmentCenter;
    _TipsNextText.editable = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end