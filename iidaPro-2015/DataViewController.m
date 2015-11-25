//
//  DataViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 11/22/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "DataViewController.h"
#import "CalendarTableViewCell.h"
#import "AppDelegate.h"

@interface DataViewController () <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) UITableView *calendarTableView;
@property (retain, nonatomic) NSDictionary *areaData;

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _areaData = [NSDictionary dictionaryWithDictionary:[ud objectForKey:@"district"]];
    
    CGRect rect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    _calendarTableView = [[UITableView alloc] initWithFrame:rect];
    _calendarTableView.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    _calendarTableView.delegate = self;
    _calendarTableView.dataSource = self;
    [self.view addSubview:_calendarTableView];
    
    UINib *nib = [UINib nibWithNibName:@"CalendarTableViewCell" bundle:nil];
    [_calendarTableView registerNib:nib forCellReuseIdentifier:@"Calendar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)trashImage:(NSString *)weekday {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString *todayCategory;
    for (NSString *category in appDelegate.categoryArray) {
        NSString *categoryKey = [appDelegate.categoryDict valueForKey:category];
        if ([weekday  isEqual: [_areaData valueForKey:categoryKey]]) {
            todayCategory = categoryKey;
            break;
        }
    }
    
    UIImage *categoryImage;
    if (![todayCategory  isEqual: @""] && [weekday  isEqual: [_areaData valueForKey:@"bigRefuse_date"]]) {
        // TODO: 小物金属とその他のごみがかぶっている
    } else {
        if ([todayCategory  isEqual:@"normal_1"] || [todayCategory isEqual:@"normal_2"]) {
            categoryImage = [UIImage imageNamed:@"S_Normal"];
        } else if ([todayCategory isEqual:@"bottle"]) {
            categoryImage = [UIImage imageNamed:@"S_Can"];
        } else if ([todayCategory isEqual:@"plastic"]) {
            categoryImage = [UIImage imageNamed:@"S_plastic"];
        } else if ([todayCategory isEqual:@"mixedPaper"]) {
            categoryImage = [UIImage imageNamed:@"S_Mixed"];
        } else if ([todayCategory isEqual:@"bigRefuse"]) {
            // TODO: 隔週のチェックをする
            categoryImage = [UIImage imageNamed:@"S_BigRefuse"];
        }
    }
    
    return categoryImage;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 31;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Calendar" forIndexPath:indexPath];
    if (indexPath.row == 15) {
        cell.backgroundColor = [UIColor colorWithRed:41/255.0 green:52/255.0 blue:92/255.0 alpha:0.6];
    } else {
        cell.backgroundColor = [UIColor clearColor];
    }
    
    long time = (-15 + indexPath.row)*24*60*60;
    NSDate *date = [_num initWithTimeInterval:time sinceDate:_num];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    NSString* weekDayStr = df.weekdaySymbols[comps.weekday-1];
    cell.weekdayLabel.text = weekDayStr;
    if (comps.weekday == 7) {
        // Saturday
        cell.weekdayLabel.textColor = [UIColor blueColor];
        cell.dayLabel.textColor = [UIColor blueColor];
    } else if (comps.weekday == 1) {
        // Sunday
        cell.weekdayLabel.textColor = [UIColor redColor];
        cell.dayLabel.textColor = [UIColor redColor];
    } else {
        cell.weekdayLabel.textColor = [UIColor whiteColor];
        cell.dayLabel.textColor = [UIColor whiteColor];
    }
    
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja"];
    weekDayStr = df.shortWeekdaySymbols[comps.weekday-1];
    cell.iconImageView.image = [self trashImage:weekDayStr];
    
    comps = [calendar components:NSCalendarUnitDay fromDate:date];
    NSString *dayStr = [NSString stringWithFormat:@"%ld", (long)comps.day];
    cell.dayLabel.text = dayStr;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 15) {
        return 110.0;
    }
    return 55.0;
}

@end
