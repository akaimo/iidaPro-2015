//
//  DataViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 11/22/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController () <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) UITableView *calendarTableView;

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 66, self.view.frame.size.width, self.view.frame.size.height - 66);
    _calendarTableView = [[UITableView alloc] initWithFrame:rect];
    _calendarTableView.delegate = self;
    _calendarTableView.dataSource = self;
    [self.view addSubview:_calendarTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 31;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"cid"];
    }
    cell.textLabel.text = @"hoge";
    
    return cell;
}

@end
