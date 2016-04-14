//
//  ZFJStewardShopOwnVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/14.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJStewardShopOwnVC.h"
#import "ZFJStewardShopOwnCell.h"
#import "ZFJStewardShopHeaderView.h"
#import "ZFJStewardShopInfoVC.h"
#import "ZFJSteShopMoneyDetailVC.h"
#import "ZFJSteShopGoodsConTypeVC.h"
#import "ZFJSteShopOrderVC.h"
#import "ZFJSteShopMsgVC.h"
#import "ZFJSteShopPartnerVC.h"
#import "ZFJSteShopDistributionVC.h"
#import "ZFJSteShopInfoModel.h"
#import "ZFJSteShopListTravelModel.h"
#import "YXDetailTraveViewController.h"
#import "ProductDetailViewController.h"
#import "ShareCustom.h"

#define M_GAP_SECTION_VIEW 20
#define M_GAP_LEFT 10
#define M_HEADER_VIEW_HEIGHT 140
#define M_FUNCTION_VIEW_HEIGHT 95
#define M_SELL_TITLE_VIEW_HEIGHT 30

//#define WLWeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
//#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//#define WeakSelf __weak typeof(self) weakSelf = self;

@interface ZFJStewardShopOwnVC ()<UITableViewDataSource, UITableViewDelegate>
{
    //管家部落扫描二维码URL
    NSString *imgSite;
    
    //管家部落跳转URL
    NSString *assistantSite;
    
    //管家部落名称
    NSString *assistantName;
    
    UIImage *_shareImage;

}
@property (nonatomic, strong) UIView * headerView;
@property (nonatomic, strong) UIView * functionView;
@property (nonatomic, strong) UITableView * sellTableView;
@property (nonatomic, strong) ZFJStewardShopHeaderView * shopInfoView;
@property (nonatomic, strong) ZFJSteShopInfoModel * infoModel;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, copy) NSString * partnerConuntStr;
@end

@implementation ZFJStewardShopOwnVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = M_STEWARD_SHOP_NAME;
    self.partnerConuntStr = @"0";
    [self addSellProductsTabelView];
    [self loadData];

    
    
    //获取管家店铺ID
    NSString *assistantId = [[LXUserTool alloc] getKeeper];
    
    //获取管家UID
    NSString *uid=[[LXUserTool alloc] getUid];
    
    
    //获取管家扫描二维码URL
    imgSite = [NSString stringWithFormat:@"%@",GET_ASSISTANT_SHOP_QRCODE_URL(assistantId)];
    
    //管家部落跳转URL
    assistantSite=[NSString stringWithFormat:@"%@",REGISTER_ASSISTANT_SHOP_URL(uid)];
    
    //获取管家部落名称
    assistantName=[[LXUserTool alloc] getRealname];
    
    
    //新增【管家部落】分享功能
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, 24, 24);
    [searchBtn setImage:[UIImage imageNamed:@"分享1"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNowData) name:@"distributionSuc" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNowData) name:@"cancelDistribution" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadShopAvatar:) name:@"upload_shop_avatar" object:nil];
    
    
    
    //获取分享产品的图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgSite]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _shareImage = [UIImage imageWithData:imageData];
        });
    });
    

}

//分享 点击事件
-(void)shareClick:(UIButton *)sender
{

    //分享的内容
    NSString *content=@"我是微旅管家-";
    content=[content stringByAppendingString:assistantName];
    content=[content stringByAppendingString:@",这是我的部落."];
    
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@"微旅"
                                                image:[ShareSDK jpegImageWithImage:_shareImage quality:1]
                                                title:@"微旅,您家门口的旅行管家"
                                                  url:assistantSite
                                          description:content
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    
    //微信朋友圈显示内容样式
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                          content:INHERIT_VALUE
                                            title:content
                                              url:INHERIT_VALUE
                                       thumbImage:[ShareSDK jpegImageWithImage:_shareImage quality:1]
                                            image:INHERIT_VALUE
                                     musicFileUrl:nil
                                          extInfo:nil
                                         fileData:nil
                                     emoticonData:nil];
    
    
    //QQ空间、好友显示内容样式
    [publishContent addQQUnitWithType:INHERIT_VALUE
                              content:INHERIT_VALUE
                                title:INHERIT_VALUE
                                  url:INHERIT_VALUE
                                image:INHERIT_VALUE];
    
    
    //调用自定义分享
    [ShareCustom shareWithContent:publishContent];

    
    
}



#pragma mark --- AddCustomView
/**
 *  功能选择按钮
 */
- (UIView *)addFunctionView
{
    self.functionView = [[UIView alloc] initWithFrame:CGRectMake(0, (-(M_HEADER_VIEW_HEIGHT + M_FUNCTION_VIEW_HEIGHT + M_GAP_SECTION_VIEW * 2 + M_SELL_TITLE_VIEW_HEIGHT) + M_HEADER_VIEW_HEIGHT) + M_GAP_SECTION_VIEW, windowContentWidth, M_FUNCTION_VIEW_HEIGHT)];
    self.functionView.backgroundColor = [UIColor whiteColor];
    
    NSArray * titleArr = @[@"商品管理", @"分销订单", @"合伙人", [NSString stringWithFormat:@"%@消息", M_STEWARD_SHOP_LAST_NAME]];
    NSArray * iconArr = @[@"商品管理", @"分销订单", @"合伙人", @"店铺消息"];
    for (int i = 0; i < titleArr.count; i++)
    {
    
        UIImageView * funcIcon = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth / titleArr.count * i + (windowContentWidth / titleArr.count - 50) / 2.0 , 10, 50, 50)];
        funcIcon.image = [UIImage imageNamed:[iconArr objectAtIndex:i]];
        funcIcon.userInteractionEnabled = YES;
        [self.functionView addSubview:funcIcon];

        UILabel * funcTitle = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth / titleArr.count * i, ViewBelow(funcIcon), windowContentWidth / titleArr.count, M_FUNCTION_VIEW_HEIGHT - ViewBelow(funcIcon))];
        funcTitle.text = [titleArr objectAtIndex:i];
        funcTitle.font = [UIFont systemFontOfSize:14];
        funcTitle.userInteractionEnabled = YES;
        funcTitle.textAlignment = NSTextAlignmentCenter;
        [self.functionView addSubview:funcTitle];

        UIButton * funcBut = [UIButton buttonWithType:UIButtonTypeCustom];
        funcBut.frame = CGRectMake(windowContentWidth / titleArr.count * i, 0, windowContentWidth / titleArr.count, M_FUNCTION_VIEW_HEIGHT);
        funcBut.tag = 100 + i;
        [funcBut addTarget:self action:@selector(goFunctionView:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.functionView addSubview:funcBut];

    }
    
    
    return _functionView;
}

#pragma mark --- Button点击跳转方法

- (void)goShopMsgView:(UIButton *)button
{
    ZFJStewardShopInfoVC * vc = [[ZFJStewardShopInfoVC alloc] init];
    vc.infoModel = self.infoModel;
    vc.moneyCountStr = _shopInfoView.balanceNumStr;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goDetailMoneyView:(UIButton *)button
{
    ZFJSteShopMoneyDetailVC * shopMoneyDetailVC = [[ZFJSteShopMoneyDetailVC alloc] init];
    [self.navigationController pushViewController:shopMoneyDetailVC animated:YES];
    
}

- (void)goFunctionView:(UIButton *)button
{
    switch (button.tag - 100)
    {
        case 0:
        {
            //商品管理
            ZFJSteShopGoodsConTypeVC * vc = [[ZFJSteShopGoodsConTypeVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
              //分销订单
            ZFJSteShopOrderVC * vc = [[ZFJSteShopOrderVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 2:
        {
            //合伙人
            ZFJSteShopPartnerVC * vc = [[ZFJSteShopPartnerVC alloc] init];
            vc.partnerCountStr = self.partnerConuntStr;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 3:
        {
            //部落消息
            ZFJSteShopMsgVC * vc = [[ZFJSteShopMsgVC alloc] init];
            WS(ws);
            [vc refreshSteShopInfo:^{
                [ws refreshNowData];
            }];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;

        default:
            break;
    }
}

/**
 *  销售产品列表
 */
- (void)addSellProductsTabelView {
    self.sellTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.sellTableView.dataSource = self;
    self.sellTableView.delegate = self;
    self.sellTableView.rowHeight = 100;
    self.sellTableView.contentInset = UIEdgeInsetsMake(M_HEADER_VIEW_HEIGHT + M_FUNCTION_VIEW_HEIGHT + M_GAP_SECTION_VIEW * 2 + M_SELL_TITLE_VIEW_HEIGHT, 0, 0, 0);
    self.sellTableView.tableFooterView = [[UIView alloc] init];
    self.shopInfoView = [[ZFJStewardShopHeaderView alloc] initWithFrame:CGRectMake(0, -(M_HEADER_VIEW_HEIGHT + M_FUNCTION_VIEW_HEIGHT + M_GAP_SECTION_VIEW * 2 + M_SELL_TITLE_VIEW_HEIGHT), windowContentWidth, M_HEADER_VIEW_HEIGHT)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShopName:) name:@"shopName" object:nil];

    [_shopInfoView.shopMsgBut addTarget:self action:@selector(goShopMsgView:) forControlEvents:UIControlEventTouchUpInside];
    [_shopInfoView.detailsBut addTarget:self action:@selector(goDetailMoneyView:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sellTableView addSubview:_shopInfoView];
    [self.sellTableView addSubview:[self addFunctionView]];
    
  
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, -M_SELL_TITLE_VIEW_HEIGHT, windowContentWidth, M_SELL_TITLE_VIEW_HEIGHT)];
    titleView.backgroundColor = [UIColor whiteColor];
    
    UILabel * sellTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_GAP_LEFT, 0, windowContentWidth - M_GAP_LEFT, M_SELL_TITLE_VIEW_HEIGHT)];
    sellTitleLabel.text = @"销售商产品";
    [titleView addSubview:sellTitleLabel];
    
    [self.sellTableView addSubview:titleView];
    
    self.sellTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_sellTableView];
}
#pragma mark --- 通知

- (void)changeShopName:(NSNotification *)notification {
    NSString * str = [notification object];
    _shopInfoView.shopTitleStr = str;
}

- (void)refreshNowData {
    [self.dataArr removeAllObjects];
    [self loadData];
    
}

- (void)uploadShopAvatar:(NSNotification *)notification{
    _shopInfoView.shopIcon.image = [notification object];
}

#pragma mark --- UITabelViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"TravelCell";
    ZFJStewardShopOwnCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJStewardShopOwnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.distributionBut.tag = 100 + indexPath.row;
    [cell.distributionBut addTarget:self action:@selector(goDistributionVC:) forControlEvents:UIControlEventTouchUpInside];
    cell.modelTravel = [self.dataArr objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    YXDetailTraveViewController * vc = [[YXDetailTraveViewController alloc] init];
    ZFJSteShopListTravelModel * model = [self.dataArr objectAtIndex:indexPath.row];
//    vc.productId = model.product_id;
//    vc.orderSource = WLOrderSourceStewardShop;
//    vc.store_id = [[WLSingletonClass defaultWLSingleton] wlUserSteShopID];
//    [self.navigationController pushViewController:vc animated:YES];
    ProductDetailViewController *productVC = [[ProductDetailViewController alloc]init];
    productVC.productID = model.product_id;
    productVC.gj_commission = model.partner_reward;
    [self.navigationController pushViewController:productVC animated:YES];
}

#pragma mark --- 点击分销
- (void)goDistributionVC:(UIButton *)button {
    
    ZFJSteShopDistributionVC * vc = [[ZFJSteShopDistributionVC alloc] init];
    vc.goodsType = ZFJGoodsTypeOfTravel;
    vc.goodsTeam = ZFJGoodsTeamOfRetailer;
    vc.model = [self.dataArr objectAtIndex:button.tag - 100];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --- LoadData
- (void)loadData {
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                                 @"store_id":[[WLSingletonClass defaultWLSingleton] wlUserSteShopID],
                                 @"type":@"1",
                                 @"show_type":@"1",
                                 @"limit":@"5"};
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_SHOP_HOME;
    
    //发送请求
    __weak ZFJStewardShopOwnVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1 && [[dic objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            if ([[[dic objectForKey:@"data"] objectForKey:@"store_info"] isKindOfClass:[NSDictionary class]]) {
                weakSelf.infoModel = [[ZFJSteShopInfoModel alloc] initWithDictionary:[[dic objectForKey:@"data"] objectForKey:@"store_info"]];
               
                [_shopInfoView.shopIcon sd_setImageWithURL:[NSURL URLWithString:[weakSelf judgeImageURL:weakSelf.infoModel.store_avatar]] placeholderImage:[UIImage imageNamed:@"默认图2"]];
                _shopInfoView.shopTitleStr = [weakSelf judgeReturnString:weakSelf.infoModel.store_name withReplaceString:@"部落"];
                DLog(@"%@",[[dic objectForKey:@"data"] objectForKey:@"goods_count"]);
                _shopInfoView.productCountStr = [NSString stringWithFormat:@"分销产品:%@个", [[dic objectForKey:@"data"] objectForKey:@"goods_count"]];
                _shopInfoView.partnerCountStr = [NSString stringWithFormat:@"合伙人:%@人", [[dic objectForKey:@"data"] objectForKey:@"partner_count"]];
                weakSelf.partnerConuntStr = [[dic objectForKey:@"data"] objectForKey:@"partner_count"];
                if ([[[dic objectForKey:@"data"] objectForKey:@"cash_account"] isKindOfClass:[NSArray class]]) {
                    NSArray * arr = [[dic objectForKey:@"data"] objectForKey:@"cash_account"];
                    if (arr.count >0) {
                        CGFloat activeV = [[[[[dic objectForKey:@"data"] objectForKey:@"cash_account"] objectAtIndex:0] objectForKey:@"active"] floatValue];
                        CGFloat inaactiveV = [[[[[dic objectForKey:@"data"] objectForKey:@"cash_account"] objectAtIndex:0] objectForKey:@"inactive"] floatValue];
                        _shopInfoView.balanceNumStr = [weakSelf judgeReturnString:[NSString stringWithFormat:@"%.2f", (activeV + inaactiveV)] withReplaceString:@"0.00"];
                    } else {
                        _shopInfoView.balanceNumStr = @"0.00";
                    }
                }
            }
            
            if ([[[dic objectForKey:@"data"] objectForKey:@"goods"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * productDic in [[dic objectForKey:@"data"] objectForKey:@"goods"]) {
                    DLog(@"%@",productDic);
                    ZFJSteShopListTravelModel * model = [[ZFJSteShopListTravelModel alloc] initWithDictionary:productDic];
                    [weakSelf.dataArr addObject:model];
                }
            }
            [weakSelf.sellTableView reloadData];
            //[[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
        }
   
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:weakSelf] showErrorMsgInView:weakSelf.view evn:^{
            [weakSelf loadData];
        }];
        
    }];
    
}
- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
