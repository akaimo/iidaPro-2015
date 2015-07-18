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
#import "TipsViewController.h"

@interface SecondTipsViewController()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *SecondTipsDataSourcename;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation SecondTipsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"豆知識2";
    self.SecondTipsTable.delegate = self;
    self.SecondTipsTable.dataSource = self;
    self.SecondTipsDataSourcename = @[@"かわるんについて", @"川崎市のごみ処理場", @"夜間はごみをださないで"];
    UINib *nib = [UINib nibWithNibName:TipsCustomCellIdentifier bundle:nil];
    [self.SecondTipsTable registerNib:nib forCellReuseIdentifier:@"Cell"];
}
- (IBAction)backBtm:(UITabBarItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

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
    cell.TipsUIImage.image = [UIImage imageNamed:@"tipsCellIcon"];
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
    tipsnextviewcontroller.TipsNextNum = self.selectedIndexPath.row+3+1;
    tipsnextviewcontroller.TipsNextTitle = _SecondTipsDataSourcename[_selectedIndexPath.row];
}

@end
