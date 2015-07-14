//
//  SecondTipsViewController.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/09.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "SecondTipsViewController.h"
#import "tipstableviewconst.h"
#import "TipsCustomTableCell.h"
#import "TipsNextViewController.h"

@interface SecondTipsViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *SecondTipsDataSourcename;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation SecondTipsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.SecondTipsTable.delegate = self;
    self.SecondTipsTable.dataSource = self;
    self.SecondTipsDataSourcename = @[@"2test", @"2testt", @"2testtt",@"tttt",@"ttttt",@"ttttttt",@"ttttttt",@"ttttttttt",@"ttttttttt",@"tttttttttt",@"ttttttttttt",@"ttttttttttt",@"tttttttttttt"];
    UINib *nib = [UINib nibWithNibName:TipsCustomCellIdentifier bundle:nil];
    [self.SecondTipsTable registerNib:nib forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger dataCount;
    dataCount = self.SecondTipsDataSourcename.count;
    return dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TipsCustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.TipsUIImage.image = [UIImage imageNamed:@"trashicon1"];
    cell.TipsTitleLabel.text = self.SecondTipsDataSourcename[indexPath.row];
    cell.TipsNum.text = [NSString stringWithFormat:@"No.%ld", (long)indexPath.row+1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"pushDetailView" sender:self];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [TipsCustomTableCell rowHeight];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TipsNextViewController*tipsnextviewcontroller = segue.destinationViewController;
    tipsnextviewcontroller.TipsNextImageName = @"trashicon1";
    tipsnextviewcontroller.TipsNextTitle = _SecondTipsDataSourcename[_selectedIndexPath.row];
}

@end
