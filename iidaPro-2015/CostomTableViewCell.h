//
//  CostomTableViewCell.h
//  iidaPro-2015
//
//  Created by 岩村圭太 on 2015/07/03.
//  Copyright (c) 2015年 akaimo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tableName;
@property (weak, nonatomic) IBOutlet UIImageView *tableUIimage;
+(CGFloat)rowHeight;
@end
