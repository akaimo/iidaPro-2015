//
//  SearchResultViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/08/11.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchTableViewCell.h"
#import "SearchDetailViewController.h"

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
    
    self.title = @"分別辞典";
    
    self.view.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:86/255.0 green:96/255.0 blue:133/255.0 alpha:1.000];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    
    _searchTableView.backgroundColor = [UIColor clearColor];
    _searchTableView.sectionIndexColor = [UIColor whiteColor];
    _searchTableView.sectionIndexBackgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1];
    
    self.searchDisplayController.searchResultsTableView.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    
    _searchBar.placeholder = @"Search";
//    _searchBar.backgroundColor = [UIColor colorWithRed:41/255.0 green:52/255.0 blue:92/255.0 alpha:1.0];
    
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
    self.searchDisplayController.searchResultsTableView.tableFooterView = [[UIView alloc] init];
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
    _reSearchArray = [[TrashCategory objectsWithPredicate:pred] sortedResultsUsingProperty:@"read" ascending:YES];
    
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

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    headerView.backgroundColor = [UIColor colorWithRed:41/255.0 green:52/255.0 blue:92/255.0 alpha:0.95];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, headerView.frame.size.width - 20, headerView.frame.size.height)];
    label.text = [_sectionList objectAtIndex:section];
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.shadowOffset = CGSizeMake(0, 1);
    label.shadowColor = [UIColor grayColor];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    
    [headerView addSubview:label];
    tableView.sectionHeaderHeight = headerView.frame.size.height;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {  // 検索後
        return 0.0;
    } else {
        return 20.0;
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
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.text = @"該当する品目はありません";
            cell.textLabel.textColor = [UIColor whiteColor];
            return cell;
        }
        
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Trash" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.trashLabel.text = [_reSearchArray[indexPath.row] valueForKey:@"title"];
        
        if ([[_sectionArray[indexPath.section][indexPath.row] valueForKey:@"category"]  isEqual: @"普通ごみ"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_Normal"];
        } else if ([[_reSearchArray[indexPath.row] valueForKey:@"category"]  isEqual: @"ミックスペーパー"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_Mixed"];
        } else if ([[_reSearchArray[indexPath.row] valueForKey:@"category"]  isEqual: @"プラスチック製容器包装"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_plastic"];
        } else if ([[_reSearchArray[indexPath.row] valueForKey:@"category"]  isEqual: @"小物金属"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_Metal"];
        } else if ([[_reSearchArray[indexPath.row] valueForKey:@"category"]  isEqual: @"使用済み乾電池"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_battery"];
        } else if ([[_reSearchArray[indexPath.row] valueForKey:@"category"]  isEqual: @"空き缶・ペットボトル"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_Can"];
        } else if ([[_reSearchArray[indexPath.row] valueForKey:@"category"]  isEqual: @"粗大ごみ"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_BigRefure"];
        } else {
//            cell.trashImage.image = [UIImage imageNamed:@"sun"];
        }
        
        return cell;
    }
    
    else {  // 検索前
        SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Trash" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        cell.trashLabel.text = [_sectionArray[indexPath.section][indexPath.row] valueForKey:@"title"];
        
        if ([[_sectionArray[indexPath.section][indexPath.row] valueForKey:@"category"]  isEqual: @"普通ごみ"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_Normal"];
        } else if ([[_sectionArray[indexPath.section][indexPath.row] valueForKey:@"category"]  isEqual: @"ミックスペーパー"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_Mixed"];
        } else if ([[_sectionArray[indexPath.section][indexPath.row] valueForKey:@"category"]  isEqual: @"プラスチック製容器包装"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_plastic"];
        } else if ([[_sectionArray[indexPath.section][indexPath.row] valueForKey:@"category"]  isEqual: @"小物金属"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_Metal"];
        } else if ([[_sectionArray[indexPath.section][indexPath.row] valueForKey:@"category"]  isEqual: @"使用済み乾電池"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_battery"];
        } else if ([[_sectionArray[indexPath.section][indexPath.row] valueForKey:@"category"]  isEqual: @"空き缶・ペットボトル"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_Can"];
        } else if ([[_sectionArray[indexPath.section][indexPath.row] valueForKey:@"category"]  isEqual: @"粗大ごみ"]) {
            cell.trashImage.image = [UIImage imageNamed:@"S_BigRefure"];
        } else {
//            cell.trashImage.image = [UIImage imageNamed:@"sun"];
        }
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: 詳細がある場合は詳細ページへ遷移
    SearchDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchDetail"];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 画面遷移
}



- (RLMResults *)section:(int)num {
    NSPredicate *pred;
    
    switch (num) {
        case 0:
            pred = [NSPredicate predicateWithFormat:@"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", @"あ", @"い", @"う", @"え", @"お"];
            break;
            
        case 1:
            pred = [NSPredicate predicateWithFormat:@"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", @"か", @"き", @"く", @"け", @"こ"];
            break;
            
        case 2:
            pred = [NSPredicate predicateWithFormat:@"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", @"さ", @"し", @"す", @"せ", @"そ"];
            break;
            
        case 3:
            pred = [NSPredicate predicateWithFormat:@"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", @"た", @"ち", @"つ", @"て", @"と"];
            break;
            
        case 4:
            pred = [NSPredicate predicateWithFormat:@"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", @"な", @"に", @"ぬ", @"ね", @"の"];
            break;
            
        case 5:
            pred = [NSPredicate predicateWithFormat:@"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", @"は", @"ひ", @"ふ", @"へ", @"ほ"];
            break;
            
        case 6:
            pred = [NSPredicate predicateWithFormat:@"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", @"ま", @"み", @"む", @"め", @"も"];
            break;
            
        case 7:
            pred = [NSPredicate predicateWithFormat:@"read_head = %@ OR read_head = %@ OR read_head = %@", @"や", @"ゆ", @"よ"];
            break;
            
        case 8:
            pred = [NSPredicate predicateWithFormat:@"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", @"ら", @"り", @"る", @"れ", @"ろ"];
            break;
            
        case 9:
            pred = [NSPredicate predicateWithFormat:@"read_head = %@ OR read_head = %@", @"わ", @"を"];
            break;
            
        default:
            break;
    }
    
    return [[TrashCategory objectsWithPredicate:pred] sortedResultsUsingProperty:@"read" ascending:YES];
}

@end
