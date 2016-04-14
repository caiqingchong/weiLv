//
//  HotelSortControl.h
//  CreateControl
//
//  Created by James on 15/11/25.
//  Copyright © 2015年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HotelSortControlDelegatge

@optional

//回调函数
-(void)resultSortDelegate:(NSString *)resultValue;

@end

@interface HotelSortControl : UIView<UITableViewDataSource,UITableViewDelegate>{
    UITableView *sortTableView;
    UIButton *btnSelect1;
    UIImage *filterUnSelect;
    UIImage *filterSelect;
    NSDictionary *Dict;
    int indexValue;
}
//背景视图
@property(nonatomic,strong)UIView *backgroundView;
//公共存储变量
@property(nonatomic,strong)NSString *pubString;
//代理
@property(retain,nonatomic)id<HotelSortControlDelegatge>delegate;
//初始化-复制方法
-(void)initWithSortValue:(NSString *)value;
@end
