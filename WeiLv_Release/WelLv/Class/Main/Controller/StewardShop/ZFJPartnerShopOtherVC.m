//
//  ZFJPartnerShopOtherVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJPartnerShopOtherVC.h"
#import "ZFJStewardShopHeaderView.h"
//#import "ZFJStewardShopMsgVC.h"
#import "ZFJSteShopCommendProductCell.h"
#import "ZFJSteShopInfoModel.h"
#import "ZFJSteShopListTravelModel.h"
#import "YXDetailTraveViewController.h"
#import "IconAndTitleView.h"
#import "ProductDetailViewController.h"

#define CELL_INDENTIFIER @"Cell"

@interface ZFJPartnerShopOtherVC ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) ZFJStewardShopHeaderView * headerView;
@property (nonatomic, strong) UIView * headerBgView;
@property (nonatomic, strong) UILabel * titleLab;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) ZFJSteShopInfoModel * infoModel;

@end

@implementation ZFJPartnerShopOtherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self customCollectionView];
    
}
#pragma mark --- 加载UICollectionView

- (void)customCollectionView {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    layout.itemSize = CGSizeMake((windowContentWidth - 25) / 2.0, (windowContentWidth - 25) / 2.0 * 220 / 352.0 + 40);
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 10;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight) collectionViewLayout:layout];
    //self.chooseCollectionView.contentOffset = CGPointMake(0, -70);
    //self.chooseCollectionView.contentSize = CGSizeMake(windowContentWidth, -70);
    self.collectionView.contentInset = UIEdgeInsetsMake(135, 0, 0, 0);
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //_chooseCityTableView.backgroundColor = bordColor;
    [self.collectionView registerClass:[ZFJSteShopCommendProductCell class] forCellWithReuseIdentifier:CELL_INDENTIFIER];
    [self.view addSubview:_collectionView];
    
    
    
    self.headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -135, windowContentWidth, 135)];
    self.headerBgView.backgroundColor =  kColor(240, 246, 251);
    [self.collectionView addSubview:_headerBgView];
    
    self.headerView = [[ZFJStewardShopHeaderView alloc] initWithFrame:CGRectMake(0, 0 , windowContentWidth, 90)];
    [self.headerView.shopIcon sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"默认图2"]];
    self.headerView.shopTitleStr = @"测试123456789";
    self.headerView.productCountStr = @"分销产品:120个";
    //self.headerView.partnerCountStr = @"合伙人:220人";
    self.headerView.balanceNumStr = @"1111.00";
    
    //[self.headerView .shopMsgBut addTarget:self action:@selector(goShopMsgView:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerBgView addSubview:self.headerView ];
    
    
//    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewBelow(_headerView) + 15, windowContentWidth, 30)];
//    self.titleLab.backgroundColor =[UIColor whiteColor];
//    self.titleLab.text = @"   推荐产品";
    IconAndTitleView * titleView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewHeight(_headerBgView) - 30, windowContentWidth, 30)];
    titleView.backgroundColor = [UIColor whiteColor];
    titleView.titleStr = @"推荐产品";
    titleView.more = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goMoreView:)];
    [titleView addGestureRecognizer:tap];
    [self.headerBgView addSubview:titleView];
    
}

#pragma mark --- 更多
- (void)goMoreView:(UIButton *)button {
    NSLog(@"*******");
}

#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZFJSteShopCommendProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_INDENTIFIER forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.titleLab.text =@"旅游产品标题＋＋＋＋＋＋＋＋＋＋＋＋＋";
    cell.priceLab.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#6F7378;font-size:14px>微旅价:</span><span style=color:#FF5B26;font-size:14px>¥%@</span>", @"300"] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    return cell;
}

#pragma mark --- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ZFJSteShopListTravelModel * model = [self.dataArr objectAtIndex:indexPath.row];
//    YXDetailTraveViewController * vc = [[YXDetailTraveViewController alloc] init];
//    vc.productId = model.product_id;
//    [self.navigationController pushViewController:vc animated:YES];
    ProductDetailViewController *productVC = [[ProductDetailViewController alloc]init];
    productVC.productID = model.product_id;
    productVC.gj_commission = model.partner_reward;
    [self.navigationController pushViewController:productVC animated:YES];
}

#pragma mark --- LoadData
- (void)loadData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                                 @"store_id":@"3",
                                 @"type":@"1",
                                 @"show_type":@"1",
                                 @"limit":@"6"};
    NSLog(@"parameters = %@", parameters);
    //接口
    //   /api/assistant/assistant_store_index
    NSString *url= M_SS_URL_SHOP_HOME;
    
    //发送请求
    __weak ZFJPartnerShopOtherVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1 && [[dic objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            if ([[[dic objectForKey:@"data"] objectForKey:@"store_info"] isKindOfClass:[NSDictionary class]]) {
                weakSelf.infoModel = [[ZFJSteShopInfoModel alloc] initWithDictionary:[[dic objectForKey:@"data"] objectForKey:@"store_info"]];
                
                [_headerView.shopIcon sd_setImageWithURL:[NSURL URLWithString:[weakSelf judgeImageURL:weakSelf.infoModel.store_avatar]] placeholderImage:[UIImage imageNamed:@"默认图2"]];
                _headerView.shopTitleStr = [weakSelf judgeReturnString:weakSelf.infoModel.store_name withReplaceString:@""];
                _headerView.productCountStr = [NSString stringWithFormat:@"分销产品:%@个", [[dic objectForKey:@"data"] objectForKey:@"goods_count"]];
                _headerView.partnerCountStr = [NSString stringWithFormat:@"合伙人:%@人", [[dic objectForKey:@"data"] objectForKey:@"partner_count"]];
            }
            
            if ([[[dic objectForKey:@"data"] objectForKey:@"goods"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * productDic in [[dic objectForKey:@"data"] objectForKey:@"goods"]) {
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

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
