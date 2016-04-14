//
//  YXShipOrderView.h
//  WelLv
//
//  Created by lyx on 15/7/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXShipCabinCell.h"

@class ZFJShoreTraveModel;
@class YXShipOrderView;

@protocol YXShipOrderViewDelegate <NSObject>

- (void)changeShipViewFrame:(YXShipOrderView *)orderView;

- (void)totalPriceData:(NSMutableArray *)allData price:(float)total num:(int)number;
- (void)totalPriceData:(NSMutableArray *)allData price:(float)total adultNum:(int)adultNum childNum:(int)childNum;

- (void)totalPriceDataDic:(NSMutableDictionary *)dataDic totalPrice:(float)totalPrice adultNum:(int)adultNum childNum:(int)childNum;

- (void)totalChooseDataDic:(NSMutableDictionary *)dataDic;

- (void)totalChooseDataDic:(NSMutableDictionary *)dataDic shoreTraveLine:(ZFJShoreTraveModel *)shoreTraveModel;
@end

@interface YXShipOrderView : UIView<UITableViewDataSource,UITableViewDelegate,YXShipCabinCellDelegate>
{
    UITableView *_shipTableView;
}

@property (nonatomic,strong) UITableView *shipTableView;
@property (nonatomic,strong) NSMutableArray *lowestPrice;     //最低价格数组
@property (nonatomic,strong) NSArray *keys;                  //type_id
@property (nonatomic,strong) NSArray *AllData;              //按照舱位归类后的数据
@property (nonatomic) NSInteger buttonIndex;      //用于区分每个房型的cell   并且用于区分选择的房型
@property (nonatomic,strong) NSArray *cabinArr;       //仓位数组;
@property (nonatomic,strong)  NSMutableArray *buttonArr;   //仓房标题button数组


@property (nonatomic,strong) NSDictionary *selectDic;     //挑选的房型字典
@property (nonatomic,strong) NSString *totalNumber;       //总人数
@property (nonatomic,strong) NSMutableArray *selectedCabin;   //挑选的所有房型
@property (nonatomic,strong) NSMutableArray *totalData;         //挑选的所有房型数据，包含人数和价格
@property (nonatomic,strong) NSArray *shoreTrave;   //岸上观光数组;


@property (nonatomic,weak)id <YXShipOrderViewDelegate>delegate;


- (id)initWithFrame:(CGRect)frame initWithKeys:(NSArray *)kes lowest:(NSMutableArray *)price all:(NSArray *)data cabin:(NSArray *)Arr index:(NSInteger)button shoreTraveLineArr:(NSArray *)shoreTraveLineArr;

- (id)initWithFrame:(CGRect)frame withRoomTypeArr:(NSArray *)roomTypeArr minPriceArr:(NSMutableArray *)minPriceArr roomsDic:(NSDictionary *)roomsDic chooseRoomType:(NSString *)chooseType shoreTraveLineArr:(NSArray *)shoreTraveLineArr;


@end

