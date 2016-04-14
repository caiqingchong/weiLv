//
//  DateView.m
//  Sungrnw
//
//  Created by a on 15-2-4.
//  Copyright (c) 2015年 DSsy. All rights reserved.
//

#import "DateView.h"

@implementation DateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}
-(void)makeUI
{
    dataView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width,220 )];
    dataView.backgroundColor=[UIColor whiteColor];
    [self addSubview:dataView];
    if (!datePick) {
        datePick=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 180)];
        //日期模式
        [datePick setDatePickerMode:UIDatePickerModeDate];
        NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:@"Chinese"];
        [datePick setLocale:locale];
        [dataView addSubview:datePick];
    }
    //datePick.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    
    NSString *minDateString = @"1900-01-01";
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
   // dateFormater.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    [dateFormater setDateFormat:@"yyyy-MM-DD"];
    NSDate *minCurrentDate = [dateFormater dateFromString: minDateString];
    NSDate *maxCurrentDate = [NSDate date];
    NSLog(@"%@\n%@",minCurrentDate,maxCurrentDate);
    datePick.minimumDate = minCurrentDate; datePick.maximumDate = maxCurrentDate;
    
    
    UIButton *succbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    succbutton.frame=CGRectMake((self.frame.size.width-240)/2, 190, 100, 20);
    [succbutton setTitle:@"确定" forState:UIControlStateNormal];
    [succbutton addTarget:self action:@selector(succButtonClick) forControlEvents:UIControlEventTouchUpInside];
    succbutton.backgroundColor=[UIColor colorWithRed:0.05 green:0.45 blue:0.76 alpha:1];
    succbutton.layer.masksToBounds=YES;
    succbutton.layer.cornerRadius=6;
    succbutton.titleLabel.textColor=[UIColor whiteColor];
    [dataView addSubview:succbutton];
    
    UIButton *queButton=[UIButton buttonWithType:UIButtonTypeCustom];
    queButton.frame=CGRectMake(succbutton.frame.origin.x+140, 190, 100, 20);
    [queButton setTitle:@"取消" forState:UIControlStateNormal];
    [queButton addTarget:self action:@selector(QueButtonClick) forControlEvents:UIControlEventTouchUpInside];
    queButton.backgroundColor=[UIColor colorWithRed:0.05 green:0.45 blue:0.76 alpha:1];
    [queButton setBackgroundImage:[UIImage imageNamed:@"ss_normal"] forState:UIControlStateNormal];
    [queButton setBackgroundImage:[UIImage imageNamed:@"ss_pressed"] forState:UIControlStateHighlighted];
    queButton.layer.masksToBounds=YES;
    queButton.layer.cornerRadius=6;
    queButton.titleLabel.textColor=[UIColor whiteColor];
    [dataView addSubview:queButton];
}
-(void)succButtonClick
{
    NSDateFormatter *formatter_minDate =[[NSDateFormatter alloc] init];
    [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
    NSDate *senddate = [datePick date];
    dataText=[formatter_minDate stringFromDate:senddate];
    [self.g_delegate sendDateToSup:dataText];
    [datePick removeFromSuperview];
    datePick=nil;
    [dataView removeFromSuperview];
    [self removeFromSuperview];
}
-(void)QueButtonClick
{
    [datePick removeFromSuperview];
    datePick=nil;
    [dataView removeFromSuperview];
    [self removeFromSuperview];
}


@end
