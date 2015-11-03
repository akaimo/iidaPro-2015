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
@property (strong, nonatomic) NSMutableArray *sectionArray;
@property (strong, nonatomic) NSArray *sectionList;
@property (strong, nonatomic) RLMResults *reSearchArray;
@property (strong, nonatomic) NSString *searchText;

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"分別辞典";
    
    _searchBar.placeholder = @"Search";
    
    _sectionList =  [NSArray arrayWithObjects:@"あ", @"か", @"さ", @"た", @"な", @"は", @"ま", @"や", @"ら", @"わ", nil];
    _sectionArray = [NSMutableArray array];
    for (int i=0; i<10; i++) {
        [_sectionArray addObject:[self section:i]];
    }
    
//    [_searchTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
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
//    [_searchTableView setContentOffset:CGPointMake(0.0f, -64.0f) animated:YES];
}

- (BOOL)searchDisplayController:controller shouldReloadTableForSearchString:(NSString *)searchString {
    // リアルタイム検索
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@ OR read CONTAINS %@", searchString, searchString];
    _reSearchArray = [[Classification objectsWithPredicate:pred] sortedResultsUsingProperty:@"read" ascending:YES];
    
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
        return _sectionArray.count;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {  // 検索後
        return @"";
    }
    
    else {  // 検索前
        return [_sectionList objectAtIndex:section];
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {  // 検索後
        return nil;
    }
    
    else {  // 検索前
        return _sectionList;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [_sectionList indexOfObject:title];
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
        return [_sectionArray[section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.searchDisplayController.searchResultsTableView) {  // 検索後
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
        
        if ([_reSearchArray[indexPath.row] valueForKey:@"knowledge"] != nil) {
            cell.knowledgeImage.image = [UIImage imageNamed:@"sun"];    // icon修正
        }
        
        return cell;
    }
    
    else {  // 検索前
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Trash" forIndexPath:indexPath];
        cell.trashLabel.text = [_sectionArray[indexPath.section][indexPath.row] valueForKey:@"title"];
        // TODO: ゴミの種別によりアイコンを変える
        cell.trashImage.image = [UIImage imageNamed:@"sun"];
        
        if ([_sectionArray[indexPath.section][indexPath.row] valueForKey:@"knowledge"] != nil) {
            cell.knowledgeImage.image = [UIImage imageNamed:@"sun"];    // icon修正
        }
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: 豆知識がある場合は豆知識ページへ遷移
//    NSLog(@"%ld", (long)indexPath.row);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 画面遷移
}



- (RLMResults *)section:(int)num {
    NSPredicate *pred;
    
    switch (num) {
        case 0:
            pred = [NSPredicate predicateWithFormat:@"read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@", @"あ", @"い", @"う", @"え", @"お"];
            break;
            
        case 1:
            pred = [NSPredicate predicateWithFormat:@"read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@", @"か", @"き", @"く", @"け", @"こ"];
            break;
            
        case 2:
            pred = [NSPredicate predicateWithFormat:@"read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@", @"さ", @"し", @"す", @"せ", @"そ"];
            break;
            
        case 3:
            pred = [NSPredicate predicateWithFormat:@"read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@", @"た", @"ち", @"つ", @"て", @"と"];
            break;
            
        case 4:
            pred = [NSPredicate predicateWithFormat:@"read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@", @"な", @"に", @"ぬ", @"ね", @"の"];
            break;
            
        case 5:
            pred = [NSPredicate predicateWithFormat:@"read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@", @"は", @"ひ", @"ふ", @"へ", @"ほ"];
            break;
            
        case 6:
            pred = [NSPredicate predicateWithFormat:@"read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@", @"ま", @"み", @"む", @"め", @"も"];
            break;
            
        case 7:
            pred = [NSPredicate predicateWithFormat:@"read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@", @"や", @"ゆ", @"よ"];
            break;
            
        case 8:
            pred = [NSPredicate predicateWithFormat:@"read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@ OR read BEGINSWITH %@", @"ら", @"り", @"る", @"れ", @"ろ"];
            break;
            
        case 9:
            pred = [NSPredicate predicateWithFormat:@"read BEGINSWITH %@ OR read BEGINSWITH %@", @"わ", @"を"];
            break;
            
        default:
            break;
    }
    
    return [[Classification objectsWithPredicate:pred] sortedResultsUsingProperty:@"read" ascending:YES];
}

@end
