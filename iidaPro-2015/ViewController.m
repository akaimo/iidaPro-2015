//
//  ViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/06/19.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "ViewController.h"
#import "TipsTabViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *trashImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventLabel;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *blurEffectView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *vibrancyEffectView;

@end

const NSUInteger iconNum = 7;
const CGFloat iconHeight = 72.0;
const CGFloat iconWidth = 72.0;
const CGFloat iconMargin = 20.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setBackgroundImage];
    [self setTrashImage];
    [self setDate];
    [self setEvent];
    
    for (int i=0; i < iconNum; i++) {
        NSString *imageName = [NSString stringWithFormat:@"Image-%d", i];
        UIImage *img = [UIImage imageNamed:imageName];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, iconWidth, iconHeight)];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        [_scrollView addSubview:btn];
    }
    [self setupScrollContent];
    
    // adjust the size of the navigationBar and statusBar
    _scrollView.contentInset=UIEdgeInsetsMake(-20.0, 0.0, 0.0, 0.0);
    _scrollView.scrollIndicatorInsets=UIEdgeInsetsMake(-20.0,0.0, 0.0,0.0);
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setBackgroundImage {
    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:@"Sunny"] drawInRect:self.view.bounds];
//    [[UIImage imageNamed:@"Cloudy"] drawInRect:self.view.bounds];
    [[UIImage imageNamed:@"Rainy"] drawInRect:self.view.bounds];
//    [[UIImage imageNamed:@"Snowy"] drawInRect:self.view.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}

- (void)setTrashImage {
    _trashImageView.image = [UIImage imageNamed:@"Bottle"];
}

- (void)setDate {
    NSDate *now = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSCalendarUnitWeekday fromDate:now];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja"];
    [formatter setDateFormat:@"M月dd日"];
    NSString* now_str = [formatter stringFromDate:now];
    NSString* weekDayStr = formatter.shortWeekdaySymbols[comps.weekday-1];
    NSString* date_str = [NSString stringWithFormat:@"%@(%@)", now_str, weekDayStr];
    _dateLabel.text = date_str;
}

- (void)setEvent {
    _eventLabel.text = @"7月25日 中間発表";
}

- (void)setupScrollContent {
    UIImageView *view = nil;
    NSArray *subviews = [_scrollView subviews];
    // 描画開始の x,y 位置
    CGFloat px = iconMargin;
    CGFloat py = 0.0;
    for (view in subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag > 0) {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(px, py);
            view.frame = frame;
            
            px += (iconWidth + iconMargin);
        }
    }
    
    // UIScrollViewのコンテンツサイズを計算
    [_scrollView setContentSize:CGSizeMake( iconWidth * iconNum + iconMargin * (iconNum + 1), iconHeight)];
}

- (void)nextPage:(UIButton *)sender {
    switch (sender.tag) {
        case 3:{
            TipsTabViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TipsTabView"];
            [self presentViewController:controller animated:YES completion:nil];
            break;
        }
            
        default:
            NSLog(@"%ld", (long)sender.tag);
            break;
    }
}

// statusbarの色を白に
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count;
    count = 10;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorColor = [UIColor clearColor];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = @"hogehoge";
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld", (long)indexPath.row);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 画面遷移
}


#pragma mark - UISearchDisplayControllerDelegate
- (BOOL)searchDisplayController:controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContainsWithSearchText:searchString];
    return YES;
}

- (void)filterContainsWithSearchText:(NSString *)searchText {
    // searchTextをもとに検索する
}

@end
