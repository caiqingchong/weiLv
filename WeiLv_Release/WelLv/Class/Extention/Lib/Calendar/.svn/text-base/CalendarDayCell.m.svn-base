//
//  CalendarDayCell.m
//  tttttt
//
//  Created by 张凡 on 14-8-20.
//  Copyright (c) 2014年 张凡. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "CalendarDayCell.h"

@implementation CalendarDayCell

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
    imgview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 25, self.bounds.size.width-5, self.bounds.size.width-5)];
    imgview.image = [UIImage imageNamed:@"chack.png"];
    [self addSubview:imgview];
    
    //日期
    day_lab = [[UILabel alloc]initWithFrame:CGRectMake(2, 17, self.bounds.size.width, self.bounds.size.width-10)];
    day_lab.textAlignment = NSTextAlignmentCenter;
    day_lab.font = [UIFont systemFontOfSize:14];
    [self addSubview:day_lab];

    //农历
    day_title = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 13)];
    day_title.textColor = [UIColor orangeColor];
    day_title.font = [UIFont boldSystemFontOfSize:9];
    day_title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:day_title];
    

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
            day_title.hidden=YES;
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
            day_title.hidden=YES;
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
                day_title.hidden=YES;
            }
            else if ([model.price intValue] == -2)
            {
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [UIColor blackColor];
                day_title.hidden=YES;
            }else
            {
                
                //NSLog(@"将来的日期==%d",model.price);
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = COLOR_THEME;
                day_title.text = model.price;
            }
           
            
            
            imgview.hidden = YES;
            break;
            
        case CellDayTypeWeek://周末
            [self hidden_NO];
            
            if ( [[self getTodayModel] isEqualTo:model]) {
                
                //self.userInteractionEnabled=NO;
                day_lab.text = @"今天";
                day_lab.textColor = [UIColor blackColor];
                day_title.hidden=YES;
                imgview.hidden = YES;
            }
            else if ([model.price intValue] == -2)
            {
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [UIColor blackColor];
                day_title.hidden=YES;
            }else if (model.holiday)
            {
                
                
                day_lab.text = model.holiday;
                day_lab.textColor = [UIColor orangeColor];
                day_title.text = model.price;
                
            }
            else{
                
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = COLOR_THEME1;
                day_title.text = model.price;
                
            }
            
            imgview.hidden = YES;
            break;
            
        case CellDayTypeClick://被点击的日期
            [self hidden_NO];
            
            
            if (model.price)
            {
                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
                day_lab.textColor = [UIColor whiteColor];
                NSLog(@"被点击的日期");
                day_title.text = model.price;
                imgview.hidden = NO;
            }
//            }else
//            {
//                day_lab.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.day];
//                day_lab.textColor = [UIColor blackColor];
//                NSLog(@"被点击的日期");
//                day_title.hidden=YES;
//                imgview.hidden = YES;
//               // day_title.text = model.price;
//            }
          
            break;
            
        default:
            
            break;
    }


}



- (void)hidden_YES{
    
    day_lab.hidden = YES;
    day_title.hidden = YES;
    imgview.hidden = YES;
    
}


- (void)hidden_NO{
    
    day_lab.hidden = NO;
    day_title.hidden = NO;
    
}


@end
