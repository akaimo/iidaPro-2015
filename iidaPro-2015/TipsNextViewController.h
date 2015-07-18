//
//  TipsNextViewController.h
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/08.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipsNextViewController : UIViewController

@property NSInteger TipsNextNum;
@property (weak, nonatomic) IBOutlet NSString *TipsNextTitle;
@property (weak, nonatomic) IBOutlet NSString *TipsNextImageName;
@property (weak, nonatomic) IBOutlet UITextView *TipsNextText;

@end
