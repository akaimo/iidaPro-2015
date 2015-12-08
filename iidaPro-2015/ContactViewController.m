//
//  ContactViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/10/02.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UITextView *firstTextView;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UITextView *secondTextView;
@property (weak, nonatomic) IBOutlet UILabel *therdLabel;
@property (weak, nonatomic) IBOutlet UITextView *therdTextView;
@property (retain, nonatomic) NSDictionary *areaData;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"問い合わせ";
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _areaData = [NSDictionary dictionaryWithDictionary:[ud objectForKey:@"district"]];
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:86/255.0 green:96/255.0 blue:133/255.0 alpha:1.000];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    [self setLabels];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setLabels {
    _firstLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    _firstLabel.textColor = [UIColor whiteColor];
    _firstLabel.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    NSString *office;
    if ([[_areaData valueForKey:@"office"]  isEqual: @"南部"]) {
        office = @"南部生活環境事業所 044-266-5747";
    } else if ([[_areaData valueForKey:@"office"]  isEqual: @"川崎"]) {
        office = @"川崎生活環境事業所 044-541-2043";
    } else if ([[_areaData valueForKey:@"office"]  isEqual: @"中原"]) {
        office = @"中原生活環境事業所 044-411-9220";
    } else if ([[_areaData valueForKey:@"office"]  isEqual: @"宮前"]) {
        office = @"宮前生活環境事業所 044-866-9131";
    } else if ([[_areaData valueForKey:@"office"]  isEqual: @"多摩"]) {
        office = @"多摩生活環境事業所 044-933-4111";
    }
    _firstTextView.text = office;
    _firstTextView.textColor = [UIColor whiteColor];
    _firstTextView.backgroundColor = [UIColor clearColor];
    _firstTextView.editable = NO;
    
    _secondLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    _secondLabel.textColor = [UIColor whiteColor];
    _secondLabel.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    _secondTextView.text = @"電話 044-930-5300\n Web http://www.city.kawasaki.jp/kurashi/category/24-1-11-2-0-0-0-0-0-0.html";
    _secondTextView.textColor = [UIColor whiteColor];
    _secondTextView.backgroundColor = [UIColor clearColor];
    _secondTextView.editable = NO;
    
    _therdLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    _therdLabel.textColor = [UIColor whiteColor];
    _therdLabel.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    _therdTextView.text = @"電話 044-200-3939\n Web http://www.city.kawasaki.jp/index.html\n Mail https://www.contact.city.kawasaki.jp/cgi-bin/jp/mail/input.cgi";
    _therdTextView.textColor = [UIColor whiteColor];
    _therdTextView.backgroundColor = [UIColor clearColor];
    _therdTextView.editable = NO;
}

@end
