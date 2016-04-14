//
//  ZFJSteShopProductListVC.m
//  WelLv
//
//  Created by WeiLv on 15/11/5.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopProductListVC.h"
#import "ZFJStewardShopOwnCell.h"
#import "ZFJFilterDetailView.h"
#import "ZFJSteShopListTravelModel.h"
#import "ZFJSteShopListShipModel.h"
#import "ZFJSteShopListStudyTourModel.h"
#import "YXDetailTraveViewController.h"
#import "ZFJShipDetailVC.h"
#import "LXSTDetailViewController.h"
#import "ZFJSteShopListVisaModel.h"
#import "ZFJSteShopDistributionVC.h"
#import "ZFJVisaDetailVC.h"
#import "ProductDetailViewController.h"
@interface ZFJSteShopProductListVC ()<UITableViewDelegate, UITableViewDataSource>
{
    UILabel * chooseLab;
}
@property (nonatomic, strong) UIImageView * iconChoose;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) WLProductType productType;
@property (nonatomic, strong) ZFJFilterDetailView * filterDetailView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, copy) NSString *categoryIdStr;
@property (nonatomic, assign) NSInteger offsetNum;

@end

@implementation ZFJSteShopProductListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.offsetNum = 1;
    self.categoryIdStr = @"5";//旅游
    
    [self addChooseNaviTitle];
    [self customTableView];
    [self addRefreshing];
}

- (void)addChooseNaviTitle {
    chooseLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self returnTextCGRectText:@"推荐产品" textFont:17 cGSize:CGSizeMake(0, 45)].size.width + 20, 45)];
    chooseLab.text = @"推荐产品";
    chooseLab.textAlignment=NSTextAlignmentCenter;
    chooseLab.userInteractionEnabled = YES;
    self.iconChoose = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(chooseLab) - 20 + 10, (self.navigationController.navigationBar.frame.size.height - 5) / 2, 5, 5)];
    _iconChoose.image = [UIImage imageNamed:@"矩形-3-副本-2"];
    _iconChoose.transform = CGAffineTransformMakeRotation(M_PI_4);
    [chooseLab addSubview:_iconChoose];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseNaviTitle:)];
    [chooseLab addGestureRecognizer:tap];
    self.navigationItem.titleView = chooseLab;

}

#pragma mark --- NaviTitle

//点击NaviTitle
- (void)chooseNaviTitle:(UITapGestureRecognizer *)tap {
    [self changeFilterViewColor];
    if (self.filterDetailView == nil) {
        self.filterDetailView = [[ZFJFilterDetailView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight) style:ZFJFilterDetailStyleOneListFlagNoChangeColor];
        self.filterDetailView.titleArr = @[@"旅游度假", @"邮轮", @"游学",@"签证"];
        [self.view addSubview:_filterDetailView];
        
    } else {
        self.filterDetailView.hidden = !self.filterDetailView.hidden;
    }
    __weak ZFJSteShopProductListVC * weakSelf = self;
    [self.filterDetailView selectFilterViewIndexPath:^(NSIndexPath *indexPath) {
        [weakSelf changeFilterViewColor];
        
        switch (indexPath.row) {
            case 0:
            {
                self.productType = WLProductTypeTravel;
                self.categoryIdStr = @"5";//旅游
                chooseLab.text=@"旅游度假";
            }
                break;
            case 1:
            {
                self.productType = WLProductTypeShip;
                self.categoryIdStr = @"3";//邮轮
                chooseLab.text=@"邮轮";
            }
                break;
            case 2:
            {
                self.productType = WLProductTypeStudyTour;
                self.categoryIdStr = @"-2";//游学
                chooseLab.text=@"游学";
            }
                break;
            case 3:
            {
                self.productType=WLProductTypeVisa;
                self.categoryIdStr = @"2";//签证
                chooseLab.text=@"签证";
            }
                break;
            case 4:
            {
                self.categoryIdStr = @"";
                
            }
                break;
                
            default:
                break;
        }
        [self addRefreshing];

    }];
    [self.filterDetailView selectHiddenView:^(UIView *view) {
        [weakSelf changeFilterViewColor];
    }];
    
}

//改变NaviTitleFlag
- (void)changeFilterViewColor {
    
    [_iconChoose.image isEqual:[UIImage imageNamed:@"矩形-3-副本-2"]] ? (_iconChoose.image = [UIImage imageNamed:@"矩形-3"]) : (_iconChoose.image = [UIImage imageNamed:@"矩形-3-副本-2"]);
}


#pragma mark --- 刷新
/**
 *   加载刷新控件
 */
- (void)addRefreshing {
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    
    __weak ZFJSteShopProductListVC * weakSelf = self;
    [self.tableView addGifHeaderWithRefreshingBlock:^{
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideAll];
        [[XCLoadMsg sharedLoadMsg:weakSelf] showActivityLoading:weakSelf.view];
        //[weakSelf setProgressHud];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.dataArr removeAllObjects];
            weakSelf.offsetNum = 1;
            [weakSelf loadData];
        });
    }];
    // 设置普通状态的动画图片
    [self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self.tableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    [self.tableView.gifHeader beginRefreshing];
    
    
    [self.tableView.footer setState:MJRefreshFooterStateIdle];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideAll];
        [[XCLoadMsg sharedLoadMsg:weakSelf] showActivityLoading:weakSelf.view];
        //[weakSelf setProgressHud];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (weakSelf.dataArr.count < weakSelf.offsetNum * 10) {
                [[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                [weakSelf.tableView.footer endRefreshing];
                [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
                return;
            }
            weakSelf.offsetNum = weakSelf.offsetNum + 1;
            //weakSelf.numbers = 10;
            [weakSelf loadData];
            [weakSelf.tableView.footer endRefreshing];
        });
        
    }];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


#pragma mark --- TableView

- (void)customTableView {
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 95;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

#pragma mark --- UITableViewdataSource 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"Cell";
    ZFJStewardShopOwnCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJStewardShopOwnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.distributionBut.hidden = YES;
    }
    switch (self.productType) {
        case WLProductTypeTravel:
        {
            ZFJSteShopListTravelModel * model = [self.dataArr objectAtIndex:indexPath.row];
            cell.modelTravel = model;
            float a=[model.partner_reward floatValue];
            NSString *str=[NSString stringWithFormat:@"%0.2f",a];
            cell.commissionLabel.attributedText = [self partnerCommission:str];
            [cell.commissionLabel sizeToFit];
            cell.partnerCommissionLab.text = @"";
           // [cell.partnerCommissionLab sizeToFit];
            cell.commissionLabel.hidden = NO;
            cell.priceLabel.hidden = NO;

        }
            break;
        case WLProductTypeShip:
        {
            ZFJSteShopListShipModel * model = [self.dataArr objectAtIndex:indexPath.row];
            cell.modelShip = model;
            [cell.commissionLabel sizeToFit];
           // cell.partnerCommissionLab.text=@"";
            cell.commissionLabel.hidden = YES;
            cell.priceLabel.hidden = YES;
        }
            break;
        case WLProductTypeStudyTour:
        {
            ZFJSteShopListStudyTourModel * model = [self.dataArr objectAtIndex:indexPath.row];
            cell.modelStudyTour = model;
            float a=[model.camper_reward floatValue];
            NSString *str=[NSString stringWithFormat:@"%0.2f",a];
            cell.commissionLabel.attributedText = [self partnerCommission:str];
            [cell.commissionLabel sizeToFit];
            //[cell.partnerCommissionLab sizeToFit];
            cell.commissionLabel.hidden = NO;
            cell.priceLabel.hidden = NO;
        }
            break;
        case WLProductTypeVisa:
        {
        
            ZFJSteShopListVisaModel * model = [self.dataArr objectAtIndex:indexPath.row];
            cell.modelVisa = model;
            //[cell.commissionLabel sizeToFit];
            
            float a=[model.partner_reward floatValue];
            NSString *str=[NSString stringWithFormat:@"%0.2f",a];
            cell.commissionLabel.attributedText = [self partnerCommission:str];
            [cell.commissionLabel sizeToFit];
            //[cell.partnerCommissionLab sizeToFit];

            cell.commissionLabel.hidden = NO;
            cell.priceLabel.hidden = NO;

        }
        break;
        default:
            break;
    }
    return cell;
}

- (NSAttributedString *)partnerCommission:(NSString *)str {
    return [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#6F7378;font-size:12px>分销佣金:&nbsp;</span><span style=color:#2ECD70;font-size:12px>¥%@</span>", [self judgeReturnString:str withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
}

#pragma mark --- UITableViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.productType) {
        case WLProductTypeTravel:
        {
            ZFJSteShopListTravelModel * model = [self.dataArr objectAtIndex:indexPath.row];
//            YXDetailTraveViewController * vc = [[YXDetailTraveViewController alloc] init];
//            vc.productId = model.product_id;
//            vc.orderSource = WLOrderSourceStewardShop;
//            vc.store_id = self.store_id;
//            [self.navigationController pushViewController:vc animated:YES];
            
            ProductDetailViewController *productVC = [[ProductDetailViewController alloc]init];
            productVC.productID = model.product_id;
            productVC.gj_commission = model.partner_reward;
            productVC.shop_id = self.store_id;
            [self.navigationController pushViewController:productVC animated:YES];
        }
            break;
        case WLProductTypeShip:
        {
            ZFJSteShopListShipModel * model = [self.dataArr objectAtIndex:indexPath.row];
            ZFJShipDetailVC * vc = [[ZFJShipDetailVC alloc] init];
            vc.product_id = model.product_id;
            vc.orderSource = WLOrderSourceStewardShop;
            vc.store_id = self.store_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case WLProductTypeStudyTour:
        {
            ZFJSteShopListStudyTourModel * model = [self.dataArr objectAtIndex:indexPath.row];
            LXSTDetailViewController * vc = [[LXSTDetailViewController alloc] init];
            vc.productId = model.product_id;
            vc.orderSource = WLOrderSourceStewardShop;
            vc.store_id = self.store_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case WLProductTypeVisa:
        {
            ZFJVisaDetailVC *vc = [[ZFJVisaDetailVC alloc] init];
            ZFJSteShopListVisaModel *model = [self.dataArr objectAtIndex:indexPath.row];
            vc.product_id =model.product_id;
            vc.orderSource = WLOrderSourceStewardShop;
            vc.store_id = self.store_id;
            [self.navigationController pushViewController:vc animated:YES];
        }
        break;
        default:
            break;
    }
}

#pragma mark --- 加载数据
/**
 *  请求数据
 */
- (void)loadData {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"assistant_id":self.stewardIDStr,
                                 @"category_id":self.categoryIdStr,
                                 @"offset":[NSString stringWithFormat:@"%ld", self.offsetNum],
                                 @"limit":@"10",
                                 @"show_type":@"1",
                                 @"type":@"2"};
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_GOODS_LIST;
    
    //发送请求
    __weak ZFJSteShopProductListVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"data"] isKindOfClass:[NSDictionary class]] && [[[dic objectForKey:@"data"] objectForKey:@"goods"] isKindOfClass:[NSArray class]]) {
            NSArray * goodsArr = [[dic objectForKey:@"data"] objectForKey:@"goods"];
            switch (weakSelf.productType) {
                case WLProductTypeTravel:
                {
                    for (NSDictionary * goodsDic in goodsArr) {
                        ZFJSteShopListTravelModel * model = [[ZFJSteShopListTravelModel alloc] initWithDictionary:goodsDic];
                        [weakSelf.dataArr addObject:model];
                    }
                }
                    break;
                case WLProductTypeShip:
                {
                    for (NSDictionary * goodsDic in goodsArr) {
                        ZFJSteShopListShipModel * model = [[ZFJSteShopListShipModel alloc] initWithDictionary:goodsDic];
                        [weakSelf.dataArr addObject:model];
                    }
                }
                    break;
                case WLProductTypeStudyTour:
                {
                    for (NSDictionary * goodsDic in goodsArr) {
                        ZFJSteShopListStudyTourModel * model = [[ZFJSteShopListStudyTourModel alloc] initWithDictionary:goodsDic];
                        [weakSelf.dataArr addObject:model];
                    }
                }
                    break;
                case WLProductTypeVisa:
                {
                    for (NSDictionary * goodsDic in goodsArr) {
                        ZFJSteShopListVisaModel * model = [[ZFJSteShopListVisaModel alloc] initWithDictionary:goodsDic];
                        [weakSelf.dataArr addObject:model];
                    }
                }
                break;
                default:
                    break;
            }
            [weakSelf.tableView.header endRefreshing];
            [weakSelf.tableView.footer endRefreshing];
            
            [weakSelf.tableView reloadData];
            if (weakSelf.tableView.contentSize.height < ControllerViewHeight) {
                [weakSelf.tableView removeFooter];
            }
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
