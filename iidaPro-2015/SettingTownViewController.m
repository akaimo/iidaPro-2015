//
//  SettingTownViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 11/20/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "SettingTownViewController.h"
#import "District.h"

@interface SettingTownViewController ()
@property (weak, nonatomic) IBOutlet UITableView *townTableView;
@property (retain, nonatomic) NSArray *sectionList;
@property (retain, nonatomic) NSMutableArray *sectionArray;

@end

@implementation SettingTownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _area;
    self.view.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    
    _townTableView.backgroundColor = [UIColor clearColor];
    _townTableView.sectionIndexColor = [UIColor whiteColor];
    _townTableView.sectionIndexBackgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    _sectionList =  [NSArray arrayWithObjects:@"あ", @"か", @"さ", @"た", @"な", @"は", @"ま", @"や", @"ら", @"わ", nil];
    _sectionArray = [NSMutableArray array];
    for (int i=0; i<_sectionList.count; i++) {
        [_sectionArray addObject:[self section:i area:_area]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [_sectionList objectAtIndex:section];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    headerView.backgroundColor = [UIColor colorWithRed:41/255.0 green:52/255.0 blue:92/255.0 alpha:0.95];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, headerView.frame.size.width - 20, headerView.frame.size.height)];
    label.text = [_sectionList objectAtIndex:section];
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
    return [_sectionArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"cell"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [_sectionArray[indexPath.section][indexPath.row] valueForKey:@"town"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Realm
- (RLMResults *)section:(int)num area:(NSString *)area {
    NSPredicate *pred;
    
    switch (num) {
        case 0:
            pred = [NSPredicate predicateWithFormat:@"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", area, @"あ", @"い", @"う", @"え", @"お"];
            break;
            
        case 1:
            pred = [NSPredicate predicateWithFormat:@"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", area, @"か", @"き", @"く", @"け", @"こ"];
            break;
            
        case 2:
            pred = [NSPredicate predicateWithFormat:@"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", area, @"さ", @"し", @"す", @"せ", @"そ"];
            break;
            
        case 3:
            pred = [NSPredicate predicateWithFormat:@"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", area, @"た", @"ち", @"つ", @"て", @"と"];
            break;
            
        case 4:
            pred = [NSPredicate predicateWithFormat:@"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", area, @"な", @"に", @"ぬ", @"ね", @"の"];
            break;
            
        case 5:
            pred = [NSPredicate predicateWithFormat:@"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", area, @"は", @"ひ", @"ふ", @"へ", @"ほ"];
            break;
            
        case 6:
            pred = [NSPredicate predicateWithFormat:@"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", area, @"ま", @"み", @"む", @"め", @"も"];
            break;
            
        case 7:
            pred = [NSPredicate predicateWithFormat:@"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@)", area, @"や", @"ゆ", @"よ"];
            break;
            
        case 8:
            pred = [NSPredicate predicateWithFormat:@"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", area, @"ら", @"り", @"る", @"れ", @"ろ"];
            break;
            
        case 9:
            pred = [NSPredicate predicateWithFormat:@"area = %@ AND (read_head = %@ OR read_head = %@)", area, @"わ", @"を"];
            break;
            
        default:
            break;
    }
    
    return [[District objectsWithPredicate:pred] sortedResultsUsingProperty:@"read" ascending:YES];
}

@end
