//
//  ZFJHotelListLocationFilterVC.h
//  WelLv
//
//  Created by WeiLv on 15/10/8.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonModel.h"
#import "LocationModel.h"

@protocol ZFJHotelListLocationFilterVCDelegate

@optional
-(void)resultLocationValue:(NSString *)resultValue;

@end

@interface ZFJHotelListLocationFilterVC : XCSuperObjectViewController<UITableViewDataSource, UITableViewDelegate>
{
    int firstRowCount;
    int secondRowCount;
    int thirdRowCount;
    JsonModel *jsonModel;
    LocationModel *locModel;
    NSMutableArray *locArray;
    NSMutableArray *childrenArray;
    NSMutableArray *subChildrenArray;
    NSMutableDictionary *firstDict;
    NSMutableDictionary *secondDict;
    NSMutableDictionary *thirdDict;
    NSMutableDictionary *fourthDict;
    UIButton *iconFirst;
    UIButton *iconSecond;
    UIButton *iconThird;
    UIImage *iconSelect;
    UIImage *iconCircle;
    
}
@property (nonatomic,strong) NSString *firstSelectValue;
@property (nonatomic,strong) NSString *secondSelectValue;
@property (nonatomic,strong) NSString *thirdSelectValue;
@property (nonatomic, strong) UITableView * firstTableView;
@property (nonatomic, strong) UITableView * secondTableView;
@property (nonatomic,strong)  UITableView *thirdTableView;
@property (nonatomic, assign) NSInteger firstTableViewSelectRow;
@property (nonatomic, assign) NSInteger secondTableViewSelectRow;
@property (nonatomic, assign) NSInteger thirdTableViewSelectRow;
@property (retain,nonatomic)id<ZFJHotelListLocationFilterVCDelegate>delegate;
@property (nonatomic,strong)NSMutableDictionary *pubDict;
@property (nonatomic,strong) NSString *pubLocValue;
@property (nonatomic,strong)NSArray *pubLocArray;
-(void)initLocation:(NSString *)value;

@end
