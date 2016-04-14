//
//  ZFJSteShopGoodsConTypeVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopGoodsConTypeVC.h"
#import "ZFJSteShopGoodsControlVC.h"
#import "ZFJSteShopGoodsTypeCell.h"

//typedef NS_ENUM(NSInteger, ZFJGoodsType){
//    ZFJGoodsTypeOfTravel,
//    ZFJGoodsTypeOfShip,
//    ZFJGoodsTypeOfVisa,
//    ZFJGoodsTypeOfStudyTour,
//    ZFJGoodsTypeOfTicket
//};

//typedef NS_ENUM(NSInteger, ZFJGoodsTeam) {
//    ZFJGoodsTeamOfOwn,       //分销产品
//    ZFJGoodsTeamOfRetailer   //销售商产品
//};

@interface ZFJSteShopGoodsConTypeVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) ZFJGoodsType goodsType;
@property (nonatomic, assign) ZFJGoodsTeam goodsTeam;
@property (nonatomic, strong) UITableView * tabelView;
@property (nonatomic, strong) NSMutableArray * titleArr;
@property (nonatomic, strong) NSMutableArray * iconArr;

@end

@implementation ZFJSteShopGoodsConTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UISegmentedControl * segmentedCon = [[UISegmentedControl alloc] initWithItems:@[@"分销产品", @"供销商产品"]];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16.0],NSFontAttributeName,nil];
    [segmentedCon setTitleTextAttributes:dic forState:UIControlStateNormal];
    segmentedCon.tintColor = [UIColor orangeColor];
    segmentedCon.frame = CGRectMake(0, 0,windowContentWidth-140, 30);
    segmentedCon.selectedSegmentIndex = 0;
    self.goodsTeam = ZFJGoodsTeamOfOwn;
    [segmentedCon addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedCon;
    //,@"签证",@"ste_shop_goods_type_visa"
    
    [self.titleArr addObjectsFromArray:@[@"旅游度假",
                                         @"邮轮",
                                         @"游学",
                                         @"签证"]];
    
    [self.iconArr addObjectsFromArray:@[@"ste_shop_goods_type_travel",
                                        @"ste_shop_goods_type_ship",
                                        @"ste_shop_goods_type_study_tour",
                                        @"ste_shop_goods_type_visa"]];
    [self customTableView];
}

- (void)segmentControlAction:(UISegmentedControl *)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
            self.goodsTeam = ZFJGoodsTeamOfOwn;

        }
            break;
        case 1:
        {
            self.goodsTeam = ZFJGoodsTeamOfRetailer;

        }
            break;
            

        default:
            break;
    }
}

- (void)customTableView {
    self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    self.tabelView.rowHeight = 50;
    self.tabelView.tableFooterView = [[UIView alloc] init];
    self.tabelView.separatorStyle = UITableViewScrollPositionNone;
    [self.view addSubview:_tabelView];
}

#pragma mark --- UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"Cell";
    ZFJSteShopGoodsTypeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJSteShopGoodsTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    /*
    switch (indexPath.row) {
        case 0:
        {
            cell.titleLabel.text = @"旅游度假";
            cell.iconImage.image = [UIImage imageNamed:@"ste_shop_goods_type_travel"];
        }
            break;
        case 1:
        {
            cell.titleLabel.text = @"邮轮";
            cell.iconImage.image = [UIImage imageNamed:@"ste_shop_goods_type_ship"];

        }
            break;
        case 2:
        {
            cell.titleLabel.text = @"游学";
            cell.iconImage.image = [UIImage imageNamed:@"ste_shop_goods_type_study_tour"];

        }
            break;
             default:
            break;
    }
    */
    cell.titleLabel.text = self.titleArr[indexPath.row];
    cell.iconImage.image = [UIImage imageNamed:self.iconArr[indexPath.row]];
    
    return cell;
}

#pragma mark --- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZFJSteShopGoodsControlVC * vc = [[ZFJSteShopGoodsControlVC alloc] init];
    switch (indexPath.row) {
        case 0:
        {
            vc.goodsType = ZFJGoodsTypeOfTravel;

        }
            break;
        case 1:
        {
            vc.goodsType = ZFJGoodsTypeOfShip;

        }
            break;
        case 2:
        {
            vc.goodsType = ZFJGoodsTypeOfStudyTour;
        }
            break;
        case 3:
        {
            vc.goodsType = ZFJGoodsTypeOfVisa;
        }
            break;

        default:
            break;
    }
    vc.title = self.titleArr[indexPath.row];
    vc.goodsTeam = self.goodsTeam;
    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - 懒加载

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        self.titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (NSMutableArray *)iconArr {
    if (!_iconArr) {
        self.iconArr = [NSMutableArray array];
    }
    return _iconArr;
}

@end
