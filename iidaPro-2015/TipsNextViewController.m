//
//  TipsNextViewController.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/08.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "TipsNextViewController.h"

@interface TipsNextViewController()

@property (weak, nonatomic) IBOutlet UILabel *TipsNextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *TipsNextImage;
@end

@implementation TipsNextViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.TipsNextImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_TipsNextImageName]];
    self.TipsNextLabel.text = _TipsNextTitle;
    switch(_TipsNextNum){
        case 1:
            _TipsNextText.text = @"レジ袋などに入れた\nプラスチック容器は\nさらに大きな袋に入れて\nごみに出さないでください";
            _TipsNextImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"tips1"]];
            break;
        case 2:
            _TipsNextText.text = @"";
            _TipsNextImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"tips1"]];
            break;
        case 3:
            _TipsNextText.text=@"";
            _TipsNextImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"tips1"]];
            break;
        case 4:
            _TipsNextText.text=@"かわるんは川崎市の3R推進キャラクターです\nごみの資源化、減量を目指す\nリデュース(発生・排出抑制)\nリユース(再使用)\nリサイクル(再生利用)\nのことです。";
            _TipsNextImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@", @"tips4"]];            break;
        case 5:
            break;
        case 6:
            break;
    }
    _TipsNextText.textColor = [UIColor blackColor];
    _TipsNextText.backgroundColor = [UIColor whiteColor];
    _TipsNextText.textAlignment = NSTextAlignmentCenter;
    _TipsNextText.editable = NO;
    [_TipsNextText flashScrollIndicators];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
