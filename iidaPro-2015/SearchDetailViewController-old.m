//
//  SearchDetailViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 11/29/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "SearchDetailViewController-old.h"

@interface SearchDetailViewControllerOld ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *genreView;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genreImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *genreImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *genreImageView3;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@end

@implementation SearchDetailViewControllerOld

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"詳細";
    self.view.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    _genreView.layer.cornerRadius = 10.0;
    _genreView.layer.masksToBounds = YES;
    
    [self setupData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_detailTextView setContentOffset:CGPointZero animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData {
    _titleLabel.text = [_trashData valueForKey:@"title"];
    NSArray *array = [[_trashData valueForKey:@"allCategory"] componentsSeparatedByString:@"|"];    NSMutableArray *imageViewArray = [NSMutableArray arrayWithArray:@[_genreImageView1, _genreImageView2, _genreImageView3]];
    for (int i=0; i<array.count; i++) {
        [imageViewArray[i] setImage:[self setGenreImage:array[i]]];
    }
    _detailTextView.text = [_trashData valueForKey:@"info"];
    _detailTextView.textColor = [UIColor whiteColor];
    _detailTextView.font = [UIFont systemFontOfSize:16];
}

- (UIImage *)setGenreImage:(NSString *)genre {
    UIImage *img;
    if ([genre  isEqual: @"普通ごみ"]) {
        img = [UIImage imageNamed:@"S_Normal"];
    } else if ([genre  isEqual: @"ミックスペーパー"]) {
        img = [UIImage imageNamed:@"S_Mixed"];
    } else if ([genre  isEqual: @"プラスチック製容器包装"]) {
        img = [UIImage imageNamed:@"S_plastic"];
    } else if ([genre  isEqual: @"小物金属"]) {
        img = [UIImage imageNamed:@"S_Metal"];
    } else if ([genre  isEqual: @"使用済み乾電池"]) {
        img = [UIImage imageNamed:@"S_battery"];
    } else if ([genre  isEqual: @"空き缶・ペットボトル"]) {
        img = [UIImage imageNamed:@"S_Can"];
    } else if ([genre  isEqual: @"粗大ごみ"]) {
        img = [UIImage imageNamed:@"S_BigRefuse"];
    } else if ([genre  isEqual: @"収集しない"]) {
        img = [UIImage imageNamed:@"S_No"];
    }
    
    return img;
}

@end
