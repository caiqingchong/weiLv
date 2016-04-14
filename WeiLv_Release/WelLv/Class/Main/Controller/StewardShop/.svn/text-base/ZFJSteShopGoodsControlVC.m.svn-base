//
//  ZFJSteShopGoodsControlVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopGoodsControlVC.h"
#import "ZFJStewardShopOwnCell.h"
#import "ZFJSteShopListTravelModel.h"
#import "ZFJSteShopListShipModel.h"
#import "ZFJSteShopListStudyTourModel.h"
#import "ZFJSteShopDistributionVC.h"
#import "ZFJSteShopShipDistDetailVC.h"
#import "ZFJSteShopListVisaModel.h"
#import "ZFJShipDetailVC.h"
#import "YXDetailTraveViewController.h"
#import "ProductDetailViewController.h"
#import "ZFJVisaDetailVC.h"
#import "LXSTDetailViewController.h"

@interface ZFJSteShopGoodsControlVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, copy) NSString *categoryIdStr;
@property (nonatomic, copy) NSString *typeStr;
@property (nonatomic, assign) NSInteger offsetNum;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, assign) NSInteger chooseRow;
@end

@implementation ZFJSteShopGoodsControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.offsetNum = 1;
    switch (self.goodsTeam) {
        case ZFJGoodsTeamOfOwn:
        {
            self.typeStr = @"2";  //1是管家销售商产品，2是管家分销产品
        }
            break;
        case ZFJGoodsTeamOfRetailer:
        {
            self.typeStr = @"1";
        }
            break;
            
        default:
            break;
    }
    
    switch (self.goodsType) {
        case ZFJGoodsTypeOfTravel:
        {
            self.categoryIdStr = @"5";
        }
            break;
        case ZFJGoodsTypeOfShip:
        {
            self.categoryIdStr = @"3";
            
        }
            break;
        case ZFJGoodsTypeOfStudyTour:
        {
            self.categoryIdStr = @"-2";
            
        }
            break;
        case ZFJGoodsTypeOfTicket:
        {
            self.categoryIdStr = @"";
            
        }
            break;
        case ZFJGoodsTypeOfVisa:
        {
            self.categoryIdStr = [[WLSingletonClass defaultWLSingleton] wlProductTypeCatId:WLProductTypeVisa];
            
        }
            break;
            
        default:
            break;
    }
    
    [self customTabelView];
    [self addRefreshing];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNowData) name:@"distributionSuc" object:nil];
}
#pragma mark --- 通知
- (void)refreshNowData {
    [self addRefreshing];
    
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
    
    __weak ZFJSteShopGoodsControlVC * weakSelf = self;
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

- (void)customTabelView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

#pragma  mark --- UITabelViewDataSource
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
    if (self.goodsTeam == ZFJGoodsTeamOfOwn) {
        //cell.partnerCommissionLab.text = @"哈哈哈哈";
        switch (self.goodsType) {
            case ZFJGoodsTypeOfTravel:
            {
                ZFJSteShopListTravelModel * model = [self.dataArr objectAtIndex:indexPath.row];
                cell.modelTravel = model;
                [cell.commissionLabel sizeToFit];
                NSString *st=[NSString stringWithFormat:@"%0.2f",[model.partner_reward floatValue]];
                cell.partnerCommissionLab.attributedText = [self partnerCommission:st];
                [cell.partnerCommissionLab sizeToFit];
            }
                break;
            case ZFJGoodsTypeOfShip:
            {
                ZFJSteShopListShipModel * model = [self.dataArr objectAtIndex:indexPath.row];
                cell.modelShip = model;
                [cell.commissionLabel sizeToFit];
                cell.partnerCommissionLab.text = @"";
                
            }
                break;
            case ZFJGoodsTypeOfStudyTour:
            {
                ZFJSteShopListStudyTourModel * model = [self.dataArr objectAtIndex:indexPath.row];
                cell.modelStudyTour = model;
                [cell.commissionLabel sizeToFit];
                NSString *st=[NSString stringWithFormat:@"%0.2f",[model.camper_reward floatValue]];
                cell.partnerCommissionLab.attributedText = [self partnerCommission:st];
                [cell.partnerCommissionLab sizeToFit];
            }
                break;
            case ZFJGoodsTypeOfVisa:
            {
                ZFJSteShopListVisaModel * model = [self.dataArr objectAtIndex:indexPath.row];
                cell.modelVisa = model;
                [cell.commissionLabel sizeToFit];
                NSString *st=[NSString stringWithFormat:@"%0.2f",[model.partner_reward floatValue]];
                cell.partnerCommissionLab.attributedText = [self partnerCommission:st];
                [cell.partnerCommissionLab sizeToFit];
            }
                break;

            default:
                break;
        }
        
        
        [cell.distributionBut addTarget:self action:@selector(cancelBut:) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        
        switch (self.goodsType) {
            case ZFJGoodsTypeOfTravel:
            {
                ZFJSteShopListTravelModel * model = [self.dataArr objectAtIndex:indexPath.row];
                cell.modelTravel = model;
                cell.titleLabel.numberOfLines = 2;
                [cell.titleLabel sizeToFit];
            }
                break;
            case ZFJGoodsTypeOfShip:
            {
                ZFJSteShopListShipModel * model = [self.dataArr objectAtIndex:indexPath.row];
                cell.modelShip = model;
            }
                break;
            case ZFJGoodsTypeOfStudyTour:
            {
                ZFJSteShopListStudyTourModel * model = [self.dataArr objectAtIndex:indexPath.row];
                cell.modelStudyTour = model;
                cell.titleLabel.numberOfLines = 2;
                [cell.titleLabel sizeToFit];
            }
                break;
            case ZFJGoodsTypeOfVisa:{
                ZFJSteShopListVisaModel * model = [self.dataArr objectAtIndex:indexPath.row];
                cell.modelVisa = model;
                cell.titleLabel.numberOfLines = 2;
                [cell.titleLabel sizeToFit];
                [cell.commissionLabel sizeToFit];

            }
                break;
            default:
                break;
        }
        
        [cell.distributionBut addTarget:self action:@selector(goDistributionVC:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return cell;
}


- (NSAttributedString *)partnerCommission:(NSString *)str {
    return [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#6F7378;font-size:12px>分销返佣:&nbsp;</span><span style=color:#2ECD70;font-size:12px>¥%@</span>", [self judgeReturnString:str withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
}
#pragma mark --- UITabelViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.goodsTeam == ZFJGoodsTeamOfOwn) {
        switch (self.goodsType) {
            case ZFJGoodsTypeOfTravel:
            {
                ZFJSteShopDistributionVC * vc = [[ZFJSteShopDistributionVC alloc] init];
                vc.goodsType = self.goodsType;
                vc.model = [self.dataArr objectAtIndex:indexPath.row];
                vc.goodsTeam = self.goodsTeam;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ZFJGoodsTypeOfShip:
            {
                ZFJSteShopShipDistDetailVC * vc = [[ZFJSteShopShipDistDetailVC alloc] init];
                ZFJSteShopListShipModel * model = [self.dataArr objectAtIndex:indexPath.row];
                vc.modelShip = model;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ZFJGoodsTypeOfStudyTour:
            {
                ZFJSteShopDistributionVC * vc = [[ZFJSteShopDistributionVC alloc] init];
                vc.goodsType = self.goodsType;
                vc.model = [self.dataArr objectAtIndex:indexPath.row];
                vc.goodsTeam = self.goodsTeam;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case ZFJGoodsTypeOfTicket:
            {
                
            }
                break;
            case ZFJGoodsTypeOfVisa:
            {
                ZFJSteShopDistributionVC * vc = [[ZFJSteShopDistributionVC alloc] init];
                vc.goodsType = self.goodsType;
                vc.model = [self.dataArr objectAtIndex:indexPath.row];
                vc.goodsTeam = self.goodsTeam;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }

    }
    else if (self.goodsTeam == ZFJGoodsTeamOfRetailer)
    {
        switch (self.goodsType)
        {
            case ZFJGoodsTypeOfTravel:
            {
//                YXDetailTraveViewController * vc = [[YXDetailTraveViewController alloc] init];
                ZFJSteShopListTravelModel * model = [self.dataArr objectAtIndex:indexPath.row];
//                vc.productId = model.product_id;
//                vc.orderSource = WLOrderSourceStewardShop;
//                vc.store_id = [[WLSingletonClass defaultWLSingleton] wlUserSteShopID];
//                [self.navigationController pushViewController:vc animated:YES];
                ProductDetailViewController *productVC = [[ProductDetailViewController alloc]init];
                productVC.productID = model.product_id;
                productVC.gj_commission = model.partner_reward;
                [self.navigationController pushViewController:productVC animated:YES];
            }
            break;
            case ZFJGoodsTypeOfShip:
            {
                ZFJShipDetailVC * vc = [[ZFJShipDetailVC alloc] init];
                ZFJSteShopListShipModel * model = [self.dataArr objectAtIndex:indexPath.row];
                vc.product_id = model.product_id;
                vc.orderSource = WLOrderSourceStewardShop;
                vc.store_id = [[WLSingletonClass defaultWLSingleton] wlUserSteShopID];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
            case ZFJGoodsTypeOfStudyTour:
            {
                LXSTDetailViewController * vc = [[LXSTDetailViewController alloc] init];
                ZFJSteShopListStudyTourModel * model = [self.dataArr objectAtIndex:indexPath.row];
                vc.productId = model.yoosure_id;
                vc.orderSource = WLOrderSourceStewardShop;
                vc.store_id = [[WLSingletonClass defaultWLSingleton] wlUserSteShopID];
                [self.navigationController pushViewController:vc animated:YES];
 
            }
            break;
            case ZFJGoodsTypeOfTicket:
            {
                
            }
            break;
            case ZFJGoodsTypeOfVisa:
            {
                ZFJVisaDetailVC *vc = [[ZFJVisaDetailVC alloc] init];
                ZFJSteShopListVisaModel *model = [self.dataArr objectAtIndex:indexPath.row];
                vc.product_id =model.product_id;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            break;
            default:
                break;
        }
    }
}

#pragma mark --- cell上按钮方法
//分销
- (void)goDistributionVC:(UIButton *)button {
    
    ZFJSteShopDistributionVC * vc = [[ZFJSteShopDistributionVC alloc] init];
    vc.goodsType = self.goodsType;
    vc.goodsTeam = ZFJGoodsTeamOfRetailer;
    vc.model = [self.dataArr objectAtIndex:button.tag - 100];
    [self.navigationController pushViewController:vc animated:YES];
}

//取消
- (void)cancelBut:(UIButton *)button {
    self.chooseRow = button.tag - 100;
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定取消分销该产品?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
}

#pragma mark --- UIActionSheetDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self dismissDistiribution];
    }
}

#pragma mark --- 取消分销

- (void)dismissDistiribution {
    NSString * product_id_str = @"";
    switch (self.goodsType) {
        case ZFJGoodsTypeOfTravel:
        {
            ZFJSteShopListTravelModel * model = [self.dataArr objectAtIndex:self.chooseRow];
            product_id_str = model.product_id;
        }
            break;
        case ZFJGoodsTypeOfShip:
        {
            ZFJSteShopListShipModel * model = [self.dataArr objectAtIndex:self.chooseRow];
            product_id_str = model.product_id;
            
        }
            break;
        case ZFJGoodsTypeOfStudyTour:
        {
            ZFJSteShopListStudyTourModel * model = [self.dataArr objectAtIndex:self.chooseRow];
            product_id_str = model.product_id;
            
        }
            break;
        case ZFJGoodsTypeOfVisa:{
            ZFJSteShopListVisaModel * model = [self.dataArr objectAtIndex:self.chooseRow];
            product_id_str = model.product_id;
        }
        default:
            break;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"assistant_id":[[LXUserTool alloc] getUid],
                                 @"category_id":self.categoryIdStr,
                                 @"product_id":product_id_str};
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_DELETE_GOODS;
    
    //发送请求
    __weak ZFJSteShopGoodsControlVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        //NSLog(@"%@", [dic objectForKey:@"msg"]);
        if ([self judgeString:[[dic objectForKey:@"status"] stringValue]] && [[dic objectForKey:@"status"] integerValue] ==1) {
            //[weakSelf.tableView remo]
            [weakSelf.dataArr removeObjectAtIndex:self.chooseRow];
            //[weakSelf.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:button.tag -100 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [weakSelf.tableView reloadData];
            [[LXAlterView sharedMyTools] createTishi:@"成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"cancelDistribution" object:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"失败"];
        
    }];
    
}
#pragma mark --- loadData
/**
 *  请求数据
 */
- (void)loadData {
    

    NSString *show_type=@"1";//会员看管家部落的商品，是1，管家看自己的是0，管家查看自分销的产品时，是看不到平台推广产品的，所以正常
    if ([[[LXUserTool sharedUserTool] getuserGroup] isEqualToString:@"assistant"])
    {
        show_type=@"0";
    }
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"assistant_id":[[LXUserTool alloc] getUid],
                                 @"category_id":self.categoryIdStr,
                                 @"offset":[NSString stringWithFormat:@"%ld", self.offsetNum],
                                 @"limit":@"10",
                                 @"show_type":show_type,
                                 @"type":self.typeStr};
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_GOODS_LIST;
    
    //发送请求
    __weak ZFJSteShopGoodsControlVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"data"] isKindOfClass:[NSDictionary class]] && [[[dic objectForKey:@"data"] objectForKey:@"goods"] isKindOfClass:[NSArray class]]) {
            NSArray * goodsArr = [[dic objectForKey:@"data"] objectForKey:@"goods"];
            switch (weakSelf.goodsType) {
                case ZFJGoodsTypeOfTravel:
                {
                    for (NSDictionary * goodsDic in goodsArr) {
                        ZFJSteShopListTravelModel * model = [[ZFJSteShopListTravelModel alloc] initWithDictionary:goodsDic];
                        [weakSelf.dataArr addObject:model];
                    }
                }
                    break;
                case ZFJGoodsTypeOfShip:
                {
                    for (NSDictionary * goodsDic in goodsArr) {
                        ZFJSteShopListShipModel * model = [[ZFJSteShopListShipModel alloc] initWithDictionary:goodsDic];
                        [weakSelf.dataArr addObject:model];
                    }
                }
                    break;
                case ZFJGoodsTypeOfStudyTour:
                {
                    for (NSDictionary * goodsDic in goodsArr) {
                        ZFJSteShopListStudyTourModel * model = [[ZFJSteShopListStudyTourModel alloc] initWithDictionary:goodsDic];
                        [weakSelf.dataArr addObject:model];
                    }
                }
                    break;
                case ZFJGoodsTypeOfVisa:
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
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cancelDistribution" object:nil];
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

@end
