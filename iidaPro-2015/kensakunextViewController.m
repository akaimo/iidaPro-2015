//
//  kensakunextViewController.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/03.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "kensakunextViewController.h"

@interface kensakunextViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (strong, nonatomic) IBOutlet UIImageView *imageName;

@end

@implementation kensakunextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageName.image = [UIImage imageNamed:_nextImageName];
    self.labelName.text = _nextLabelName;
    
    if([_nextImageName isEqual: @"trushicon1"]){
        _nextText.text = @"ゴミの種類1個目は\nこうやって\n捨てます。";
    }
    _nextText.textColor = [UIColor blackColor];
    _nextText.backgroundColor = [UIColor yellowColor];
    _nextText.textAlignment = NSTextAlignmentCenter;
    _nextText.editable = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
