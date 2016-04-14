//
//  ShipCalendarDayCell.m
//  WelLv
//
//  Created by 刘鑫 on 15/5/22.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ShipCalendarDayCell.h"

@implementation ShipCalendarDayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    
    //选中时显示的图片
    //    imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 25, self.bounds.size.width-5, self.bounds.size.width-5)];
    //    imgview.image = [UIImage imageNamed:@"chack.png"];
    //    [self addSubview:imgview];
    
    shipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 38, 24, 14)];
    shipImageView.image = [UIImage imageNamed:@"icon_cruise_b_blue"];
    shipImageView.hidden=YES;
    [self addSubview:shipImageView];
    
    //日期
    self.day_lab = [[UILabel alloc]initWithFrame:CGRectMake(2, 10, self.bounds.size.width, self.bounds.size.height-20)];
    self.day_lab.textAlignment = NSTextAlignmentCenter;
    self.day_lab.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.day_lab];
    
    _todayView=[[UIView alloc] init];
    _todayView.backgroundColor=kColor(57, 246, 177);
    _todayView.center= self.day_lab.center;
    _todayView.bounds=CGRectMake(0, 0, ViewWidth(self)-10, ViewWidth(self)-10);
    _todayView.layer.cornerRadius=(ViewWidth(self)-10)/2;
    _todayView.hidden=YES;
    [self addSubview:_todayView];
    [self sendSubviewToBack:_todayView];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self)-0.5, ViewWidth(self), 0.5)];
    _lineView.backgroundColor=TableLineColor;
    [self addSubview:_lineView];
    
    
    
//    //农历
//    day_title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 13)];
//    day_title.textColor = [UIColor orangeColor];
//    day_title.font = [UIFont boldSystemFontOfSize:11];
//    day_title.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:day_title];
    
    
}

#pragma mark--今天的日期
-(CalendarDayModel *)getTodayModel
{
    NSDate *todate = [NSDate date];//今天
    //    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    //    NSDateComponents *comps_today= [calendar components:(NSYearCalendarUnit |
    //                                                         NSMonthCalendarUnit |
    //                                                         NSDayCalendarUnit |
    //                                                         NSWeekdayCalendarUnit) fromDate:todate];
    
    NSString *date=[todate stringFromDate:todate];
    NSArray *array = [date componentsSeparatedByString:@"-"];
    
    CalendarDayModel *model=[[CalendarDayModel alloc] init];
    model.year=[[array objectAtIndex:0] integerValue];
    model.month=[[array objectAtIndex:1] integerValue];
    model.day=[[array objectAtIndex:2] integerValue];
    
    return model;
}


- (void)setModel:(CalendarDayModel *)model
{
    
    
    switch (model.style) {
            
        case CellDatTypeCannotClick:
            DLog(@"11111&&&&&&&&===%lu,%lu",(unsigned long)model.month,model.day);

            [self hidden_NO];
            
            if ([[self getTodayModel] isEqualTo:model]) {
                self.day_lab.text=@"今天";
                self.day_lab.textColor=[UIColor whiteColor];
                _todayView.hidden=NO;
               // DLog(@"11111&&&&&&&&===%lu,%lu",(unsigned long)model.month,model.day);
            }else
            {
                self.day_lab.text=[NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                _todayView.hidden=YES;
            }
            shipImageView.hidden=YES;
            imgview.hidden=YES;
            day_title.hidden=YES;
            break;
            
        case CellDayTypeEmpty://不显示
            
            [self hidden_YES];
            _todayView.hidden=YES;
            break;
            
        case CellDayTypePast://过去的日期
            [self hidden_NO];
            
            if (model.holiday) {
                self.day_lab.text = model.holiday;
            }else{
                self.day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            }
            DLog(@"11111&&&&&&&&===%lu,%lu",(unsigned long)model.month,model.day);

            self.day_lab.textColor = [UIColor grayColor];
            day_title.hidden=YES;
            imgview.hidden = YES;
            shipImageView.hidden=YES;
            _todayView.hidden=YES;
            break;
            
        case CellDayTypeFutur://将来的日期（包括当天）
            
            [self hidden_NO];
            //            if (model.holiday) {
            //                day_lab.text = model.holiday;
            //                day_lab.textColor = [UIColor orangeColor];
            //            }else{
            //                day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            //                day_lab.textColor = COLOR_THEME;
            //            }
            
            if ([[self getTodayModel] isEqualTo:model])
            {
                DLog(@"&&&&&&&&===%lu,%lu",(unsigned long)model.month,model.day);
                //self.userInteractionEnabled=NO;
                self.day_lab.text = @"今天";
                self.day_lab.textColor = [UIColor whiteColor];
                day_title.hidden=YES;
                shipImageView.hidden=YES;
                _todayView.hidden=NO;
                
            }
            else if ([model.price intValue] == -2)
            {
                
                self.day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                self.day_lab.textColor = [UIColor blackColor];
                day_title.hidden=YES;
                shipImageView.hidden=YES;
                _todayView.hidden=YES;
            }
            else
            {
                
                //NSLog(@"将来的日期==%@",model.price);
                self.day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                //day_lab.textColor = COLOR_THEME;
                self.day_lab.textColor = [UIColor blackColor];
                day_title.text = model.price;
                shipImageView.hidden=NO;
                _todayView.hidden=YES;
            }
            
            
            
            imgview.hidden = YES;
            break;
            
        case CellDayTypeWeek://周末
            [self hidden_NO];
            
            if ( [[self getTodayModel] isEqualTo:model]) {
                
                //self.userInteractionEnabled=NO;
                self.day_lab.text = @"今天";
                self.day_lab.textColor = [UIColor whiteColor];
                _todayView.hidden=NO;
                day_title.hidden=YES;
                imgview.hidden = YES;
                shipImageView.hidden=YES;
            }
            else if ([model.price intValue] == -2)
            {
                self.day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                self.day_lab.textColor = [UIColor blackColor];
                day_title.hidden=YES;
                shipImageView.hidden=YES;
                _todayView.hidden=YES;
            }
            else if (model.holiday)
            {
                
                
                self.day_lab.text = model.holiday;
                self.day_lab.textColor = [UIColor orangeColor];
                self.day_lab.text = model.price;
                _todayView.hidden=YES;
                
            }
            else{
                
                self.day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                self.day_lab.textColor = COLOR_THEME1;
                day_title.text = model.price;
                shipImageView.hidden=NO;
                _todayView.hidden=YES;
            }
            
            imgview.hidden = YES;
            break;
            
        case CellDayTypeClick://被点击的日期
            [self hidden_NO];
            //            if (model.holiday) {
            //                day_lab.text = model.holiday;
            //                day_lab.textColor = [UIColor orangeColor];
            //            }else{
            //                day_lab.text = [NSString stringWithFormat:@"%d",model.day];
            //                day_lab.textColor = COLOR_THEME;
            //            }
            
            if ([[self getTodayModel] isEqualTo:model])
            {
                //self.userInteractionEnabled=NO;
                self.day_lab.text = @"今天";
                self.day_lab.textColor=[UIColor whiteColor];
                _todayView.hidden=NO;
                day_title.hidden=YES;
                shipImageView.hidden=YES;
            }
            else if ([model.price intValue] == -2)
            {
                
                self.day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                self.day_lab.textColor = [UIColor blackColor];
                day_title.hidden=YES;
                shipImageView.hidden=YES;
                _todayView.hidden=YES;
            }
            else
            {
                
                //NSLog(@"将来的日期==%@",model.price);
                self.day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                //day_lab.textColor = COLOR_THEME;
                self.day_lab.textColor = [UIColor blackColor];
                day_title.text = model.price;
                shipImageView.hidden=NO;
                _todayView.hidden=YES;
            }
            
            
            
            imgview.hidden = YES;
            
            break;
            
        default:
            
            break;
    }
    
    
}



- (void)hidden_YES{
    
    self.day_lab.hidden = YES;
    day_title.hidden = YES;
    imgview.hidden = YES;
    shipImageView.hidden=YES;
}


- (void)hidden_NO{
    
    self.day_lab.hidden = NO;
    day_title.hidden = NO;
    
}


@end
