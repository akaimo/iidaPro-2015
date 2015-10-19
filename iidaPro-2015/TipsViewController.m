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
@end

@implementation TipsViewController{
    int _selectedDataNum;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    _selectedDataNum=1;
    self.navigationItem.title=@"豆知識1";
    self.TipsTableView.delegate = self;
    self.TipsTableView.dataSource = self;
    self.TipsDataSourceFirst = @[@"袋は二重にいれないで", @"普通ごみとの違い", @"プラスチック容器出し方のコツ"];
    self.TipsDataSourceSecond = @[@"かわるんについて", @"川崎市のごみ処理場", @"夜間はごみをださないで"];
    UINib *nib = [UINib nibWithNibName:TipsCustomCellIdentifier bundle:nil];
    [self.TipsTableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_selectedDataNum==1){
        return [_TipsDataSourceFirst count];
    }else{
        return [_TipsDataSourceSecond count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    TipsCustomTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.TipsUIImage.image = [UIImage imageNamed:@"tipsCellIcon"];
    switch (_selectedDataNum) {
        case 1:cell.TipsTitleLabel.text = self.TipsDataSourceFirst[indexPath.row];
            break;
        case 2:cell.TipsTitleLabel.text = self.TipsDataSourceSecond[indexPath.row];
            break;
    }
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
    switch (_selectedDataNum) {
        case 1:
            tipsnextviewcontroller.TipsNextNum = self.selectedIndexPath.row+1;
            tipsnextviewcontroller.TipsNextTitle = _TipsDataSourceFirst[_selectedIndexPath.row];
            break;
        case 2:
            tipsnextviewcontroller.TipsNextNum = self.selectedIndexPath.row+[_TipsDataSourceFirst count]+1;
            tipsnextviewcontroller.TipsNextTitle = _TipsDataSourceSecond[_selectedIndexPath.row];
            break;
    }
}

- (IBAction)TipsBottun:(UIButton *)sender {
    if (_selectedDataNum == 2) {
        _selectedDataNum = 1;
        self.title=@"豆知識1";
        [self.TipsTableView reloadData];
        [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
    }
}

- (IBAction)SecondTipsBottun:(UIButton *)sender {
    if (_selectedDataNum == 1) {
        _selectedDataNum = 2;
        self.title=@"豆知識2";
        [self.TipsTableView reloadData];
        [self.TipsTableView scrollRectToVisible:CGRectMake(0,0,1,1)animated:YES];
    }
}


@end
