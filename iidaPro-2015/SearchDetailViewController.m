//
//  SearchDetailViewController.m
//  iidaPro-2015
//
//  Created by akaimo on 11/29/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "SearchDetailViewController.h"

@interface SearchDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *genreView;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genreImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *genreImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *genreImageView3;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

@end

@implementation SearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"詳細";
    self.view.layer.contents = (id)[UIImage imageNamed:@"Base"].CGImage;
    _genreView.layer.cornerRadius = 10.0;
    _genreView.layer.masksToBounds = YES;
    
    [self setupData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData {
    _titleLabel.text = [_trashData valueForKey:@"title"];
    // TODO: 実際のデータに置き換える
    _genreImageView1.image = [self setGenreImage:[_trashData valueForKey:@"category"]];
    _detailTextView.text = @"分解できるなら... \n hogehogehogehogehogehoge";
    _detailTextView.textColor = [UIColor whiteColor];
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
        img = [UIImage imageNamed:@"S_BigRefure"];
    }
    
    return img;
}

@end
