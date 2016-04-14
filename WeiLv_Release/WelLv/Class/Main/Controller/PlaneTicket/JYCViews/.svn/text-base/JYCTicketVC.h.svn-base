//
//  JYCTicketVC.h
//  WelLv
//
//  Created by lyx on 15/9/8.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#define ControllerViewHeight              ([[UIScreen mainScreen] bounds].size.height - [[UIApplication sharedApplication] statusBarFrame].size.height - self.navigationController.navigationBar.frame.size.height)
@interface JYCTicketVC : XCSuperObjectViewController
{
    NSString *_startCity;
    NSString *_endfCity;
    NSString *_startTime;
    NSString *_backTime;
    BOOL _isSingle;
}
@property(nonatomic,copy)NSString *startCity;
@property(nonatomic,copy)NSString *endCity;
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *backTime;
@property(assign)BOOL isSingle;
@property(nonatomic,copy)NSString *singleWeek;//接收首页传过来的字符串日期
@property(nonatomic,copy)NSString *backWeek;//接收首页传过来的字符串日期 如果有返回的事后
@property(assign)NSUInteger receiveWeek;//接收首页传过来的NSUInteger型的星期
@property(assign)NSUInteger backReceiveWeek;//接收首页传过来的NSUInteger型的星期 返回的时候

-(void)loadDataWith:(NSString *)url;
@end
