//
//  ViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/06/19.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "ViewController.h"
#import "TipsTabViewController.h"
#import "AlarmViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (retain, nonatomic) UIImageView *trashView;
@property (retain, nonatomic) UIScrollView *btnScrollView;

@property float screenWidth;    // 画面サイズ（横）
@property float screenHeight;   // 画面サイズ（縦）
@property float labelMargin;    // scrollBarとeventLabelのマージン
@property float scrollHeight;   // ScrollBarの高さ
@property float eventHeight;

@end

const NSUInteger iconNum = 7;
const CGFloat iconMargin = 20.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    _screenWidth = screen.size.width;
    _screenHeight = screen.size.height;
    _labelMargin = _screenHeight * 1/32;
    _scrollHeight = _screenHeight * 4/32;
    _eventHeight = _screenHeight * 3/28;
    
    // TODO: 端末情報から端末によりフォントサイズを調整
    
    [self setBackgroundImage];
    [self setupTrashImage];
    [self setupDateLabel];
    [self setupEventLabel];
    [self setupScrollBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
- (void)setBackgroundImage {
    // TODO: 天気APIにより背景画像の切り替え
    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:@"Sunny"] drawInRect:self.view.bounds];
//    [[UIImage imageNamed:@"Cloudy"] drawInRect:self.view.bounds];
    [[UIImage imageNamed:@"Rainy"] drawInRect:self.view.bounds];
//    [[UIImage imageNamed:@"Snowy"] drawInRect:self.view.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}

- (void)setupTrashImage {
    // TODO: ゴミDBから当日のゴミマークを取得
    const float px = _screenWidth * 1/8;
    const float py = _screenHeight * 2/9;
    const float square = _screenWidth * 6/8;
    
    _trashView = [[UIImageView alloc] init];
    _trashView.frame = CGRectMake(px, py, square, square);
    _trashView.image = [UIImage imageNamed:@"Bottle"];
    
    [self.view addSubview:_trashView];
}


#pragma mark - DateLabel
- (void)setupDateLabel {
    const float px = 0.0;
    const float py = _screenHeight * 1/9;
    const float labelHeight = _screenHeight * 1/8;
    
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.frame = CGRectMake(px, py, _screenWidth, labelHeight);
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = [UIFont systemFontOfSize:40];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.text = [self getDate];
    
    [self.view addSubview:dateLabel];
}

- (NSString *)getDate {
    NSDate *now = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps = [calendar components:NSCalendarUnitWeekday fromDate:now];
    
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja"];
    [formatter setDateFormat:@"M月dd日"];
    NSString* now_str = [formatter stringFromDate:now];
    NSString* weekDayStr = formatter.shortWeekdaySymbols[comps.weekday-1];
    
    NSString* date_str = [NSString stringWithFormat:@"%@(%@)", now_str, weekDayStr];
    
    return date_str;
}


#pragma mark - EventLavel
- (void)setupEventLabel {
    const float px = 0.0;
    const float py = _screenHeight - (2*_labelMargin + _scrollHeight + _eventHeight);
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = CGRectMake(px, py, _screenWidth, _eventHeight);
    [self.view addSubview:blurEffectView];
    
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    vibrancyEffectView.frame = CGRectMake(0.0, 0.0, blurEffectView.bounds.size.width, blurEffectView.bounds.size.height);
    [blurEffectView.contentView addSubview:vibrancyEffectView];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0.0, 0.0, _screenWidth, _eventHeight);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:22];
    label.text = [self getEvent];
    [vibrancyEffectView.contentView addSubview: label];
}

- (NSString *)getEvent {
//    NSURL *url = [NSURL URLWithString:@"http://133.242.226.227/api/get"];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    [request setHTTPMethod:@"POST"];
//    NSString *param = [NSString stringWithFormat:@"num=0"];
//    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    NSURLResponse *response = nil;
//    NSError *error = nil;
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    
//    if (error != nil) {
//        NSLog(@"Error!");
//        return;
//    }
//    
//    NSError *e = nil;
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&e];
//    
//    NSString *event = [NSString stringWithFormat:@"%@ %@", [dict valueForKey:@"date"], [dict valueForKey:@"event"]];
    NSString *event = @"7月25日 中間発表";
    
    return event;
}


#pragma mark - ScrolllView
- (void)setupScrollBar {
    const float px = 0.0;
    const float py = _screenHeight - _scrollHeight - _labelMargin;
    
    _btnScrollView = [[UIScrollView alloc] init];
    _btnScrollView.frame = CGRectMake(px, py, _screenWidth, _scrollHeight);
    [self.view addSubview:_btnScrollView];
    
    [self setScrollContent];
}

- (void)setScrollContent {
    const float square = _scrollHeight;  // 正方形の一辺
    
    for (int i=0; i < iconNum; i++) {
        NSString *imageName = [NSString stringWithFormat:@"Image-%d", i];
        UIImage *img = [UIImage imageNamed:imageName];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, square, square)];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(nextPage:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        [_btnScrollView addSubview:btn];
    }
    
    UIImageView *view = nil;
    NSArray *subviews = [_btnScrollView subviews];
    // 描画開始の x,y 位置
    CGFloat px = iconMargin;
    CGFloat py = 0.0;
    for (view in subviews) {
        if ([view isKindOfClass:[UIButton class]] && view.tag > 0) {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(px, py);
            view.frame = frame;
            
            px += (square + iconMargin);
        }
    }
    
    // UIScrollViewのコンテンツサイズを計算
    [_btnScrollView setContentSize:CGSizeMake( square * iconNum + iconMargin * (iconNum + 1), square)];
}


#pragma mark -
- (void)nextPage:(UIButton *)sender {
    switch (sender.tag) {
        case 3:{
            TipsTabViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"TipsTabView"];
            [self presentViewController:controller animated:YES completion:nil];
            break;
        }
        case 4:{
          AlarmViewController *controller= [self.storyboard instantiateViewControllerWithIdentifier:@"AlarmView"];
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
