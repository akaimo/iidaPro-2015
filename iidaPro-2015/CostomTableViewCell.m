//
//  CostomTableViewCell.m
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/03.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import "CostomTableViewCell.h"

@implementation CostomTableViewCell

+ (CGFloat)rowHeight
{
    return 60.0f;
}

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
