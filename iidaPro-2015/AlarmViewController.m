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

@interface AlarmViewController () <UITableViewDelegate, UITableViewDataSource, AlarmPopUpViewDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *alarmTableView;

@property (retain, nonatomic) UIBarButtonItem *addBtn;

@property (strong, nonatomic) NSArray *sectionArray;
@property (strong, nonatomic) NSArray *trashArray;
@property (strong, nonatomic) NSMutableArray *myAlarm;
@property (strong, nonatomic) NSArray *defaultAlarmArray;
@property (nonatomic) CGPoint startCenter;

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

- (void)panGesture:(UIPanGestureRecognizer *)sender {
    CGPoint p = [sender translationInView:self.view];
    if (sender.state == UIGestureRecognizerStateBegan) {
        [_alarmTableView setScrollEnabled:NO];
        _startCenter = sender.view.center;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (_startCenter.x + 60.0 < sender.view.center.x) {
            UITableViewCell *cell = [self findUITableViewCellFromSuperViewsForView:sender.view];
            if (cell) {
                // TODO: require speed up
                NSIndexPath *indexPath = [_alarmTableView indexPathForCell:cell];
                NSMutableArray *array = (indexPath.section == 0) ? [_defaultAlarmArray mutableCopy] : [_myAlarm mutableCopy];
                NSMutableDictionary *dic = [array[indexPath.row] mutableCopy];
                NSString *str = ([[dic valueForKey:@"switch"] isEqualToString:@"on"]) ? @"off" : @"on";
                [dic setObject:str forKey:@"switch"];
                [array replaceObjectAtIndex:indexPath.row withObject:dic];
                
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                NSString *key = (indexPath.section == 0) ? @"defaultAlarm" : @"myAlarm";
                [ud setObject:array forKey:key];
                
                _defaultAlarmArray = [ud objectForKey:@"defaultAlarm"];
                _myAlarm = [ud objectForKey:@"myAlarm"];
                [_alarmTableView reloadData];
            }
        }
        sender.view.frame = CGRectMake(0.0, sender.view.frame.origin.y, sender.view.frame.size.width, sender.view.frame.size.height);
        _startCenter = CGPointZero;
        [_alarmTableView setScrollEnabled:YES];
        
    } else if ([sender.view isKindOfClass:[TrashAlarmCell class]] || [sender.view isKindOfClass:[MyAlarmCell class]]) {
        if (sender.view.center.x + p.x > _startCenter.x && sender.view.center.x + p.x < _startCenter.x + 80) {
            sender.view.center = CGPointMake(sender.view.center.x + p.x, sender.view.center.y);
            [sender setTranslation:CGPointZero inView:self.view];
        }
    }
}

- (UITableViewCell *)findUITableViewCellFromSuperViewsForView:(id)view {
    if (![view isKindOfClass:[UIView class]]) {
        return nil;
    }
    UIView *superView = view;
    while (superView) {
        if ([superView isKindOfClass:[UITableViewCell class]]) {
            break;
        }
        superView = [superView superview];
    }
    return (UITableViewCell *)superView;
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
        if ([[_defaultAlarmArray[indexPath.row] valueForKey:@"switch"]  isEqual: @"on"]) {
            cell.titleLabel.textColor = [UIColor blackColor];
            cell.dayLabel.textColor = [UIColor blackColor];
            cell.timeLabel.textColor = [UIColor blackColor];
        } else {
            cell.titleLabel.textColor = [UIColor lightGrayColor];
            cell.dayLabel.textColor = [UIColor lightGrayColor];
            cell.timeLabel.textColor = [UIColor lightGrayColor];
        }
        
        for(UIGestureRecognizer *gesture in [cell gestureRecognizers]) {
            if([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
                [cell removeGestureRecognizer:gesture];
            }
        }
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        pan.delegate = self;
        [cell addGestureRecognizer:pan];
        
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
            if ([[_myAlarm[indexPath.row] valueForKey:@"switch"]  isEqual: @"on"]) {
                cell.titleLabel.textColor = [UIColor blackColor];
                cell.dateLabel.textColor = [UIColor blackColor];
                cell.timeLabel.textColor = [UIColor blackColor];
            } else {
                cell.titleLabel.textColor = [UIColor lightGrayColor];
                cell.dateLabel.textColor = [UIColor lightGrayColor];
                cell.timeLabel.textColor = [UIColor lightGrayColor];
            }
            
            for(UIGestureRecognizer *gesture in [cell gestureRecognizers]) {
                if([gesture isKindOfClass:[UIPanGestureRecognizer class]]) {
                    [cell removeGestureRecognizer:gesture];
                }
            }
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
            pan.delegate = self;
            [cell addGestureRecognizer:pan];
            
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    UIView *cell = [gestureRecognizer view];
    CGPoint translation = [gestureRecognizer translationInView:[cell superview]];
    if (fabs(translation.x) > fabs(translation.y)) {
        return YES;
    }
    return NO;
}

@end
