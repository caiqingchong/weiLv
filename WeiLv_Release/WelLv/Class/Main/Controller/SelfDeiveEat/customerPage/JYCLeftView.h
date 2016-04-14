//
//  JYCLeftView.h
//  WelLv
//
//  Created by lyx on 15/11/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "JYCorderDishesCell.h"
#import "RestauantModel.h"
@protocol clickBtndelegate <NSObject>

-(void)clickToPush:(NSMutableArray *)arr;
-(void)didSelectToPresent:(NSMutableDictionary *)dict;
@end
@interface JYCLeftView : UIView<UITableViewDataSource,UITableViewDelegate>

- (id)initWithFrame:(CGRect)frame with:(NSString *)shopId;;
@property (assign,nonatomic)id<clickBtndelegate>delegate;
@property(nonatomic,strong)NSMutableArray *leftArr;
@property(nonatomic,strong)NSMutableArray *rightArr;
@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UITableView *rightTableView;
@property(nonatomic,assign)int total;
@property(nonatomic,strong)NSMutableArray *chuArr;
@property(nonatomic,copy)NSString *shopId;
@end
