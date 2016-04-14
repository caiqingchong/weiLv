//
//  LXTopSiftView.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/21.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    isShow,//展开
    isCloose,//关闭
    Reload//刷新列表
}TableState;

typedef void (^siftTypeBlock)(NSString * siftTypeID);//返回筛选内容
typedef void (^siftInfoBlock)(NSString *siftInfoID,NSString *days);//返回筛选价格
//typedef void (^siftDayBlock)(NSString *days);//返回筛选天数

@interface LXTopSiftView : UIView
<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_siftNameArray;
    NSMutableArray *_siftInfoArray;
    
    UIView *_maskView;
    BOOL _maskIsShow;
    int _selectBtnID;//选择的按钮
    int _lastBtnID;
    NSInteger _selectPrice;//选择的价格
    NSInteger _selectDays;//选择的出行天数
    NSInteger _selectPriceAndDay;//1选中价格区间，2选择行程天数
    
    UITableView *_contentTable;
    UITableView *_mudidiLeftTable;
    UITableView *_priceTable;
    UITableView *_daysTable;
    //UIView *_destinationView;//目的地view
    NSInteger _mudidiType;//目的地的类型1(周边，港澳台)，2（国内）,3(出境，境外参团),4(一日游)
    NSArray *_mudidiLeftArray;//目的地左侧的一级分类
    
    NSIndexPath *_lastIndexPath;
    NSIndexPath *_leftLastIndexPath;
    NSIndexPath *_priceIndexPath;
    NSIndexPath *_dayIndexPath;
    
    NSMutableArray *_contentMudidiArray;//二级目的地
    
    NSArray *_priceAndDaysLeftArray;
    NSMutableArray *_priceAndDaysArray;//价格和日期
    
    //UIView *_priceAndDaysView;//筛选价格和日程view
    UIWindow *_window;
    
    UIButton *_resetBtn;//重置按钮
    UIButton *_affirmBtn;//确定按钮
    UIView *_resetView;
   // NSArray *_hotArray;//热门目的地
    
//    //-------国内游二级目的地-----
//    NSArray *_dongbeiArray;
//    NSArray *_huabeiArray;
//    NSArray *_huazhongArray;
//    NSArray *_huadongArray;
//    NSArray *_huananArray;
//    NSArray *_xinanArray;//西南
//    NSArray *_xibeirray;
//    
//    //-------出境二级目的地-----
//    NSArray *_dongnanyaArray;
//    NSArray *_haidaoArray;
//    NSArray *_rihanArray;
//    NSArray *_ouzhouArray;
//    NSArray *_meizhouArray;
//    NSArray *_zhongdongfeiArray;
//    NSArray *_dayangzhouArray;

    
}
@property (nonatomic, strong)siftTypeBlock typeBlock;
@property (nonatomic, strong)siftInfoBlock infoBlock;
//@property (nonatomic, strong)siftDayBlock dayBlock;

@property (nonatomic,assign) TableState tableState;


-(id)initWithFrame:(CGRect)frame nameArray:(NSMutableArray *)siftNameArray InfoArray:(NSMutableArray *)siftInfoArray mudidiType:(NSInteger)mudidiType;
-(void)returnSifyIDBlock:(siftTypeBlock)typeBlock infoBlock:(siftInfoBlock)infoBlock;
-(void)tapMask;

//- (id)initWithFrame:(CGRect)frame
//          nameArray:(NSMutableArray *)siftNameArray//筛选类型
//          InfoArray:(NSMutableArray *)siftInfoArray//筛选具体条件
//     selectSiftType:(int (^)(int typeId))typeID
//     selectSiftInfo:(int (^)(int selectInfoID))infoID;
@end
