//
//  ZFJDatePickerView.m
//  WelLv
//
//  Created by WeiLv on 15/11/4.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJDatePickerView.h"

@interface ZFJDatePickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, assign) ZFJDatePickerViewStyle style;
@end

@implementation ZFJDatePickerView

- (instancetype)initWithFrame:(CGRect)frame style:(ZFJDatePickerViewStyle)style{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.style = style;
        switch (style) {
            case ZFJDatePickerViewStyleYM:
            {
                [self addYMStyle];
            }
                break;
            case ZFJDatePickerViewStyleYMDhm:
            {
                [self addYMStyle];
            }
            default:
                break;
        }
    }
    return self;
}
#pragma mark - customView

- (void)addYMStyle {
    UIButton * cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBut.frame = CGRectMake(15, 0, 50, 45);
    [cancelBut setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelBut addTarget:self action:@selector(clickCancelBut:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBut];
    
    UIButton * confirmBut = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBut.frame = CGRectMake(windowContentWidth - 50 - 15, 0, 50, 45);
    [confirmBut setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [confirmBut addTarget:self action:@selector(clickConfirmBut:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBut];

    self.pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 45, windowContentWidth, ViewHeight(self) - 45)];
    self.pickView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.pickView.delegate = self;
    self.pickView.dataSource = self;
    [self addSubview:self.pickView];
}

- (void)addYYYY_MM_DD_hh_mmStyle {
    UIButton * cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBut.frame = CGRectMake(15, 0, 50, 45);
    [cancelBut setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [cancelBut addTarget:self action:@selector(clickCancelBut:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBut];
    
    UIButton * confirmBut = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBut.frame = CGRectMake(windowContentWidth - 50 - 15, 0, 50, 45);
    [confirmBut setTitle:@"确认" forState:UIControlStateNormal];
    [confirmBut setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [confirmBut addTarget:self action:@selector(clickConfirmBut:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBut];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 45, windowContentWidth, ViewHeight(self) - 45)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
    self.datePicker.minimumDate = [NSDate date];
    NSString * maxDateString = @"2099-12-31";
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    // dateFormater.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [dateFormater setDateFormat:@"yyyy-MM-DD"];
    NSDate *maxCurrentDate = [dateFormater dateFromString: maxDateString];
    self.datePicker.maximumDate = maxCurrentDate;
    [self addSubview:_datePicker];
}
#pragma mark --- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (self.style) {
        case ZFJDatePickerViewStyleYM:
        {
            return 2;

        }
            break;
        case ZFJDatePickerViewStyleYMDhm:
        {
            return 4;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    switch (self.style) {
        case ZFJDatePickerViewStyleYM:
        {
            switch (component) {
                case 0:
                {
                    return 85;
                }
                    break;
                case 1:
                {
                    return 12;
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case ZFJDatePickerViewStyleYMDhm:
        {
            switch (component) {
                case 0:
                {
                    return (2100 - [[[WLSingletonClass defaultWLSingleton] wlNowTimeFormatterStr:@"YYYY"] integerValue]);
                }
                    break;
                case 1:
                {
                    return 12;
                }
                    break;
                case 2:
                {
                    return 31;
                }
                    break;
                case 3:
                {
                    return 24;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    return 0;
//    
//    if (component == 0) {
//        return 85;
//    }
//    return 12;
}

#pragma mark --- UIPickerViewDataSource
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    if (component == 0) {
//        return [NSString stringWithFormat:@"%ld年", row + 2015];
//    }
//    return [NSString stringWithFormat:@"%ld月", row + 1];
    switch (self.style) {
        case ZFJDatePickerViewStyleYM:
        {
            if (component == 0) {
                return [NSString stringWithFormat:@"%ld年", row + 2015];
            }
            return [NSString stringWithFormat:@"%ld月", row + 1];
        }
            break;
        case ZFJDatePickerViewStyleYMDhm:
        {
            switch (component) {
                case 0:
                {
                    return [NSString stringWithFormat:@"%ld年", row + 2015];

                }
                    break;
                case 1:
                {
                    return [NSString stringWithFormat:@"%ld月", row + 1];

                }
                    break;
                case 2:
                {
                    return [NSString stringWithFormat:@"%ld日", row + 1];

                }
                    break;
                case 3:
                {
                    return [NSString stringWithFormat:@"%ld", row];

                }
                    break;

                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    return @"";
}
#pragma mark --- 按钮点击方法
- (void)clickCancelBut:(UIButton *)button {
    if (self.canceBut) {
        self.canceBut(button);
        self.hidden = YES;
    }
}

- (void)clickConfirmBut:(UIButton *)button {
    if (self.dateStr) {
        switch (self.style) {
            case ZFJDatePickerViewStyleYM:
            {
                self.dateStr([NSString stringWithFormat:@"%ld-%@-00 00:00:00", ([self.pickView selectedRowInComponent:0] + 2015), ([self.pickView selectedRowInComponent:1] + 1) < 10 ? [NSString stringWithFormat:@"0%ld", ([self.pickView selectedRowInComponent:1] + 1)] : [NSString stringWithFormat:@"%ld", ([self.pickView selectedRowInComponent:1] + 1)]]);
                self.hidden = YES;
            }
                break;
                
            case ZFJDatePickerViewStyleYMDhm:
            {
                NSInteger year = ([self.pickView selectedRowInComponent:0] + 2015);
                NSString * month = ([self.pickView selectedRowInComponent:1] + 1) < 10 ? [NSString stringWithFormat:@"0%ld", ([self.pickView selectedRowInComponent:1] + 1)] : [NSString stringWithFormat:@"%ld", ([self.pickView selectedRowInComponent:1] + 1)];
                NSInteger day = [self.pickView selectedRowInComponent:2]+1;
                NSInteger hour = [self.pickView selectedRowInComponent:3];
                //([self.pickView selectedRowInComponent:3] < 10 ? [NSString stringWithFormat:@"0%ld", [self.pickView selectedRowInComponent:3]]: [NSString stringWithFormat:@"%ld", [self.pickView selectedRowInComponent:3]]);
                self.dateStr([NSString stringWithFormat:@"%ld-%@-%ld %ld:00:00", year, month, day, hour]);
                self.hidden = YES;
            }
                break;
            default:
                break;
        }
    }
}

- (void)chooseConfirmBut:(ZFJDatePickerDateStr)dateStr {
    self.dateStr = dateStr;
}
- (void)chooseCancelBut:(ZFJChooseCanceBut)canceBut {
    self.canceBut = canceBut;
}
@end
