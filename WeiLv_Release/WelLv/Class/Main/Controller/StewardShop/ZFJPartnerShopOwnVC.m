//
//  ZFJPartnerShopOwnVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJPartnerShopOwnVC.h"
#import "ZFJStewardShopHeaderView.h"
#import "ZFJStewardShopInfoVC.h"
#import "ZFJSteShopCommendProductCell.h"
#import "ZFJSteShopMoneyDetailVC.h"
#import "ZFJSteShopInfoModel.h"
#import "ZFJSteShopListTravelModel.h"
#import "YXDetailTraveViewController.h"
#import "ZFJSteShopProductListVC.h"
#import "IconAndTitleView.h"
#import "ProductDetailViewController.h"

#define CELL_INDENTIFIER @"Cell"

@interface ZFJPartnerShopOwnVC ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    //合伙人部落扫描二维码URL
    NSString *imgSite;
    
    //合伙人部落跳转URL
    NSString *partnerSite;
    
    //合伙人部落名称
    NSString *partnerName;
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) ZFJStewardShopHeaderView * headerView;
@property (nonatomic, strong) UIView * headerBgView;
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) ZFJSteShopInfoModel * infoModel;

@end

@implementation ZFJPartnerShopOwnVC

- (void)viewDidLoad
{
    //父类初始化
    [super viewDidLoad];
    
    //设置当前视图背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置当前视图标题
    NSString *partnerRealName= [[LXUserTool alloc] getRealname];
    partnerRealName=[partnerRealName stringByAppendingString:@"的部落"];
    self.title=partnerRealName;
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadShopAvatar:) name:@"upload_shop_avatar" object:nil];
    
    
    //获取合伙人店铺ID
    NSString *partnerId = [[LXUserTool alloc] getKeeper];
    
    //获取合伙人UID
    NSString *uid=[[LXUserTool alloc] getUid];
    
    //获取管家扫描二维码URL
    imgSite = [NSString stringWithFormat:@"%@",GET_ASSISTANT_SHOP_QRCODE_URL(uid)];

    
    //合伙人部落跳转URL
    partnerSite=[NSString stringWithFormat:@"%@",REGISTER_PARTANT_SHOP_URL(uid)];
    
    //获取合伙人部落名称
    partnerName=[[LXUserTool alloc] getRealname];
    if (partnerName==nil)
    {
        partnerName=[[LXUserTool alloc] getUserName];
    }
    
    //创建分享按钮
    [self addNavChooseBut];
    
    //创建自定义CollectionView
    [self customCollectionView];
    
    //获取网络列表数据
    [self loadData];
}
#pragma mark --- 添加分享
- (void)addNavChooseBut
{
    UIButton * chooseBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBut.frame = CGRectMake(0, 0 , ViewHeight(self.navigationController.navigationBar) - 5, ViewHeight(self.navigationController.navigationBar) - 5);
    chooseBut.backgroundColor = [UIColor whiteColor];
    [chooseBut addTarget:self action:@selector(shareShop:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(chooseBut) - 18, (ViewHeight(chooseBut) - 21) / 2.0, 24, 24)];
    icon.image = [UIImage imageNamed:@"分享1"];
    [chooseBut addSubview:icon];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chooseBut];
}

#pragma mark - 分享按钮 点击事件
- (void)shareShop:(UIButton *)sender
{
   
    //分享的内容
    NSString *content=@"我是微旅管家合伙人";
    content=[content stringByAppendingString:partnerName];
    content=[content stringByAppendingString:@",这是我的部落."];
    
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@"微旅"
                                                image:[ShareSDK imageWithUrl:imgSite]
                                                title:@"微旅,您家门口的旅行管家"
                                                  url:partnerSite
                                          description:content
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    
    
    //创建自定义分享列表
    NSArray *shareList = [ShareSDK customShareListWithType:
                          SHARE_TYPE_NUMBER(ShareTypeQQSpace),
                          SHARE_TYPE_NUMBER(ShareTypeQQ),
                          SHARE_TYPE_NUMBER(ShareTypeWeixiTimeline),
                          SHARE_TYPE_NUMBER(ShareTypeWeixiSession),
                          nil];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:NO
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                    message:nil
                                                                                   delegate:self
                                                                          cancelButtonTitle:@"确定"
                                                                          otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                    message:[NSString stringWithFormat:@"失败原因：%@",[error errorDescription]]
                                                                                   delegate:self
                                                                          cancelButtonTitle:@"确定"
                                                                          otherButtonTitles:nil, nil];
                                    [alert show];
                                    
                                }
                            }];
    
    
    


}

#pragma mark --- 加载UICollectionView

- (void)customCollectionView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.itemSize = CGSizeMake((windowContentWidth - 25) / 2.0, (windowContentWidth - 25) / 2.0 * 220 / 352.0 + 55);
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight) collectionViewLayout:layout];
    self.collectionView.contentInset = UIEdgeInsetsMake(185, 0, 5, 0);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[ZFJSteShopCommendProductCell class] forCellWithReuseIdentifier:CELL_INDENTIFIER];
    [self.view addSubview:_collectionView];
    
    self.headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -185, windowContentWidth, 185)];
    self.headerBgView.backgroundColor =  kColor(240, 246, 251);
    [self.collectionView addSubview:_headerBgView];
    
    self.headerView = [[ZFJStewardShopHeaderView alloc] initWithFrame:CGRectMake(0, 0 , windowContentWidth, 140)];
    [self.headerView.shopIcon sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"默认图2"]];
    self.headerView.balanceNumStr = @"0.00";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShopName:) name:@"shopName" object:nil];

    [self.headerView.shopMsgBut addTarget:self action:@selector(goShopMsgView:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView.detailsBut addTarget:self action:@selector(goDetailMoneyView:) forControlEvents:UIControlEventTouchUpInside];

    [self.headerBgView addSubview:self.headerView ];
    
    IconAndTitleView * titleView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewHeight(_headerBgView) - 30, windowContentWidth, 30)];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.titleStr = @"推荐产品";
    titleView.more = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goMoreView:)];
    [titleView addGestureRecognizer:tap];
    [self.headerBgView addSubview:titleView];

}

#pragma mark --- 更多
- (void)goMoreView:(UIButton *)button
{
    ZFJSteShopProductListVC * vc = [[ZFJSteShopProductListVC alloc] init];
    vc.userType = WLMemberTypeMember;
    vc.stewardIDStr = [[WLSingletonClass defaultWLSingleton] wlUserStewardID];
    vc.store_id = self.infoModel.shop_ID;
    [self.navigationController pushViewController:vc
                                         animated:YES];
}

#pragma mark --- 通知
- (void)changeShopName:(NSNotification *)notification
{
    NSString * str = [notification object];
    _headerView.shopTitleStr = str;
    self.infoModel.store_name = str;
    
}

- (void)uploadShopAvatar:(NSNotification *)notification
{
    _headerView.shopIcon.image = [notification object];
}

#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZFJSteShopCommendProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_INDENTIFIER forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    ZFJSteShopListTravelModel * model = [self.dataArr objectAtIndex:indexPath.row];
    cell.modelTravel = model;
    return cell;
}

#pragma mark --- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZFJSteShopListTravelModel * model = [self.dataArr objectAtIndex:indexPath.row];
//    YXDetailTraveViewController * vc = [[YXDetailTraveViewController alloc] init];
//    vc.productId = model.product_id;
//    vc.orderSource = WLOrderSourceStewardShop;
//    vc.store_id = self.infoModel.shop_ID;
//    [self.navigationController pushViewController:vc animated:YES];
    ProductDetailViewController *productVC = [[ProductDetailViewController alloc]init];
    productVC.productID = model.product_id;
    productVC.gj_commission = model.partner_reward;
    [self.navigationController pushViewController:productVC animated:YES];
}

#pragma mark --- Button点击跳转方法
- (void)goShopMsgView:(UIButton *)button
{
    ZFJStewardShopInfoVC * vc = [[ZFJStewardShopInfoVC alloc] init];
    vc.infoModel = self.infoModel;
    vc.moneyCountStr = _headerView.balanceNumStr;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goDetailMoneyView:(UIButton *)button
{
    ZFJSteShopMoneyDetailVC * shopMoneyDetailVC = [[ZFJSteShopMoneyDetailVC alloc] init];
    [self.navigationController pushViewController:shopMoneyDetailVC animated:YES];
    
}
#pragma mark --- LoadData
- (void)loadData
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"uid":[[WLSingletonClass defaultWLSingleton] wlUserID],
                                 @"store_id":[[WLSingletonClass defaultWLSingleton] wlUserSteShopID],
                                 @"show_type":@"1",
                                 @"limit":@"6"};
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_PARTNER_HOME;
    //发送请求
    __weak ZFJPartnerShopOwnVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1 && [[dic objectForKey:@"data"] isKindOfClass:[NSDictionary class]])
        {
            if ([[[dic objectForKey:@"data"] objectForKey:@"store_info"] isKindOfClass:[NSDictionary class]])
            {
                weakSelf.infoModel = [[ZFJSteShopInfoModel alloc] initWithDictionary:[[dic objectForKey:@"data"] objectForKey:@"store_info"]];
                
                
                if (weakSelf.infoModel.store_name!=nil)
                {
                    NSString *partnerRealName=weakSelf.infoModel.store_name;
                    partnerRealName=[partnerRealName stringByAppendingString:@"的部落"];
                    weakSelf.title=partnerRealName;
                }
                
                [_headerView.shopIcon sd_setImageWithURL:[NSURL URLWithString:[weakSelf judgeImageURL:weakSelf.infoModel.store_avatar]] placeholderImage:[UIImage imageNamed:@"默认图2"]];
                _headerView.shopTitleStr = [weakSelf judgeReturnString:weakSelf.infoModel.store_name withReplaceString:@"部落"];
                _headerView.productCountStr = [NSString stringWithFormat:@"分销产品:%@个", [[dic objectForKey:@"data"] objectForKey:@"goods_count"]];
            }
            
            if ([[[dic objectForKey:@"data"] objectForKey:@"goods"] isKindOfClass:[NSArray class]])
            {
                for (NSDictionary * productDic in [[dic objectForKey:@"data"] objectForKey:@"goods"])
                {
                    ZFJSteShopListTravelModel * model = [[ZFJSteShopListTravelModel alloc] initWithDictionary:productDic];
                    [weakSelf.dataArr addObject:model];
                }
            }
            [weakSelf.collectionView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [weakSelf loadData];
        }];
        
    }];
    
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

- (NSMutableArray *)dataArr
{
    if (!_dataArr)
    {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}


@end
