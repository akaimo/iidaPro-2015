//
//  kensakunextViewController.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/03.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "kensakunextViewController.h"

@interface kensakunextViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelname;
@property (weak, nonatomic) IBOutlet UIImageView *imagename;

@end

@implementation kensakunextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagename.image = [UIImage imageNamed:_nextimagename];
    self.labelname.text = _nextlabelname;
    
    if([_nextimagename isEqual: @"trushicon1"]){
        _nexttext.text = @"ゴミの種類1個目は\nこうやって\n捨てます。";
    }
    _nexttext.textColor = [UIColor blackColor];
    _nexttext.backgroundColor = [UIColor yellowColor];
    _nexttext.textAlignment = NSTextAlignmentCenter;
    _nexttext.editable = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
