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
@property (strong, nonatomic) NSMutableArray *DataSourceArray;
@property (strong, nonatomic) RLMResults *DataSource;
@end

@implementation TipsViewController{
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title=@"豆知識";
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:86/255.0 green:96/255.0 blue:133/255.0 alpha:1.000];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    _TipsTableView.backgroundColor = [UIColor clearColor];
    _TipsTableView.sectionIndexBackgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    self.TipsTableView.delegate = self;
    self.TipsTableView.dataSource = self;
    self.DataSourceArray= [NSMutableArray array];
    self.DataSource = [TipsObject allObjects];
    UINib *nib = [UINib nibWithNibName:TipsCustomCellIdentifier bundle:nil];
    [_TipsTableView registerNib:nib forCellReuseIdentifier:@"title"];
    [self.DataSourceArray addObject:_DataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TipsCustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"title" forIndexPath:indexPath]
    ;
    if(indexPath.row %2==0){
        cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0];
    }else{
        cell.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    if(!cell){
        cell = [[TipsCustomTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.TipsTitleLabel.text =[_DataSource[indexPath.row] valueForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TipsNextViewController *tipsnext = [self.storyboard instantiateViewControllerWithIdentifier:@"TipsNextView"];
    tipsnext.tipsData = _DataSourceArray[indexPath.section][indexPath.row];
    [self.navigationController pushViewController:tipsnext animated:YES];}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TipsCustomTableCell rowHeight];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
}

- (IBAction)TipsBottun:(UIButton *)sender {
    self.title=@"ルール";
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"genre = %@",@"ルール"];
    _DataSource=[[TipsObject objectsWithPredicate:pred]sortedResultsUsingProperty:@"id" ascending:YES];
    [self.TipsTableView reloadData];
    [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
}

- (IBAction)SecondTipsBottun:(UIButton *)sender {
    self.title=@"テクニック";
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"genre = %@",@"テクニック"];
    _DataSource = [[TipsObject objectsWithPredicate:pred] sortedResultsUsingProperty:@"id" ascending:YES];
    [self.TipsTableView reloadData];
    [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
}

- (IBAction)thirdTipsBottun:(UIButton *)sender {
    self.title=@"出来事";
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"genre = %@",@"出来事"];
    _DataSource = [[TipsObject objectsWithPredicate:pred] sortedResultsUsingProperty:@"id" ascending:YES];
    [self.TipsTableView reloadData];
    [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
}

- (IBAction)forthTipsBottun:(UIButton *)sender {
    self.title=@"情報";
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"genre = %@",@"情報"];
    _DataSource = [[TipsObject objectsWithPredicate:pred] sortedResultsUsingProperty:@"id" ascending:YES];
    [self.TipsTableView reloadData];
    [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
}

@end