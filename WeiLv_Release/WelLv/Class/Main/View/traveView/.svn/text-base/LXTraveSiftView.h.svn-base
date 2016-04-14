//
//  LXTraveSiftView.h
//  WelLv
//
//  Created by lx on 15/8/4.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    isShow,//展开
    isCloose,//关闭
    Reload//刷新列表
}TableState;

/**
 *  综合返回的内容
 */
typedef void (^compositeBlock) (NSString *compositeInfo);

/**
 *  返回筛选条件
 */
typedef void (^siftInfoBlock) (NSString *priceBlock,NSString *dayBlock,NSString *destinationBlock);

@interface LXTraveSiftView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIWindow *_window;
    UIView *_maskView;
    UIView *_resetView;//重置按钮和确定按钮
    
    UITableView *_compositeTable;//综合列表
    UITableView *_leftSiftTable;//筛选类型列表
    UITableView *_priceTable;
    UITableView *_daysTable;
    UITableView *_destinationTable;
    
    NSMutableArray *_compositeInfoArray;
    NSMutableArray *_compositeImageArray;
    NSMutableArray *_siftNameArray;
    NSMutableArray *_leftSiftTableArray;
    NSMutableArray *_leftSiftImageArray;
    NSInteger _traveType;
    
    NSInteger _selectSiftType;//左边选中的筛选类型 1价格 2行程 3目的地
    NSIndexPath *_priceTabLastPath;//价格上一次选中的cell
    NSIndexPath *_dayTabLastPath;//日程上一次选中的cell
    NSIndexPath *_destinationTableLastPath;//目的地上一次选中的cell
    NSIndexPath *_currentPath;
    
    NSString *_selectPrice;
    NSString *_selectDays;
    NSString *_selectDestination;
    
    NSMutableArray *_priceArray;
    NSMutableArray *_daysArray;
    NSMutableArray *_destinationArray;
    
}

@property (nonatomic,assign) TableState tableState;
@property (nonatomic,strong) compositeBlock compositeInfo;
@property (nonatomic,strong) siftInfoBlock siftccInfoBlock;


-(id)initWithFrame:(CGRect)frame traveType:(NSInteger)traveTpye;
-(void)returnCompositeBlock:(compositeBlock)CompositeBlock infoBlock:(siftInfoBlock)infoBlock;
-(void)All_Hidden_Yes;

@end
