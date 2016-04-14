//
//  YXChoosCabinViewController.h
//  WelLv
//
//  Created by lyx on 15/5/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#import "YXTabbarBtn.h"
#import "YXShipCabinCell.h"
#import "YXOrderViewController.h"
#import "ZFJShipDetailModel.h"
#import "LXCommonTools.h"


@interface YXChoosCabinViewController : XCSuperObjectViewController<YXButtonViewDelegate,UITableViewDataSource,UITableViewDelegate,YXShipCabinCellDelegate>
{
    BOOL _isShow;          //控制详细视图的伸缩
    NSArray *_AllData;     //按照typeId归类后的数据
    NSMutableArray *_lowestPrice;   //最低价格数组
    NSArray *keys;         //type_id
    NSInteger buttonIndex;      //用于区分每个房型的cell   并且用于区分选择的房型
    
    
    //最后传到下个页面的数据
    NSDictionary *selectDic;     //挑选的房型字典
    NSString *totalNumber;       //总人数
    NSMutableArray *selectedCabin;   //挑选的所有房型
    NSMutableArray *allData;         //挑选的所有房型数据，包含人数和价格
}

@property (nonatomic,copy)NSString *typeId;        //产品id
@property (nonatomic, strong) ZFJShipDetailModel * shipModel;
@property (nonatomic,strong)NSArray *dataArray;
@end


@interface CabinPriceCell : UITableViewCell
{
    UILabel *_bottomCabinName;  //底部详细视图中的仓房名称
    UILabel *_price12;          // 底部详细视图中的第1/2人价格
    UILabel *_price34;          // 底部详细视图中的第3/4人价格
    
}
@property (nonatomic,strong)UILabel *bottomCabinName;
@property (nonatomic,strong)UILabel *price12;
@property (nonatomic,strong)UILabel *price34;
@property (nonatomic, strong) UILabel * childPrice34; //儿童34人价


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;
@end