//
//  ViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/06/19.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "ViewController.h"
#import "TipsTabViewController.h"
#import "SearchResultViewController.h"
#import "Classification.h"

@interface ViewController () <UISearchBarDelegate>

//@property (retain, nonatomic) UISearchBar *searchBar;
@property (retain, nonatomic) UIImageView *trashView;
@property (retain, nonatomic) UIScrollView *btnScrollView;
@property (retain, nonatomic) UIView *bottomView;

@property float screenWidth;    // 画面サイズ（横）
@property float screenHeight;   // 画面サイズ（縦）
@property float labelMargin;    // scrollBarとeventLabelのマージン
@property float scrollHeight;   // ScrollBarの高さ
@property float eventHeight;

@end

const NSUInteger iconNum = 6;
const CGFloat iconMargin = 20.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    _screenWidth = screen.size.width;
    _screenHeight = screen.size.height;
    _labelMargin = _screenHeight * 1/32;
    _scrollHeight = _screenHeight * 4/32;
    _eventHeight = _screenHeight * 3/28;
    
    // TODO: 端末情報から端末によりフォントサイズを調整
    
    [self setBackgroundImage];
    [self setupTopView];
    [self setupBottomView];
    
    [self setupLabel];
    [self setupTrashImage];
    [self setupScrollBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    topView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:topView];
}

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


#pragma mark - EventLavel
- (void)setupLabel {
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.frame = CGRectMake(0, _screenHeight * 1/13, _screenWidth, _screenHeight * 1/13);
    locationLabel.textAlignment = NSTextAlignmentCenter;
    locationLabel.font = [UIFont boldSystemFontOfSize:36];
    locationLabel.textColor = [UIColor whiteColor];
    // TODO: 登録されている地域名を取得
    locationLabel.text = @"多摩区";
    [self.view addSubview:locationLabel];
    
    UILabel *eventLabel = [[UILabel alloc] init];
    eventLabel.frame = CGRectMake(0, _screenHeight * 2/13, _screenWidth, _screenHeight * 1/15);
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
    _bottomView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_bottomView];
}

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
        case 1:{
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

@end
