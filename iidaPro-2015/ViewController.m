//
//  ViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/06/19.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "ViewController.h"
#import "TipsTabViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

const NSUInteger iconNum = 8;
const CGFloat iconHeight = 60.0;
const CGFloat iconWidth = 60.0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    for (int i=0; i < iconNum; i++) {
        NSString *imageName = [NSString stringWithFormat:@"sun"];
        UIImage *img = [UIImage imageNamed:imageName];
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(hoge:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i + 1;
        [_scrollView addSubview:btn];
    }
    [self setupScrollContent];
    
    // adjust the size of the navigationBar and statusBar
    _scrollView.contentInset=UIEdgeInsetsMake(-64.0, 0.0, 0.0, 0.0);
    _scrollView.scrollIndicatorInsets=UIEdgeInsetsMake(-64.0,0.0, 0.0,0.0);
    
    // navigationControllerを透明にする
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupScrollContent {
    UIImageView *view = nil;
    NSArray *subviews = [_scrollView subviews];
    // 描画開始の x,y 位置
    CGFloat px = 28.0;
    CGFloat py = 0.0;
    for (view in subviews) {
        NSLog(@"tag = %ld",(long)view.tag);
        if ([view isKindOfClass:[UIButton class]] && view.tag > 0) {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(px, py);
            view.frame = frame;
            
            px += (iconWidth + 28);
        }
    }
    
    // UIScrollViewのコンテンツサイズを計算
    [_scrollView setContentSize:CGSizeMake( iconWidth * iconNum + 28 * (iconNum + 1), iconHeight)];
}

- (void)hoge:(UIButton *)sender {
    NSLog(@"%ld", (long)sender.tag);
}

@end
