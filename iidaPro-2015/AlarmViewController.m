//
//  AlarmViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/10/02.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import "AlarmViewController.h"
#import "AppDelegate.h"
#import "TrashAlarmCell.h"
#import "noMyAlarmCell.h"
#import "MyAlarmCell.h"
#import "AlarmPopUpView.h"

@interface AlarmViewController () <UITableViewDelegate, UITableViewDataSource, AlarmPopUpViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *alarmTableView;

@property (retain, nonatomic) UIBarButtonItem *addBtn;

@property (strong, nonatomic) NSArray *sectionArray;
@property (strong, nonatomic) NSArray *trashArray;
@property (strong, nonatomic) NSMutableArray *myAlarm;
@property (strong, nonatomic) NSArray *defaultAlarmArray;

@end

@implementation AlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Alarm";
    _sectionArray = @[@"ごみ収集通知", @"My通知"];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _trashArray = [ud objectForKey:@"trash"];
    _defaultAlarmArray = [ud objectForKey:@"defaultAlarm"];
    _myAlarm = [ud objectForKey:@"myAlarm"];
    
    _addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(tapAdd:)];
    self.navigationItem.rightBarButtonItem = _addBtn;
    
    UINib *nib = [UINib nibWithNibName:@"TrashAlarmCell" bundle:nil];
    UINib *nonib = [UINib nibWithNibName:@"noMyAlarmCell" bundle:nil];
    UINib *mynib = [UINib nibWithNibName:@"MyAlarmCell" bundle:nil];
    [_alarmTableView registerNib:nib forCellReuseIdentifier:@"Alarm"];
    [_alarmTableView registerNib:nonib forCellReuseIdentifier:@"noAlarm"];
    [_alarmTableView registerNib:mynib forCellReuseIdentifier:@"myAlarm"];
    _alarmTableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tapAdd:(UIButton *)sender {
    AlarmPopUpView *popup = [[AlarmPopUpView alloc] initWithFrame:self.view.frame style:PopupNewMyAlarmStyle row:0];
    popup.delegate = self;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:popup];
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
        return _trashArray.count;
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
        cell.titleLabel.text = [_trashArray[indexPath.row] valueForKey:@"title"];
        cell.dayLabel.text = [_trashArray[indexPath.row] valueForKey:@"date"];
        cell.timeLabel.text = [_defaultAlarmArray[indexPath.row] valueForKey:@"time"];
        return cell;
        
    } else if (indexPath.section == 1) {
        if (_myAlarm.count == 0) {
            noMyAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noAlarm" forIndexPath:indexPath];
            return cell;
            
        } else {
            MyAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myAlarm" forIndexPath:indexPath];
            NSArray *array = [[_myAlarm[indexPath.row] valueForKey:@"time"] componentsSeparatedByString:@" "];
            cell.titleLabel.text = [_myAlarm[indexPath.row] valueForKey:@"title"];
            cell.dateLabel.text = array[0];
            cell.timeLabel.text = array[1];
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
    if (indexPath.section == 1 && _myAlarm.count == 0) {
        return 124;
    }
    return 44.0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *array = [NSMutableArray array];
    if (indexPath.section == 0) {
        UITableViewRowAction *edit =[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                       title:@"Edit"
                                                                     handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                         // edit default alarm
                                                                         AlarmPopUpView *popup = [[AlarmPopUpView alloc] initWithFrame:self.view.frame style:PopupDefaultStyle row:indexPath.row];
                                                                         popup.delegate = self;
                                                                         AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                                                         [appDelegate.window addSubview:popup];
                                                                     }];
        edit.backgroundColor = [UIColor greenColor];
        [array addObject:edit];
    } else if (indexPath.section == 1) {
        UITableViewRowAction *delete =[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive
                                                                         title:@"Delete"
                                                                       handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                           // delete my alarm
                                                                           NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                                                                           NSMutableArray *array = [_myAlarm mutableCopy];
                                                                           [array removeObjectAtIndex:indexPath.row];
                                                                           [ud setObject:array forKey:@"myAlarm"];
                                                                           _myAlarm = [ud objectForKey:@"myAlarm"];
                                                                           [_alarmTableView reloadData];
                                                                       }];
        delete.backgroundColor = [UIColor redColor];
        [array addObject:delete];
        
        UITableViewRowAction *edit =[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                                       title:@"Edit"
                                                                     handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                         // edit my alarm
                                                                         AlarmPopUpView *popup = [[AlarmPopUpView alloc] initWithFrame:self.view.frame style:PopupEditMyAlarmStyle row:indexPath.row];
                                                                         popup.delegate = self;
                                                                         AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                                                         [appDelegate.window addSubview:popup];
                                                                     }];
        edit.backgroundColor = [UIColor greenColor];
        [array addObject:edit];
    }
    
    return array;
}

#pragma mark - AlarmPopUpViewDelegate
- (void)alarmPopUpView:(AlarmPopUpView *)alarmPopUpView didTappedEnterButton:(UIButton *)button {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _defaultAlarmArray = [ud objectForKey:@"defaultAlarm"];
    _myAlarm = [ud objectForKey:@"myAlarm"];
    [_alarmTableView reloadData];
}

@end
