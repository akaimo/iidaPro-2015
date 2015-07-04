//
//  kensakutavleTableViewController.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/03.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "kensakutableTableViewController.h"
#import "tableviewconst.h"
#import "CostomTableViewCell.h"
#import "kensakunextViewController.h"

@interface kensakutableTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *kensakuTableView;
@property (nonatomic, strong) NSArray *dataSourcename;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation kensakutableTableViewController

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
    cell.tableUIimage.image = [UIImage imageNamed:@"trushicon1"];
    cell.tableName.text = self.dataSourcename[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndexPath = indexPath;
    [self performSegueWithIdentifier:@"pushDetailView" sender:self];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CostomTableViewCell rowHeight];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    kensakunextViewController *kensakunextViewController = segue.destinationViewController;
    kensakunextViewController.nextImageName = @"trushicon1";
    kensakunextViewController.nextLabelName = _dataSourcename[_selectedIndexPath.row];
}
@end