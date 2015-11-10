//
//  TrashAlarmCell.h
//  iidaPro-2015
//
//  Created by akaimo on 2015/11/04.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrashAlarmCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

@end
