//
//  SettingViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/10/02.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTownViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;
@property (retain, nonatomic) NSArray *sectionArray;
@property (retain, nonatomic) NSArray *areaArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"設定";
    self.view.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:86/255.0 green:96/255.0 blue:133/255.0 alpha:1.000];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    _settingTableView.backgroundColor = [UIColor clearColor];
    _settingTableView.tableFooterView = [[UIView alloc] init];
    
    _sectionArray = @[@"パターンから選ぶ", @"GPSを使用する"];
    _areaArray = @[@"川崎区", @"幸区", @"中原区", @"高津区", @"宮前区", @"多摩区", @"麻生区"];
    
    if (_isFirstRun == YES) {
        [self.navigationItem setHidesBackButton:YES];
        
        _isFirstRun = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionArray[section];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    headerView.backgroundColor = [UIColor colorWithRed:41/255.0 green:52/255.0 blue:92/255.0 alpha:0.95];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, headerView.frame.size.width - 20, headerView.frame.size.height)];
    label.text = [_sectionArray objectAtIndex:section];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.shadowOffset = CGSizeMake(0, 1);
    label.shadowColor = [UIColor grayColor];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];    [headerView addSubview:label];
    tableView.sectionHeaderHeight = headerView.frame.size.height;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _areaArray.count;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"cell"];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = _areaArray[indexPath.row];
        
        return cell;
        
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"cell"];
        }
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = @"検索";
        
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cid"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"cid"];
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SettingTownViewController *town = [self.storyboard instantiateViewControllerWithIdentifier:@"Town"];
        town.area = _areaArray[indexPath.row];
        [[self navigationController] pushViewController:town animated:YES];
    }
}

@end
