//
//  AlarmViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/10/02.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import "AlarmViewController.h"
#import "TrashAlarmCell.h"
#import "noMyAlarmCell.h"

@interface AlarmViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *alarmTableView;

@property (retain, nonatomic) UIBarButtonItem *addBtn;

@property (strong, nonatomic) NSArray *sectionArray;
@property (strong, nonatomic) NSDictionary *trashDict;
@property (strong, nonatomic) NSArray *trashKeyArray;
@property (strong, nonatomic) NSMutableArray *myAlarm;

@end

@implementation AlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Alarm";
    _sectionArray = @[@"ごみ収集通知", @"My通知"];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _trashDict = [ud objectForKey:@"trash"];
    _trashKeyArray = [ud objectForKey:@"title"];
    _myAlarm = [ud objectForKey:@"myAlarm"];
    
    _addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(tapAdd:)];
    self.navigationItem.rightBarButtonItem = _addBtn;
    
    UINib *nib = [UINib nibWithNibName:@"TrashAlarmCell" bundle:nil];
    [_alarmTableView registerNib:nib forCellReuseIdentifier:@"Alarm"];
    UINib *nonib = [UINib nibWithNibName:@"noMyAlarmCell" bundle:nil];
    [_alarmTableView registerNib:nonib forCellReuseIdentifier:@"noAlarm"];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tapAdd:(UIButton *)sender {
    NSLog(@"add");
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionArray[section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _trashDict.count;
    } else if (section == 1) {
        if (_myAlarm.count == 0) {
            return 1;
        } else {
            return  _myAlarm.count;
        }
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TrashAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Alarm" forIndexPath:indexPath];
        cell.titleLabel.text = _trashKeyArray[indexPath.row];
        cell.dayLabel.text = [_trashDict valueForKey:_trashKeyArray[indexPath.row]];
        cell.timeLabel.text = @"08:00";
        
        return cell;
    } else if (indexPath.section == 1) {
        if (_myAlarm == NULL) {
            noMyAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noAlarm" forIndexPath:indexPath];
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cid"];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                              reuseIdentifier: @"cid"];
            }
            cell.textLabel.text = [[NSString alloc] initWithFormat:@"%ld行目のセル", indexPath.row + 1];
            return cell;
        }
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cid"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier: @"cid"];
        }
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && _myAlarm == NULL) {
        return 124;
    }
    return 44.0;
}

@end
