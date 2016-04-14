//
//  LXShipCalendarView.h
//  WelLv
//
//  Created by 刘鑫 on 15/5/21.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarLogic.h"
#import "XCSuperObjectViewController.h"

typedef void (^CalendarBlock)(NSUInteger productNumber);
typedef void (^CalendarBlockProduct_id)(NSString * product_id);
typedef void (^CalendarViewHeightBlock)(CGFloat calendarViewHeight);
@interface LXShipCalendarView : UIView
<UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate>
{
    
    int daynumber;//天数
    int optiondaynumber;//选择日期数量
    NSTimer* timer;//定时器
    int _price;
    CalendarDayModel *_getModel;
    UIView *_bottomView;
    UIButton *_topBtnInBottom;
    UIView *_maskView;
    
    UILabel *_adultLab;//成人数
    UILabel *_childrenLab;//儿童数
    
    UILabel *_showNumberLab;//底部显示已选人数
    UILabel *_showDateLab;//底部显示已选日期
    
    UIView *_showView;
    BOOL _isChooseDate;//是否已选择日期
    BOOL _isShow;//底部UI是否已经弹出
    NSString *_chooseDate;//已经选择的日期
    
    UIButton *_nextBtn;
    
    UIImageView *_bttomImage;
    
    int _currentMonth;//当前月份
    int _showMonth;//显示的月份
    int _currentYear;
    int _showYear;
    NSInteger cellNumber;
    CGFloat collectheight;
    CGFloat allCollectHeight;//整个日历的高度
    UIView *_productView;
    
    UIView *line;
    UILabel *nameLab;
    UILabel *priceLab;
    UIButton *bookBtn;
    
    UIImageView *gone_upImage;
    UIButton *gone_upBtn;

}

@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图

@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器数组
@property(nonatomic ,strong) NSMutableArray *assignArray;//指定的日期
@property(nonatomic ,strong) NSMutableArray *shipCalendarArray;//邮轮日历数组
@property(nonatomic ,strong) NSMutableArray *shipCalendarModelArray;//邮轮日历数组
@property(nonatomic ,strong) NSMutableArray *shipProductArray;//邮轮产品数组
@property(nonatomic ,strong) CalendarLogic *Logic;

@property (nonatomic, copy) CalendarBlock calendarblock;//回调
@property (nonatomic, copy) CalendarBlockProduct_id blockProduct_id;//回调产品id
@property (nonatomic, copy) CalendarViewHeightBlock calendarViewHeight;//回调日历控件高度
- (id)initWithFrame:(CGRect)frame ;
-(NSInteger)getShipCalendarArray:(NSMutableArray *)array;

//- (void)setTrainToDay:(int)day ToDateforString:(NSString *)todate price:(int)aPrice beginDate:(NSString *)beginDate;//初始化方法
@end
