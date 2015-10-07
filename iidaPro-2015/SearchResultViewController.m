//
//  SearchResultViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/08/11.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchTableViewCell.h"

@interface SearchResultViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (retain, nonatomic) UIBarButtonItem *searchBtn;

@property (strong, nonatomic) RLMResults *resultArray;
@property (strong, nonatomic) NSString *searchText;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSMutableString *searchTitle = [NSMutableString stringWithString:_searchText];
//    [searchTitle appendString:@"の検索結果"];
//    self.title = searchTitle;
    
    _searchBar.placeholder = @"Search";
    _searchBar.text = _searchText;
    
    [_searchTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    _searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(tapSearch:)];
    self.navigationItem.rightBarButtonItem = _searchBtn;
    
    UINib *nib = [UINib nibWithNibName:@"SearchTableViewCell" bundle:nil];
    [_searchTableView registerNib:nib forCellReuseIdentifier:@"Trash"];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - searchBar
//- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar {
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"title CONTAINS %@ OR read CONTAINS %@", searchBar.text, searchBar.text];
//    RLMResults *results = [Classification objectsWithPredicate:pred];
//    
//    NSMutableString *searchTitle = [NSMutableString stringWithString:_searchBar.text];
//    [searchTitle appendString:@"の検索結果"];
//    self.title = searchTitle;
//    
//    _resultArray = results;
//    [_searchTableView reloadData];
//    
//    [_searchBar resignFirstResponder];
//    [_searchTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}
//
//- (void)tapSearch:(UIButton *)sender {
//    [_searchBar becomeFirstResponder];
//    [_searchTableView setContentOffset:CGPointMake(0.0f, -64.0f) animated:YES];
//}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_resultArray.count == 0) {
        return 1;
    }
    return _resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: ゴミ分別マークとゴミの名前を表示
//    tableView.separatorColor = [UIColor clearColor];
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    if (_resultArray.count == 0) {
//        cell.textLabel.text = @"該当する品目はありません";
//    } else {
//        cell.textLabel.text = [_resultArray[indexPath.row] valueForKey:@"title"];
//    }
    
    if (_resultArray.count == 0) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text = @"該当する品目はありません";
        return cell;
    }
    
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Trash" forIndexPath:indexPath];
    cell.trashLabel.text = [_resultArray[indexPath.row] valueForKey:@"title"];
    // TODO: ゴミの種別によりアイコンを変える
    cell.trashImage.image = [UIImage imageNamed:@"sun"];
    // TODO: 豆知識があればアイコンを表示する
    cell.knowledgeImage.image = [UIImage imageNamed:@"sun"];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: 豆知識がある場合は豆知識ページへ遷移
    NSLog(@"%ld", (long)indexPath.row);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 画面遷移
}

@end
