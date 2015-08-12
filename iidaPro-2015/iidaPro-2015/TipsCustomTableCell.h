//
//  TipsCustomCell.h
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/08.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipsCustomTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *TipsUIImage;
@property (weak, nonatomic) IBOutlet UILabel *TipsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *TipsNum;
+(CGFloat)rowHeight;

@end
