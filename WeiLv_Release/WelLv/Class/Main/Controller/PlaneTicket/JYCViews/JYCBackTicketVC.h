//
//  JYCBackTicketVC.h
//  WelLv
//
//  Created by lyx on 15/9/12.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#define ControllerViewHeight              ([[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.navigationController.navigationBar.frame.size.height)
#import "cablistModel.h"
@interface JYCBackTicketVC : XCSuperObjectViewController
{
    NSString *_startCity;
    NSString *_endfCity;
    NSString *_startTime;
    NSString *_backTime;
    NSString *_backUrl;
    NSString *_backTittle;
}
@property(nonatomic,copy)NSString *startCity;
@property(nonatomic,copy)NSString *endCity;
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *backTime;
@property(nonatomic,copy)NSString *backUrl;
@property(nonatomic,copy)NSString *backTittle;
@property(nonatomic,strong)NSMutableArray *receiveArr;//接收去时的model
@property(nonatomic,copy)NSString *backWeek;//接收首页传过来的字符串日期 如果有返回的事后
@property(assign)NSUInteger backReceiveWeek;//接收首页传过来的NSUInteger型的星期 返回的时候
-(void)loadDataWith:(NSString *)url;
@end
