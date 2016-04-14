//
//  ZFJTicketHomeVC.m
//  WelLv
//
//  Created by 张发杰 on 15/8/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJTicketHomeVC.h"
#import "ZFJTicketHotCountryCell.h"
#import "ZFJTicketProductCell.h"
#import "ZFJTicketHeaderView.h"
#import "ZFJTicketFooterView.h"
#import "YXBannerView.h"
#import "HotCountryOrCityVC.h"
#import "ZFJTicketListVC.h"
#import "ZFJTicketDetailVC.h"
#import "ZFJTicketHotCityModel.h"
#import "TicketListModel.h"
#import "LXGetCityIDTool.h"

#define CELL_HOTCONTRY_INDENTIFIER @"HotCountryCell"
#define CELL_PRODUCT_INDENTIFIER @"ThemeActivitiesCell"
#define HEADER_INDENTIFIER @"Header"
#define FOOTER_INDENTIFIER @"Footer"

#define M_CYCLE_HEIGHT 150
#define M_TYPE_VIEW_HEIGHT 45
@interface ZFJTicketHomeVC ()<UICollectionViewDataSource, UICollectionViewDelegate, EScrollerViewDelegate>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) YXBannerView * headerView;

@property (nonatomic, strong) NSDictionary * dataDic;
@property (nonatomic, strong) NSMutableArray * hotCityArr;       //热门城市数组
@property (nonatomic, strong) NSMutableArray * recommendArr;     //产品推荐数组
@property (nonatomic, strong) NSMutableArray * areaArr;          //周边景点数组
@property (nonatomic, strong) NSMutableArray * adArray;
@property (nonatomic, strong) MBProgressHUD * hud;

@end

@implementation ZFJTicketHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"门票";
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, 24, 24.5);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    [self loadAD];
    [self loadData];
    [self addCustomCollectionView];
    
    //[self addCycleView];
    //[self addChooseTypeView];
}

#pragma mark ---- 搜索
/**
 *  跳转到搜索页面。
 */
-(void)searchBtnClick
{
    SearchViewController *seachVc=[[SearchViewController alloc] init];
    seachVc.searchType = 6;
    [self.navigationController pushViewController:seachVc animated:YES];
}


#pragma mark ---- 加载视图
/**
 *  加载CollectionView
 */
- (void)addCustomCollectionView {
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
  
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - [[UIApplication sharedApplication] statusBarFrame].size.height - self.navigationController.navigationBar.frame.size.height) collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(M_CYCLE_HEIGHT + M_TYPE_VIEW_HEIGHT * 2, 0, 0, 0);
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[ZFJTicketHotCountryCell class] forCellWithReuseIdentifier:CELL_HOTCONTRY_INDENTIFIER];
    [self.collectionView registerClass:[ZFJTicketProductCell class] forCellWithReuseIdentifier:CELL_PRODUCT_INDENTIFIER];
    
    [self.collectionView registerClass:[ZFJTicketHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_INDENTIFIER];
    
    [self.collectionView registerClass:[ZFJTicketFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTER_INDENTIFIER];
    
    [self.view addSubview:self.collectionView];
    [self setProgressHud];

}

/**
 *  加载轮播图
 */
- (void)addCycleViewWithY:(CGFloat)y {
    
    UIView *headerBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, y, windowContentWidth, M_CYCLE_HEIGHT)];
    headerBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.collectionView addSubview:headerBackgroundView];
    
    if (_headerView != nil)
    {
        [_headerView removeFromSuperview];
    }
    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i < self.adArray.count; i++) {
        LXAdvertModel * model = [self.adArray objectAtIndex:i];
        [arr addObject:[self judgeImageURL:model.src]];
    }
    _headerView = [[YXBannerView alloc] initWithFrameRect:CGRectMake(0, 0, windowContentWidth, M_CYCLE_HEIGHT) ImageArray:arr];
    _headerView.delegate = self;
    [headerBackgroundView addSubview:_headerView];
    

}
- (void)EScrollerViewDidClicked:(NSUInteger)index {
//    if (self.adArray.count >0) {
//        LXAdvertModel *model=[_adArray objectAtIndex:index-1];
//        if ([model.link hasPrefix:@"https://"] || [model.link hasPrefix:@"http://"]) {
//            NSString *url=[model.link stringByReplacingOccurrencesOfString:@"android" withString:@"ios"];
//            DLog(@"点击了-%@",url);
//            LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
//            specialVc.loadUrl=url;
//            specialVc.title=model.title;
//            [self.navigationController pushViewController:specialVc animated:YES];
//        }else{
//            DLog(@"没有连接");
//        }
//    }
    if (_adArray.count >0) {
        LXAdvertModel *model=[_adArray objectAtIndex:index-1];
        NSDictionary *dic = model.gotoDic;//[LXTools dictionaryWithJsonString:model.gotoDic];
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"type"] isEqualToString:@"list"]) {
            //跳转列表页
                if([self judgeString:[dic objectForKey:@"d_city"]] || [self judgeString:[dic objectForKey:@"d_province"]] || [self judgeString:[dic objectForKey:@"ticket_theme"]] ){
                    ZFJTicketListVC *ticker = [[ZFJTicketListVC alloc] init];
                    if ([self judgeString:[dic objectForKey:@"d_city"]]) {
                        NSString * cityIDStr = [[[dic objectForKey:@"d_city"] componentsSeparatedByString:@"-"] objectAtIndex:1];
                        ticker.isCity = YES;
                        ticker.keyStr = @"placecity";
                        ticker.valueStr = cityIDStr;
                    } else if ([self judgeString:[dic objectForKey:@"d_province"]]) {
                        NSString * provinceIDStr = [[[dic objectForKey:@"d_province"] componentsSeparatedByString:@"-"] objectAtIndex:1];
                        ticker.keyStr = @"placecity";
                        ticker.valueStr = provinceIDStr;
                    }
                    if ([self judgeString:[dic objectForKey:@"ticket_theme"]]) {
                        ticker.keyStr =  @"producttheme";
                        ticker.valueStr = [dic objectForKey:@"ticket_theme"];
                    }
                    [self.navigationController pushViewController:ticker animated:YES];
                }
                
            
        }else if([[dic objectForKey:@"type"] isEqualToString:@"detail"]) {
            //跳转详情页
                ZFJTicketDetailVC * detailVC = [[ZFJTicketDetailVC alloc] init];
                detailVC.product_id = [dic objectForKey:@"product_id"];
                [self.navigationController pushViewController:detailVC animated:YES];
        }else if ([[dic objectForKey:@"type"] isEqualToString:@"page"]){
            //跳转网页
            if ([[dic objectForKey:@"link"] hasPrefix:@"https://"] || [[dic objectForKey:@"link"] hasPrefix:@"http://"]) {
                NSString *url=[model.link stringByReplacingOccurrencesOfString:@"android" withString:@"ios"];
                DLog(@"点击了-%@",url);
                LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
                specialVc.loadUrl=url;
                specialVc.title=model.title;
                [self.navigationController pushViewController:specialVc animated:YES];
            }else{
                DLog(@"没有连接");
            }
            
        }else if([[dic objectForKey:@"type"] isEqualToString:@"index"]) {
            //跳转首页
                ZFJTicketHomeVC * detailVC = [[ZFJTicketHomeVC alloc] init];
                [self.navigationController pushViewController:detailVC animated:YES];
                
        }
    }

    
}

/**
 *  加载主题类型View
 */
- (void)addChooseTypeView {
   
    NSArray * typeArr = [self.dataDic objectForKey:@"themelist"];

   
    //NSLog(@"***\n%ld\n****", typeArr.count / 4.0 > typeArr.count / 4 ? typeArr.count / 4 + 1 : typeArr.count / 4);
    
    
    
    NSInteger typeViewHeight = -(M_TYPE_VIEW_HEIGHT * (typeArr.count / 4.0 > typeArr.count / 4 ? typeArr.count / 4 + 1 : typeArr.count / 4));
    self.collectionView.contentInset =  UIEdgeInsetsMake(M_CYCLE_HEIGHT + M_TYPE_VIEW_HEIGHT * (typeArr.count / 4.0 > typeArr.count / 4 ? typeArr.count / 4 + 1 : typeArr.count / 4) + 1, 0, 0, 0);
    
    [self addCycleViewWithY:-M_CYCLE_HEIGHT + typeViewHeight];
    
    UIView * typeBackView = [[UIView alloc] init];
    typeBackView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    for (int i = 0; i < typeArr.count; i++) {
        UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.backgroundColor = [UIColor whiteColor];
        if (i < 4) {
            but.frame = CGRectMake(i * (windowContentWidth - 3) / 4 + i * 1, 0, (windowContentWidth - 3) / 4, M_TYPE_VIEW_HEIGHT);
            typeBackView.frame = CGRectMake(0, typeViewHeight, windowContentWidth, M_TYPE_VIEW_HEIGHT);
        } else {
             but.frame = CGRectMake((i - 4) * (windowContentWidth - 3) / 4 + (i - 4) * 1,  M_TYPE_VIEW_HEIGHT + 1, (windowContentWidth - 3) / 4, M_TYPE_VIEW_HEIGHT);
            typeBackView.frame = CGRectMake(0, typeViewHeight, windowContentWidth, M_TYPE_VIEW_HEIGHT * 2 + 1);

        }
        but.tag = 1000 + i;
        but.titleLabel.font  = [UIFont systemFontOfSize:16];
        [but setTitle:[typeArr objectAtIndex:i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(chooseTypeBut:) forControlEvents:UIControlEventTouchUpInside];
        
        [typeBackView addSubview:but];
    }
    [self.collectionView addSubview:typeBackView];
}
/**
 *  选择主题类型按钮方法
 *
 *  @param button
 */
- (void)chooseTypeBut:(UIButton *)button {
    NSArray * typeArr = [self.dataDic objectForKey:@"themelist"];
    [self pushToTicketListVCWithKey:@"producttheme" value:[typeArr objectAtIndex:button.tag - 1000]];
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return self.recommendArr.count;
            break;
            
        case 1:
            return self.areaArr.count;
            break;
            
        case 2:
            return MIN(self.hotCityArr.count, 8);
            break;

        default:
            break;
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        
        ZFJTicketHotCountryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_HOTCONTRY_INDENTIFIER forIndexPath:indexPath];
        cell.model = [self.hotCityArr objectAtIndex:indexPath.row];
        return cell;
       
    } else {
        
        ZFJTicketProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_PRODUCT_INDENTIFIER forIndexPath:indexPath];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        if (indexPath.section == 0) {
            cell.model = [self.recommendArr objectAtIndex:indexPath.row];
        } else {
            cell.model = [self.areaArr objectAtIndex:indexPath.row];
        }
        return cell;
    }
    
    return nil;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr = @[@"产品推荐", @"周边景点", @"热门国家"];
    NSArray *titleArr = @[@"产品推荐", @"周边景点", @"热门城市"];

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ZFJTicketHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADER_INDENTIFIER forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        headerView.iconImageView.image = [UIImage imageNamed:[arr objectAtIndex:indexPath.section]];
        headerView.titleLabel.text = [titleArr objectAtIndex:indexPath.section];
        
        return headerView;
    }
    
    ZFJTicketFooterView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTER_INDENTIFIER forIndexPath:indexPath];
    footerView.titleBut.tag = 100 + indexPath.section;
    [footerView.titleBut addTarget:self action:@selector(checkMore:) forControlEvents:UIControlEventTouchUpInside];
    footerView.backgroundColor = [UIColor blueColor];
    return footerView;

}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return CGSizeMake((windowContentWidth - 20 - 10) / 2, (windowContentWidth - 20 - 10) / 2 * 22 / 35);
            break;
            
        case 1:
            return CGSizeMake((windowContentWidth - 20 - 10) / 2, (windowContentWidth - 20 - 10) / 2 * 22 / 35);
            break;
            
        case 2:
            return CGSizeMake(70, 90);
            break;
            
        default:
            break;
    }
    
    return CGSizeMake(0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 0:
            return 10;
            break;
            
        case 1:
            return 10;
            break;
            
        case 2:
            return ((windowContentWidth - 20) - 70 * 4) / 3.0;
            break;

        default:
            break;
    }
    return 0;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(0, 10, 0, 10);
            break;
            
        case 1:
            return UIEdgeInsetsMake(0, 10, 0, 10);
            break;
            
        case 2:
            return UIEdgeInsetsMake(0, 10, 0, 10);
            break;

        default:
            break;
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return CGSizeMake(windowContentWidth, 55);

            break;
        case 1:
            return CGSizeMake(windowContentWidth, 55);

            break;
        case 2:
            return CGSizeMake(windowContentWidth, 55);

            break;

        default:
            break;
    }
    return CGSizeMake(windowContentWidth, 55);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    

    switch (section) {
        case 0:
            if (self.recommendArr.count >=4) {
                return CGSizeMake(windowContentWidth, 40);
            }
            return CGSizeMake(windowContentWidth, 0);
            
            break;
        case 1:
            if (self.areaArr.count >=4) {
                return CGSizeMake(windowContentWidth, 40);
            }
            return CGSizeMake(windowContentWidth, 0);
            
            break;
        case 2:
            
            if (self.hotCityArr.count >= 8) {
                return CGSizeMake(windowContentWidth, 40);

            }
            return CGSizeMake(windowContentWidth, 0);
            
            break;
            
        default:
            break;
    }
    return CGSizeMake(windowContentWidth, 0);
}

#pragma mark ---- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        ZFJTicketHotCityModel * model = [self.hotCityArr objectAtIndex:indexPath.row];
//        [self pushToTicketListVCWithKey:@"placecity" value:model.place_city];
        ZFJTicketListVC * listVC = [[ZFJTicketListVC alloc] init];
        listVC.keyStr = @"placecity";
        listVC.valueStr = model.name;
        listVC.isCity = YES;
        [self.navigationController pushViewController:listVC animated:YES];

    } else {
        [self pushProductDetailVC:indexPath];
    }
    
}
#pragma mark --- 查看更多
- (void)checkMore:(UIButton *)button {
    
    switch (button.tag - 100) {
        case 0:
            [self pushToTicketListVCWithKey:@"isrecommend" value:@"1"];
            
            break;
        case 1:
            [self pushToTicketListVCWithKey:@"placecity" value:[[WLSingletonClass defaultWLSingleton] wlCityName]];
           // NSLog(@"%@", [self choose_City]);
            //placeprovince
            //[self pushToTicketListVCWithKey:@"placeprovince" value:[self choose_City]];

            break;
            
        case 2:
            [self pushToHotCityVC];
            break;
            
        default:
            break;
    }
}

/**
 *  查看更多列表页面
 */
- (void)pushToTicketListVCWithKey:(NSString *)keyStr value:(NSString *)valueStr {
    //NSLog(@"***\n%@\n%@***", keyStr, valueStr);
    ZFJTicketListVC * listVC = [[ZFJTicketListVC alloc] init];
    listVC.keyStr = keyStr;
    listVC.valueStr = valueStr;
    if ([keyStr isEqualToString:@"isrecommend"]) {
        listVC.provinceStr = [self.dataDic objectForKey:@"province"];
    }
    [self.navigationController pushViewController:listVC animated:YES];
}

/**
 *   查看更多热门城市
 */
- (void)pushToHotCityVC {
    
    HotCountryOrCityVC * hotCityVC = [[HotCountryOrCityVC alloc] init];
    hotCityVC.titleStr = @"热门城市";
    hotCityVC.type = 1;
    hotCityVC.listURLStr = M_TICKET_HOTCITY_URL;
    [self.navigationController pushViewController:hotCityVC animated:YES];
}

/**
 *  产品详情
 */
- (void)pushProductDetailVC:(NSIndexPath *)indexPath {
    
    ZFJTicketDetailVC * detailVC = [[ZFJTicketDetailVC alloc] init];
    if (indexPath.section == 0) {
        TicketListModel * model = [self.recommendArr objectAtIndex:indexPath.row];
        detailVC.product_id = model.product_id;
    } else if (indexPath.section == 1) {
        TicketListModel * model = [self.areaArr objectAtIndex:indexPath.row];
        detailVC.product_id = model.product_id;
    }
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark ---- 加载数据

/**
 *  请求数据 post
 */
- (void)loadData {
    [self setProgressHud];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSLog(@"*****\n%@\n*****", [self choose_City]);
    
    NSDictionary *parameters = @{@"placecity":[self judgeReturnString:[[WLSingletonClass defaultWLSingleton] wlCityName] withReplaceString:@"郑州"]};
    NSLog(@"***parameters = %@***", parameters);
    //接口
    NSString *url= M_TICKET_HOME_URL;
    //发送请求
    __weak ZFJTicketHomeVC * homeVC = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        [_hud hide:YES];

        homeVC.dataDic = [dic objectForKey:@"data"];
        
        if ([[[dic objectForKey:@"data"] objectForKey:@"recommendlist"] isEqual:[NSNull null]]) {
           
        } else {
            for (NSDictionary * dict in [[dic objectForKey:@"data"] objectForKey:@"recommendlist"]) {
                TicketListModel * model = [[TicketListModel alloc] initWithDictionary:dict];
                if ([self judgeString:model.start_price]) {
                    if (![model.start_price isEqualToString:@"0"]) {
                        [homeVC.recommendArr addObject:model];
                    }
                }
            }

        }
        if ([[[dic objectForKey:@"data"] objectForKey:@"arealist"] isEqual:[NSNull null]]) {
            
        } else {
            for (NSDictionary * dict in [[dic objectForKey:@"data"] objectForKey:@"arealist"]) {
                TicketListModel * model = [[TicketListModel alloc] initWithDictionary:dict];
                if ([self judgeString:model.start_price] ) {
                    if (![model.start_price isEqualToString:@"0"]) {
                        [homeVC.areaArr addObject:model];
                    }
                }

            }
        }
        if ([[[dic objectForKey:@"data"] objectForKey:@"hotcity"] isEqual:[NSNull null]]) {
            
        } else {
            
            NSArray * hotCityArr = [[dic objectForKey:@"data"] objectForKey:@"hotcity"];
            for (int i = 0; i < hotCityArr.count; i++) {
                if ([[hotCityArr objectAtIndex:i] isKindOfClass:[NSDictionary class]]) {
                    ZFJTicketHotCityModel * model = [[ZFJTicketHotCityModel alloc] initWithDictionary:[hotCityArr objectAtIndex:i]];
                    [homeVC.hotCityArr addObject:model];
                } else {
                    
                }
            }
            
        }
        
        [homeVC addChooseTypeView];
        [homeVC.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [_hud hide:YES];
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [homeVC loadData];
        }];


    }];
    
}

//加载签证广告
- (void)loadAD
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    [self setProgressHud];

    NSString *str=[NSString stringWithFormat:@"%@", AdvertUrl(@"89", [[WLSingletonClass defaultWLSingleton] wlCityId])];
    NSLog(@"%@", str);
    __weak ZFJTicketHomeVC * homeVC = self;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        [homeVC.adArray removeAllObjects];
        for (NSDictionary * dic in dict) {
            //[homeVC.adArray addObject:[NSString stringWithFormat:@"%@/%@", WLHTTP, [dic objectForKey:@"src"]]];
            LXAdvertModel *detailModel = [[LXAdvertModel alloc] initWithDictionary:dic];
            [homeVC.adArray addObject:detailModel];
        }
        [homeVC.collectionView reloadData];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [homeVC loadAD];
        }];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}
- (NSMutableArray *)adArray {
    if (_adArray == nil) {
        self.adArray = [NSMutableArray array];
    }
    return _adArray;
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}
//数据加载完成之前显示转动的菊花圈
- (void)setProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"正在加载...";
    [self.view addSubview:_hud];
    [_hud show:YES];
}

#pragma mark ---- 懒加载

- (NSMutableArray *)hotCityArr {
    if (_hotCityArr == nil) {
        self.hotCityArr = [NSMutableArray array];
    }
    return _hotCityArr;
}

- (NSMutableArray *)areaArr {
    if (_areaArr == nil) {
        self.areaArr = [NSMutableArray array];
    }
    return _areaArr;
}

- (NSMutableArray *)recommendArr {
    if (_recommendArr == nil) {
        self.recommendArr = [NSMutableArray array];
    }
    return _recommendArr;
}


- (void)viewDidDisappear:(BOOL)animated {
    [_hud hide:YES];

}
@end
