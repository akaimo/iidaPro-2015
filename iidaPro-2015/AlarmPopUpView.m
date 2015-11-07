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
@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UILabel *alarmTitleLabel;
@property (retain, nonatomic) UIDatePicker *datePicker;
@property (retain, nonatomic) UIButton *enterBtn;
@property (retain, nonatomic) UIButton *cancelBtn;

@property (retain, nonatomic) NSMutableArray *alarmArray;
@property (retain, nonatomic) NSDate *tempData;
@property (nonatomic) PopupStyle style;
@property (nonatomic) NSInteger selectedRow;

@end

@implementation AlarmPopUpView

- (id)init {
    return [self initWithFrame:CGRectMake(0, 0, 0, 0) style:PopupDefaultStyle row:0];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithFrame:CGRectMake(0, 0, 0, 0) style:PopupDefaultStyle row:0];
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:PopupDefaultStyle row:0];
}

- (id)initWithFrame:(CGRect)frame style:(PopupStyle)style row:(NSInteger)row {
    if (self = [super initWithFrame:frame]) {
        _style = style;
        _selectedRow = row;
        [self setup:frame];
    }
    return self;
}


- (void)setup:(CGRect)frame {
    self.frame = frame;
    self.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.5];
    
    CGFloat width = frame.size.width * 0.8;
    CGFloat wMargin = frame.size.width * 0.1;
    CGFloat height = 250.0;
    CGFloat hMargin = (frame.size.height - 300) / 2;
    _popup = [[UIView alloc] init];
    _popup.frame = CGRectMake(wMargin, hMargin, width, height);
    _popup.backgroundColor = [UIColor whiteColor];
    _popup.userInteractionEnabled = YES;
    [self addSubview:_popup];
    
    switch (_style) {
        case PopupDefaultStyle:
            [self setupDefaultStyle];
            break;
            
        case PopupEditMyAlarmStyle:
            // myAlarm - edit
            break;
            
        case PopupNewMyAlarmStyle:
            // myAlarm - new
            break;
            
        default:
            break;
    }
}

- (void)setupDefaultStyle {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _alarmArray = [ud objectForKey:@"defaultAlarm"];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _popup.frame.size.width, 50)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = [_alarmArray[_selectedRow] valueForKey:@"title"];
    [_popup addSubview:_titleLabel];
    
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    [inputDateFormatter setLocale:locale];
    [inputDateFormatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    [inputDateFormatter setDateFormat:@"H:mm"];
    NSDate *inputDate = [inputDateFormatter dateFromString:[_alarmArray[_selectedRow] valueForKey:@"time"]];
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 50, _popup.frame.size.width, 150)];
    _datePicker.datePickerMode = UIDatePickerModeTime;
    _datePicker.date = inputDate;
    [_datePicker addTarget:self action:@selector(changeDatePicker:) forControlEvents:UIControlEventValueChanged];
    [_popup addSubview:_datePicker];
}



- (void)changeDatePicker:(id)sender {
    UIDatePicker *picker = (UIDatePicker *)sender;
    _tempData = picker.date;
}

#pragma mark - UIView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([event touchesForView:self]) {
        [self removeFromSuperview];
    }
}

@end
