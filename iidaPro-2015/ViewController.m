//
//  ViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/06/19.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "ViewController.h"
#import "TipsViewController.h"
#import "SearchResultViewController.h"
#import "CalendarViewController.h"
#import "AlarmViewController.h"
#import "ContactViewController.h"
#import "SettingViewController.h"

@interface ViewController () <UISearchBarDelegate>

//@property (retain, nonatomic) UISearchBar *searchBar;
@property (retain, nonatomic) UILabel *locationLabel;
@property (retain, nonatomic) UIImageView *trashView;
@property (retain, nonatomic) UIScrollView *btnScrollView;
@property (retain, nonatomic) UIView *bottomView;
@property (retain, nonatomic) NSDictionary *areaData;

@property float screenWidth;    // 画面サイズ（横）
@property float screenHeight;   // 画面サイズ（縦） 
@property float scrollHeight;   // ScrollBarの高さ

@end

const NSUInteger iconNum = 6;
const CGFloat iconMargin = 20.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 高速化のために先にメモリ上に読み込んでおく
    [[UITextView alloc] init];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    _screenWidth = screen.size.width;
    _screenHeight = screen.size.height;
    _scrollHeight = _screenHeight * 4/32;
    
    // TODO: 端末情報から端末によりフォントサイズを調整
    
    [self setupTopView];
    [self setupBottomView];
    [self setBackgroundImage];
    
    [self setupLabel];
    [self setupTrashImage];
    [self setupScrollBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _areaData = [NSDictionary dictionaryWithDictionary:[ud objectForKey:@"district"]];
    _locationLabel.text = [_areaData valueForKey:@"area"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TopView
- (void)setupTopView {
    UIView *topView = [[UIView alloc] init];
    topView.frame = CGRectMake(0, 0, _screenWidth, _screenHeight * 7/10);
    // TODO: 天気ごとに色を変える
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = topView.bounds;
    gradient.colors = @[
                        (id)[UIColor colorWithRed:71/255.0 green:117/255.0 blue:192/255.0 alpha:1].CGColor,
                        (id)[UIColor colorWithRed:21/255.0 green:39/255.0 blue:69/255.0 alpha:1].CGColor
                        ];
    [topView.layer insertSublayer:gradient atIndex:0];
    [self.view addSubview:topView];
}

- (void)setBackgroundImage {
    // TODO: 天気APIにより背景画像の切り替え
    UIImageView *weatherImageView = [[UIImageView alloc] init];
    weatherImageView.image = [UIImage imageNamed:@"Rainy"];
    // TODO: 要調整
    weatherImageView.frame = CGRectMake(0, _screenHeight * 9/11 - 150, _screenWidth, 150);
    [self.view addSubview:weatherImageView];
}

- (void)setupTrashImage {
    // TODO: ゴミDBから当日のゴミマークを取得
    const float px = _screenWidth * 2/11;
    const float py = _screenHeight * 2/10;
    const float square = _screenWidth * 7/11;
    
    _trashView = [[UIImageView alloc] init];
    _trashView.frame = CGRectMake(px, py, square, square);
    _trashView.image = [UIImage imageNamed:@"Bottle"];
    
    [self.view addSubview:_trashView];
}


#pragma mark - EventLavel
- (void)setupLabel {
    _locationLabel = [[UILabel alloc] init];
    _locationLabel.frame = CGRectMake(0, _screenHeight * 1/15, _screenWidth, _screenHeight * 1/15);
    _locationLabel.textAlignment = NSTextAlignmentCenter;
    _locationLabel.font = [UIFont boldSystemFontOfSize:36];
    _locationLabel.textColor = [UIColor whiteColor];
    // TODO: 登録されている地域名を取得
    _locationLabel.text = @"多摩区";
    [self.view addSubview:_locationLabel];
    
    UILabel *eventLabel = [[UILabel alloc] init];
    eventLabel.frame = CGRectMake(0, _screenHeight * 2/15, _screenWidth, _screenHeight * 1/17);
    eventLabel.textAlignment = NSTextAlignmentCenter;
    eventLabel.font = [UIFont systemFontOfSize:18];
    eventLabel.textColor = [UIColor whiteColor];
    // TODO: イベントAPIからtextを取得
    eventLabel.text = @"00月00日にhogehogehogehoge";
    [self.view addSubview:eventLabel];
}


#pragma mark - ScrolllView
- (void)setupBottomView {
    _bottomView = [[UIView alloc] init];
    _bottomView.frame = CGRectMake(0, _screenHeight * 9/11, _screenWidth, _screenHeight * 2/11);
    // TODO: 天気によって色を変える
    _bottomView.backgroundColor = [UIColor colorWithRed:74/255.0 green:144/255.0 blue:226/255.0 alpha:1.0];
    [self.view addSubview:_bottomView];
}

- (void)setupScrollBar {
    const float labelMargin = _screenHeight * 1/32;
    const float px = 0.0;
    const float py = _screenHeight - _scrollHeight - labelMargin;
    
    _btnScrollView = [[UIScrollView alloc] init];
    _btnScrollView.frame = CGRectMake(px, py, _screenWidth, _scrollHeight);
    [_btnScrollView setShowsHorizontalScrollIndicator:NO];
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
        case 1:{
            // 検索
            SearchResultViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"Search"];
            [self.navigationController pushViewController:search animated:YES];

            break;
        }
            
        case 2:{
            // 豆知識
            TipsViewController *tips = [self.storyboard instantiateViewControllerWithIdentifier:@"tips"];
            [self.navigationController pushViewController:tips animated:YES];
            break;
        }
            
        case 3:{
            // カレンダー
            CalendarViewController *calendar = [self.storyboard instantiateViewControllerWithIdentifier:@"Calendar"];
            [self.navigationController pushViewController:calendar animated:YES];
            break;
        }
            
        case 4:{
            // アラーム
            AlarmViewController *alarm = [self.storyboard instantiateViewControllerWithIdentifier:@"Alarm"];
            [self.navigationController pushViewController:alarm animated:YES];
            break;
        }
            
        case 5:{
            // 問い合わせ
            ContactViewController *contact = [self.storyboard instantiateViewControllerWithIdentifier:@"Contact"];
            [self.navigationController pushViewController:contact animated:YES];
            break;
        }
            
        case 6:{
            // 設定
            SettingViewController *setting = [self.storyboard instantiateViewControllerWithIdentifier:@"Setting"];
            [self.navigationController pushViewController:setting animated:YES];
            break;
        }
            
        default:
            NSLog(@"Error");
            break;
    }
}

@end
