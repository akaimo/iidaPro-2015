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

@interface AlarmPopUpView () <UITextFieldDelegate>
@property (retain, nonatomic) UIView *popup;
@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UITextField *titleTextField;
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
    CGFloat height = (_style == PopupDefaultStyle) ? 250.0 : 300.0;
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
            [self setupEditMyAlarmStyle];
            break;
            
        case PopupNewMyAlarmStyle:
            [self setupNewMyAlarmStyle];
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

- (void)setupEditMyAlarmStyle {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    _alarmArray = [ud objectForKey:@"myAlarm"];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _popup.frame.size.width, 50)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"Myアラームの編集";
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_popup addSubview:_titleLabel];
    
    _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, _popup.frame.size.width - 40, 40)];
    _titleTextField.delegate = self;
    _titleTextField.clearButtonMode = UITextFieldViewModeAlways;
    _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    _titleTextField.placeholder = @"タイトルを入力";
    _titleTextField.text = [_alarmArray[_selectedRow] valueForKey:@"title"];
    [_popup addSubview:_titleTextField];
    
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    [inputDateFormatter setLocale:locale];
    [inputDateFormatter setCalendar:[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]];
    [inputDateFormatter setDateFormat:@"MM/dd H:mm"];
    NSDate *inputDate = [inputDateFormatter dateFromString:[_alarmArray[_selectedRow] valueForKey:@"time"]];
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 100, _popup.frame.size.width, 150)];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _datePicker.date = inputDate;
    _datePicker.minimumDate = [NSDate date];
    [_datePicker addTarget:self action:@selector(changeDatePicker:) forControlEvents:UIControlEventValueChanged];
    [_datePicker addTarget:self action:@selector(touchDatePicker:) forControlEvents:UIControlEventAllEvents];
    [_popup addSubview:_datePicker];
    
    [self setupButton];
}

- (void)setupNewMyAlarmStyle {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _popup.frame.size.width, 50)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"Myアラームの新規作成";
    _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [_popup addSubview:_titleLabel];
    
    _titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, _popup.frame.size.width - 40, 40)];
    _titleTextField.delegate = self;
    _titleTextField.clearButtonMode = UITextFieldViewModeAlways;
    _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    _titleTextField.placeholder = @"タイトルを入力";
    [_popup addSubview:_titleTextField];
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 100, _popup.frame.size.width, 150)];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _datePicker.date = [NSDate date];
    _datePicker.minimumDate = [NSDate date];
    [_datePicker addTarget:self action:@selector(changeDatePicker:) forControlEvents:UIControlEventValueChanged];
    [_datePicker addTarget:self action:@selector(touchDatePicker:) forControlEvents:UIControlEventAllEvents];
    [_popup addSubview:_datePicker];
    
    [self setupButton];
}

- (void)setupButton {
    // TODO: set tapping button clolr
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

// TODO: lock button when don`t set time for alarm

- (BOOL)setAlarmTime {
    if (_tempData == NULL) {
        return NO;
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    [formatter setLocale:locale];
    if (_style == PopupDefaultStyle) {
        [formatter setDateFormat:@"HH:mm"];
    } else {
        [formatter setDateFormat:@"MM/dd HH:mm"];
    }
    NSString *str = [formatter stringFromDate:_tempData];
    
    switch (_style) {
        case PopupDefaultStyle: {
            NSMutableArray *array = [_alarmArray mutableCopy];
            NSMutableDictionary *dic = [array[_selectedRow] mutableCopy];
            [dic setObject:str forKey:@"time"];
            [array replaceObjectAtIndex:_selectedRow withObject:dic];
            [ud setObject:array forKey:@"defaultAlarm"];
            break;
        }
            
        case PopupEditMyAlarmStyle: {
            if ([_titleTextField.text  isEqual: @""]) {
                return NO;
            }
            NSMutableArray *array = [_alarmArray mutableCopy];
            NSMutableDictionary *dic = [array[_selectedRow] mutableCopy];
            [dic setObject:str forKey:@"time"];
            [dic setObject:_titleTextField.text forKey:@"title"];
            [array replaceObjectAtIndex:_selectedRow withObject:dic];
            [ud setObject:array forKey:@"myAlarm"];
            break;
        }
            
        case PopupNewMyAlarmStyle: {
            if ([_titleTextField.text  isEqual: @""]) {
                return NO;
            }
            _alarmArray = [ud objectForKey:@"myAlarm"];
            NSMutableArray *array = [_alarmArray mutableCopy];
            NSDictionary *dic = @{@"title":_titleTextField.text,
                                  @"time":str,
                                  @"switch":@"on"};
            [array addObject:dic];
            [ud setObject:array forKey:@"myAlarm"];
            break;
        }
            
        default:
            return NO;
            break;
    }
    return YES;
}


- (void)changeDatePicker:(id)sender {
    UIDatePicker *picker = (UIDatePicker *)sender;
    _tempData = picker.date;
}

- (void)touchDatePicker:(id)sender {
    [_titleTextField resignFirstResponder];
}

- (void)cancelButtonTapped:(UIButton *)button {
    [self removeFromSuperview];
}

- (void)enterButtonTapped:(UIButton *)button {
    if ([self setAlarmTime] == NO) {
        return;
    }
    [self.delegate alarmPopUpView:self didTappedEnterButton:_enterBtn];
    [self removeFromSuperview];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UIView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([event touchesForView:self]) {
        [self removeFromSuperview];
    }
    
    if ([event touchesForView:_popup]) {
        [_titleTextField resignFirstResponder];
    }
}

@end
