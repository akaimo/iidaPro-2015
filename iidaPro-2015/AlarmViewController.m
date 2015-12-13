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
@property (strong, nonatomic) NSArray *areaData;
@property (strong, nonatomic) NSMutableArray *myAlarm;
@property (strong, nonatomic) NSDictionary *defaultAlarm;
@property (nonatomic) CGPoint startCenter;

@end

@implementation AlarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"アラーム";
    self.view.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:86/255.0 green:96/255.0 blue:133/255.0 alpha:1.000];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    _alarmTableView.backgroundColor = [UIColor clearColor];
    
    _sectionArray = @[@"ごみ収集通知", @"My通知"];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _areaData = [ud objectForKey:@"district"];
    _defaultAlarm = [ud objectForKey:@"defaultAlarm"];
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
                
                if (indexPath.section == 0) {
                    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
                    NSString *categoryName = [delegate.categoryDict valueForKey:delegate.categoryArray[indexPath.row]];
                    
                    NSMutableDictionary *alarm = [_defaultAlarm mutableCopy];
                    NSMutableDictionary *dic = [[alarm valueForKey:categoryName] mutableCopy];
                    NSString *str = ([[dic valueForKey:@"switch"] isEqualToString:@"on"]) ? @"off" : @"on";
                    [dic setObject:str forKey:@"switch"];
                    [alarm setObject:dic forKey:categoryName];
                    
                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                    [ud setObject:alarm forKey:@"defaultAlarm"];
                    
                    _defaultAlarm = [ud objectForKey:@"defaultAlarm"];
                    
                } else {
                    NSMutableArray *array = [_myAlarm mutableCopy];
                    NSMutableDictionary *dic = [array[indexPath.row] mutableCopy];
                    NSString *str = ([[dic valueForKey:@"switch"] isEqualToString:@"on"]) ? @"off" : @"on";
                    [dic setObject:str forKey:@"switch"];
                    [array replaceObjectAtIndex:indexPath.row withObject:dic];
                    
                    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                    [ud setObject:array forKey:@"myAlarm"];
                    
                    _myAlarm = [ud objectForKey:@"myAlarm"];
                }
                
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
        AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        return delegate.categoryArray.count;
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
    AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if (indexPath.section == 0) {
        
        TrashAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Alarm" forIndexPath:indexPath];
        cell.titleLabel.text = delegate.categoryArray[indexPath.row];
        
        NSString *categoryStr = [delegate.categoryDict valueForKey:delegate.categoryArray[indexPath.row]];
        cell.timeLabel.text = [[_defaultAlarm valueForKey:categoryStr] valueForKey:@"time"];
        if ([categoryStr isEqual:@"bigRefuse"]) {
            NSString *str = [NSString stringWithFormat:@"第 %@, %@ %@", [_areaData valueForKey:@"bigRefuse_1"], [_areaData valueForKey:@"bigRefuse_2"], [_areaData valueForKey:@"bigRefuse_date"]];
            cell.dayLabel.text = str;
        } else {
            cell.dayLabel.text = [_areaData valueForKey:categoryStr];
        }
        
        if ([[[_defaultAlarm valueForKey:categoryStr] valueForKey:@"switch"]  isEqual: @"on"]) {
            cell.backgroundColor = [UIColor clearColor];
            cell.titleLabel.textColor = [UIColor whiteColor];
            cell.dayLabel.textColor = [UIColor whiteColor];
            cell.timeLabel.textColor = [UIColor whiteColor];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
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
            cell.backgroundColor = [UIColor clearColor];
            return cell;
            
        } else {
            MyAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myAlarm" forIndexPath:indexPath];
            NSArray *array = [[_myAlarm[indexPath.row] valueForKey:@"time"] componentsSeparatedByString:@" "];
            cell.titleLabel.text = [_myAlarm[indexPath.row] valueForKey:@"title"];
            cell.dateLabel.text = array[0];
            cell.timeLabel.text = array[1];
            if ([[_myAlarm[indexPath.row] valueForKey:@"switch"]  isEqual: @"on"]) {
                cell.backgroundColor = [UIColor clearColor];
                cell.titleLabel.textColor = [UIColor whiteColor];
                cell.dateLabel.textColor = [UIColor whiteColor];
                cell.timeLabel.textColor = [UIColor whiteColor];
            } else {
                cell.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && _myAlarm.count == 0) {
        return NO;
    }
    return YES;
}

#pragma mark - AlarmPopUpViewDelegate
- (void)alarmPopUpView:(AlarmPopUpView *)alarmPopUpView didTappedEnterButton:(UIButton *)button {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _defaultAlarm = [ud objectForKey:@"defaultAlarm"];
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
