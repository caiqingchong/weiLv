//
//  ShaixuanVc.h
//  Lvyou
//
//  Created by 赵冉 on 16/1/12.
//  Copyright © 2016年 赵冉. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol Shaixuandlegate <NSObject>
//回调函数
- (void)ReturnShaixuanstr:(NSMutableDictionary *)dict;

@end

@interface ShaixuanVc : UIView<UITableViewDataSource,UITableViewDelegate>

-(instancetype)initWithCityID:(NSString *)cityID andRouteType:(NSString *)routeType andDestination:(NSArray *)datasource;
//参数
@property(nonatomic,copy)NSString  *rote_ID;
@property (nonatomic,copy)NSString *city_id;


//背景视图
@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)UITableView * tablevc;
@property(nonatomic,strong)UIButton * topbutton;
@property(nonatomic,strong)UIButton * button;
@property(nonatomic,strong)UIButton * lowbutton;
@property(nonatomic,strong)UILabel * toplable;
@property(nonatomic,strong)UILabel * lable;
@property(nonatomic,strong)UILabel * lowlable;
@property(nonatomic,strong)NSMutableArray * datasource;//数据源
@property(nonatomic,strong)NSMutableArray * Daydata;//天数 数据源
@property(nonatomic,strong)NSMutableArray * Pricedata;//价格 数据源

@property(nonatomic,assign)NSInteger cellheight ;//每行高度
@property(nonatomic,assign)NSInteger buttonheight;//按钮高度
@property(nonatomic,copy)NSString * str; //点击每行传值

@property(nonatomic,copy)NSString * Destionstr; //目的地参数
@property(nonatomic,copy)NSString * Daystr; //行程参数
@property(nonatomic,copy)NSString * Pricestr; //价格参数

@property(nonatomic,copy)NSMutableDictionary * Mdit; //存放参数


@property(nonatomic,copy)NSMutableArray * DFarray; //记录点击是哪一行
@property(nonatomic,copy)NSMutableArray * Dayarray; //记录点击是哪一行
@property(nonatomic,copy)NSMutableArray * Pricearray; //记录点击是哪一行


//代理
@property(assign,nonatomic)id<Shaixuandlegate>delegate;

@end
