//
//  AlarmPopUpView.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/11/05.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import "AlarmPopUpView.h"
#import "AppDelegate.h"

@interface AlarmPopUpView ()
@property (retain, nonatomic) UIView *popup;
@property (nonatomic) PopupStyle style;

@end

@implementation AlarmPopUpView

- (id)init {
    return [self initWithFrame:CGRectMake(0, 0, 0, 0) style:PopupDefaultStyle];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithFrame:CGRectMake(0, 0, 0, 0) style:PopupDefaultStyle];
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:PopupDefaultStyle];
}

- (id)initWithFrame:(CGRect)frame style:(PopupStyle)style {
    if (self = [super initWithFrame:frame]) {
        _style = style;
        NSLog(@"%ld", (long)_style);
        [self setup:frame];
    }
    return self;
}


- (void)setup:(CGRect)frame {
    self.frame = frame;
    self.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.5];
    
    CGFloat width = frame.size.width * 0.8;
    CGFloat wMargin = frame.size.width * 0.1;
    CGFloat height = 300.0;
    CGFloat hMargin = (frame.size.height - 300) / 2;
    _popup = [[UIView alloc] init];
    _popup.frame = CGRectMake(wMargin, hMargin, width, height);
    _popup.backgroundColor = [UIColor whiteColor];
    _popup.userInteractionEnabled = YES;
    [self addSubview:_popup];
}




#pragma mark - UIView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([event touchesForView:self]) {
        [self removeFromSuperview];
    }
}

@end
