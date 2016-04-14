//
//  DetailOrideViewController.m
//  WelLv
//
//  Created by 赵冉 on 16/1/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "DetailOrideViewController.h"
#import "TravelAllHeader.h"
#import "GuoneiViewController.h"
#import "MBProgressHUD.h"
#import "FillOrderViewController.h"
#import "CYYkViewController.h"
#import "TravelCancelTitleView.h"
#import "ChangeTravellerInfoViewController.h"
#import "webViewController.h"
#import "ProductDetailViewController.h"


#import "PartnerConfig.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "YXPaySuccessViewController.h"
#import "LXCommonTools.h"
#import "payRequsestHandler.h"

#import "WXApi.h"
#import "WXApiObject.h"

#define LOWVC 50
 static BOOL isOpen;


@interface DetailOrideViewController ()<UIScrollViewDelegate,UIAlertViewDelegate,UIDocumentInteractionControllerDelegate>{
    NSDictionary *_DICTdata;//数据源
    NSArray * _arraym;//存放出游人的数组
    UIDocumentInteractionController * _document;//打开doc文件
    NSString * _savepath;//存放文件路径
    UILabel * _childLabel;
    //取消提示X
    NSInteger cancelTitleViewX;
    //取消提示Y
    NSInteger cancelTitleViewY;
    //取消提示宽
    NSInteger cancelTitleViewWidth;
    //取消提示高
    NSInteger cancelTitleViewHeight;
    //修改联系人传值
    NSString *order_IDStr;
    NSString *product_categoryStr;
    NSString *Cityname;
    
    float progress;//下载进度
    BOOL A;//判断是否下载过判断条件
    payRequsestHandler *req;
    
}
@property (nonatomic, strong) UILabel *ZhifuVc;
@property (nonatomic, strong) UIView *aView;
@property (nonatomic, strong) UILabel * titlelable;
@property (nonatomic, assign) BOOL isFirstRefersh;

//取消视图
@property (nonatomic, strong) TravelCancelTitleView *cancelTitleView;
//取消背景图
@property (nonatomic, strong) UIView *cancelBackView;
//转动菊花
@property (nonatomic, strong) MBProgressHUD *HUD;
//证件类型
@property (nonatomic, strong) NSString *credentialsStyle;

//姓名
@property (nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong)UILabel *childNumLabel;
@property (nonatomic,strong)UILabel *childPrice;

//证件类型



@end

@implementation DetailOrideViewController

@synthesize order_id,cat_id,member_id;

- (void)viewWillAppear:(BOOL)animated {
    
    for(UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    _isFirstRefersh = YES;
    
    [self GEtData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _savepath = [NSHomeDirectory()stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.doc", order_id]];
    self.navigationItem.title = @"订单详情";
    self.view.backgroundColor = [UIColor whiteColor];
    

}
#pragma mark -------------------------添加下拉刷新-------------------
- (void)addRefersh {
    
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    
    //-----------下拉刷新
    //    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [self.scrollView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(GEtData)];
    //    // 设置普通状态的动画图片
    [self.scrollView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    //    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.scrollView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    //
    //    // 设置正在刷新状态的动画图片
    [self.scrollView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    //    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    //
    //    // 马上进入刷新状态

    [self.scrollView.gifHeader beginRefreshing];

    
}

#pragma mark -----------------创建scrollView-------------------
- (void)createSCroll
{
    NSInteger scrollViewHeight;
    if (windowContentHeight == 667) {
        if ([_DICTdata[@"pay_status"] integerValue] == 0 && [_DICTdata[@"order_status"] integerValue] == 0) {
            if (_num > 1) {
                scrollViewHeight = windowContentHeight + _num * (windowContentHeight / 14.8)+50;
            } else {
                scrollViewHeight = windowContentHeight+50;
            }
        } else {
            if (_num > 1) {
                scrollViewHeight = windowContentHeight + _num * (windowContentHeight / 14.8)+50;
            } else {
                scrollViewHeight = windowContentHeight+20;
            }
        }
    } else if (windowContentHeight < 569) {
        if ([_DICTdata[@"pay_status"] integerValue] == 0 && [_DICTdata[@"order_status"] integerValue] == 0) {
            if (_num > 1) {
                scrollViewHeight = windowContentHeight + _num * (windowContentHeight / 14.8)+50;
            } else {
                scrollViewHeight = windowContentHeight+20;
            }
        } else {
            if (_num > 1) {
                scrollViewHeight = windowContentHeight + _num * (windowContentHeight / 14.8)-20;
            } else {
                scrollViewHeight = windowContentHeight+20;
            }
        }
    } else if (windowContentHeight == 736) {
        if ([_DICTdata[@"pay_status"] integerValue] == 0 && [_DICTdata[@"order_status"] integerValue] == 0) {
            if (_num > 1) {
                scrollViewHeight = windowContentHeight + _num * (windowContentHeight / 14.8);
            } else {
                scrollViewHeight = windowContentHeight+20;
            }
        } else {
            if (_num > 1) {
                scrollViewHeight = windowContentHeight + _num * (windowContentHeight / 14.8)-20;
            } else {
                scrollViewHeight = windowContentHeight+20;
            }
        }
    }
    
//    windowContentHeight / 14.8
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - LOWVC - 64)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(windowContentWidth, scrollViewHeight);
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}

#pragma mark ------------------------创建底部显示按钮-----------------------------------
- (void)createZHIFuANNIU
{
    //底部按钮
    _Lowbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, windowContentHeight  - LOWVC - 64, windowContentWidth, LOWVC)];
    [_Lowbutton addTarget:self action:@selector(LowbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    _Lowbutton.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_Lowbutton];
    //订单状态
    if ([_DICTdata[@"pay_status"] integerValue]== 0 )
    {
#pragma mark ---------------底部按钮显示内容----------------------
        //待确认
        if (([_DICTdata[@"order_status"] integerValue] == 90 || [_DICTdata[@"order_status"] integerValue] == 92 || [_DICTdata[@"order_status"] integerValue] == 91 || [_DICTdata[@"order_status"] integerValue] == 12 ) && [_DICTdata[@"pay_status"] integerValue]== 0)
        {
            _leftbutt = [[UIButton alloc]initWithFrame:CGRectMake(0,  0, windowContentWidth / 2.5, LOWVC)];
            _leftbutt.backgroundColor = [UIColor whiteColor];
            [_leftbutt setTitle:@"取消订单" forState:UIControlStateNormal];
            [_leftbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_leftbutt addTarget:self action:@selector(leftbuttClick) forControlEvents:UIControlEventTouchUpInside];
            _rightbutt = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth / 2.5,   0, windowContentWidth  - windowContentWidth / 2.5, LOWVC)];
            [_rightbutt addTarget:self action:@selector(rightbutt) forControlEvents:UIControlEventTouchUpInside];
            [_rightbutt setTitle:@"等待供销商确认 " forState:UIControlStateNormal];
            _rightbutt.backgroundColor = BgViewColor;
            
            [_Lowbutton addSubview:_leftbutt];
            [_Lowbutton addSubview:_rightbutt];
            
            //[_Lowbutton setTitle:@"等待销售商确认" forState:UIControlStateNormal];
            
        }
        //已取消
        else if([_DICTdata[@"order_status"] integerValue] == 9||[_DICTdata[@"order_status"] integerValue]== 11)
        {
            [_Lowbutton setTitle:@"再次预定" forState:UIControlStateNormal];
        }
        //已完成
        else if([_DICTdata[@"order_status"] integerValue] == 2 && [_DICTdata[@"pay_status"] integerValue] == 1)
        {
            [_Lowbutton setTitle:@"再次预定" forState:UIControlStateNormal];
        }
        //待付款
        else if(([_DICTdata[@"order_status"] integerValue] == 0 || [_DICTdata[@"order_status"] integerValue] == 1) && ([_DICTdata[@"pay_status"] integerValue] == 0))
        {
            
            _leftbutt = [[UIButton alloc]initWithFrame:CGRectMake(0,  0, windowContentWidth / 2.5, LOWVC)];
            _leftbutt.backgroundColor = [UIColor whiteColor];
            [_leftbutt setTitle:@"取消订单" forState:UIControlStateNormal];
            [_leftbutt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_leftbutt addTarget:self action:@selector(leftbuttClick) forControlEvents:UIControlEventTouchUpInside];
            _rightbutt = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth / 2.5,   0, windowContentWidth - windowContentWidth / 2.5, LOWVC)];
            [_rightbutt addTarget:self action:@selector(rightbutts) forControlEvents:UIControlEventTouchUpInside];
            [_rightbutt setTitle:@"立即支付 " forState:UIControlStateNormal];
        
            [self ZHIFUprice];
            [_Lowbutton addSubview:_leftbutt];
            [_Lowbutton addSubview:_rightbutt];
            
            
        }
    }
    else if ([_DICTdata[@"order_status"] integerValue]== 2 && [_DICTdata[@"pay_status"] integerValue] == 1)
    {
        [_Lowbutton setTitle:@"再次预定" forState:UIControlStateNormal];
    }
    else if ([_DICTdata[@"pay_status"] integerValue]== 1)
    {

        [_Lowbutton removeFromSuperview];
        [_scrollView setFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];

    } else if ([_DICTdata[@"order_status"] integerValue]== 90 || ([_DICTdata[@"order_status"] integerValue]== 92) || ([_DICTdata[@"order_status"] integerValue]== 91)) {
        [_Lowbutton setTitle:@"等待供销商确认" forState:UIControlStateNormal];
        _Lowbutton.userInteractionEnabled = YES;
    }
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType]==WLMemberTypeSteward && [self.frontPageFlag isEqualToString:@"100"]) {
        [_Lowbutton removeFromSuperview];
        [_scrollView setFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    }
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType]==WLMemberTypeMember && [self.frontPageFlag isEqualToString:@"200"]) {
        [_Lowbutton removeFromSuperview];
        [_scrollView setFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    }
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType]==WLMemberTypeSteward && [self.frontPageFlag isEqualToString:@"300"]) {
        [_Lowbutton removeFromSuperview];
        [_scrollView setFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];

    }
    

}

#pragma mark -- 头标题
- (void)Toplable
{
    
    if (_titlelable == nil) {
         UILabel * titlelable = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34, 0, windowContentWidth/6*5, windowContentHeight / 14.8)];
        _titlelable = titlelable;
    }
   
  
   
    _titlelable.text = [NSString stringWithFormat:@"< %@ >",_DICTdata[@"product_name"]];
    _titlelable.numberOfLines = 0;
    _titlelable.font = [UIFont systemFontOfSize:windowContentWidth / 24];
    UILabel * line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 14.8 , windowContentWidth, 0.5)];
    line1.backgroundColor = BgViewColor;
     UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth - windowContentHeight / 14.8  , 0, windowContentHeight / 14.8, windowContentHeight / 14.8)];
    [button setImage:[UIImage imageNamed:@"矩形-32"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ONBUTTON) forControlEvents:UIControlEventTouchUpInside];
   
    [_scrollView addSubview:button];
    [_scrollView addSubview:line1];
    [_scrollView addSubview:_titlelable];
}
#pragma mark -- 标题跳到产品详情 
- (void)ONBUTTON
{
    
    ProductDetailViewController *productVC = [ProductDetailViewController new];
    productVC.productID =_DICTdata[@"product_id"];
    productVC.gj_commission = _DICTdata[@"gj_adult_rebate"];
    [self.navigationController pushViewController:productVC animated:YES];
    
 
}

#pragma mark --订单标号

- (void)Createnum
{
    NSMutableArray * marray = [NSMutableArray array];
    
    
    
     NSString * orderid = [NSString stringWithFormat:@"订单编号:%@",_DICTdata[@"order_sn"]];
    
   
    [marray addObject:orderid];
    
//    NSString * Cityname = [NSString stringWithFormat:@"出发城市:%@",_DICTdata[@"f_city_name"]];

    if ([self.cat_id isEqualToString:@"-15"]) {
        Cityname = [NSString stringWithFormat:@"出发城市:全国"];
    }else{
           Cityname = [NSString stringWithFormat:@"出发城市:%@",_DICTdata[@"f_city_name"]];
    }
    
    
    [marray addObject:Cityname];
    //时间戳转化
    NSString *BookTimeString = [_DICTdata objectForKey:@"f_time"];
    NSTimeInterval bookTime = [BookTimeString doubleValue] ;
    NSDate *detaildatee=[NSDate dateWithTimeIntervalSince1970:bookTime];
    NSDateFormatter *dateFormatterr = [[NSDateFormatter alloc] init];
    [dateFormatterr setDateFormat:@"yyyy-MM-dd"];
    NSString * STRS = [dateFormatterr stringFromDate: detaildatee];
    NSString * Starttime = [NSString stringWithFormat:@"出发日期:%@",STRS];
    
    [marray addObject:Starttime];
    
     NSString * totlepople = [NSString stringWithFormat:@"出游人数:%@成人 %@儿童",_DICTdata[@"adule"],_DICTdata[@"child"]];
    
    [marray addObject:totlepople];
    
    //时间戳转化
    NSString * ordeTimeString = [_DICTdata objectForKey:@"create_time"];
    NSTimeInterval orderTime = [ordeTimeString doubleValue] ;
    NSDate * datee=[NSDate dateWithTimeIntervalSince1970:orderTime];
    NSDateFormatter * Formatterr = [[NSDateFormatter alloc] init];
    [Formatterr setDateFormat:@"yyyy-MM-dd"];
    NSString * Leave = [dateFormatterr stringFromDate: datee];
     NSString * ordertime = [NSString stringWithFormat:@"下单时间:%@",Leave];
    
    [marray addObject:ordertime];

#pragma mark -------------------订单状态--------------------------
    
//    if ([_DICTdata[@"order_status"] integerValue]== 0)
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"未付款"];
//        [marray addObject:statanc];
//    } else if ([_DICTdata[@"pay_status"] integerValue]== 1)
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"已支付"];
//        [marray addObject:statanc];
//    }
//    else if ([_DICTdata[@"order_status"] integerValue]== 2)
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"已完成"];
//        [marray addObject:statanc];
//    }
//    else if ([_DICTdata[@"order_status"] integerValue]== 9)
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"已取消"];
//        [marray addObject:statanc];
//    }
//    else if ([_DICTdata[@"order_status"] integerValue]== 90 )
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"待确认"];
//        [marray addObject:statanc];
//    }
//    else if ([_DICTdata[@"order_status"] integerValue]== 91 )
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"余额待确认"];
//        [marray addObject:statanc];
//    }
//    else if ([_DICTdata[@"order_status"] integerValue]== 92 )
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"待确认"];
//        [marray addObject:statanc];
//    }
//    else if ([_DICTdata[@"order_status"] integerValue]== 3 )
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"投诉中"];
//        [marray addObject:statanc];
//    }
//    else if ([_DICTdata[@"order_status"] integerValue]== 6 )
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"退款中"];
//        [marray addObject:statanc];
//    }
//    else if ([_DICTdata[@"order_status"] integerValue]== 92 )
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"需要供应商确认"];
//        [marray addObject:statanc];
//    }
//    else if ([_DICTdata[@"order_status"] integerValue]== 7 )
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"退款成功"];
//        [marray addObject:statanc];
//    }
//    else if ([_DICTdata[@"order_status"] integerValue]== 8 )
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"退款失败"];
//        [marray addObject:statanc];
//    }
//    else if ([_DICTdata[@"order_status"] integerValue]== 11 )
//    {
//        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"已取消"];
//        [marray addObject:statanc];
//    }
    
    
    if ([_DICTdata[@"order_status"] integerValue] == 2 && [_DICTdata[@"pay_status"] integerValue] == 1) {
        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"已完成"];
        [marray addObject:statanc];
    }else if ([_DICTdata[@"pay_status"] integerValue] == 0 && ([_DICTdata[@"order_status"] integerValue] == 0 || [_DICTdata[@"order_status"] integerValue] == 1)) {
        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"待付款"];
        [marray addObject:statanc];
    } else if ([_DICTdata[@"order_status"] integerValue] == 11) {
        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"已取消"];
        [marray addObject:statanc];
    } else if ([_DICTdata[@"pay_status"] integerValue] == 1) {
        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"已付款"];
        [marray addObject:statanc];
    }else if (([_DICTdata[@"order_status"] integerValue] == 90 || [_DICTdata[@"order_status"] integerValue] == 92 || [_DICTdata[@"order_status"] integerValue] == 91 || [_DICTdata[@"order_status"] integerValue] == 12) && ([_DICTdata[@"pay_status"] integerValue] == 0)) {
        NSString * statanc = [NSString stringWithFormat:@"订单状态: %@",@"待确认"];
        [marray addObject:statanc];
    }

    

    
    NSString * totlePrice = [NSString stringWithFormat:@"订单总额:¥%@",_DICTdata[@"order_price"]];
    
    [marray addObject:totlePrice];
    DLog(@"%lu",marray.count);
    for (int i =0; i < marray.count; i ++)
    {
        _NUm = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34, windowContentHeight / 11.3 + windowContentHeight / 40 * i * 2, 400, windowContentHeight / 40)];
        _NUm.text = marray[i];
        _NUm.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
        
        [_scrollView addSubview:_NUm];
    }
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame =CGRectMake(windowContentWidth -windowContentHeight / 43 - windowContentWidth / 21.4 -10, windowContentHeight / 11.3 + windowContentHeight / 40 * 6 * 2, windowContentHeight / 40+ 20 , windowContentHeight / 40 + 10);
 
    [_button setImage:[UIImage imageNamed:@"订单明细按钮-副本"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(onBUttonClick:) forControlEvents:UIControlEventTouchUpInside];
    isOpen =NO;
    [_scrollView addSubview:_button];
}
#pragma mark-- 显示  隐藏  按钮

- (void)onBUttonClick:(UIButton*)sender
{
    sender.selected = !sender.selected;
  //  [UIView animateWithDuration:0.7f animations:^{
        if (!isOpen)
        {
            [_button setImage:[UIImage imageNamed:@"订单明细按钮"] forState:UIControlStateSelected];
            _aView = [[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight / 2.3, windowContentWidth, windowContentHeight / 13.4+5)];
            _aView.backgroundColor = [UIColor whiteColor];
            [_scrollView addSubview:_aView];
            
            // 黑线
            UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34, 0, windowContentWidth - windowContentWidth / 34 , 0.5)];
            line.backgroundColor = BgViewColor;
            [_aView addSubview:line];
            
            //成人
            UILabel * Adoultlable = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34, windowContentHeight / 38.1, 100, windowContentHeight / 44.4)];
            Adoultlable.text = @"成人:";
            Adoultlable.font =[UIFont systemFontOfSize:windowContentHeight / 47.6];
            
            //儿童
            self.childNumLabel =[[UILabel alloc]initWithFrame:CGRectMake(ViewX(Adoultlable), ViewY(Adoultlable)+windowContentHeight / 44.4+5, 100, windowContentHeight/44.4)];
             self.childNumLabel.text = @"儿童:";
             self.childNumLabel.font = [UIFont systemFontOfSize:windowContentHeight/47.6];
          
            //成人价格
            UILabel * price =[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth - windowContentWidth / 21.4 - 200  , windowContentHeight / 38.1, 200, windowContentHeight / 44.4)];
            price.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
            price.text= [NSString stringWithFormat:@"¥%0.2f*%d 人",[_DICTdata[@"adule_price"] floatValue],[_DICTdata[@"adule"] intValue]];
           
            //儿童价格
            self.childPrice = [[UILabel alloc]init];
          ///  NSDictionary *addDict = @{NSFontAttributeName:[UIFont systemFontOfSize:windowContentHeight / 47.6]};
         //   CGRect  bodyFram = [_DICTdata[@"child_price"] boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:addDict context:nil];
            //根据儿童人数 是否为0判断 是否显示儿童订单信息
            if ([_DICTdata[@"child"]integerValue]!=0) {
                if (IS_IPHONE_4_OR_LESS) {
                self.childPrice.frame =CGRectMake(windowContentWidth - windowContentWidth / 21.4 -63 ,  ViewY(self.childNumLabel), 200, windowContentHeight / 44.4);
                    
                }else if (IS_IPHONE_5)
                {
                    self.childPrice.frame =CGRectMake(windowContentWidth - windowContentWidth / 21.4-73,  ViewY(self.childNumLabel), 200, windowContentHeight / 44.4);
                }else if (IS_IPHONE_6)
                {
                  self.childPrice.frame =CGRectMake(windowContentWidth - windowContentWidth / 21.4 - 84 ,  ViewY(self.childNumLabel),  200, windowContentHeight / 44.4);
                }else if (IS_IPHONE_6P)
                {
                  self.childPrice.frame =CGRectMake(windowContentWidth - windowContentWidth / 21.4 - 92 ,  ViewY(self.childNumLabel), 200, windowContentHeight / 44.4);
                }
             
                self.childPrice.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
                self.childPrice.text = [NSString stringWithFormat:@"¥%0.2f*%d 人",[_DICTdata[@"child_price"]floatValue],[_DICTdata[@"child"]intValue]];
                [_aView addSubview:self.childPrice];
                
            }else
            {
                self.childPrice.hidden = YES;
                self.childNumLabel.hidden = YES;
            }
          
            
            DLog(@"6666%@",_DICTdata[@"adule_price"]);
            price.textAlignment = NSTextAlignmentRight;
            [_aView addSubview:price];
            [_aView addSubview:Adoultlable];
            [_aView addSubview:self.childNumLabel];
           
            
            _LINE1.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 13.3, windowContentWidth, windowContentHeight / 44.4);
            _LINE2.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4+ windowContentHeight / 13.3, windowContentWidth, windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num);
            _LINE3.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 13.3 , windowContentWidth, windowContentHeight / 44.4);
            _lowvc.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 13.3  , windowContentWidth, windowContentHeight / 14.8 * 3);
            _LINE4.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 14.8 * 4, windowContentWidth, windowContentHeight / 44.4);
            
            _ZhifuVc.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 14.8 * 3 + windowContentHeight / 44.4 + windowContentHeight / 14.8  , windowContentWidth, windowContentHeight / 14.8 * 2);

          
            if ([_DICTdata[@"is_have_notice"] integerValue]==1&&[_DICTdata[@"pay_status"] integerValue]==1) {
                _Tongzivc.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 13.4, windowContentWidth, windowContentHeight / 11.1);
                
                _LINE2.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4+ windowContentHeight / 13.3 + windowContentHeight / 44.4+ windowContentHeight / 13.4, windowContentWidth, windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num);
                _LINE3.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 13.3+ windowContentHeight / 44.4 + windowContentHeight / 13.4, windowContentWidth, windowContentHeight / 44.4);
                _lowvc.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 13.3+ windowContentHeight / 44.4 + windowContentHeight / 13.4 , windowContentWidth, windowContentHeight / 14.8 * 3);
                
                _LINE4.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 14.8 * 4 , windowContentWidth, windowContentHeight / 44.4);
                
                _ZhifuVc.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 14.8 * 3 + windowContentHeight / 44.4 + windowContentHeight / 14.8  , windowContentWidth, windowContentHeight / 14.8 * 2);
            }
            
        }
        else
        {
            
            self.aView.hidden = YES;
            if ([_DICTdata[@"is_have_notice"] integerValue]==1&&[_DICTdata[@"pay_status"] integerValue]==1)
            {
                
                [_button setImage:[UIImage imageNamed:@"订单明细按钮-副本"] forState:UIControlStateSelected];
                _LINE1.frame = CGRectMake(0, windowContentHeight / 2.3  , windowContentWidth, windowContentHeight / 44.4);
                _LINE2.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4+ windowContentHeight / 11.1, windowContentWidth, windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num);
                _LINE3.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num+ windowContentHeight / 11.1 , windowContentWidth, windowContentHeight / 44.4);
                _lowvc.frame =CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 +windowContentHeight / 14.8 , windowContentWidth, windowContentHeight / 14.8 * 3);
                _Tongzivc.frame =CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 , windowContentWidth, windowContentHeight / 11.1);
                
                _LINE4.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 14.8 * 4 , windowContentWidth, windowContentHeight / 44.4);
                
                _ZhifuVc.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 14.8 * 3 + windowContentHeight / 44.4 + windowContentHeight / 14.8  , windowContentWidth, windowContentHeight / 14.8 * 2);
                
                
            }
            else
            {
                    _LINE1.frame = CGRectMake(0, windowContentHeight / 2.3  , windowContentWidth, windowContentHeight / 44.4);
                    _LINE2.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4, windowContentWidth, windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num);
                    _LINE3.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num , windowContentWidth, windowContentHeight / 44.4);
                    _lowvc.frame =CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 , windowContentWidth, windowContentHeight / 14.8 * 3);
                    _LINE4.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 14.8 * 3, windowContentWidth, windowContentHeight / 44.4);
                    
                    self.ZhifuVc.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 14.8 * 3 + windowContentHeight / 44.4, windowContentWidth, windowContentHeight / 14.8 * 2);

            
            }
            
            
        }
        
   // }];
    
    isOpen = !isOpen;
    
    
}


//通知书
- (void)createTongzhi
{
    if ([_DICTdata[@"is_have_notice"] integerValue]==1&&[_DICTdata[@"pay_status"] integerValue]==1)
    {
        _Tongzivc = [[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 , windowContentWidth, windowContentHeight / 11.1)];
        UILabel * Tonghi = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34, windowContentHeight / 44.4, windowContentWidth * 0.2, windowContentHeight / 44.4)];
       Tonghi.text = @"出团通知书";
        
        Tonghi.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
        Tonghi.adjustsFontSizeToFitWidth = YES;
        [_Tongzivc addSubview:Tonghi];
        [_scrollView addSubview:_Tongzivc];
        
        UILabel * line= [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 14.8 , windowContentWidth, windowContentHeight / 44.4)];
        line.backgroundColor = BgViewColor;
        [_Tongzivc addSubview:line];

        
        //提示
        UIButton * TISHI = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth / 34 + windowContentWidth * 0.2, windowContentHeight / 44.4, windowContentHeight / 35, windowContentHeight / 40)];
        [TISHI setImage:[UIImage imageNamed:@"提示"] forState:UIControlStateNormal];
        [TISHI addTarget:self action:@selector(ONtishiClick) forControlEvents:UIControlEventTouchUpInside];
        [_Tongzivc addSubview:TISHI];
        
        // 跟新标题
        UILabel * TItle = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34 + windowContentWidth * 0.22 + windowContentHeight / 44.4, windowContentHeight / 44.4, 150, windowContentHeight / 44.4)];
        TItle.text = _Ttitle;
        [_Tongzivc addSubview:TItle];
        //通知书简介
        _photovc = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth / 34 + windowContentWidth * 0.22 - windowContentHeight / 44.4-3 , windowContentHeight / 44.4 * 2 + windowContentHeight / 44.4 / 3 - 5, self.Tongzivc.size.width -(windowContentWidth / 34 + windowContentWidth * 0.22 - windowContentHeight / 44.4)- windowContentWidth / 21.4 , self.Tongzivc.size.height - (windowContentHeight / 44.4 * 2 + windowContentHeight / 44.4 / 3))];
        [_photovc setImage:[UIImage imageNamed:@"出团说明框"]];

        _JIanJie = [[UILabel alloc]initWithFrame:CGRectMake(0 , 0, self.Tongzivc.size.width -(windowContentWidth / 34 + windowContentWidth * 0.22 - windowContentHeight / 44.4)- windowContentWidth / 21.4 , self.Tongzivc.size.height - (windowContentHeight / 44.4 * 2 + windowContentHeight / 44.4 / 3))];
        //_JIanJie.alpha = 0.1;
        _JIanJie.layer.cornerRadius = 15;
        _JIanJie.text = @"出团通知以临近出团前的通知为准，请及时查看";
        _JIanJie.font = [UIFont systemFontOfSize:windowContentWidth / 29.5];
        _JIanJie.textColor = [UIColor whiteColor];
        
        _photovc.hidden = YES;
        
        
        [_photovc addSubview:_JIanJie];
        [_Tongzivc addSubview: _photovc];
        
        //下载提示

        
        _buttonLodown = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth -  windowContentHeight / 44.4 * 4 - windowContentWidth / 21.4, windowContentHeight / 44.4 , windowContentHeight / 44.4 * 4, windowContentHeight / 44.4 )];
        
                [_Tongzivc addSubview:_buttonLodown];
        
       
        _titi = [[UILabel alloc]initWithFrame:CGRectMake(windowContentHeight / 44.4 * 2, 0, windowContentHeight / 44.4 * 2, windowContentHeight / 44.4 )];
       
        _titi.text = @"下载";
      
        _titi.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
        _titi.textColor = [UIColor orangeColor];
        _titi.textAlignment = NSTextAlignmentRight;
        
        
        [_buttonLodown addSubview:_titi];
        
       _imVc = [[UIButton alloc]initWithFrame:CGRectMake(windowContentHeight / 44.4 - windowContentWidth / 16, 0, windowContentHeight / 44.4+ windowContentWidth / 16 , windowContentHeight / 44.4 )];
        [_imVc setImage:[UIImage imageNamed:@"下载"] forState:UIControlStateNormal];
        _imVc.imageEdgeInsets =UIEdgeInsetsMake(0, 0, 0, -windowContentWidth / 16);
       
        
        
        NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *despath = [path stringByAppendingString:@"/gg.plist"];
        NSArray * infoarray = [NSKeyedUnarchiver unarchiveObjectWithFile:despath];
        for (NSDictionary * dict in infoarray)
        {
            if([_DICTdata[@"order_id"] isEqualToString:dict[@"id"]])
            {
                A = YES;
            }
        }

        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if(![fileManager fileExistsAtPath:_savepath]) //如果不存在
        {
            [_buttonLodown addTarget:self action:@selector(ONDowload) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            _titi.text = @"打开";
            _titi.tintColor = [UIColor orangeColor];
            [_imVc setImage:[UIImage imageNamed:@"打开"] forState:UIControlStateNormal];
            [_buttonLodown addTarget:self action:@selector(DAKAICLICK) forControlEvents:UIControlEventTouchUpInside];
        }

        [_buttonLodown addSubview:_imVc];

        _LINE2.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4+ windowContentHeight / 13.3 + windowContentHeight / 44.4, windowContentWidth, windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num);
        _LINE3.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 13.3+ windowContentHeight / 44.4 , windowContentWidth, windowContentHeight / 44.4);
        _lowvc.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 13.3+ windowContentHeight / 44.4 , windowContentWidth, windowContentHeight / 14.8 * 3);
        
        _ZhifuVc.frame = CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 14.8 * 3 + windowContentHeight / 44.4 + windowContentHeight / 11.1 , windowContentWidth, windowContentHeight / 14.8 * 2);
    
        [self postID];//上传产品id给服务器
       
    }
    else
    {
       
    
    }
    
    
    

}

- (void)gettitle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    NSDictionary *parameters = @{@"order_id":order_id,@"member_id":[[LXUserTool alloc] getUid],@"wltoken":md5str};
    [manager POST:STATUS parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
    {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        
    }];

}
//上传产品ID
- (void)postID{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
   
    NSDictionary *parameters = @{@"order_ids":_DICTdata[@"order_id"] };
    
    [manager POST:POSTID parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
       NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
      
        DLog(@"%@",dic[@"status"]);
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        
    }];


}
//下载出团通知书
- (void)ONDowload
{
    
   //_savepath = [NSHomeDirectory()stringByAppendingString:@"/Documents/3.doc"];
   
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:_savepath]) //如果不存在
    {
        [self getNetData:_savepath];
    }
}

- (void)getNetData:(NSString *)savepath
{
    NSURL *URL = [NSURL URLWithString:DOWN];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:savepath append:YES];
    //下载进度回调
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //下载进度
        progress = ((float)totalBytesRead) / (totalBytesExpectedToRead);
        NSInteger  S = progress * 100;
       
        _titi.text = [NSString stringWithFormat:@"%ld%@",(long)S,@"%"];
        _titi.textColor = BgViewColor;

        if (progress == 1.0)
        {
            NSDictionary * dict = @{@"id":_DICTdata[@"order_id"]};
            NSString * path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString * despath = [path stringByAppendingString:@"/gg.Plist"];
            NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithFile:despath];
            NSMutableArray * marray = [NSMutableArray arrayWithObject:dict];
            [marray addObjectsFromArray:array];
            [NSKeyedArchiver archiveRootObject:marray toFile:despath];
         
            _titi.text = @"打开";
            _titi.textColor = [UIColor orangeColor];
            [_imVc setImage:[UIImage imageNamed:@"打开"] forState:UIControlStateNormal];
           [_buttonLodown addTarget:self action:@selector(DAKAICLICK) forControlEvents:UIControlEventTouchUpInside];
           [self gettitle];//通知书跟新状态
                     
        }
    }];
    
    //成功和失败回调
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"ok");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];
    
    [operation start];
    
}
#pragma mark -- 打开按钮
- (void)DAKAICLICK
{
    webViewController * webvc = [[webViewController alloc]init];
    webvc.path = [NSHomeDirectory()stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.doc", _DICTdata[@"order_id"]]];
    
#pragma mark ---- 添加判断出团通知书是否已读 ----
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"已读"];
    //存储,同步
    [defaults synchronize];
    
    [self.navigationController pushViewController:webvc animated:YES];
    
}
#pragma mark -- 提示按钮
- (void)ONtishiClick
{
    if (!isOpen)
    {
        _photovc.hidden = NO;
    }
    else
    {
        _photovc.hidden = YES;
    }
    isOpen = !isOpen;

}
#pragma mark -- 底部支付按钮
- (void)LowbuttonClick {//再次预订

    ProductDetailViewController *detailVC = [[ProductDetailViewController alloc]init];
    detailVC.productID = _DICTdata[@"product_id"];
    detailVC.gj_commission = _DICTdata[@"gj_adult_rebate"];
    [self.navigationController pushViewController:detailVC animated:YES];
    
   }
#pragma mark --------------------- 取消按钮----------------- --
- (void)leftbuttClick{
    
    if (UISCREEN_HEIGHT == 736) {
        cancelTitleViewWidth = 334;
        cancelTitleViewHeight = 166;
        cancelTitleViewX = UISCREEN_WIDTH/2 - 334/2;
        cancelTitleViewY = UISCREEN_HEIGHT/2 - 166/2;
    } else if (UISCREEN_HEIGHT == 667) {
        cancelTitleViewWidth = 300;
        cancelTitleViewHeight = 150;
        cancelTitleViewX = UISCREEN_WIDTH/2 - 300/2;
        cancelTitleViewY = UISCREEN_HEIGHT/2 - 150/2;
    } else if (UISCREEN_HEIGHT < 569) {
        cancelTitleViewWidth = 254;
        cancelTitleViewHeight = 128;
        cancelTitleViewX = UISCREEN_WIDTH/2 - 254/2;
        cancelTitleViewY = UISCREEN_HEIGHT/2 - 128/2;
    }
    
    self.cancelBackView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _cancelBackView.backgroundColor = [UIColor blackColor];
    _cancelBackView.alpha = 0.5;
    
    self.cancelTitleView = [[TravelCancelTitleView alloc]initWithFrame:CGRectMake(cancelTitleViewX, cancelTitleViewY, cancelTitleViewWidth, cancelTitleViewHeight)];
    self.cancelTitleView.backgroundColor = [UIColor whiteColor];
    self.cancelTitleView.layer.masksToBounds = YES;
    self.cancelTitleView.layer.cornerRadius = 5;
    
    //添加事件
    //让我想想按钮
    [self.cancelTitleView.leftButton addTarget:self action:@selector(stantCurrentPage:) forControlEvents:UIControlEventTouchUpInside];
    
    //确定取消
    [self.cancelTitleView.rightButton addTarget:self action:@selector(goonCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.view addSubview:_cancelBackView];
    [self.navigationController.view addSubview:self.cancelTitleView];
    
}

//让我想想
- (void)stantCurrentPage:(UIButton *)leftButton {
    [self.cancelTitleView removeFromSuperview];
    [self.cancelBackView removeFromSuperview];
}

//确定取消
- (void)goonCancel:(UIButton *)rightButton {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    
    NSDictionary *parameters = @{@"order_id":order_id,@"member_id":[[LXUserTool alloc] getUid],@"wltoken":md5str};

    
    [manager POST:CancelOrderUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@",dict);
        if([[dict objectForKey:@"state"] integerValue] ==1 ){
            [[LXAlterView sharedMyTools]createTishi:@"取消成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [[LXAlterView sharedMyTools]createTishi:@"取消失败，请检查网络"];
        }
        [self.HUD hide:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[LXAlterView sharedMyTools]createTishi:@"取消失败，请检查网络"];
    }];
    
    
    [self.cancelBackView removeFromSuperview];
    [self.cancelTitleView removeFromSuperview];
}


//支付按钮  销售商 按钮
-(void)rightbutts
{
    
    if ([_DICTdata[@"order_status"] integerValue]== 90||[_DICTdata[@"order_status"] integerValue]== 91 ||[_DICTdata[@"order_status"] integerValue]== 92 )
    {
        //等待销售商确认
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请等待商家确认后继续付款" delegate:self cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        alert.tag=2;
        [alert show];
        
        return;
    
    }
    else
    {
        
        if (self.select)
        {
            //   微信支付
            if (![WXApi isWXAppInstalled])
            {
//                self.HUD.labelText = @"正在进入支付宝支付状态,请稍候";
//                [self setProgressHUD];
                [self alikPay];
            }
            else
            {
//                self.HUD.labelText = @"正在进入微信支付状态,请稍候";
//                [self setProgressHUD];
                [self payOrder];
                
            }

        }else
        {
            //支付方法调用
//            self.HUD.labelText = @"正在进入支付宝支付状态,请稍候";
//            [self setProgressHUD];
            [self alikPay];
        }
    }
}

#pragma mark 支付宝支付
#pragma mark ------------------ 支付宝支付 -----------------------
- (void)alikPay
{
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    #pragma mark - 产品名称
    NSString *body= [YXTools filterSpecialString:_DICTdata[@"product_name"]];
    NSString *title = [YXTools filterSpecialString:_DICTdata[@"product_name"]];
    if (body.length >512) {
        body = [body substringToIndex:512];
    }
    if (title.length > 128) {
        title = [title substringToIndex:128];
    }
    Order *order = [[Order alloc] init];
    order.partner = AlikPartnerID;
    order.seller = AlikSellerID;
    
    #pragma mark - 订单ID
    order.tradeNO =  _DICTdata[@"order_sn"]; //订单ID（由商家自行制定）
   
    order.productName = title; //商品标题
    order.productDescription = body; //商品描述
    
    #pragma mark - 订单总价
    order.amount = [NSString stringWithFormat:@"%.2f",[_DICTdata[@"order_price"] floatValue]]; //商品价格
    //    order.amount = @"0.01";
    order.notifyURL =  ZFBNOTIFY_URL; //回调URL
    
    order.service = @"mobile.securitypay.pay";   //固定值
    order.paymentType = @"1";                    //支付类型。默认值为:1(商 品购买)。
    order.inputCharset = @"utf-8";               //固定编码
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    //    order.appenv = @"app";                   //支付来源
    
    //应用注册scheme,在WeiLv-Info.plist定义URL types
    NSString *appScheme = @"WeiLv";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(AlikPartnerPrivKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"支付结果__________%@",resultDic);
            NSString *errorCode = [resultDic objectForKey:@"resultStatus"];
            NSString *tishi = [resultDic objectForKey:@"memo"];
            if ([errorCode intValue] == 9000)
            {
              [self backSuccessViewController];
                tishi = @"支付成功";
            } else if ([errorCode intValue] == 8000) {
                tishi = @"正在处理中";
            }else if ([errorCode intValue] == 4000)
            {
                tishi = @"订单支付失败";
            }else if ([errorCode intValue] == 6001)
            {
                tishi = @"用户中途取消";
            }else if ([errorCode intValue] == 6002)
            {
                tishi = @"网络连接出错";
            }else
            {
                tishi = @"支付失败";
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付结果"
                                                            message:tishi
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            
        }];
    }
}

//支付成功跳转
- (void)toNextSuccess
{
    int number;
    NSLog(@"支付成功");
    YXPaySuccessViewController *payVC = [[YXPaySuccessViewController alloc] init];

    payVC.productName = _DICTdata[@"product_name"];
    payVC.beginDate = [_DICTdata objectForKey:@"f_time"];
    payVC.contactPerson = _DICTdata[@"contacts"];
    payVC.phone = _DICTdata[@"phone"];
    number = [_DICTdata[@"adule"] intValue] + [_DICTdata[@"child"] intValue];
    payVC.number = [NSString stringWithFormat:@"%d",number];
    
    
    [self.navigationController pushViewController:payVC animated:YES];
}
// 获取时间戳
- (NSString *)genTimeStamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

// 第一个分隔栏
- (void)CrLIne {
    _LINE1 = [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 2.3 , windowContentWidth, windowContentHeight / 44.4)];
    _LINE1.backgroundColor = BgViewColor;

    [_scrollView addSubview:_LINE1];
    
}

#pragma mark ------------------------中间出诱人信息--------------------------

- (void)createZHlable{
    
     //出诱人数组
    _arraym = _DICTdata[@"person_info"];
    //DLog(@"%lu",_arraym.count);
    //DLog(@"%lu",_num);
    _LINE2 = [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4, windowContentWidth, windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num)];
    [_scrollView addSubview:_LINE2];
    _LINE2.userInteractionEnabled = YES;
    
    UILabel * namelable = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34, 0, windowContentWidth, windowContentHeight / 14.8)];
    namelable.text = @"出游人信息";
    namelable.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
    [_LINE2 addSubview:namelable];
    
    
    
    //是否可编辑出诱人
    for (int i =0; i < _num; i ++) {
       _Dbutton = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth - windowContentHeight / 14.8  , windowContentHeight / 11.5 + windowContentHeight / 9.5  * i, windowContentHeight / 14.8, windowContentHeight / 14.8)];
        [_Dbutton setImage:[UIImage imageNamed:@"矩形-32-副本-2"] forState:UIControlStateNormal];
        _Dbutton.tag = 1 + i;
        [_Dbutton addTarget:self action:@selector(ONDButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_LINE2 addSubview:_Dbutton];

        
#pragma mark ----------------判断是否显示可以修改出游人信息的箭头--------
//        
//        if ([_DICTdata[@"pay_status"] integerValue]== 0 && [_DICTdata[@"pay_way"] integerValue]== 1 && [_DICTdata[@"order_status"] integerValue] != 11) {
//            
//            _Dbutton.hidden = NO;
//            
//        } else if ([_DICTdata[@"pay_status"] integerValue] == 0 && [_DICTdata[@"pay_way"] integerValue] != 1) {
//            
//            if ([_DICTdata[@"order_status"] integerValue] == 90 || [_DICTdata[@"order_status"] integerValue] == 92) {
//                
//                _Dbutton.hidden = NO;
//            }
//        } else {
//            _Dbutton.hidden = YES;
//        }
        
        
        if ([self.hideArrowFlag isEqualToString:@"300"] || [self.frontPageFlag isEqualToString: @"200"]) {
            
            _Dbutton.hidden = YES;
            
        } else {
            
            if (([_DICTdata[@"order_status"] integerValue] == 90 || [_DICTdata[@"order_status"] integerValue] == 92 || [_DICTdata[@"order_status"] integerValue] == 91 || [_DICTdata[@"order_status"] integerValue] == 12) && ([_DICTdata[@"pay_status"] integerValue] == 0)) {
            _Dbutton.hidden = NO;
            } else if ([_DICTdata[@"pay_status"] integerValue] == 0 && ([_DICTdata[@"order_status"] integerValue] == 0 || [_DICTdata[@"order_status"] integerValue] == 1)) {
            _Dbutton.hidden = NO;
            } else if ([_DICTdata[@"pay_status"] integerValue] == 1) {
            _Dbutton.hidden = NO;
            } else {
            _Dbutton.hidden = YES;
            }
            
        }
    }

    //  出诱人人数  num
//    DLog(@"%ld",(long)_num);
    for (int i =0; i < _num; i ++) {
        // 中间黑线
        UILabel * lin = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34, windowContentHeight / 14.8 + windowContentHeight / 9.5 * i, windowContentWidth - windowContentWidth / 34, 0.5)];
        lin.backgroundColor = BgViewColor;
        [_LINE2 addSubview:lin];
        //姓名
        UILabel * namelable = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34, windowContentHeight / 47.6 + windowContentHeight / 16 + windowContentHeight / 9.5 * i, windowContentWidth / 4.7, windowContentHeight / 24.5)];

        namelable.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
        [_LINE2 addSubview:namelable];
        
        UILabel * name = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 4.16, windowContentHeight / 47.6 + windowContentHeight / 16 + windowContentHeight / 9.5 * i, windowContentWidth / 4.7, windowContentHeight / 24.5)];
        namelable.text = [NSString stringWithFormat:@"出游人%d:",i+1];
       
        if ([_arraym isKindOfClass:[NSArray class]]) {
              name.text = _arraym[i][@"t-name"];
        }else{
             name.text=@"";
        }
      

        name.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
        [_LINE2 addSubview:name];

        
        //身份证号
        UILabel * labSF = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34, windowContentHeight / 47.6 + windowContentHeight / 16 + windowContentHeight / 9.5 * i + windowContentHeight / 24.5 , windowContentWidth / 2, windowContentHeight / 24.5)];
        
#pragma mark -----------------------修改证件类型显示BUG-----------------------
        
        id personArray = _DICTdata[@"person_info"];

        if ([personArray isKindOfClass:[NSArray class]]) {
            if ([_DICTdata[@"person_info"] count] == 0  ) {
                self.credentialsStyle = @"1";
            }else{
                NSArray *personInfoArray = _DICTdata[@"person_info"];
                NSDictionary *personDic = personInfoArray[i];
                self.credentialsStyle = [NSString stringWithFormat:@"%@",personDic[@"t-zj"]];
            }
        }
            else
            {
                self.credentialsStyle = @"1";
            }

//        if ([self.credentialsStyle isEqualToString:@"1"]) {
//            labSF.text = @"身份证号:";
//        }else if([self.credentialsStyle isEqualToString:@"2"]){
//            labSF.text = @"护照:";
//        }else if([self.credentialsStyle isEqualToString:@"3"]){
//            labSF.text = @"军官证:";
//        }else if([self.credentialsStyle isEqualToString:@"4"]){
//            labSF.text = @"港澳通行证:";
//        } else if([self.credentialsStyle isEqualToString:@"5"]){
//            labSF.text = @"台胞证:";
//        }
        labSF.text = [NSString stringWithFormat:@"手机号:        %@",_DICTdata[@"phone"]];
        labSF.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
        [_LINE2 addSubview:labSF];
        
//        UILabel * SF = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 4.16, windowContentHeight / 47.6 + windowContentHeight / 16 + windowContentHeight / 9.5 * i + windowContentHeight / 24.5 , 300, windowContentHeight / 24.5)];
//       // labSF.text = @"身份账号:";
//        SF.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
//        if ([_arraym isKindOfClass:[NSArray class]]) {
//
//            SF.text = _arraym[i][@"t-zjnum"];
//        }else{
//            SF.text=@"";
//        }
//        [_LINE2 addSubview:SF];
        
        
    }
    

    _LINE3 = [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num  , windowContentWidth, windowContentHeight / 44.4)];
    _LINE3.backgroundColor = BgViewColor;
    [_scrollView addSubview:_LINE3];
    
}

#pragma mark -- 可编辑联系人按钮

- (void)ONDButtonClick:(UIButton *)sender
{
    ChangeTravellerInfoViewController * changeVC = [[ChangeTravellerInfoViewController alloc]init];
    changeVC.detaillArray = [NSMutableArray array];
    changeVC.order_IdStr = order_IDStr;
    changeVC.product_CategoryStr = product_categoryStr;
    
    if ([_arraym isKindOfClass:[NSArray class]]) {
        [changeVC.detaillArray addObjectsFromArray:_arraym];
    }

    changeVC.tag = [NSString stringWithFormat:@"%ld",(long)sender.tag];
    
    changeVC.changTravelerInfoBlock = ^ (NSDictionary *personInfoDic) {
        NSLog(@"%@",personInfoDic);
    };
    
    
    
    [self.navigationController pushViewController:changeVC animated:YES];
    
}

//联系人信息
- (void)createLOwvc{
    if ([_DICTdata[@"is_have_notice"] integerValue]==1&&[_DICTdata[@"pay_status"] integerValue]==1) {
        _lowvc = [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 11.1  , windowContentWidth, windowContentHeight / 14.8 * 3)];
    }else{
        _lowvc = [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4   , windowContentWidth, windowContentHeight / 14.8 * 3)];

    
    }
 
   
    [_scrollView addSubview:_lowvc];
    for (int i =0; i < 3;  i++) {
        //黑线
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34, windowContentHeight / 14.8 * ( i + 1), windowContentWidth - windowContentWidth / 34, 0.5)];
        line.backgroundColor = BgViewColor;
        [_lowvc addSubview:line];

    }
    
    UILabel * namelable = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34, windowContentHeight / 44.4, windowContentWidth / 2.9, windowContentHeight / 44.4)];
    namelable.text = @"联系人信息";
    namelable.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
    [_lowvc addSubview:namelable];
    
    NSArray * arr = @[@"姓名",@"手机"];

    //联系人信息
    for (int i =0; i < 2; i ++)
    {
        UILabel * xinxLable = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 34,  windowContentHeight / 44.4 + windowContentHeight/ 14.8 * (i + 1) , windowContentWidth / 2.9, windowContentHeight / 44.4)];
        xinxLable.text = [NSString stringWithFormat:@"%@:",arr[i]];
        xinxLable.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
        [_lowvc addSubview:xinxLable];
        
        
    }
    UILabel * xinxName = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 5,  windowContentHeight / 44.4 + windowContentHeight/ 14.8  , windowContentWidth / 2.9, windowContentHeight / 44.4)];
   // xinx.text = marr[i];
   
    xinxName.text = _DICTdata[@"contacts"];
    xinxName.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
    [_lowvc addSubview:xinxName];
    
    UILabel * xinPhone = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 5,  windowContentHeight / 44.4 + windowContentHeight/ 14.8 * (1 + 1) , windowContentWidth / 2.9, windowContentHeight / 44.4)];
    
    xinPhone.text = _DICTdata[@"phone"];
    xinPhone.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
    [_lowvc addSubview:xinPhone];


   }

#pragma mark -------------------------获取订单数据---------------------------
- (void)GEtData
{
    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
     NSDictionary *parameters = @{@"order_id":order_id,@"cat_id":cat_id,@"member_id":[[LXUserTool alloc] getUid],@"wltoken":md5str};
        [manager POST:ORDERS parameters:parameters
     
        success:^(AFHTTPRequestOperation *operation,id responseObject)
         {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
             _DICTdata = dict[@"data"];
              product_categoryStr = _DICTdata[@"product_category"];
              order_IDStr = _DICTdata[@"order_id"];

//             _num = [_DICTdata[@"adule"] intValue];
             if ([_DICTdata[@"person_info"] isKindOfClass:[NSArray class]]) {
                 _num = [_DICTdata[@"person_info"] count];
             } else {
                 _num = 0;
             }
             
             for (UIView *subView in _scrollView.subviews) {
                 [subView removeFromSuperview];
             }
             
//             NSMutableArray *imageAray=[NSMutableArray array];
//             for (int i=0; i<2; i++)
//             {
//                 UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
//                 [imageAray addObject:image];
//             }
//             
//             //-----------下拉刷新
//             //    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//             [self.scrollView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(GEtData)];
//             //    // 设置普通状态的动画图片
//             [self.scrollView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
//             //    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
//             [self.scrollView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
//             //
//             //    // 设置正在刷新状态的动画图片
//             [self.scrollView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];



              [self createSCroll];
              [self Toplable];
              [self Createnum];
              [self CrLIne];
              [self createZHlable];//出游人
              [self createZHIFuANNIU];
              [self createTongzhi];//有无通知
              [self createLOwvc];//联系人
             

             [self.scrollView.gifHeader endRefreshing];
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
}
//出团通知
- (void)getTongzi
{
    //请求数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    NSDictionary *parameters = @{@"member_id":[[LXUserTool alloc] getUid],@"wltoken":md5str,@"order_id":order_id};
  
    [manager POST:TONGZHISHU parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject)
    {
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        
    }];
    

}
#pragma mark --  支付宝支付
- (void)ZHIFUprice
{
  
    _LINE4 = [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 14.8 * 3 , windowContentWidth, windowContentHeight / 44.4)];
    _LINE4.backgroundColor = BgViewColor;
    [_scrollView addSubview:_LINE4];
    
    if (![self.hideArrowFlag  isEqualToString: @"300"]) {
        _LINE4.hidden = YES;
    }
    
    if ([self.hideArrowFlag  isEqualToString: @"200"]) {
        _LINE4.hidden = YES;
    }
    [self createLOWZHIFU];
}
#pragma mark ------------------支付宝\微信视图------------------
- (void)createLOWZHIFU
{
    NSArray * arr = @[@"支付宝支付",@"微信支付"];
    
     self.ZhifuVc = [[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 2.3 + windowContentHeight / 44.4 + windowContentHeight / 14.8 + windowContentHeight / 9.5 * _num + windowContentHeight / 44.4 + windowContentHeight / 14.8 * 3 + windowContentHeight / 44.4 , windowContentWidth, windowContentHeight / 14.8 * 2 + 500)];

    [_scrollView addSubview:_ZhifuVc];
    _ZhifuVc.userInteractionEnabled = YES;
    
    _ONEbutton = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth  - windowContentWidth / 1.6  , 0  , windowContentWidth * 1.1, windowContentHeight / 14.8)];
     [_ONEbutton setImage:[UIImage imageNamed:@"选中按钮"] forState:UIControlStateNormal];
     [_ONEbutton addTarget:self action:@selector(onONEClick) forControlEvents:UIControlEventTouchUpInside];
    [_ZhifuVc addSubview:_ONEbutton];
    
    _TWObutton = [[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth  - windowContentWidth / 1.6  , windowContentHeight / 14.8 , windowContentWidth * 1.1, windowContentHeight / 14.8)];
    [_TWObutton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [_TWObutton addTarget:self action:@selector(onTWoClick) forControlEvents:UIControlEventTouchUpInside];
    [_ZhifuVc addSubview:_TWObutton];
    
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0,  windowContentHeight / 14.8   , windowContentWidth, 0.5)];
    line.backgroundColor = BgViewColor;
    [_ZhifuVc addSubview:line];
    
    NSArray * Imagearr = @[@"ico_pay_alipay",@"icon_pay_wechat"];
    
  
    // 判断微信支付是否安装
    NSInteger paywayCount;
    if ([WXApi isWXAppInstalled]) {
        paywayCount = 2;
    } else {
        paywayCount = 1;
        _TWObutton.hidden = YES;
    }
    
    
    
    for (int i = 0; i < paywayCount; i ++)
    {
        
        UIImageView * imagevc = [[UIImageView alloc]init];
        imagevc.frame = CGRectMake(windowContentWidth / 34, windowContentHeight / 66.7 + windowContentHeight / 14.8 * i, windowContentHeight / 26.8 ,windowContentHeight / 26.8 );
        imagevc.tag = i + 100;
        [imagevc setImage:[UIImage imageNamed:Imagearr[i]]];
        [_ZhifuVc addSubview:imagevc];
        
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth / 8,  windowContentHeight / 14.8 * i, windowContentWidth, windowContentHeight / 14.8)];
        lab.text =arr[i];
        lab.tag = i + 200;
        lab.tintColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:windowContentHeight / 47.6];
        [_ZhifuVc addSubview:lab];
        
        UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0,  windowContentHeight / 14.8 * (i+1) - windowContentHeight / 11.1, windowContentWidth, 0.5)];
        line.backgroundColor = BgViewColor;

        UILabel * la =[[UILabel alloc]initWithFrame:CGRectMake(0, windowContentHeight / 14.8 * paywayCount, windowContentWidth, 500)];
        la.backgroundColor = BgViewColor;
//        la.backgroundColor = [UIColor blackColor];
        [_ZhifuVc addSubview:la];
    }
    
    if (![WXApi isWXAppInstalled]) {
        
        UIImageView *paywayImageView = (UIImageView *)[_ZhifuVc viewWithTag:100];
        [paywayImageView setFrame:CGRectMake(windowContentWidth / 34, 5, windowContentHeight / 26.8 ,windowContentHeight / 26.8 )];
        UILabel *zhifubaoLabel = (UILabel *)[_ZhifuVc viewWithTag:200];
        [zhifubaoLabel setFrame:CGRectMake(windowContentWidth / 8,  -5, windowContentWidth, windowContentHeight / 14.8)];
        [_ONEbutton setFrame:CGRectMake(windowContentWidth  - windowContentWidth / 1.6  , -5  , windowContentWidth * 1.1, windowContentHeight / 14.8)];
    }
    

    if ([self.hideArrowFlag isEqualToString: @"300"]) {
        _ZhifuVc.hidden = YES;
    }
    
    if ([self.hideArrowFlag  isEqualToString: @"200"]) {
        _ZhifuVc.hidden = YES;
    }
    
}

- (void)onONEClick
{
    self.select = NO;
    [_ONEbutton setImage:[UIImage imageNamed:@"选中按钮"] forState:UIControlStateNormal];
   [_TWObutton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    
}

- (void)onTWoClick
{
    self.select = YES;
    [_ONEbutton setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    [_TWObutton setImage:[UIImage imageNamed:@"选中按钮"] forState:UIControlStateNormal];
  
}



#pragma mark ----------------------微信支付--------------------------------
- (void)payOrder
{
    req = [[payRequsestHandler alloc]init];
    [req init:APP_ID mch_id:MCH_ID];
    [req setKey:PARTNER_ID];
    NSMutableDictionary *dict = [self sendPay_demo];
    if(dict == nil)
    {
        //错误提示
        NSString *debug = [req getDebugifo];
        [self alert:@"提示信息" msg:@"支付失败"];
        NSLog(@"%@\n\n",debug);
    }
    else
    {
        NSLog(@"%@\n\n",[req getDebugifo]);
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        PayReq* request             = [[PayReq alloc] init];
        request.openID              = [dict objectForKey:@"appid"];
        request.partnerId           = [dict objectForKey:@"partnerid"];
        request.prepayId            = [dict objectForKey:@"prepayid"];
        request.nonceStr            = [dict objectForKey:@"noncestr"];
        request.timeStamp           = stamp.intValue;
        request.package             = [dict objectForKey:@"package"];
        request.sign                = [dict objectForKey:@"sign"];
        [WXApi safeSendReq:request];
    }
}


- ( NSMutableDictionary *)sendPay_demo
{
    srand( (unsigned)time(0) );
    NSString *noncestr  = [NSString stringWithFormat:@"%d", rand()];
    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
    int money = [_DICTdata[@"order_price"] floatValue]*100;
    
    
    NSString *body= [YXTools filterSpecialString:_DICTdata[@"product_name"]];
    if (body.length >32)
    {
        body = [body substringToIndex:32];
    }
    
    NSString *totalFee = [NSString stringWithFormat:@"%d",money];
    [packageParams setObject: APP_ID             forKey:@"appid"];       //开放平台appid
    [packageParams setObject: MCH_ID             forKey:@"mch_id"];      //商户号
    [packageParams setObject: @"APP-001"         forKey:@"device_info"]; //支付设备号或门店号
    [packageParams setObject: noncestr           forKey:@"nonce_str"];   //随机串
    [packageParams setObject: @"APP"             forKey:@"trade_type"];  //支付类型，固定为APP
    [packageParams setObject: body               forKey:@"body"];        //订单描述，展示给用户
    [packageParams setObject: NOTIFY_URL         forKey:@"notify_url"];  //支付结果异步通知
    [packageParams setObject: _DICTdata[@"order_sn"]       forKey:@"out_trade_no"];//商户订单号
    [packageParams setObject: @"127.0.0.1"       forKey:@"spbill_create_ip"];//发器支付的机器ip
    [packageParams setObject: totalFee           forKey:@"total_fee"];       //订单金额，单位为分
    
    //获取prepayId（预支付交易会话标识）
    NSString *prePayid;
    prePayid= [req sendPrepay:packageParams];
    
    if ( prePayid != nil)
    {
        //获取到prepayid后进行第二次签名
        NSString    *package, *time_stamp, *nonce_str;
        //设置支付参数
        time_stamp  = [self genTimeStamp];
        nonce_str	= [WXUtil md5:time_stamp];
        package         = @"Sign=WXPay";
        //第二次签名参数列表
        NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
        [signParams setObject: APP_ID        forKey:@"appid"];
        [signParams setObject: nonce_str    forKey:@"noncestr"];
        [signParams setObject: package      forKey:@"package"];
        [signParams setObject: MCH_ID        forKey:@"partnerid"];
        [signParams setObject: time_stamp   forKey:@"timestamp"];
        [signParams setObject: prePayid     forKey:@"prepayid"];
        NSString *sign  = [req createMd5Sign:signParams];
        
        //添加签名
        [signParams setObject: sign         forKey:@"sign"];
        //返回参数列表
        return signParams;
        
    }
    else
    {
        
    }
    return nil;
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
}


- (void)getOrderPayResult:(NSNotification *)notification
{
    [self backSuccessViewController];
}

- (void)backSuccessViewController
{
    
    //时间戳转化-出发日期
    NSString *BookTimeString = [_DICTdata objectForKey:@"f_time"];
    NSTimeInterval bookTime = [BookTimeString doubleValue] ;
    NSDate *detaildatee=[NSDate dateWithTimeIntervalSince1970:bookTime];
    NSDateFormatter *dateFormatterr = [[NSDateFormatter alloc] init];
    [dateFormatterr setDateFormat:@"yyyy-MM-dd"];
    NSString * STRS = [dateFormatterr stringFromDate: detaildatee];

    
    int PersonNumber=[_DICTdata[@"adule"] intValue]+[_DICTdata[@"child"] intValue];;
    
    YXPaySuccessViewController *payVC = [[YXPaySuccessViewController alloc] init];
    payVC.beginDate = STRS;
    payVC.number =[NSString stringWithFormat:@"%d",PersonNumber];
    payVC.productName =_DICTdata[@"product_name"];
    payVC.contactPerson = _DICTdata[@"contacts"];
    payVC.phone = _DICTdata[@"phone"];
    
    [self.navigationController pushViewController:payVC animated:YES];
    
}
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(windowContentWidth -20, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}


//添加加载
-(void)setProgressHUD
{
    
    self.HUD = [[MBProgressHUD alloc]initWithView:self.view];
    _HUD.frame = self.view.bounds;
    _HUD.minSize = CGSizeMake(100, 100);
    _HUD.mode = MBProgressHUDModeIndeterminate;
    [self.view addSubview:_HUD];
    [_HUD show:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
