//
//  CalendarTableViewCell.h
//  iidaPro-2015
//
//  Created by akaimo on 11/25/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *icon2ImageView;
@property (weak, nonatomic) IBOutlet UIButton *alarmButton;

@end
