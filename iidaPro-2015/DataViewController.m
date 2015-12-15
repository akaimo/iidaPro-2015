//
//  DataViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 11/22/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "DataViewController.h"
#import "CalendarTableViewCell.h"
#import "AdjustNSDate.h"
#import "CMPopTipView.h"
#import "RandomNumber.h"
#import "iidaPro_2015-Swift.h"

@interface DataViewController () <UITableViewDataSource, UITableViewDelegate, CMPopTipViewDelegate>
@property (retain, nonatomic) UITableView *calendarTableView;
@property (retain, nonatomic) NSDictionary *areaData;
@property (retain, nonatomic) NSMutableArray *monthNumArray;
@property (retain, nonatomic) NSMutableArray *monthStrArray;
@property (retain, nonatomic) NSMutableArray *separateMonthArray;
@property (nonatomic) BOOL nowMonth;
@property (retain, nonatomic) NSIndexPath *todayIndexPath;
@property (retain, nonatomic) NSArray *myAlarm;
@property (retain, nonatomic) NSMutableArray *myAlarmDate;
@property (retain, nonatomic) CMPopTipView *roundRectButtonPopTipView;
@property (retain, nonatomic) NSMutableDictionary *popTipMessageDic;
@property (retain, nonatomic) RandomNumber *randomNumber;

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self useMonth];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _areaData = [NSDictionary dictionaryWithDictionary:[ud objectForKey:@"district"]];
    _myAlarm = [ud objectForKey:@"myAlarm"];
    _myAlarmDate = [NSMutableArray array];
    _popTipMessageDic = [NSMutableDictionary dictionary];
    for (NSDictionary *dic in _myAlarm) {
        NSString *str = [dic valueForKey:@"time"];
        NSArray *ary = [str componentsSeparatedByString:@" "];
        [_myAlarmDate addObject:ary[0]];
    }
    
    CGRect rect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 64, self.view.frame.size.width, self.view.frame.size.height - 64);
    _calendarTableView = [[UITableView alloc] initWithFrame:rect];
    _calendarTableView.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    _calendarTableView.delegate = self;
    _calendarTableView.dataSource = self;
    [self.view addSubview:_calendarTableView];
    
    if (_nowMonth == YES) {
        [_calendarTableView scrollToRowAtIndexPath:_todayIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
    
    UINib *nib = [UINib nibWithNibName:@"CalendarTableViewCell" bundle:nil];
    [_calendarTableView registerNib:nib forCellReuseIdentifier:@"Calendar"];
    
    _randomNumber = [[RandomNumber alloc] init];
    [_randomNumber createRandomNumberArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)trashImage:(NSDate *)date {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *weekday = [self weekdayStr:date];
    
    NSString *todayCategory;
    for (NSString *category in appDelegate.categoryArray) {
        NSString *categoryKey = [appDelegate.categoryDict valueForKey:category];
        if ([weekday  isEqual: [_areaData valueForKey:categoryKey]]) {
            todayCategory = categoryKey;
            break;
        }
    }
    
    UIImage *categoryImage;
    NSMutableArray *array = [NSMutableArray array];
    if ([todayCategory  isEqual:@"normal_1"] || [todayCategory isEqual:@"normal_2"]) {
        [array addObject:[UIImage imageNamed:@"S_Normal"]];
    } else if ([todayCategory isEqual:@"bottle"]) {
        [array addObject:[UIImage imageNamed:@"C_Can"]];
    } else if ([todayCategory isEqual:@"plastic"]) {
        [array addObject:[UIImage imageNamed:@"S_plastic"]];
    } else if ([todayCategory isEqual:@"mixedPaper"]) {
        [array addObject:[UIImage imageNamed:@"S_Mixed"]];
    }
    
    // 小物金属・粗大ごみを出す曜日
    if (![todayCategory  isEqual: @""] && [weekday  isEqual: [_areaData valueForKey:@"bigRefuse_date"]]) {
        NSInteger *weekdayOridinal = (long *)[self weekdayOridinal:date];
        if (weekdayOridinal == (long *)[[_areaData valueForKey:@"bigRefuse_1"] longValue] || weekdayOridinal == (long *)[[_areaData valueForKey:@"bigRefuse_2"] longValue]) {
            [array addObject:[UIImage imageNamed:@"C_BigRefuse"]];
        }
    }
    
    return array;
}

- (NSInteger)weekdayOridinal:(NSDate *)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitWeekdayOrdinal fromDate:date];
    return components.weekdayOrdinal;
}

- (NSString *)weekdayStr:(NSDate *)date {
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja"];
    return df.shortWeekdaySymbols[comps.weekday-1];
}

- (void)useMonth {
    // カレンダーに使う日にちの作成
    NSMutableArray *calendarData = [NSMutableArray array];
    for (int i=0; i<31; i++) {
        long time = (-3 + i)*24*60*60;
        NSDate *date = [_num initWithTimeInterval:time sinceDate:_num];
        [calendarData addObject:date];
    }
    
    // カレンダーに登場する月の数字を取得
    _monthNumArray = [NSMutableArray array];
    AdjustNSDate *adjust = [[AdjustNSDate alloc] init];
    for (NSDate *date in calendarData) {
        bool insert = YES;
        NSString *str = [adjust getMonthNum:date];
        for (NSString *month in _monthNumArray) {
            if ([month isEqual:str]) {
                insert = NO;
                break;
            }
        }
        if (insert == YES) {
            [_monthNumArray addObject:str];
        }
    }
    
    // 月の英語を取得
    _monthStrArray = [NSMutableArray array];
    for (NSString *numStr in _monthNumArray) {
        int num = [numStr intValue];
        NSString *monthStr = [adjust getMonthStr:num];
        [_monthStrArray addObject:monthStr];
    }
    
    // 月別に分けてカレンダーのデータを作成
    _separateMonthArray = [NSMutableArray array];
    for (NSString *monthNum in _monthNumArray) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDate *date in calendarData) {
            if (monthNum == [adjust getMonthNum:date]) {
                [array addObject:date];
            }
        }
        [_separateMonthArray addObject:array];
    }
    
    // 今月かどうかのフラグ
    if ([adjust getMonthNum:[NSDate date]] == [adjust getMonthNum:_num]) {
        _nowMonth = YES;
    } else {
        _nowMonth = NO;
    }
    
    // 当日のindexPathを作成
    if (_nowMonth == YES) {
        for (int i=0; i<_separateMonthArray.count; i++) {
            for (int j=0; j<[_separateMonthArray[i] count]; j++) {
                if ([_separateMonthArray[i][j] isEqualToDate:_num]) {
                    _todayIndexPath = [NSIndexPath indexPathForRow:j inSection:i];
                }
            }
        }
    }
}

- (NSString *)dateForString:(NSDate *)date {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd"];
    NSString *str = [formatter stringFromDate:date];
    
    return str;
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _separateMonthArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_monthStrArray objectAtIndex:section];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    headerView.backgroundColor = [UIColor colorWithRed:41/255.0 green:52/255.0 blue:92/255.0 alpha:0.95];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, headerView.frame.size.width - 20, headerView.frame.size.height)];
    label.text = [_monthStrArray objectAtIndex:section];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.shadowOffset = CGSizeMake(0, 1);
    label.shadowColor = [UIColor grayColor];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    
    [headerView addSubview:label];
    tableView.sectionHeaderHeight = headerView.frame.size.height;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_separateMonthArray[section] count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Calendar" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath == _todayIndexPath) {
        cell.backgroundColor = [UIColor colorWithRed:41/255.0 green:52/255.0 blue:92/255.0 alpha:0.6];
    } else {
        cell.backgroundColor = [UIColor clearColor];
    }
    
    NSDate *date = _separateMonthArray[indexPath.section][indexPath.row];
    
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en"];
    NSString* weekDayStr = df.shortWeekdaySymbols[comps.weekday-1];
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
    
    NSArray *array = [self trashImage:date];
    if (array.count == 1) {
        cell.iconImageView.image = array[0];
    } else if (array.count == 2) {
        cell.iconImageView.image = array[0];
        cell.icon2ImageView.image = array[1];
    }
    
    comps = [calendar components:NSCalendarUnitDay fromDate:date];
    NSString *dayStr = [NSString stringWithFormat:@"%ld", (long)comps.day];
    cell.dayLabel.text = dayStr;
    
    NSString *time = [self dateForString:date];
    cell.alarmButton.hidden = YES;
    for (int i=0; i<_myAlarmDate.count; i++) {
        if ([time isEqual:_myAlarmDate[i]] && [[_myAlarm[i] valueForKey:@"switch"]  isEqual: @"on"]) {
            cell.alarmButton.hidden = NO;
            
            if (cell.alarmButton.tag == 0) {
                int num = [_randomNumber getRandomNumber];
                NSArray *time = [[_myAlarm[i] valueForKey:@"time"] componentsSeparatedByString:@" "];
                NSString *message = [NSString stringWithFormat:@"%@ %@", [_myAlarm[i] valueForKey:@"title"], time[1]];
                NSString *key = [NSString stringWithFormat:@"%d", num];
                [_popTipMessageDic setObject:message forKey:key];
                cell.alarmButton.tag = num;
            }
            [cell.alarmButton addTarget:self action:@selector(popTip:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath == _todayIndexPath) {
        return 110.0;
    }
    return 55.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.roundRectButtonPopTipView dismissAnimated:YES];
    self.roundRectButtonPopTipView = nil;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.roundRectButtonPopTipView dismissAnimated:NO];
    self.roundRectButtonPopTipView = nil;
}

- (void)popTip:(UIButton *)sender {
    if (nil == self.roundRectButtonPopTipView) {
        NSString *key = [NSString stringWithFormat:@"%ld", sender.tag];
        self.roundRectButtonPopTipView = [[CMPopTipView alloc] initWithMessage:[_popTipMessageDic valueForKey:key]];
        self.roundRectButtonPopTipView.delegate = self;
        self.roundRectButtonPopTipView.backgroundColor = [UIColor blackColor];
        self.roundRectButtonPopTipView.textColor = [UIColor whiteColor];
        self.roundRectButtonPopTipView.has3DStyle = NO;
        
        UIButton *button = (UIButton *)sender;
        [self.roundRectButtonPopTipView presentPointingAtView:button inView:self.view animated:YES];
    }
    else {
        // Dismiss
        [self.roundRectButtonPopTipView dismissAnimated:YES];
        self.roundRectButtonPopTipView = nil;
    }
}

#pragma mark CMPopTipViewDelegate methods
- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView {
    // User can tap CMPopTipView to dismiss it
    self.roundRectButtonPopTipView = nil;
}

@end
