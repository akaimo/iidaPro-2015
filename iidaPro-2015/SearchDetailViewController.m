//
//  SearchDetailViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 11/29/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "SearchDetailViewController.h"

@interface SearchDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *genreView;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genreImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *genreImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *genreImageView3;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@end

@implementation SearchDetailViewController

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

@end
