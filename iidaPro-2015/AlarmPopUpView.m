//
//  AlarmPopUpView.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/11/05.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import "AlarmPopUpView.h"

@implementation AlarmPopUpView

- (id)init {
    self = [super init];
    if (self) {
        [self setup:CGRectMake(0, 0, 0, 0)];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup:CGRectMake(0, 0, 0, 0)];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup:frame];
    }
    return self;
}

- (void)setup:(CGRect)frame {
    self.frame = frame;
    
    CGFloat width = frame.size.width * 0.8;
    CGFloat wMargin = frame.size.width * 0.1;
    CGFloat height = 300.0;
    CGFloat hMargin = (frame.size.height - 300) / 2;
//    self.frame = CGRectMake(wMargin, hMargin, width, height);
    self.backgroundColor = [UIColor lightGrayColor];
}

@end
