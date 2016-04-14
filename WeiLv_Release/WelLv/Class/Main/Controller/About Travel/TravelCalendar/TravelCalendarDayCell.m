//
//  TravelCalendarDayCell.m
//  WelLv
//
//  Created by 张子乾 on 16/2/16.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "TravelCalendarDayCell.h"

#import "TravelAllHeader.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation TravelCalendarDayCell

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
    imgview = [[UIImageView alloc]init];
  
        imgview.frame = CGRectMake(0, 18, self.bounds.size.width, self.bounds.size.width);

    //    imgview.image = [UIImage imageNamed:@"chack.png"];
    imgview.backgroundColor = UIColorFromRGB(0x70d480);
    [self addSubview:imgview];
    
    //日期
    day_lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 17, self.bounds.size.width, self.bounds.size.width-10)];
    day_lab.textAlignment = NSTextAlignmentCenter;
    day_lab.font = [UIFont systemFontOfSize:14];
    [self addSubview:day_lab];
    
    //农历
    _day_title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 13)];
//    _day_title.textColor = [UIColor orangeColor];
    _day_title.font = [UIFont boldSystemFontOfSize:11];
    _day_title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_day_title];
    
    
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
            
            [self hidden_NO];
            
            if ([[self getTodayModel] isEqualTo:model]) {
                day_lab.text=@"今天";
            }else
            {
                day_lab.text=[NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            }
            
            imgview.hidden=YES;
            _day_title.hidden=YES;
            break;
            
        case CellDayTypeEmpty://不显示
            
            [self hidden_YES];
            break;
            
        case CellDayTypePast://过去的日期
            [self hidden_NO];
            
            if (model.holiday) {
                day_lab.text = model.holiday;
            }else{
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
            }
            
            day_lab.textColor = [UIColor lightGrayColor];
            _day_title.hidden=YES;
            imgview.hidden = YES;
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
                //self.userInteractionEnabled=NO;
                day_lab.text = @"今天";
                day_lab.textColor = [UIColor blackColor];
                _day_title.hidden=YES;
            }
            else if ([model.price intValue] == -2)
            {
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [UIColor blackColor];
                _day_title.hidden=YES;
            }
            else
            {
                
                //NSLog(@"将来的日期==%d",model.price);
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [UIColor blackColor];
                _day_title.text = model.price;
                _day_title.textColor = [UIColor orangeColor];
            }
            
            imgview.hidden = YES;
            break;
            
        case CellDayTypeWeek://周末
            [self hidden_NO];
            
            if ( [[self getTodayModel] isEqualTo:model]) {
                
                //self.userInteractionEnabled=NO;
                day_lab.text = @"今天";
                day_lab.textColor = [UIColor blackColor];
                _day_title.hidden=YES;
                imgview.hidden = YES;
            }
            else if ([model.price intValue] == -2)
            {
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [UIColor blackColor];
                _day_title.hidden=YES;
            }
            else if (model.holiday)
            {
                
                
                day_lab.text = model.holiday;
                day_lab.textColor = [UIColor orangeColor];
                _day_title.text = model.price;
                
            }
            else{
                
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [UIColor blackColor];
                _day_title.text = model.price;
                _day_title.textColor = [UIColor orangeColor];
                
            }
            
            imgview.hidden = YES;
            
            break;
            
        case CellDayTypeClick://被点击的日期
            [self hidden_NO];
            
            
            if (model.price)
            {
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [UIColor whiteColor];
//                NSLog(@"被点击的日期");
                _day_title.text = model.price;
                _day_title.textColor = [UIColor whiteColor];

            }
            imgview.hidden = NO;
//            _day_title.textColor = [UIColor whiteColor];
            break;
            
        default:
            
            break;
    }
    
    if (UISCREEN_HEIGHT < 569) {
        _day_title.font = [UIFont systemFontOfSize:9];
    } else if (UISCREEN_HEIGHT == 667) {
        _day_title.font = [UIFont systemFontOfSize:11];
    } else if (UISCREEN_HEIGHT == 736) {
        _day_title.font = [UIFont systemFontOfSize:12];
    }
    _day_title.textAlignment = NSTextAlignmentCenter;
    
    
}



- (void)hidden_YES{
    
    day_lab.hidden = YES;
    _day_title.hidden = YES;
    imgview.hidden = YES;
    
}


- (void)hidden_NO{
    
    day_lab.hidden = NO;
    _day_title.hidden = NO;
    
}



@end
