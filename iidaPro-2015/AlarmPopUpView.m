//
//  AlarmPopUpView.m
//  iidaPro-2015
//
//  Created by akaimo on 2015/11/05.
//  Copyright © 2015年 akaimo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
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
    _popup.layer.cornerRadius = 6;
    _popup.clipsToBounds = YES;
    _popup.userInteractionEnabled = YES;
    [self addSubview:_popup];
    
    switch (_style) {
        case PopupDefaultStyle:
            [self setupDefaultStyle];
            break;
            
        case PopupEditMyAlarmStyle:
            [self setupMyAlarmStyle];
            break;
            
        case PopupNewMyAlarmStyle:
            [self setupMyAlarmStyle];
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
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
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
    
    [self setupButton];
}

- (void)setupMyAlarmStyle {
    // TODO: myAlarm
}

- (void)setupButton {
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(0, _popup.frame.size.height - 50, _popup.frame.size.width / 2, 50);
    [_cancelBtn setTitle:@"キャンセル" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor colorWithRed:3/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_popup addSubview:_cancelBtn];
    
    _enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _enterBtn.frame = CGRectMake(_popup.frame.size.width / 2, _popup.frame.size.height - 50, _popup.frame.size.width / 2, 50);
    [_enterBtn setTitle:@"登録" forState:UIControlStateNormal];
    [_enterBtn setTitleColor:[UIColor colorWithRed:3/255.0 green:122/255.0 blue:255/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_enterBtn addTarget:self action:@selector(enterButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_popup addSubview:_enterBtn];
    
    // TODO: add line
}



- (void)setAlarmTime {
    // TODO: suport myAlarm
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm"];
    NSString *str = [formatter stringFromDate:_tempData];
    NSMutableArray *array = [_alarmArray mutableCopy];
    NSMutableDictionary *dic = [array[_selectedRow] mutableCopy];
    [dic setObject:str forKey:@"time"];
    [array replaceObjectAtIndex:_selectedRow withObject:dic];
    [ud setObject:array forKey:@"defaultAlarm"];
}


- (void)changeDatePicker:(id)sender {
    UIDatePicker *picker = (UIDatePicker *)sender;
    _tempData = picker.date;
}

- (void)cancelButtonTapped:(UIButton *)button {
    [self removeFromSuperview];
}

- (void)enterButtonTapped:(UIButton *)button {
    [self setAlarmTime];
    [self removeFromSuperview];
}

#pragma mark - UIView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([event touchesForView:self]) {
        [self removeFromSuperview];
    }
}

@end
