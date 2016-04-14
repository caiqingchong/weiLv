//
//  ZFJShipViewController.m
//  WelLv
//
//  Created by 张发杰 on 15/5/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipViewController.h"
#import "LXTopBtnView.h"
#import "YXBannerView.h"
#import "NavSearchView.h"
#import "ZFJImageAndTitleButton.h"
#import "ZFJShipTableViewCell.h"
#import "ZFJShipZeroRowCell.h"
#import "ZFJShipListVC.h"
#import "ZFJShipDetailVC.h"
#import "ZFJShipLineModel.h"
#import "ZFJShipListModel.h"
#import "LXShipCalendarView.h"
#import "LXShipCalendarModel.h"
#import "LXGetCityIDTool.h"
#import "LXShipCalendarViewController.h"
//#import "TitleAndBtnScrollView.h"
//
#import "IconAndTitleView.h"

#define HotBtnWith (windowContentWidth -15*2-10*2)/3
#define BannerHegit 150
#define M_SHIPLINEHIGTH 240
//(270 * windowContentWidth / 320) / 2 - 45

#define M_LEFT_WIDTH 15
#define M_LINE_Introduce_HEIGHT 120

#define M_Canlendar_View_HEIGHT 60*6+65 //日历图高度；
#define M_TITLE_HEIGHT 30  //标题高度；
#define M_HADER_HEIGHT 45  //区头高度；



@interface ZFJShipViewController ()<LXTopBtnViewDelegate, UITableViewDataSource, UITableViewDelegate, EScrollerViewDelegate, NavSearchViewDelegate>
{
    YXBannerView *_headerView;
    NSMutableArray *_webSiteArr;
    NSMutableArray *_shipCalendarArray;
}
@property (nonatomic, strong) LXTopBtnView *topView;
@property (nonatomic, strong) UITableView * shipTableView;

@property (nonatomic, strong) UIView * firstHeaderView;


@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSMutableArray * lineArray;     //航线数组；
@property (nonatomic, strong) NSMutableArray * privilegeArray;//特惠数组；
@property (nonatomic, strong) NSMutableArray * shipOneLineArray;
@property (nonatomic, strong) NSMutableArray * shipLineMsgArray;
@property (nonatomic, strong) NSMutableArray * adArray;

@property (nonatomic, copy) NSString *searchStr;

@property (nonatomic, strong) UIView * headerView;




@property (nonatomic, strong) YXBannerView * circulationView;//轮播图

@property (nonatomic, strong) UIScrollView * shipScrollView;

//@property (nonatomic, strong) UIView *canlendarView; //日历图


@property (nonatomic, strong) UIView * setSailDayShipView; //日历下某天出发的邮轮；
@property (nonatomic, assign) BOOL isSetSailDayShipViewOpen;

@property (nonatomic, strong) UILabel *privilegeLabel;
@property (nonatomic, strong) UIView * lineTwo;

@property (nonatomic, assign) CGFloat zeroHeight;
@property (nonatomic, strong) LXShipCalendarView *LxShipCalendar;

@property (nonatomic, strong) NavSearchView *searchView;
@property (nonatomic, strong) UIButton * moreBut;

//
@property (nonatomic, strong) UIView * chooesLinePage;


@end

@implementation ZFJShipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"邮轮";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, 23, 23);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    // 导航栏（navigationbar）
    CGRect rectNav = self.navigationController.navigationBar.frame;
    self.shipTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - rectNav.size.height ) style:UITableViewStyleGrouped];
    
    self.shipTableView.dataSource = self;
    self.shipTableView.delegate = self;
    self.shipTableView.rowHeight = 95;
    self.shipTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.zeroHeight = BannerHegit + M_SHIPLINEHIGTH  + M_TITLE_HEIGHT + M_Canlendar_View_HEIGHT + 5 + rectNav.size.height;
    self.shipTableView.sectionHeaderHeight = 45;
    self.shipTableView.sectionFooterHeight = 0;
    [self.view addSubview:_shipTableView];
    [self loadData];
    
}
-(void)searchBtnClick
{
    SearchViewController *seachVc=[[SearchViewController alloc] init];
    seachVc.searchType = 2;
    [self.navigationController pushViewController:seachVc animated:YES];
}

- (UIView *)addFirstHeaderView{
    if (self.firstHeaderView == nil) {
        self.firstHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 540)];
    }
    self.firstHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self initScrollView];
    return _firstHeaderView;
}
#pragma mark加载上边的视图
- (void)addshipLineView {
    
    NSInteger pageCount = self.lineArray.count / 8 < self.lineArray.count / 8.0 ? self.lineArray.count / 8 + 1 :self.lineArray.count / 8;
    UIScrollView * shipLineScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BannerHegit, windowContentWidth , self.lineArray.count > 4 ? 245 : 125)];
    shipLineScrollView.contentSize = CGSizeMake(windowContentWidth * (self.lineArray.count / 8 < self.lineArray.count / 8.0 ? self.lineArray.count / 8 + 1 :self.lineArray.count / 8 ), shipLineScrollView.height);
    shipLineScrollView.delegate = self;
    shipLineScrollView.pagingEnabled = YES;
    shipLineScrollView.backgroundColor = [UIColor whiteColor];
    shipLineScrollView.showsHorizontalScrollIndicator = NO;
    shipLineScrollView.tag = 222;
    
    NSMutableArray * nameArr = [NSMutableArray array];
    NSMutableArray * iconImageArr = [NSMutableArray array];
    for (int i = 0; i < pageCount; i++) {
        [nameArr addObject:[NSMutableArray array]];
        [iconImageArr addObject:[NSMutableArray array]];
    }
    
    for (int i = 0; i < self.lineArray.count; i++) {
        ZFJShipLineModel * model = [self.lineArray objectAtIndex:i];
        NSString * str = [self judgeReturnString:model.line_name withReplaceString:@""];
        NSArray * arr = [str componentsSeparatedByString:@"航线"];
        [[nameArr objectAtIndex:i / 8] addObject:[arr objectAtIndex:0]];
        [[iconImageArr objectAtIndex:i / 8] addObject:[self judgeReturnString:[self judgeImageURL:model.pic] withReplaceString:[arr objectAtIndex:0]]];
    }
    
    for (int i = 0; i < nameArr.count; i++) {
        IconAndTitleView * shipLineView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(windowContentWidth * i, 15, windowContentWidth, 220) shipLineTitleArray:[nameArr objectAtIndex:i] ImageURLArray:[iconImageArr objectAtIndex:i]];
        [shipLineView chooseTop:^(NSInteger chooseTop) {
            ZFJShipLineModel * model = [_lineArray objectAtIndex:chooseTop];
            ZFJShipListVC * shipListVC = [[ZFJShipListVC alloc] init];
            shipListVC.line_id = model.line_id;
            shipListVC.lineName = model.line_name;
            shipListVC.keywoerd = @"";
            [self.navigationController pushViewController:shipListVC animated:YES];
        }];
        [shipLineScrollView addSubview:shipLineView];
    }
    
    [self.firstHeaderView addSubview:shipLineScrollView];
    if (pageCount >= 2) {
        UIView * pageTagView = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth(shipLineScrollView) / 2 - (20 * pageCount + (pageCount - 1) * 10) / 2,ViewY(shipLineScrollView) + ViewHeight(shipLineScrollView) - 10, 20 * pageCount + (pageCount - 1) * 10, 3)];
        for (int i = 0; i < pageCount; i++) {
            UIView * pageTag = [[UIView alloc] initWithFrame:CGRectMake(20  * i + 10 * i, 0, 20, 3)];
            pageTag.layer.cornerRadius = 2.0;
            pageTag.layer.masksToBounds = YES;
            pageTag.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            [pageTagView addSubview:pageTag];
        }
        self.chooesLinePage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 3)];
        _chooesLinePage.backgroundColor = [UIColor greenColor];
        [pageTagView addSubview:_chooesLinePage];
        
        pageTagView.backgroundColor = [UIColor whiteColor];
        [self.firstHeaderView addSubview:pageTagView];
    }
    
    IconAndTitleView * shipLineCalendarView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewY(shipLineScrollView) + ViewHeight(shipLineScrollView) + 15, windowContentWidth, 45) iconImageName:@"邮轮日历" titleLabel:@"邮轮日历"];
    shipLineCalendarView.goIcon.hidden = NO;
    shipLineCalendarView.titleLabel.userInteractionEnabled = YES;
    [shipLineCalendarView chooseTop:^(NSInteger chooseTop) {
        DLog(@"邮轮日历");
        LXShipCalendarViewController *lxshipCalendarVc=[[LXShipCalendarViewController alloc] init];
        lxshipCalendarVc.ShipCalendarArray=_shipCalendarArray;
        [self.navigationController pushViewController:lxshipCalendarVc animated:YES];
    }];
    [self.firstHeaderView addSubview:shipLineCalendarView];
    //精品航线；
    IconAndTitleView * privilegeShipLineView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewY(shipLineCalendarView) + ViewHeight(shipLineCalendarView) + 15, windowContentWidth, 45) iconImageName:@"精品航线" titleLabel:@"精品航线"];
    [self.firstHeaderView addSubview:privilegeShipLineView];
    self.zeroHeight = ViewHeight(privilegeShipLineView) + ViewY(privilegeShipLineView) - 1;
}
//#pragma mark ---- 热推航线更多按钮点击
//-(void)morBtnClick
//{
//
//    
//    
//}
#pragma mark ---- 滑动视图Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 222) {
        [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            _chooesLinePage.frame = CGRectMake(scrollView.contentOffset.x / windowContentWidth * 30, 0, 20, 3);
        } completion:nil];
    }
}


//滑动轮播图
- (void)initScrollView
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, BannerHegit)];
    headerView.backgroundColor = [UIColor clearColor];
    if (_headerView != nil)
    {
        [_headerView removeFromSuperview];
    }
    
    if (self.adArray != nil ) {
        NSMutableArray * adURLArr = [NSMutableArray array];
        for (int i = 0; i < self.adArray.count; i++) {
            LXAdvertModel * model = [self.adArray objectAtIndex:i];
            [adURLArr addObject:[self judgeImageURL:model.src]];
        }
        _headerView = [[YXBannerView alloc] initWithFrameRect:headerView.frame ImageArray:adURLArr];
    }
    _headerView.delegate = self;
    return [self.firstHeaderView addSubview:_headerView];
}

#pragma mark ---- 点击轮播图的方法

- (void)EScrollerViewDidClicked:(NSUInteger)index {
    if (_adArray.count >0) {
        LXAdvertModel *model=[_adArray objectAtIndex:index-1];
        NSDictionary *dic = model.gotoDic;//[LXTools dictionaryWithJsonString:model.gotoDic];
        NSLog(@"%@",model.gotoDic);
        if ([[dic objectForKey:@"type"] isEqualToString:@"list"]) {
            //跳转列表页
                ZFJShipListVC *ship = [[ZFJShipListVC alloc] init];
                ship.line_id =[dic objectForKey:@"cruise_line"];
                [self.navigationController pushViewController:ship animated:YES];
            
        }else if([[dic objectForKey:@"type"] isEqualToString:@"detail"]) {
            //跳转详情页
                ZFJShipDetailVC * detailVC = [[ZFJShipDetailVC alloc] init];
                detailVC.product_id = [dic objectForKey:@"product_id"];
                [self.navigationController pushViewController:detailVC animated:YES];
                
        }else if ([[dic objectForKey:@"type"] isEqualToString:@"page"]){
            //跳转网页
            if ([[dic objectForKey:@"link"] hasPrefix:@"https://"] || [[dic objectForKey:@"link"] hasPrefix:@"http://"]) {
                NSString *url=[[dic objectForKey:@"link"] stringByReplacingOccurrencesOfString:@"android" withString:@"ios"];
                // url=[model.link stringByReplacingOccurrencesOfString:@"Android" withString:@"ios"];
                // DLog(@"点击了-%@",url);
                LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
                specialVc.loadUrl=url;
                specialVc.title=model.title;
                [self.navigationController pushViewController:specialVc animated:YES];
            }else if([model.link hasPrefix:@"https://"] || [model.link hasPrefix:@"http://"]){
                NSString *url=[model.link stringByReplacingOccurrencesOfString:@"android" withString:@"ios"];
                LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
                specialVc.loadUrl=url;
                specialVc.title=model.title;
                [self.navigationController pushViewController:specialVc animated:YES];
            }else{
                DLog(@"没有连接");
            }
            
        }
    }
}

#pragma mark ----- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.privilegeArray.count != 0) {
        if (self.privilegeArray.count >= 4) {
            return 4;
        }
        return self.privilegeArray.count;
    } else if (section == 0 && self.privilegeArray.count == 0) {
        return 0;
    }
    NSMutableArray * onelineArr =[_shipOneLineArray objectAtIndex:section - 1];
    return onelineArr.count + 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > 0 && indexPath.row == 0) {
        static NSString * cellIndentifier = @"ZeroCell";
        ZFJShipZeroRowCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell = [[ZFJShipZeroRowCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if ([[NSString stringWithFormat:@"%@", [[self.shipLineMsgArray objectAtIndex:indexPath.section - 1] objectForKey:@"thumb"]] hasPrefix:@"http"]) {
            
            [cell.iconIamgeView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[self.shipLineMsgArray objectAtIndex:indexPath.section - 1] objectForKey:@"thumb"]]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
        } else {
            [cell.iconIamgeView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WLHTTP,[[self.shipLineMsgArray objectAtIndex:indexPath.section - 1] objectForKey:@"thumb"]]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
        }
        cell.lineCountLabel.text = [NSString stringWithFormat:@"%@条航次", [[self.shipLineMsgArray objectAtIndex:indexPath.section - 1] objectForKey:@"count"]];
        if ([[[self.shipLineMsgArray objectAtIndex:indexPath.section - 1] objectForKey:@"min_price"] isEqual:[NSNull null]]) {
            cell.priceLabel.text = [NSString stringWithFormat:@" "];
        } else{
            cell.priceLabel.text = [NSString stringWithFormat:@"¥%@", [[self.shipLineMsgArray objectAtIndex:indexPath.section - 1] objectForKey:@"min_price"]];
        }
        cell.inforLabel.text = [NSString stringWithFormat:@"%@", [[self.shipLineMsgArray objectAtIndex:indexPath.section - 1] objectForKey:@"profile"]];
        return cell;
    }
    else
    {
    
    }
    static NSString * cellIndentifier = @"Cell";
    ZFJShipTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[ZFJShipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier customStry:ZFJShipTableViewCellStyleTwo];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        if (self.privilegeArray.count != 0) {
            cell.shipListModel = [self.privilegeArray objectAtIndex:indexPath.row];
        }
    } else{
        if (self.shipOneLineArray.count != 0){
            cell.shipListModel = [[self.shipOneLineArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row - 1];
        }
    }
    return cell;
}

#pragma mark ----- UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (self.firstHeaderView == nil) {
            return [self addFirstHeaderView];
        }
        return self.firstHeaderView;
    }
    for (int i = 0; i < self.shipLineMsgArray.count; i++) {
        UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, M_HADER_HEIGHT)];
        titleView.backgroundColor = [UIColor whiteColor];
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, 10, windowContentWidth, M_TITLE_HEIGHT)];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = [NSString stringWithFormat:@"%@", [[self.shipLineMsgArray objectAtIndex:i] objectForKey:@"line_name"]];
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor blackColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, ViewY(titleLabel) + ViewHeight(titleLabel) - 0.5, [self returnTextCGRectText:[[self.shipLineMsgArray objectAtIndex:i] objectForKey:@"line_name"] textFont:15].size.width, 0.5)];
        line.backgroundColor = [UIColor orangeColor];
        [titleView addSubview:line];
        [titleView addSubview:titleLabel];
        UIButton * moreBut = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBut.frame = CGRectMake(windowContentWidth - 60, 10, 60, M_TITLE_HEIGHT);
        [moreBut setTitle:@"更多》" forState:UIControlStateNormal];
        [moreBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        moreBut.titleLabel.font = [UIFont systemFontOfSize:15];
        moreBut.tag = 600 + i;
        [moreBut addTarget:self action:@selector(moreView:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:moreBut];
        
        if (i  + 1 == section) {
            return titleView;
        }
        
    }
    return nil;
}


- (void)moreView:(UIButton *)button{
    if (button.tag == 888) {
        ZFJShipListVC * shipListVC = [[ZFJShipListVC alloc] init];
        shipListVC.isPrivilege = YES;
        shipListVC.lineName = @"特惠线路";
        [self.navigationController pushViewController:shipListVC animated:YES];
    } else{
        ZFJShipListVC * shipListVC = [[ZFJShipListVC alloc] init];
        
        shipListVC.lineName = [[self.shipLineMsgArray objectAtIndex:(button.tag - 600)] objectForKey:@"line_name"];
        shipListVC.line_id =[[self.shipLineMsgArray objectAtIndex:(button.tag - 600)] objectForKey:@"line_id"];
        shipListVC.keywoerd = @"";
        [self.navigationController pushViewController:shipListVC animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section > 0 && indexPath.row == 0) {
        ZFJShipListVC * shipListVC = [[ZFJShipListVC alloc] init];
        shipListVC.line_id = [[self.shipLineMsgArray objectAtIndex:indexPath.section - 1] objectForKey:@"line_id"];
        shipListVC.lineName = [[self.shipLineMsgArray objectAtIndex:indexPath.section - 1] objectForKey:@"line_name"];
        shipListVC.keywoerd = @"";
        [self.navigationController pushViewController:shipListVC animated:YES];
    }else if (indexPath.section == 0){
        ZFJShipDetailVC * dtailVC = [[ZFJShipDetailVC alloc] init];
        ZFJShipListModel * listModel = [self.privilegeArray objectAtIndex:indexPath.row];
        dtailVC.product_id = listModel.product_id;
        [self.navigationController pushViewController:dtailVC animated:YES];
        
    } else{
        ZFJShipDetailVC * dtailVC = [[ZFJShipDetailVC alloc] init];
        ZFJShipListModel * listModel = [[self.shipOneLineArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row - 1];
        dtailVC.product_id = listModel.product_id;
        [self.navigationController pushViewController:dtailVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.zeroHeight;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section >0 && indexPath.row == 0) {
        return 180;
    }
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    //NSLog(@"cell height %f",cell.frame.size.height);
    return cell.frame.size.height;
}

#pragma mark ---- loadData

- (NSMutableArray *)lineArray{
    if (_lineArray == nil) {
        self.lineArray = [NSMutableArray array];
    }
    return _lineArray;
}

#pragma mark -加载邮轮首页数据
- (void)loadData{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    NSString *assistant_id=@"";
    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
        assistant_id=@"0";
    }
    else
    {
        assistant_id=[[LXUserTool alloc] getKeeper];
    }

    
    
    NSString *str= [NSString stringWithFormat:@"%@?city_id=%@&assistant_id=%@", M_URL_SHIP_HOME, [[WLSingletonClass defaultWLSingleton] wlCityId],assistant_id];
    __weak ZFJShipViewController * shipVC = self;
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        if ([dict isKindOfClass:[NSDictionary class]] && [[dict objectForKey:@"status"] integerValue] == 1 && [[dict objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            shipVC.adArray = [NSMutableArray array];
            for (NSDictionary * dic in [[dict objectForKey:@"data"] objectForKey:@"ad"]) {
                LXAdvertModel *detailModel = [[LXAdvertModel alloc] initWithDictionary:dic];
                [shipVC.adArray addObject:detailModel];
            }
            [self initScrollView];
            
            for (NSDictionary * dic in [[dict objectForKey:@"data"] objectForKey:@"line_list"]) {
                ZFJShipLineModel * model = [[ZFJShipLineModel alloc] initWithDictionary:dic];
                [self.lineArray addObject:model];
            }
            [self addshipLineView];
            

            NSMutableArray *riliArray=[NSMutableArray array];
            riliArray=[[dict objectForKey:@"data"] objectForKey:@"rili"];
            _shipCalendarArray=[NSMutableArray array];

            if ([[[dict objectForKey:@"data"] objectForKey:@"tehuichanpin"] isKindOfClass:[NSArray class]]) {
                for (NSDictionary * dic in [[dict objectForKey:@"data"] objectForKey:@"tehuichanpin"]) {
                    ZFJShipListModel * model = [[ZFJShipListModel alloc] initWithDictionary:dic];
                    [self.privilegeArray addObject:model];
                }
            }
            [self.shipTableView reloadData];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [self loadData];
        }];
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

- (NSMutableArray *)privilegeArray{
    if (_privilegeArray == nil) {
        self.privilegeArray = [NSMutableArray array];
    }
    return _privilegeArray;
}

- (NSMutableArray *)shipOneLineArray{
    if (_shipOneLineArray == nil) {
        self.shipOneLineArray = [NSMutableArray array];
    }
    return _shipOneLineArray;
}

- (NSMutableArray *)shipLineMsgArray{
    if (_shipLineMsgArray == nil) {
        self.shipLineMsgArray = [NSMutableArray array];
    }
    return _shipLineMsgArray;
}

#pragma mark ----navSearchDelegate

- (void)beginSearch:(NSString *)text
{
    if (text.length != 0) {
        ZFJShipListVC * shipListVC = [[ZFJShipListVC alloc] init];
        shipListVC.line_id = @"";
        shipListVC.lineName = @"邮轮列表";
        shipListVC.keywoerd = text;
        [self.navigationController pushViewController:shipListVC animated:YES];
    }
}

#pragma mark ----

- (CGRect)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(0, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return rect;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchView.searchBar resignFirstResponder];
}

@end
