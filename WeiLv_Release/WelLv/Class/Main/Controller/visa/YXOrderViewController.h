//
//  YXOrderViewController.h
//  WelLv
//
//  Created by lyx on 15/4/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CusInfoViewController.h"
#import "XCObjectViewController.h"
#import "ZFJShipDetailModel.h"
#import "WXUtil.h"
#import "ZFJMyMemberListVC.h"
#import "YXExitArrayItem.h"
#import "YXShipOrderView.h"
#import "YXAutoEditVIew.h"
#import "YXChoosCabinViewController.h"
#import "YXShipOrderView.h"
@class YXTraveDetailModel, ZFJVisaModel, YXSchedule, TicketGoodsModel ,LXSTDetailModel;
@interface YXOrderViewController : XCObjectViewController<UITextFieldDelegate, UIScrollViewDelegate,CusInfoViewControllerDelegate,ZFJMyMemberListVCDelegate,YXExitArrayItemDelegate,YXShipOrderViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSString *_visaRegion;     //签证领区
    NSString *_departureDate;  //出发日期
    NSString *_totalPrice;     //合计价格
    
    UILabel *placeLabel;
    UILabel *_beginDateLabel;
    UILabel *_numberLabel;
    UILabel *_priceLabel;
}
@property (nonatomic,copy)NSString *product_name; //产品名称（门票模块会用到）
@property (nonatomic,copy)NSString *visaRegion;
@property (nonatomic,copy)NSString *departureDate;
@property (nonatomic,copy)NSString *adultNumber;       //成人人数
@property (nonatomic,copy)NSString *childrenNumber;    //儿童人数
@property (nonatomic,copy)NSString *totalPrice;
@property (nonatomic,copy)NSString *remanentPeople;//余位
@property (nonatomic,copy)NSString *childStandard;//儿童标准
@property(nonatomic,copy)NSString *adult_price;//旅游传过来的成人价格；
@property(nonatomic,copy)NSString *child_price;//旅游传过来的儿童价格；
@property(nonatomic,copy)NSString *pay_way;//支付方式状态（立即支付、等待确认）
@property(nonatomic,copy)NSString *status;//状态
@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic,assign)BOOL isTrave;       //是否是预定产品名称
@property (nonatomic,assign)BOOL isShip;        //是否是邮轮
@property (nonatomic,assign)BOOL isRealTrave;   //是否是旅游产品
@property (nonatomic,assign)BOOL isTicket;      //门票
@property (nonatomic,assign)BOOL isVisa;        //签证
@property (nonatomic,assign)BOOL isStudyTour;   //是否是游学产品


@property (nonatomic, strong) ZFJVisaModel *visaModel;
@property (nonatomic, strong) YXTraveDetailModel * traveModel;
@property (nonatomic, strong) ZFJShipDetailModel *shipModel;
@property (nonatomic, strong) TicketGoodsModel * ticketGoodsModel;
@property (nonatomic, strong) LXSTDetailModel *stadyTourModel;



@property (nonatomic,strong)NSMutableArray *shipArr;            //邮轮选择的全部船舱
@property (nonatomic,strong)ZFJShipRoom *shipDic;      //邮轮选择的某一个船舱

//邮轮传递过来的参数
@property (nonatomic,strong)NSDictionary *shipDataDci;
@property (nonatomic,copy)NSString *shipTypeId; //产品id
@property (nonatomic,copy)NSString *company_id;//公司ID
@property (nonatomic,copy)NSString *line_id;//航线ID

/*邮轮新增的和修改 2015.09.18*/
/**
 *  岸上观光线路数组
 */
@property (nonatomic, strong) NSArray * ShoreTraveLineArr;
/**
 *  房间Model字典
 */
@property (nonatomic, strong) NSDictionary * roomsModelDic;
/**
 *  房间类型名称
 */
@property (nonatomic,copy)NSString *shipTypeName;
//邮轮总价
@property (nonatomic, assign) CGFloat shipOrderPrice;
//新添加的判断支付方式
@property (nonatomic, assign) WLOrderSource orderSource;
@property (nonatomic, copy) NSString * store_id;  //管家店铺ID
@end



@interface OrderTextFieldView : UIView

@property (nonatomic,strong)UITextField *nameTextField;
@property (nonatomic,strong)UITextField *phoneTextField;
@property (nonatomic,strong)UIImageView *contactImagV;
@property (nonatomic,strong)UIImageView *phoneImagV;

@property (nonatomic,strong)UITextField *emailTF;
@property (nonatomic,strong)UIImageView *emailImageView;

- (id)initWithFrame:(CGRect)frame placderName:(NSString *)name placderPhone:(NSString *)phone;
- (id)initWithFrame:(CGRect)frame placderName:(NSString *)name placderPhone:(NSString *)phone emial:(NSString *)emailStr;

@end
