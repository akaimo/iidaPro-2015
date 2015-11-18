//
//  TipsViewController.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/09.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "TipsViewController.h"
#import "tipstableviewconst.h"
#import "TipsCustomTableCell.h"
#import "TipsNextViewController.h"


@interface TipsViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *TipsDataSourceFirst;
@property (nonatomic, strong) NSArray *TipsDataSourceSecond;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSMutableArray *DataSourceArray;
@property (strong, nonatomic) RLMResults *DataSource;
@end

@implementation TipsViewController{
    int _selectedDataNum;
    int _datalog;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    _selectedDataNum=0;
    self.navigationItem.title=@"豆知識1";
    self.TipsTableView.delegate = self;
    self.TipsTableView.dataSource = self;
    self.DataSource = [[TipsClassification allObjects] sortedResultsUsingProperty:@"id" ascending:YES];
    UINib *nib = [UINib nibWithNibName:TipsCustomCellIdentifier bundle:nil];
    [_TipsTableView registerNib:nib forCellReuseIdentifier:@"title"];
    [self.DataSourceArray addObject:_DataSource];
    [self.TipsTableView reloadData];
    _datalog = _DataSource.count;
    NSLog(@"%d",_datalog);
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TipsCustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.TipsTitleLabel.text = [_DataSource[indexPath.row] valueForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"pushDetailView" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TipsCustomTableCell rowHeight];
}

/*
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
     NSIndexPath *indexPath =[self.TipsTableView indexpathForselectedRow];
     TipsNextViewController *ViewController = [segue destinationViewController];
     TipsNextViewController *TipsNextNum = [_DataSource[indexPath.section][indexPath.row]valueForKey:@"id"];
 }
*/

- (IBAction)TipsBottun:(UIButton *)sender {
    if (_selectedDataNum != 0) {
        _selectedDataNum = 0;
        self.title=@"豆知識1";
//        _DataSource=[[genre objectsWithPredicate:pred] sortedResultsUsingProperty:@"id" ascending:YES];
        [self.TipsTableView reloadData];
        [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
    }
}

- (IBAction)SecondTipsBottun:(UIButton *)sender {
    if (_selectedDataNum != 1) {
        _selectedDataNum = 1;
        self.title=@"豆知識2";
//        _DataSource = [[genre objectsWithPredicate:pred] sortedResultsUsingProperty:@"id" ascending:YES];
        [self.TipsTableView reloadData];
        [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
    }
}

@end
