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
@property (nonatomic, strong) NSArray *TipsDataSourcename;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation TipsViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title=@"豆知識1";
    self.TipsTableView.delegate = self;
    self.TipsTableView.dataSource = self;
    self.TipsDataSourcename = @[@"test", @"testt", @"testtt"];
    UINib *nib = [UINib nibWithNibName:TipsCustomCellIdentifier bundle:nil];
    [self.TipsTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}

- (IBAction)backBtm:(UITabBarItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger dataCount;
    dataCount = self.TipsDataSourcename.count;
    return dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TipsCustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.TipsUIImage.image = [UIImage imageNamed:@"trashicon1"];
    cell.TipsTitleLabel.text = self.TipsDataSourcename[indexPath.row];
    cell.TipsNum.text = [NSString stringWithFormat:@"No.%ld", (long)indexPath.row + 1];
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
    tipsnextviewcontroller.TipsNextTitle = _TipsDataSourcename[_selectedIndexPath.row];
}


@end
