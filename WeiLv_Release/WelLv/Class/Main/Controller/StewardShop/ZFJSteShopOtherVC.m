//
//  ZFJSteShopOtherVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopOtherVC.h"
#import "ZFJStewardShopHeaderView.h"
//#import "ZFJStewardShopMsgVC.h"
#import "ZFJSteShopCommendProductCell.h"
#import "ZFJSteShopInfoModel.h"
#import "ZFJSteShopListTravelModel.h"
#import "YXDetailTraveViewController.h"
#import "IconAndTitleView.h"
#import "ZFJSteShopProductListVC.h"
#import "LoginAndRegisterViewController.h"
#import "ShouyeHouseViewController.h"
#import "ProductDetailViewController.h"

#define CELL_INDENTIFIER @"Cell"
@interface ZFJSteShopOtherVC ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) ZFJStewardShopHeaderView * headerView;
@property (nonatomic, strong) UIView * headerBgView;
@property (nonatomic, strong) UIButton * addBut;
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) ZFJSteShopInfoModel * infoModel;
@property (nonatomic, copy) NSString * shop_ID;

@end

@implementation ZFJSteShopOtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(240, 246, 251);
    self.title = M_STEWARD_SHOP_NAME;
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] != WLMemberTypeSteward) {
        [self addNavChooseBut];
    }
    [self customCollectionView];
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember &&
        ![[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteShop]) {
        [self loadMemberShopID];
        [self loadShopID];
        
    } else {
        [self loadShopID];
    }
    //[self loadData];
}
#pragma mark --- 添加电话
/**
 *  添加电话按钮
 *
 *  @return
 */
- (void)addNavChooseBut {
    UIButton * chooseBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBut.frame = CGRectMake(0, 0 , ViewHeight(self.navigationController.navigationBar) - 5, ViewHeight(self.navigationController.navigationBar) - 5);
    chooseBut.backgroundColor = [UIColor whiteColor];
    //[chooseBut setImage:[UIImage imageNamed:@"ste_shop_coll_icon"] forState:UIControlStateNormal];
    [chooseBut addTarget:self action:@selector(collBut:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(chooseBut) - 17, (ViewHeight(chooseBut) - 22) / 2.0, 17, 22)];
    icon.image = [UIImage imageNamed:@"ste_shop_coll_icon"];
    [chooseBut addSubview:icon];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chooseBut];
}

- (void)collBut:(UIButton *)button {
    NSString * telString = [NSString stringWithFormat:@"tel:%@", self.assistant_mobile];
    NSLog(@"%@",self.assistant_mobile);
    NSURL * telUrl = [NSURL URLWithString:telString];
    [[UIApplication sharedApplication] openURL:telUrl];

}
#pragma mark --- 加载UICollectionView
- (void)customCollectionView {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.itemSize = CGSizeMake((windowContentWidth - 25) / 2.0, (windowContentWidth - 25) / 2.0 * 220 / 352.0 + 55);
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 10;

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight) collectionViewLayout:layout];
    //self.chooseCollectionView.contentOffset = CGPointMake(0, -70);
    //self.chooseCollectionView.contentSize = CGSizeMake(windowContentWidth, -70);
    self.collectionView.contentInset = UIEdgeInsetsMake(190, 0, 5, 0);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //_chooseCityTableView.backgroundColor = bordColor;
    [self.collectionView registerClass:[ZFJSteShopCommendProductCell class] forCellWithReuseIdentifier:CELL_INDENTIFIER];
    [self.view addSubview:_collectionView];

    self.headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -190, windowContentWidth, 190)];
    self.headerBgView.backgroundColor =  kColor(240, 246, 251);
    [self.collectionView addSubview:_headerBgView];
    
    self.headerView = [[ZFJStewardShopHeaderView alloc] initWithFrame:CGRectMake(0, 0 , windowContentWidth, 90)];
    [self.headerBgView addSubview:self.headerView ];
    
    if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward) {
        
        self.collectionView.contentInset = UIEdgeInsetsMake(135, 0, 5, 0);
        self.headerBgView.frame = CGRectMake(0, -135, windowContentWidth, 135);
        
    } else {
        #pragma mark -----添加合伙人
        
        self.addBut = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBut.frame = CGRectMake(0, ViewBelow(_headerView) + 15, windowContentWidth, 40);
        self.addBut.backgroundColor = [UIColor whiteColor];
        [self.addBut setTitle:@"成为合伙人" forState:UIControlStateNormal];
        [self.addBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.addBut addTarget:self action:@selector(addPartner:) forControlEvents:UIControlEventTouchUpInside];
        [self.headerBgView addSubview:self.addBut];
//        //是否是合伙人
//        if ([[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteShop])
//        {
//            //不是合伙人  显示添加按钮
//            self.addBut.hidden = NO;
//         
//            
//        }else
//        {
//            //是合伙人 隐藏 添加合伙人按钮
//            self.addBut.hidden = YES;
//        }
            self.collectionView.contentInset = UIEdgeInsetsMake(135, 0, 5, 0);
            self.headerBgView.frame = CGRectMake(0, -135, windowContentWidth, 135);
    }
    if (([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeMember)&&![[WLSingletonClass defaultWLSingleton]wlSetHehuo]) {
    
            self.collectionView.contentInset = UIEdgeInsetsMake(135+50, 0, 5, 0);
            self.headerBgView.frame = CGRectMake(0, -135-50, windowContentWidth, 135+50);
            self.addBut = [UIButton buttonWithType:UIButtonTypeCustom];
            self.addBut.frame = CGRectMake(0, ViewBelow(_headerView) + 15, windowContentWidth, 40);
            self.addBut.backgroundColor = [UIColor whiteColor];
            [self.addBut setTitle:@"成为合伙人" forState:UIControlStateNormal];
            [self.addBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [self.addBut addTarget:self action:@selector(addPartner:) forControlEvents:UIControlEventTouchUpInside];
            [self.headerBgView addSubview:self.addBut];
            
        }

    IconAndTitleView * titleView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewHeight(_headerBgView) - 30, windowContentWidth, 30)];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.titleStr = @"推荐产品";
    titleView.more = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goMoreView:)];
    [titleView addGestureRecognizer:tap];
//    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewHeight(_headerBgView) - 30 , windowContentWidth, 30)];
//    self.titleLab.backgroundColor =[UIColor whiteColor];
//    self.titleLab.text = @"    推荐产品";
    [self.headerBgView addSubview:titleView];
    
}
#pragma mark --- 更多
- (void)goMoreView:(UIButton *)button {
    
    ZFJSteShopProductListVC * vc = [[ZFJSteShopProductListVC alloc] init];
    vc.userType = WLMemberTypeMember;
    vc.stewardIDStr = self.assistant_id;
    vc.store_id = self.shop_ID;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ---------成为合伙人button---------
- (void)addPartner:(UIButton *)button {
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeNone) {
        LoginAndRegisterViewController * vc = [[LoginAndRegisterViewController alloc] init];
        WS(ws);
        vc.block = ^(NSDictionary * dic) {
    if (([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember && [[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteward]) || [[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
                //NSLog(@"%@", ws.navigationController.childViewControllers);
                UIViewController * vc = [ws.navigationController.childViewControllers objectAtIndex:0];
                [ws.navigationController popToViewController:vc animated:YES];
            }
        };
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    /**
     *  判断会员 是不是管家，只有绑定过管家，才能申请合伙人
     */
    if ([[[LXUserTool sharedUserTool]getKeeper]intValue]==0) {
        [[LXAlterView sharedMyTools]createTishi:@"您还没有绑定管家，请绑定管家"];
        
    }else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //[self setProgressHud];
        NSDictionary * parameters = @{};
        if (self.shop_ID && [[WLSingletonClass defaultWLSingleton] wlUserID] && self.assistant_id) {
            parameters = @{@"assistant_id": self.assistant_id,
                           @"uid":[[WLSingletonClass defaultWLSingleton] wlUserID],
                           @"store_id":self.shop_ID};
        } else {
            [[LXAlterView sharedMyTools] createTishi:@"失败,请重试。"];
            return;
        }
        NSLog(@"parameters = %@", parameters);
        //接口
        NSString *url= M_SS_URL_ADD_PARTNER;
        //发送请求
        //__weak ZFJSteShopOtherVC * weakSelf = self;
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"JSON: %@",  dic);
            NSLog(@"%@", [dic objectForKey:@"msg"]);
            if ([dic isKindOfClass:[NSDictionary class]] ) {
                if ([[dic objectForKey:@"status"] integerValue] == 4) {
                    [[LXAlterView sharedMyTools] createTishi:@"\n  您已经申请成为管家合伙人,请等待审核结果。  \n"];
                }else
                {
                    [[LXAlterView sharedMyTools] createTishi:[dic objectForKey:@"msg"]];
                
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[LXAlterView sharedMyTools] createTishi:@"失败,请重试。"];
        }];
    
    }
   
    
}
#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
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
    productVC.shop_id=self.shop_ID;
    [self.navigationController pushViewController:productVC animated:YES];
    
}
#pragma mark --- LoadData
- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"assistant_id":self.assistant_id,
                                 @"store_id":self.shop_ID,
                                 @"type":@"2",
                                 @"show_type":@"1",
                                 @"limit":@"6"};
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_SHOP_HOME;
    
    //发送请求
    __weak ZFJSteShopOtherVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1 && [[dic objectForKey:@"data"] isKindOfClass:[NSDictionary class]])
        {
            if ([[[dic objectForKey:@"data"] objectForKey:@"store_info"] isKindOfClass:[NSDictionary class]])
            {
                weakSelf.infoModel = [[ZFJSteShopInfoModel alloc] initWithDictionary:[[dic objectForKey:@"data"] objectForKey:@"store_info"]];
                
                [_headerView.shopIcon sd_setImageWithURL:[NSURL URLWithString:[weakSelf judgeImageURL:weakSelf.infoModel.store_avatar]] placeholderImage:[UIImage imageNamed:@"默认图2"]];
                _headerView.shopTitleStr = [weakSelf judgeReturnString:weakSelf.infoModel.store_name withReplaceString:@"部落"];
                _headerView.productCountStr = [NSString stringWithFormat:@"分销产品:%@个", [[dic objectForKey:@"data"] objectForKey:@"goods_count"]];
                _headerView.partnerCountStr = [NSString stringWithFormat:@"合伙人:%@人", [[dic objectForKey:@"data"] objectForKey:@"partner_count"]];
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
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

- (void)loadShopID
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    NSDictionary * parameters = @{@"uid":self.assistant_id,
                                  @"id_type":@"1"};
    NSString * url = M_SS_URL_SHOP_ID;
    NSLog(@"%@", parameters);
    __weak ZFJSteShopOtherVC * weakSelf = self;
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject)
    {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              NSLog(@"shop_dic === %@", dic);
              NSLog(@"%@", [dic objectForKey:@"msg"]);
              if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1)
              {
                  if ([self judgeString:[[dic objectForKey:@"data"] objectForKey:@"store_id"]])
                  {
                      weakSelf.shop_ID = [[dic objectForKey:@"data"] objectForKey:@"store_id"];
                      [weakSelf loadData];
                  }
              }
              else
              {
                  [[WLSingletonClass defaultWLSingleton] wlAddNoDataViewWithSuperView:weakSelf.view];
              }
          }failure:^(AFHTTPRequestOperation *operation,NSError *error)
          {
              NSLog(@"Error: %@", error);
              [[WLSingletonClass defaultWLSingleton] wlAddNoDataViewWithSuperView:weakSelf.view];

          }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[WLSingletonClass defaultWLSingleton] wlHiddenNoDataView];
}

- (void)loadMemberShopID
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary * parameters = @{@"uid":[[WLSingletonClass defaultWLSingleton] wlUserID],
                                  @"id_type":@"2"};
    NSString * url = M_SS_URL_SHOP_ID;
    NSLog(@"%@", parameters);
   WS(weakSelf);
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject)
    {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              NSLog(@"shop_dic === %@", dic);
              NSLog(@"%@", [dic objectForKey:@"msg"]);
              if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1)
                {

                  if ([self judgeString:[[dic objectForKey:@"data"] objectForKey:@"store_id"]]) {
// [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [self judgeReturnString:[[dic objectForKey:@"data"] objectForKey:@"store_id"]  withReplaceString:@"0"]] forKey:@"ste_shop_ID"];
                      //[weakSelf loadShopID];
                  }
                  else
                  {
                      [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"ste_shop_ID"];
                      //[weakSelf loadShopID];
                  }
              } else {
                  [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"ste_shop_ID"];
                  //[weakSelf loadShopID];
                  //[[WLSingletonClass defaultWLSingleton] wlAddNoDataViewWithSuperView:weakSelf.view];
              }
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              NSLog(@"Error: %@", error);
              //[weakSelf loadShopID];
              [[WLSingletonClass defaultWLSingleton] wlAddNoDataViewWithSuperView:weakSelf.view];
              [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"ste_shop_ID"];

          }];
}

@end
