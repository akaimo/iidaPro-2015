//
//  CalendarTableViewCell.m
//  iidaPro-2015
//
//  Created by akaimo on 11/25/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

#import "CalendarTableViewCell.h"

@implementation CalendarTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    _weekdayLabel.text = nil;
    _dayLabel.text = nil;
    _iconImageView.image = nil;
    _icon2ImageView.image = nil;
}

@end
