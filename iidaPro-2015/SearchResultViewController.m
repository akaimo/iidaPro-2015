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

@property (strong, nonatomic) RLMResults *defaultArray;
@property (strong, nonatomic) RLMResults *reSearchArray;
@property (strong, nonatomic) NSString *searchText;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"分別辞典";
    
    _searchBar.placeholder = @"Search";
    // TODO: 検索結果を「あかさたな...」というようにsectionに分ける
    _defaultArray = [[Classification allObjects] sortedResultsUsingProperty:@"read" ascending:YES];
    
    [_searchTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    _searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(tapSearch:)];
    self.navigationItem.rightBarButtonItem = _searchBtn;
    
    UINib *nib = [UINib nibWithNibName:@"SearchTableViewCell" bundle:nil];
    [_searchTableView registerNib:nib forCellReuseIdentifier:@"Trash"];
    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"Trash"];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - searchBar
- (void)tapSearch:(UIButton *)sender {
    [_searchBar becomeFirstResponder];
    [_searchTableView setContentOffset:CGPointMake(0.0f, -64.0f) animated:YES];
}

- (BOOL)searchDisplayController:controller shouldReloadTableForSearchString:(NSString *)searchString {
    // 検索
    // TODO: 大文字小文字の区別なく検索できるようにする
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@ OR read CONTAINS %@", searchString, searchString];
    _reSearchArray = [Classification objectsWithPredicate:pred];
    NSLog(@"%@", _reSearchArray);
    
    return YES;     // リロード
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_searchBar resignFirstResponder];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {  // 検索後
        return 1;
    }
    
    else {  // 検索前
        // section分けをする
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if (_reSearchArray.count == 0) {  // 検索後
            return 1;
        } else {
            return _reSearchArray.count;
        }
        
    }
    
    else {  // 検索前
        return _defaultArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: ゴミ分別マークとゴミの名前を表示
    if (tableView == self.searchDisplayController.searchResultsTableView) {  // 検索後
//        tableView.separatorColor = [UIColor clearColor];
        if (_reSearchArray.count == 0) {
            static NSString *CellIdentifier = @"Cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.textLabel.text = @"該当する品目はありません";
            return cell;
        }
        
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Trash" forIndexPath:indexPath];
        cell.trashLabel.text = [_reSearchArray[indexPath.row] valueForKey:@"title"];
        // TODO: ゴミの種別によりアイコンを変える
        cell.trashImage.image = [UIImage imageNamed:@"sun"];
        // TODO: 豆知識があればアイコンを表示する
        cell.knowledgeImage.image = [UIImage imageNamed:@"sun"];
        
        return cell;
    }
    
    else {  // 検索前
//        tableView.separatorColor = [UIColor clearColor];
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Trash" forIndexPath:indexPath];
        cell.trashLabel.text = [_defaultArray[indexPath.row] valueForKey:@"title"];
        // TODO: ゴミの種別によりアイコンを変える
        cell.trashImage.image = [UIImage imageNamed:@"sun"];
        // TODO: 豆知識があればアイコンを表示する
        cell.knowledgeImage.image = [UIImage imageNamed:@"sun"];
        
        return cell;
    }
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
