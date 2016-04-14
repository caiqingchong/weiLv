//
//  ZFJTicketReserveView.m
//  WelLv
//
//  Created by 张发杰 on 15/8/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJTicketReserveView.h"
#import "ZFJSecondView.h"
#import "TicketListModel.h"
#import "ZFJInforView.h"

#define M_TICKET_HEIGHT 61

@interface ZFJTicketReserveView ()

@property (nonatomic, strong) NSArray * ticketArr;

@end

@implementation ZFJTicketReserveView

- (id)initWithFrame:(CGRect)frame withTicketArray:(NSArray *)ticketArr {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.ticketArr = ticketArr;
        [self addCustomView];
    }
    return self;
}


- (void)addCustomView {
    for (int i = 0; i < self.ticketArr.count; i++) {
        ZFJSecondView * ticketView = [[ZFJSecondView alloc] initWithFrame:CGRectMake(0, M_TICKET_HEIGHT * i, windowContentWidth, M_TICKET_HEIGHT - 1)];
        ticketView.backgroundColor = [UIColor whiteColor];
        ticketView.tag = 100 + i;
        ticketView.reserveBut.tag = 1000 + i;
        TicketGoodsModel * goodsModel = [self.ticketArr objectAtIndex:i];
        ticketView.goodsModel = goodsModel;
        __weak ZFJTicketReserveView * view = self;
        [ticketView reserveTicket:^(UIButton *but) {
            view.tapReserveBut(but);
        }];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTicketView:)];
        [ticketView addGestureRecognizer:tap];
        [self addSubview:ticketView];
        
        NSString *html = goodsModel.other_info;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
       // NSLog(@"%@", goodsModel.ticket_type);
        
        
        NSString * str = @"";
        if (goodsModel.ticket_type) {
            //门票类型
            str = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:13px;>门票类型:%@</span></p>", str, [goodsModel.ticket_type stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"]];
        }
        //NSLog(@"**********\n%@\n********", goodsModel.ahead_hour);
        if (goodsModel.ahead_hour) {
            //提前预定时间
            //str = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:13px;>提前预定时间:%@</span></p>", str, [[[dict objectForKey:@"notice"] objectForKey:@"getTicketTime"] stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"]];
            // 退票申请提前时间
            NSInteger time = [goodsModel.ahead_hour floatValue];
             NSString * aheadHourStr = @"";
            if (time >= 0) {
                NSInteger hours = 24  - time / 60;
                NSInteger minute = (time % 60) / 60;
                if (minute == 0) {
                    aheadHourStr = [NSString stringWithFormat:@"游玩前一天%ld:00之前", hours];
                } else if (10>minute >0) {
                    aheadHourStr = [NSString stringWithFormat:@"游玩前一天%ld:0%ld之前", hours, minute];

                } else {
                    aheadHourStr = [NSString stringWithFormat:@"游玩前一天%ld:%ld之前", hours, minute];

                }
                
            } else if (time < 0) {
                time = [[goodsModel.ahead_hour stringByReplacingOccurrencesOfString:@"-" withString:@""] floatValue];
                
                NSInteger hours = time / 60;
                NSInteger minute = (time % 60) / 60;
                if (minute == 0) {
                    aheadHourStr = [NSString stringWithFormat:@"游玩当天%ld:00之前", hours];
                } else if (10>minute >0) {
                    aheadHourStr = [NSString stringWithFormat:@"游玩当天%ld:0%ld之前", hours, minute];
                    
                } else {
                    aheadHourStr = [NSString stringWithFormat:@"游玩当天%ld:%ld之前", hours, minute];
                    
                }

            } else {
                aheadHourStr = @"待定";
            }
            
           
            str = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:13px;>退票申请提前时间:%@</span></p>", str, aheadHourStr];
        }
        
        if ([[dict objectForKey:@"notice"] objectForKey:@"ways"]) {
            //入园方式
            str = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:13px;>入园方式:%@</span></p>", str, [[[dict objectForKey:@"notice"] objectForKey:@"ways"] stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"]];

        }
        
        if ([[dict objectForKey:@"notice"] objectForKey:@"effectiveDesc"]) {
            //门票有效期
            str = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:13px;>门票有效期:%@</span></p>", str, [[[dict objectForKey:@"notice"] objectForKey:@"effectiveDesc"] stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"]];

        }
        
        if ([dict objectForKey:@"importentPoint"]) {
            //其他说明
            str = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:13px;>其他说明:%@</span></p>", str, [[dict objectForKey:@"importentPoint"] stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"]];

        }
        
        if ([[dict objectForKey:@"notice"] objectForKey:@"getTicketPlace"]) {
            //取票地点
            str = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:13px;>取票地点:%@</span></p>", str, [[[dict objectForKey:@"notice"] objectForKey:@"getTicketPlace"] stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"]];

        }
        
        ZFJInforView * inforView = [[ZFJInforView alloc] initWithFrame:CGRectMake(0, ViewBelow(ticketView), windowContentWidth, 0) withInforSte:str];
        inforView.tag = 200 + i;
        inforView.hidden = YES;
        [self addSubview:inforView];
       
    }
    
}

- (void)tapTicketView:(UITapGestureRecognizer *)tap {
    //NSLog(@"点击点击");
    UIView * tempInforView = [self viewWithTag:tap.view.tag + 100];
    if (tempInforView.hidden == YES) {
        tempInforView.hidden = NO;
        ZFJSecondView * view = (ZFJSecondView *)tap.view;
        view.onAndOffIcon.image = [UIImage imageNamed:@"矩形-3"];
        view.onAndOffIcon.transform = CGAffineTransformMakeRotation(-M_PI  * 3/ 4);

        for (long i = tap.view.tag - 100; i < self.ticketArr.count; i++) {
            UIView * tempView = [self viewWithTag:100 + i + 1];
            UIView * inforTempView = [self viewWithTag:200 + i + 1];
            tempView.frame = CGRectMake(0, ViewY(tempView) + ViewHeight(tempInforView), ViewWidth(tempView), ViewHeight(tempView));
            inforTempView.frame = CGRectMake(0, ViewY(inforTempView) + ViewHeight(tempInforView), ViewWidth(inforTempView), ViewHeight(inforTempView));
        }
        self.onAndOffInforView(ViewHeight([self viewWithTag:tap.view.tag + 100]));
    } else if (tempInforView.hidden == NO) {
        tempInforView.hidden = YES;
        ZFJSecondView * view = (ZFJSecondView *)tap.view;
        view.onAndOffIcon.image = [UIImage imageNamed:@"矩形-3-副本-2"];
        view.onAndOffIcon.transform = CGAffineTransformMakeRotation(M_PI_4);

        for (long i = tap.view.tag - 100; i < self.ticketArr.count; i++) {
            UIView * tempView = [self viewWithTag:100 + i + 1];
            tempView.frame = CGRectMake(0, ViewY(tempView) - ViewHeight(tempInforView), ViewWidth(tempView), ViewHeight(tempView));
            UIView * inforTempView = [self viewWithTag:200 + i + 1];
            inforTempView.frame = CGRectMake(0, ViewY(inforTempView) - ViewHeight(tempInforView), ViewWidth(inforTempView), ViewHeight(inforTempView));

        }
        self.onAndOffInforView(-ViewHeight(tempInforView));
    }
}

- (void)reserveTicket:(TapReserveBut)reserveBut
{
    self.tapReserveBut = reserveBut;
}
- (void)returnInforViewHeight:(OnAndOffInforView)inforViewHeight
{
    self.onAndOffInforView = inforViewHeight;
}
@end
