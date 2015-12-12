//
//  SettingViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/10/02.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTownViewController.h"
#import "GPSSearchTableViewCell.h"
#import "AFNetworking.h"
#import "District.h"
#import  <CoreLocation/CoreLocation.h>

@interface SettingViewController () <CLLocationManagerDelegate>
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITableView *settingTableView;
@property (retain, nonatomic) NSArray *sectionArray;
@property (retain, nonatomic) NSArray *areaArray;
@property (retain, nonatomic) CLLocation *location;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (nil == self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        // iOS 8以上
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            // NSLocationWhenInUseUsageDescriptionに設定したメッセージでユーザに確認
            [ self.locationManager requestWhenInUseAuthorization];
            // NSLocationAlwaysUsageDescriptionに設定したメッセージでユーザに確認
            //[locationManager requestAlwaysAuthorization];
        }
    }
    
    
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // 更新間隔はdistanceFilterプロパティ
    //self.locationManager.distanceFilter = 500;
    
    // 情報の更新を開始すれば、位置情報を取得
    [self.locationManager startUpdatingLocation];
    
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
    
    UINib *nib = [UINib nibWithNibName:@"GPSSearchTableViewCell" bundle:nil];
    [_settingTableView registerNib:nib forCellReuseIdentifier:@"GPSSearch"];
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
        GPSSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GPSSearch" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        [cell.searchBtn addTarget:self action:@selector(gpsSearch:) forControlEvents:UIControlEventTouchUpInside];
        [cell.searchBtn setBackgroundImage:[UIImage imageNamed:@"tappedBtnColor"] forState:UIControlStateHighlighted];
        
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
    if (indexPath.section == 1) {
        return 66.0;
    } else {
        return 44.0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SettingTownViewController *town = [self.storyboard instantiateViewControllerWithIdentifier:@"Town"];
        town.area = _areaArray[indexPath.row];
        [[self navigationController] pushViewController:town animated:YES];
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    _location = [locations lastObject];
}

- (void)gpsSearch:(UIButton *)buttno {
    NSString *key = @"AIzaSyD29EUmubbWgfn4qdiRczDt7SPV4sxiiag";
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%+.6f,%+.6f&key=%@&language=ja", _location.coordinate.latitude, _location.coordinate.longitude, key];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        // TODO: fetch DB
        NSArray *address = [NSArray arrayWithArray:[[responseObject valueForKey:@"results"] valueForKey:@"address_components"][0]];
        NSString *town = [self townName:address];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"town = %@", town];
        RLMResults *result = [[District objectsWithPredicate:pred] sortedResultsUsingProperty:@"read" ascending:YES];
        NSLog(@"%@", result);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

// google maps api
- (NSString *)townName:(NSArray *)address {
    NSString *town;
    for (NSDictionary *dic in address) {
        NSArray *types = [dic valueForKey:@"types"];
        for (NSString *str in types) {
            if ([str  isEqual: @"sublocality_level_1"]) {
                town = [dic valueForKey:@"short_name"];
            }
        }
    }
    
    return town;
}

@end
