//
//  ZFJSteShopDistributionVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopDistributionVC.h"
#import "ZFJSteShopDistributionTravelView.h"
#import "ZFJSteShopListTravelModel.h"
#import "ZFJSteShopListStudyTourModel.h"
#import "ZFJSteShopListShipModel.h"
#import "ZFJSSShipRoomModel.h"
#import "ZFJSSDistributionShipCell.h"
#import "ZFJSteShopListVisaModel.h"

@interface ZFJSteShopDistributionVC ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

{
    
    CGFloat contentOffsetY;
    
    CGFloat oldContentOffsetY;
    
    CGFloat newContentOffsetY;
    
}
@property (nonatomic, strong) ZFJSteShopListTravelModel * modelTravel;
@property (nonatomic, strong) ZFJSteShopListShipModel * modelShip;
@property (nonatomic, strong) ZFJSteShopListStudyTourModel * modelStudyTour;
@property (nonatomic, strong) ZFJSteShopListVisaModel * modelVisa;
@property (nonatomic, strong) ZFJSteShopDistributionTravelView * adultView;
@property (nonatomic, strong) ZFJSteShopDistributionTravelView * childView;
@property (nonatomic, strong) UIScrollView * bgScrollView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) NSMutableArray * roomRewardArr;
@property (nonatomic, assign) CGFloat contentSizeHeight;
@property (nonatomic, assign) BOOL shipCanDistribution;

@end

@implementation ZFJSteShopDistributionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.goodsTeam == ZFJGoodsTeamOfRetailer) {
        
        self.title = @"设置分销";
        self.view.backgroundColor = kColor(240, 246, 251);
        UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(0, 0, 50, 45);
        [but setTitle:@"完成" forState:UIControlStateNormal];
        [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(finishDistribution:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:but];
        
    } else if (self.goodsTeam == ZFJGoodsTeamOfOwn) {
        self.navigationItem.title = @"分销详情";
    }
    
    switch (self.goodsType) {
        case ZFJGoodsTypeOfTravel :
        {
            self.modelTravel = self.model;
            CGFloat tittleHeight = [self returnTextCGRectText:self.modelTravel.product_name textFont:17 cGSize:CGSizeMake(windowContentWidth - 20, 0)].size.height;
            [self customTabelViewWithTitleHeight:tittleHeight];
            _titleLabel.text = [NSString stringWithFormat:@"%@", [self judgeReturnString:self.modelTravel.product_name withReplaceString:@""]];
            /*
             [self customTravelView];
             _titleLabel.text = [NSString stringWithFormat:@"   %@", [self judgeReturnString:self.modelTravel.product_name withReplaceString:@""]];
             
             self.adultView.titleLab.text = @"设置返佣";
             
             self.adultView.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelTravel.sell_price withReplaceString:@"0.00"]];
             self.adultView.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelTravel.gj_commission withReplaceString:@"0.00"]];
             */
            
        }
            break;
        case ZFJGoodsTypeOfShip :
        {
            self.shipCanDistribution = YES;
            self.modelShip = self.model;
            [self loadData];
            //[self customShipView];
            CGFloat tittleHeight = [self returnTextCGRectText:self.modelShip.product_name textFont:17 cGSize:CGSizeMake(windowContentWidth - 20, 0)].size.height;
            [self customTabelViewWithTitleHeight:tittleHeight];
            _titleLabel.text = [NSString stringWithFormat:@"%@", [self judgeReturnString:self.modelShip.product_name withReplaceString:@""]];
        }
            break;
        case ZFJGoodsTypeOfStudyTour :
        {
            self.modelStudyTour = self.model;
            CGFloat tittleHeight = [self returnTextCGRectText:self.modelStudyTour.yoosure_name  textFont:17 cGSize:CGSizeMake(windowContentWidth - 20, 0)].size.height;
            [self customTabelViewWithTitleHeight:tittleHeight];
            _titleLabel.text = [NSString stringWithFormat:@"%@", [self judgeReturnString:self.modelStudyTour.yoosure_name withReplaceString:@""]];
            /*
             [self customTravelView];
             _titleLabel.text = [NSString stringWithFormat:@"   %@", [self judgeReturnString:self.modelStudyTour.yoosure_name withReplaceString:@""]];
             
             self.adultView.titleLab.text = @"教师";
             
             self.adultView.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelStudyTour.teacher_price withReplaceString:@"0.00"]];
             
             self.adultView.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelStudyTour.teacher_rebate withReplaceString:@"0.00"]];
             
             self.childView = [[ZFJSteShopDistributionTravelView alloc] initWithFrame:CGRectMake(0, ViewBelow(_adultView) + 1, windowContentWidth, 135)];
             self.childView.distributionTF.delegate = self;
             self.childView.titleLab.text = @"营员";
             
             self.childView.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelStudyTour.camper_price withReplaceString:@"0.00"]];
             self.childView.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelStudyTour.camper_rebate withReplaceString:@"0.00"]];
             [self.bgScrollView addSubview:_childView];
             */
        }
            break;
            
        case ZFJGoodsTypeOfVisa:{
            self.modelVisa = self.model;
            CGFloat tittleHeight = [self returnTextCGRectText:self.modelVisa.product_name  textFont:17 cGSize:CGSizeMake(windowContentWidth - 20, 0)].size.height;
            [self customTabelViewWithTitleHeight:tittleHeight];
            _titleLabel.text = [NSString stringWithFormat:@"%@", [self judgeReturnString:self.modelVisa.product_name withReplaceString:@""]];
        }
        default:
            break;
    }
}

- (void)customTravelView {
    
    self.bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.bgScrollView.backgroundColor = kColor(240, 246, 251);
    self.bgScrollView.delegate = self;
    self.bgScrollView.contentSize = CGSizeMake(windowContentWidth, windowContentHeight + 5);
    [self.view addSubview:_bgScrollView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 45)];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    
    [self.bgScrollView addSubview:_titleLabel];
    
    self.adultView = [[ZFJSteShopDistributionTravelView alloc] initWithFrame:CGRectMake(0, ViewBelow(_titleLabel) + 20, windowContentWidth, 135)];
    //self.adultView.distributionTF.delegate = self;
    [self.bgScrollView addSubview:_adultView];
    
    
}

- (void)customTabelViewWithTitleHeight:(CGFloat)height {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.tableView.contentInset = UIEdgeInsetsMake(50 + height , 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 135;
    [self.view addSubview:_tableView];
    self.tableView.contentSize=CGSizeMake(windowContentWidth,ControllerViewHeight);
    UIView * headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -(50 + height), windowContentWidth, 50 + height)];
    headerBgView.backgroundColor = kColor(240, 246, 251);
    [self.tableView addSubview:headerBgView];
    UIView * titleBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, height + 10)];
    titleBgView.backgroundColor = [UIColor whiteColor];
    [headerBgView addSubview:titleBgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, windowContentWidth - 20, height + 10)];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.numberOfLines = 0;
    //_titleLabel.text = [NSString stringWithFormat:@"   %@", [self judgeReturnString:self.modelShip.product_name withReplaceString:@""]];
    
    [headerBgView addSubview:_titleLabel];
    
}

- (void)customShipView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.tableView.contentInset = UIEdgeInsetsMake(85, 0, 0, 0);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 135;
    [self.view addSubview:_tableView];
    
    UIView * headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, -85, windowContentWidth, 85)];
    headerBgView.backgroundColor = kColor(240, 246, 251);
    [self.tableView addSubview:headerBgView];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 45)];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.text = [NSString stringWithFormat:@"   %@", [self judgeReturnString:self.modelShip.product_name withReplaceString:@""]];
    
    [headerBgView addSubview:_titleLabel];
}

#pragma mark --- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.goodsType) {
        case ZFJGoodsTypeOfTravel:
        {
            return 2;
            
        }
            break;
        case ZFJGoodsTypeOfShip:
        {
            return self.dataArr.count;
            
        }
            break;
        case ZFJGoodsTypeOfStudyTour:
        {
            return 2;
            
        }
            break;
        case ZFJGoodsTypeOfVisa:
        {
            return 1;
            
        }
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier =[NSString stringWithFormat:@"Cell%ld", indexPath.row];
    ZFJSSDistributionShipCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJSSDistributionShipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.view.distributionLab addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    if (self.goodsTeam == ZFJGoodsTeamOfRetailer) {
        switch (self.goodsType) {
            case ZFJGoodsTypeOfTravel:
            {
                if (indexPath.row == 0) {
                    cell.view.titleLab.text = @"成人";
                    
                    cell.view.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelTravel.adult_price withReplaceString:@"0.00"]];
                    cell.view.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelTravel.gj_commission withReplaceString:@"0.00"]];
                    cell.view.distributionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"分销" msgStr:[self judgeReturnString:self.modelTravel.partner_reward withReplaceString:@"0.00"]];
                } else if (indexPath.row == 1) {
                    cell.view.titleLab.text = @"儿童";
                    
                    cell.view.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelTravel.child_price withReplaceString:@"0.00"]];
                   
                    cell.view.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelTravel.child_rebate withReplaceString:@"0.00"]];
                    
                    DLog(@"%@",self.modelTravel.children_reward);
                    cell.view.distributionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"分销" msgStr:[self judgeReturnString:self.modelTravel.children_reward withReplaceString:@"0.00"]];
                }
                
            }
                break;
            case ZFJGoodsTypeOfShip:
            {
                ZFJSSShipRoomModel * model = [self.dataArr objectAtIndex:indexPath.row];
                cell.modelShipRoom = model;
            }
                break;
            case ZFJGoodsTypeOfStudyTour:
            {
                if (indexPath.row == 0) {
                    cell.view.titleLab.text = @"教师";
                    cell.view.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelStudyTour.teacher_price withReplaceString:@"0.00"]];
                    cell.view.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelStudyTour.teacher_rebate withReplaceString:@"0.00"]];
                    cell.view.distributionLab.attributedText=[self attributedTextBlackAndRedTitleStr:@"分销" msgStr:[self judgeReturnString:self.modelStudyTour.teacher_reward withReplaceString:@"0.00"]];
                    
                } else if (indexPath.row == 1) {
                    cell.view.titleLab.text = @"营员";
                    cell.view.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelStudyTour.camper_price withReplaceString:@"0.00"]];
                    cell.view.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelStudyTour.camper_rebate withReplaceString:@"0.00"]];
                    cell.view.distributionLab.attributedText=[self attributedTextBlackAndRedTitleStr:@"分销" msgStr:[self judgeReturnString:self.modelStudyTour.camper_reward withReplaceString:@"0.00"]];
                }
            }
                break;
            case ZFJGoodsTypeOfVisa:{
                cell.view.titleLab.text = @"设置返佣";
                cell.view.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelVisa.sell_price withReplaceString:@"0.00"]];
                cell.view.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelVisa.commission withReplaceString:@"0.00"]];
                cell.view.distributionLab.attributedText=[self attributedTextBlackAndRedTitleStr:@"分销" msgStr:[self judgeReturnString:self.modelVisa.partner_reward withReplaceString:@"0.00"]];
            }
            default:
                break;
        }
        
        //cell.view.distributionTF.delegate = self;
        cell.view.distributionLab.tag =  100 + indexPath.row;
        
    } else if (self.goodsTeam == ZFJGoodsTeamOfOwn) {
        switch (self.goodsType) {
            case ZFJGoodsTypeOfTravel:
            {
                if (indexPath.row == 0) {
                    cell.view.titleLab.text = @"成人";
                    
                    cell.view.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelTravel.adult_price withReplaceString:@"0.00"]];
                    cell.view.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelTravel.gj_commission withReplaceString:@"0.00"]];
                    cell.view.distributionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"分销" msgStr:[self judgeReturnString:self.modelTravel.partner_reward withReplaceString:@"0.00"]];
                } else if (indexPath.row == 1) {
                    cell.view.titleLab.text = @"儿童";
                    
                    cell.view.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelTravel.child_price withReplaceString:@"0.00"]];
                    cell.view.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelTravel.child_rebate withReplaceString:@"0.00"]];
                    cell.view.distributionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"分销" msgStr:[self judgeReturnString:self.modelTravel.children_reward withReplaceString:@"0.00"]];
                }
                
            }
                break;
            case ZFJGoodsTypeOfShip:
            {
                ZFJSSShipRoomModel * model = [self.dataArr objectAtIndex:indexPath.row];
                cell.modelShipRoom = model;
            }
                break;
            case ZFJGoodsTypeOfStudyTour:
            {
                if (indexPath.row == 0) {
                    cell.view.titleLab.text = @"教师";
                    cell.view.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelStudyTour.teacher_price withReplaceString:@"0.00"]];
                    cell.view.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelStudyTour.teacher_rebate withReplaceString:@"0.00"]];
                    cell.view.distributionLab.text = [self judgeReturnString:self.modelStudyTour.teacher_reward withReplaceString:@"0.00"];
                } else if (indexPath.row == 1) {
                    cell.view.titleLab.text = @"营员";
                    cell.view.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelStudyTour.camper_price withReplaceString:@"0.00"]];
                    cell.view.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelStudyTour.camper_rebate withReplaceString:@"0.00"]];
                    cell.view.distributionLab.text = [self judgeReturnString:self.modelStudyTour.camper_reward withReplaceString:@"0.00"];
                    
                }
            }
                break;
            case ZFJGoodsTypeOfVisa:{
                cell.view.titleLab.text = @"设置返佣";
                cell.view.priceLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"价格" msgStr:[self judgeReturnString:self.modelVisa.sell_price withReplaceString:@"0.00"]];
                cell.view.commisstionLab.attributedText = [self attributedTextBlackAndRedTitleStr:@"返佣" msgStr:[self judgeReturnString:self.modelVisa.commission withReplaceString:@"0.00"]];
//                cell.view.distributionLab.text = [self judgeReturnString:self.modelVisa.partner_reward withReplaceString:@"0.00"];
                cell.view.distributionLab.attributedText  = [self attributedTextBlackAndRedTitleStr:@"分销" msgStr:[self judgeReturnString:self.modelVisa.partner_reward withReplaceString:@"0.00"]];            }
            default:
                break;
        }
        
        //cell.view.distributionTF.delegate = self;
        cell.view.distributionLab.tag =  100 + indexPath.row;
        cell.view.distributionLab.userInteractionEnabled = NO;
    }
    
    return cell;
}


- (void)customStudyTourView {
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"text"]) {
        if (self.goodsType == ZFJGoodsTypeOfShip) {
            UITextField * temp = object;
            NSMutableDictionary * dic = [self.roomRewardArr objectAtIndex:temp.tag - 100];
            if ([[change valueForKey:NSKeyValueChangeNewKey] floatValue] <= [[dic objectForKey:@"butler_s"] floatValue]) {
                [dic setObject:[change valueForKey:NSKeyValueChangeNewKey] forKey:@"reward"];
                self.shipCanDistribution = YES;
            } else {
                self.shipCanDistribution = NO;
                [[LXAlterView sharedMyTools] createTishi:@"设置失败,分销金额不能大于返佣金额!"];
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}




#pragma mark ---- 点击完成
/**
 *  点击完成
 *
 *  @param button
 */
- (void)finishDistribution:(UIButton *)button {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定分销该产品?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
    
}

#pragma mark --- UIActionSheetDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self distribution];
    }
}

#pragma mark --- 设置分销
/*
 *  分销
 */
- (void)distribution {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary * parameters = @{};
    switch (self.goodsType) {
        case ZFJGoodsTypeOfTravel:
        {
            NSString * adult_rewardStr = @"0.00";
            NSString * child_reward_str = @"0.00";
            UITextField * temp = (UITextField *)[self.view viewWithTag:100];
            UITextField * temp_child = (UITextField *)[self.view viewWithTag:101];
            if ([self judgeString:temp.text]) {
                adult_rewardStr = temp.text;
            }
            if ([self judgeString:temp_child.text]) {
                child_reward_str = temp_child.text;
            }
            NSLog(@"%@  %@", adult_rewardStr, self.modelTravel.gj_commission);
            if ([adult_rewardStr floatValue] > [self.modelTravel.gj_commission floatValue]) {
                [[LXAlterView sharedMyTools] createTishi:@"设置失败,分销金额不能大于返佣金额!"];
                return;
            }
            //            if ([child_reward_str floatValue] > [self.modelTravel.children_commission floatValue]) {
            //                [[LXAlterView sharedMyTools] createTishi:@"设置失败,分销金额不能大于返佣金额!"];
            //                return;
            //            }
            
            parameters =  @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                            @"category_id":@"5",
                            @"product_id":self.modelTravel.product_id,
                            @"reward":adult_rewardStr};
            //reward
            //adult_reward
            //,@"childen_reward":child_reward_str
        }
            break;
        case ZFJGoodsTypeOfShip:
        {
            
            if (self.shipCanDistribution) {
                
                parameters =  @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                                @"category_id":@"3",
                                @"product_id":self.modelShip.product_id,
                                @"reward_info":[self arrayToJson:self.roomRewardArr]};
                
            } else {
                [[LXAlterView sharedMyTools] createTishi:@"设置失败,分销金额不能大于返佣金额!"];
                return;
            }
            
        }
            break;
        case ZFJGoodsTypeOfStudyTour:
        {
            NSString * teacherRewardStr = @"0.00";
            NSString * camperRewardStr = @"0.00";
            UITextField * teacherTF = (UITextField *)[self.view viewWithTag:100];
            UITextField * camperTF = (UITextField *)[self.view viewWithTag:101];
            if ([self judgeString:teacherTF.text]) {
                teacherRewardStr = teacherTF.text;
            }
            if ([self judgeString:camperTF.text]) {
                camperRewardStr = camperTF.text;
            }
            
            if ([teacherRewardStr floatValue] > [self.modelStudyTour.teacher_rebate floatValue]) {
                [[LXAlterView sharedMyTools] createTishi:@"设置失败,分销金额不能大于返佣金额!"];
                return;
            }
            if ([camperRewardStr floatValue] > [self.modelStudyTour.camper_rebate floatValue]) {
                [[LXAlterView sharedMyTools] createTishi:@"设置失败,分销金额不能大于返佣金额!"];
                return;
            }
            
            parameters =  @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                            @"category_id":@"-2",
                            @"product_id":self.modelStudyTour.yoosure_id,
                            @"teacher_reward":teacherRewardStr,
                            @"camper_reward":camperRewardStr};
        }
            break;
        case ZFJGoodsTypeOfVisa:{
            NSString * reward = @"0.00";
            UITextField * temp = (UITextField *)[self.view viewWithTag:100];
            if ([self judgeString:temp.text]) {
                reward = temp.text;
            }
            if ([reward floatValue] > [self.modelVisa.commission floatValue]) {
                [[LXAlterView sharedMyTools] createTishi:@"设置失败,分销金额不能大于返佣金额!"];
                return;
            }
            parameters  = @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                            @"category_id":[[WLSingletonClass defaultWLSingleton] wlProductTypeCatId:WLProductTypeVisa],
                            @"product_id":self.modelVisa.product_id,
                            @"reward":reward};
        }
        default:
            break;
    }
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_DISTRIBUYION_GOODS;
    
    //发送请求
    __weak ZFJSteShopDistributionVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        NSLog(@"msg ==== %@", [dic objectForKey:@"msg"]);
        if ([dic objectForKey:@"status"] && [[dic objectForKey:@"status"] integerValue] == 1) {
            [[LXAlterView sharedMyTools] createTishi:@"成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"distributionSuc" object:nil];
        } else {
            [[LXAlterView sharedMyTools] createTishi:@"设置失败,请重试"];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"设置失败,请重试"];
        
    }];
}

- (NSString*)arrayToJson:(NSArray *)arr {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


- (NSAttributedString *)attributedTextBlackAndRedTitleStr:(NSString *)titleStr msgStr:(NSString *)msgStr {
    return [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#6F7378;font-size:17px>%@&nbsp;&nbsp;&nbsp;&nbsp;</span><span style=color:#FF0000;font-size:17px>¥%0.2f</span>", titleStr, [msgStr floatValue]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
}

#pragma mark --- 加载邮轮船舱数据
/**
 *  加载邮轮船舱数据
 */
- (void)loadData {
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"product_id":self.modelShip.product_id,@"assistant_id":[[LXUserTool alloc] getKeeper]};
    NSLog(@"parameters = %@", parameters);
    //接口
    NSString *url= M_SS_URL_SHIP_ROOMS;
    //发送请求
    __weak ZFJSteShopDistributionVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary * roomDic in [dic objectForKey:@"data"]) {
                ZFJSSShipRoomModel * model = [[ZFJSSShipRoomModel alloc] initWithDictionary:roomDic];
                [weakSelf.dataArr addObject:model];
                NSMutableDictionary * rewardDic = [NSMutableDictionary dictionaryWithDictionary:@{@"reward":@"0.00", @"room_id":model.room_id, @"butler_s":model.butler_s}];
                [weakSelf.roomRewardArr addObject:rewardDic];
            }
            [weakSelf.tableView reloadData];
            // weakSelf.contentSizeHeight = weakSelf.tableView.contentSize.height;
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

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)roomRewardArr {
    if (!_roomRewardArr) {
        self.roomRewardArr = [NSMutableArray array];
    }
    return _roomRewardArr;
}

#pragma mark --- UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"***textField.frame.origin.y %g *** \n***[textField superview] %g", textField.frame.origin.y, [[[textField superview] superview] superview].frame.origin.y);
    NSLog(@"***self.tableView.contentOffset.y = %g ***", self.tableView.contentOffset.y);
    NSLog(@"***差值 = %g ***", ControllerViewHeight - ([[[textField superview] superview] superview].frame.origin.y + 135 - self.tableView.contentOffset.y));
    
    CGFloat cell_y_height = [[[textField superview] superview] superview].frame.origin.y;
    
    if (ControllerViewHeight -  (cell_y_height + 135 - self.tableView.contentOffset.y) < 216) {
        self.tableView.contentOffset = CGPointMake(0,  self.tableView.contentOffset.y + (ControllerViewHeight -  (cell_y_height - self.tableView.contentOffset.y)));
        NSLog(@"*******");
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

//当键盘出现或改变时调用
- (void)keyboardShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    //NSLog(@"**** keyboardHeight = %g ****",height);
    NSLog(@"%f",self.contentSizeHeight);
    self.tableView.contentSize = CGSizeMake(windowContentWidth, ControllerViewHeight + height);
}
- (void)keyboardHide:(NSNotification *)aNotification{
    
    self.tableView.contentSize = CGSizeMake(windowContentWidth, ControllerViewHeight);
}
#pragma mark --- UIScrollViewDelegate
//开始拖拽视图
/*
 - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
 
 {
 contentOffsetY = scrollView.contentOffset.y;
 }
 //- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
 //    //    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
 //}
 // 滚动时调用此方法(手指离开屏幕后)
 
 - (void)scrollViewDidScroll:(UIScrollView *)scrollView
 
 {
 
 //NSLog(@"scrollView.contentOffset:%f, %f", scrollView.contentOffset.x, scrollView.contentOffset.y);
 
 newContentOffsetY = scrollView.contentOffset.y;
 
 
 if (newContentOffsetY > oldContentOffsetY && oldContentOffsetY > contentOffsetY) {  // 向上滚动
 
 
 NSLog(@"up");
 
 
 } else if (newContentOffsetY < oldContentOffsetY && oldContentOffsetY < contentOffsetY) { // 向下滚动
 
 
 NSLog(@"down");
 
 } else {
 
 
 NSLog(@"dragging");
 
 }
 
 
 if (scrollView.dragging) {  // 拖拽
 
 
 if ((scrollView.contentOffset.y - contentOffsetY) > 5.0f) {  // 向上拖拽
 
 
 // 隐藏导航栏和选项栏
 
 
 } else if ((contentOffsetY - scrollView.contentOffset.y) > 5.0f) {   // 向下拖拽
 
 
 // 显示导航栏和选项栏
 
 //            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
 //
 //            [[NSNotificationCenter defaultCenter] addObserver:self
 //                                                     selector:@selector(keyboardHide:)
 //                                                         name:UIKeyboardWillHideNotification
 //                                                       object:nil];
 //
 
 } else {
 
 
 }
 
 }
 
 }
 // 完成拖拽(滚动停止时调用此方法，手指离开屏幕前)
 
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
 oldContentOffsetY = scrollView.contentOffset.y;
 }
 */
#pragma mark --- Dealloc

- (void)dealloc {
    [XCLoadMsg removeLoadMsg:self];
    
    
    switch (self.goodsType) {
        case ZFJGoodsTypeOfTravel:
        {
            UIView * temp = [self.view viewWithTag:100];
            [temp removeObserver:self forKeyPath:@"text" context:nil];
            UIView * temp_child = [self.view viewWithTag:101];
            if (temp_child) {
                [temp_child removeObserver:self forKeyPath:@"text" context:nil];
            }
            
        }
            break;
        case ZFJGoodsTypeOfShip:
        {
            for (int i = 0; i < self.dataArr.count; i++) {
                UIView * temp = [self.view viewWithTag:100 + i];
                [temp removeObserver:self forKeyPath:@"text" context:nil];
            }
        }
            break;
        case ZFJGoodsTypeOfStudyTour:
        {
            for (int i = 0; i < 2; i++) {
                UIView * temp = [self.view viewWithTag:100 + i];
                [temp removeObserver:self forKeyPath:@"text" context:nil];
            }
        }
            break;
        case ZFJGoodsTypeOfVisa:{
            UIView * temp = [self.view viewWithTag:100];
            [temp removeObserver:self forKeyPath:@"text" context:nil];
        }
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"distributionSuc" object:nil];
}

@end
