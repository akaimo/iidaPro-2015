//
//  DataViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 11/22/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "DataViewController.h"
#import "CalendarTableViewCell.h"

@interface DataViewController () <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) UITableView *calendarTableView;

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 66, self.view.frame.size.width, self.view.frame.size.height - 66);
    _calendarTableView = [[UITableView alloc] initWithFrame:rect];
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


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 31;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Calendar" forIndexPath:indexPath];
    
    long time = (-15 + indexPath.row)*24*60*60;
    NSDate *date = [_num initWithTimeInterval:time sinceDate:_num];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    NSString* weekDayStr = df.weekdaySymbols[comps.weekday-1];
    cell.weekdayLabel.text = weekDayStr;
    
    comps = [calendar components:NSCalendarUnitDay fromDate:date];
    NSString *dateTimeString = [NSString stringWithFormat:@"%ld", (long)comps.day];
    cell.dayLabel.text = dateTimeString;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 15) {
        return 88.0;
    }
    return 55.0;
}

@end
