//
//  SettingTownViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 11/20/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "SettingTownViewController.h"

@interface SettingTownViewController ()
@property (weak, nonatomic) IBOutlet UITableView *townTableView;

@end

@implementation SettingTownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _town;
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

@end
