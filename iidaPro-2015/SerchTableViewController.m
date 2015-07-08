//
//  kensakutavleTableViewController.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/03.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "SerchTableViewController.h"
#import "tableviewconst.h"
#import "CostomTableViewCell.h"

@interface SerchTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *SerchTableView;
@property (nonatomic, strong) NSArray *dataSourcename;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@end

@implementation SerchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.dataSourcename = @[@"1test", @"te2st", @"test3"];
    
    UINib *nib = [UINib nibWithNibName:TableviewCustomCellIdentifier bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger dataCount;
    dataCount = self.dataSourcename.count;
    return dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CostomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.tableUIimage.image = [UIImage imageNamed:@"trashicon1"];
    cell.tableName.text = self.dataSourcename[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CostomTableViewCell rowHeight];
}
@end