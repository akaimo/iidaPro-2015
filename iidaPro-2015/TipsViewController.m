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
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@end

@implementation TipsViewController{
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title=@"ルール";
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:86/255.0 green:96/255.0 blue:133/255.0 alpha:1.000];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    _TipsTableView.backgroundColor = [UIColor clearColor];
    _TipsTableView.sectionIndexBackgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    self.view.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    self.TipsTableView.delegate = self;
    self.TipsTableView.dataSource = self;
    self.DataSourceArray= [NSMutableArray array];
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"genre = %@",@"ルール"];
    _DataSource=[[TipsObject objectsWithPredicate:pred]sortedResultsUsingProperty:@"id" ascending:YES];
    UINib *nib = [UINib nibWithNibName:TipsCustomCellIdentifier bundle:nil];
    [_TipsTableView registerNib:nib forCellReuseIdentifier:@"title"];
    [self.DataSourceArray addObject:_DataSource];
    _button1.enabled=NO;
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
    tipsnext.tipsData = _DataSource[indexPath.row];
    [self.navigationController pushViewController:tipsnext animated:YES];}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TipsCustomTableCell rowHeight];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
}

- (IBAction)TipsBottun:(UIButton *)sender {
    self.title=@"ルール";
    _button1.enabled=NO;
    _button2.enabled=YES;
    _button3.enabled=YES;
    _button4.enabled=YES;
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"genre = %@",@"ルール"];
    _DataSource=[[TipsObject objectsWithPredicate:pred]sortedResultsUsingProperty:@"id" ascending:YES];
    [self.TipsTableView reloadData];
    [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
}

- (IBAction)SecondTipsBottun:(UIButton *)sender {
    self.title=@"テクニック";
    _button1.enabled=YES;
    _button2.enabled=NO;
    _button3.enabled=YES;
    _button4.enabled=YES;
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"genre = %@",@"テクニック"];
    _DataSource = [[TipsObject objectsWithPredicate:pred] sortedResultsUsingProperty:@"id" ascending:YES];
    [self.TipsTableView reloadData];
    [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
}

- (IBAction)thirdTipsBottun:(UIButton *)sender {
    self.title=@"出来事";
    _button1.enabled=YES;
    _button2.enabled=YES;
    _button3.enabled=NO;
    _button4.enabled=YES;
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"genre = %@",@"出来事"];
    _DataSource = [[TipsObject objectsWithPredicate:pred] sortedResultsUsingProperty:@"id" ascending:YES];
    [self.TipsTableView reloadData];
    [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
}

- (IBAction)forthTipsBottun:(UIButton *)sender {
    self.title=@"情報";
    _button1.enabled=YES;
    _button2.enabled=YES;
    _button3.enabled=YES;
    _button4.enabled=NO;
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"genre = %@",@"情報"];
    _DataSource = [[TipsObject objectsWithPredicate:pred] sortedResultsUsingProperty:@"id" ascending:YES];
    [self.TipsTableView reloadData];
    [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
}

@end