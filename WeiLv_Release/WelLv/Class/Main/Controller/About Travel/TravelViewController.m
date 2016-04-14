
//
//  TravelViewController.m
//  WelLv
//
//  Created by lyx on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#import "MyOrderTableViewCOntroller.h"


#import "TravelViewController.h"
#import "TravelAllHeader.h"
#import "GuoneiViewController.h"
#import "CYYkViewController.h"
#import "ManagCusInfoViewController.h"

#import "ChangeTravellerInfoViewController.h"

#import "ProductDetailViewController.h"

#import "TraveSearchViewController.h"

#import "SearchViewController.h"
#import "YXPaySuccessViewController.h"

#import "TravelManagCusInfoViewController.h"

#import "TravelNewSearchResultViewController.h"
#import "ProductDetailViewController.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height






@interface TravelViewController ()<UIScrollViewDelegate>

{
    NSInteger cycleImageHeight;
}


//背部滑动
@property (nonatomic ,strong) UIScrollView *backScrollView;
//上部模块视图
@property (nonatomic, strong) TravelHeaderView *headerView;
//精品线路视图
@property (nonatomic, strong) TravelBoutiqueLineView *TBLView;
@property (nonatomic, strong) TravelMiddleView *middleView;

//精品线路列表
@property (nonatomic, strong) UITableView *boutiqueLineTabelView;

//精品线路轮播图数组
@property (nonatomic, strong) NSMutableArray *cycleImageArray;
//精品线路信息数组
@property (nonatomic, strong) NSMutableArray *jpProductsArray;
@property (nonatomic, strong) BoutiqueTableViewController *
bTTViewController;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic, strong) NSMutableArray *imageAllUrlArr;

@property (nonatomic, strong) UIPageControl *control;//页面控制器
@property (nonatomic, strong) NSTimer *timer;//设置动画
@property (nonatomic, strong) UIImageView *frontImageView; //最前一张
@property (nonatomic, strong) UIImageView *lastImageView; //最后一张

@property (nonatomic, assign) NSInteger indexNumber;


@end

@implementation TravelViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _city_id=[[WLSingletonClass defaultWLSingleton] wlCityId];
    
    self.indexNumber = 0;
    
    self.imageAllUrlArr = [NSMutableArray array];
    //请求数据
    [self getHomePageDataFromUrl];
    //添加背景滑动图
    [self addBackView];
    //添加分块视图
    [self addSubViews];
    //添加搜索按钮
    [self layoutItemButton];
    
    
    _backBtn = [[BackBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    _backBtn.leftView.image = [UIImage imageNamed:@"back"];
    [_backBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    
    
    self.view.backgroundColor = BgViewColor;
    self.title = @"旅游";
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    

    self.cycleImageArray = [NSMutableArray array];
    self.jpProductsArray = [NSMutableArray array];
    
    if (UISCREEN_HEIGHT < 667) {
        cycleImageHeight = 160;
    } else {
        cycleImageHeight = 200;
    }
    
}


- (void)close
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

//添加搜索按钮
- (void)layoutItemButton {
    
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 23, 23);
    [searchBtn setImage:[UIImage imageNamed:@"Newsearch"] forState:UIControlStateNormal];
//    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn addTarget:self action:@selector(gotoSearchPage:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
}
- (void)gotoSearchPage:(UIButton *)sender {

    SearchViewController *searchVC = [[SearchViewController alloc]init];
    searchVC.searchType=1;
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

//添加背景滚动图
- (void)addBackView {
    
    self.backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    
    if (UISCREEN_HEIGHT == 667) {
        self.backScrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, kBackViewSizeHeight6);
    } else if (UISCREEN_HEIGHT == 736) {
        self.backScrollView.contentSize = CGSizeMake(UISCREEN_WIDTH,kBackViewSizeHeight6p);
    } else if (UISCREEN_HEIGHT == 568) {
        self.backScrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, kBackViewSizeHeight5);
    } else {
        self.backScrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, kBackViewSizeHeight4);
    }

    self.backScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.backScrollView];
    
}

//添加分块视图
- (void)addSubViews {
    
    //添加搜索视图

//    [self.backScrollView addSubview:self.searchView];
    
    //添加上部视图
    
    if (UISCREEN_HEIGHT < 667) {
    self.headerView = [[TravelHeaderView alloc]initWithFrame:CGRectMake( 0,0, UISCREEN_WIDTH, kTraverProductItemHeight5)];
    } else {
    self.headerView = [[TravelHeaderView alloc]initWithFrame:CGRectMake( 0,0, UISCREEN_WIDTH, kTraverProductItemHeight)];
    }

    self.headerView.aroundLabel.text = @"周边游";
    self.headerView.domesticLabel.text = @"国内游";
    self.headerView.HMTTravelLabel.text = @"港澳台";
    self.headerView.exitLabel.text = @"出境游";
    self.headerView.exitTouristGroupLabel.text = @"境外参团";
    
    //国内游点击事件
    UITapGestureRecognizer *domesticTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoDomesticListPage:)];
    self.headerView.domestictravelImageView.userInteractionEnabled = YES;
    [self.headerView.domestictravelImageView addGestureRecognizer:domesticTap];
    
    
    //周边游点击事件
    UITapGestureRecognizer *aroundTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoAroundListPage:)];
    self.headerView.aroundTravelImageView.userInteractionEnabled = YES;
    [self.headerView.aroundTravelImageView addGestureRecognizer:aroundTap];
    
    
    //港澳台
    UITapGestureRecognizer *HMTTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoHMTListPage:)];
    self.headerView.HMTTravelImageView.userInteractionEnabled = YES;
    [self.headerView.HMTTravelImageView addGestureRecognizer:HMTTap];
   
    //出境游
    UITapGestureRecognizer *exitTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoExitListPage:)];
    self.headerView.exitTravel.userInteractionEnabled = YES;
    [self.headerView.exitTravel addGestureRecognizer:exitTap];
    
    //境外参团
    UITapGestureRecognizer *exitTouristTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoExitTouristListPage:)];
    self.headerView.exitTouristGroup.userInteractionEnabled = YES;
    [self.headerView.exitTouristGroup addGestureRecognizer:exitTouristTap];
    
    [self.backScrollView addSubview:self.headerView];
    
    
    //添加产品模块视图
    
    if (UISCREEN_HEIGHT == 568) {
    self.middleView = [[TravelMiddleView alloc]initWithFrame:CGRectMake( 0, CGRectGetMaxY(self.headerView.frame) + 10, UISCREEN_WIDTH, kTravelRecommendHeight5)];
    } else {
    self.middleView = [[TravelMiddleView alloc]initWithFrame:CGRectMake( 0, CGRectGetMaxY(self.headerView.frame) + 10, UISCREEN_WIDTH, kTravelRecommendHeight)];
    }

    //微旅推荐跳转
    UITapGestureRecognizer *giftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoWeiLvRecommend:)];
    UITapGestureRecognizer *giftTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoWeiLvRecommend:)];
    UITapGestureRecognizer *giftTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoWeiLvRecommend:)];
    [self.middleView.firstImageView addGestureRecognizer:giftTap];
    [self.middleView.firstLabel addGestureRecognizer:giftTap2];
    [self.middleView.firstLittleLabel addGestureRecognizer:giftTap3];
    
    //温泉滑雪跳转
    UITapGestureRecognizer *springTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoSpringAndSkilling:)];
    UITapGestureRecognizer *springTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoSpringAndSkilling:)];
    UITapGestureRecognizer *springTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoSpringAndSkilling:)];
    
    [self.middleView.secondLittleLabel addGestureRecognizer:springTap2];
    [self.middleView.secondImageView addGestureRecognizer:springTap3];
    [self.middleView.secondlabel addGestureRecognizer:springTap];
    
    //海岛假日
    UITapGestureRecognizer *isLandTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoisLandListPage:)];
    UITapGestureRecognizer *isLandTap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoisLandListPage:)];
    UITapGestureRecognizer *isLandTap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoisLandListPage:)];
    
    [self.middleView.thirdImageView addGestureRecognizer:isLandTap];
    [self.middleView.thirdLabel addGestureRecognizer:isLandTap2];
    [self.middleView.thirdLittleLabel addGestureRecognizer:isLandTap3];
    
    [self.backScrollView addSubview:self.middleView];
    
#pragma mark -----------------精品路线------------------------------

    self.bTTViewController = [[BoutiqueTableViewController alloc]initWithStyle:(UITableViewStylePlain)];
    self.bTTViewController.view.frame = CGRectMake( 0, CGRectGetMaxY(self.middleView.frame) + 10, UISCREEN_WIDTH, 1540);
    self.bTTViewController.tableView.scrollEnabled = NO;
    
    
    [self.backScrollView addSubview:self.bTTViewController.view];
    
}

//跳转到周边游
- (void)gotoAroundListPage:(UITapGestureRecognizer *)tap {
    
    

    GuoneiViewController *guoneiVC = [[GuoneiViewController alloc]init];
    guoneiVC.rote_ID = -11;
    guoneiVC.cityTitle = @"周边游";
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:@"-11" forKey:@"rote_ID"];
   [self.navigationController pushViewController:guoneiVC animated:YES];
}

//跳转国内游页面
- (void)gotoDomesticListPage:(UITapGestureRecognizer *)tap {
    GuoneiViewController *guoneiVC = [[GuoneiViewController alloc]init];
    guoneiVC.rote_ID = -12;
    guoneiVC.cityTitle = @"国内游";
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:@"-12" forKey:@"rote_ID"];
    [self.navigationController pushViewController:guoneiVC animated:YES];
}

//跳转港澳台
- (void)gotoHMTListPage:(UITapGestureRecognizer *)tap {
    GuoneiViewController *guoneiVC = [[GuoneiViewController alloc]init];
    guoneiVC.rote_ID = -14;
    guoneiVC.cityTitle = @"港澳台";
    [self.navigationController pushViewController:guoneiVC animated:YES];
}

//出境游
- (void)gotoExitListPage:(UITapGestureRecognizer *)tap {
    GuoneiViewController *guoneiVC = [[GuoneiViewController alloc]init];
    guoneiVC.rote_ID = -13;
    guoneiVC.cityTitle = @"出境游";
    [self.navigationController pushViewController:guoneiVC animated:YES];
    
}
//境外参团列表
- (void)gotoExitTouristListPage:(UITapGestureRecognizer *)tap {
    GuoneiViewController *guoneiVC = [[GuoneiViewController alloc]init];
    guoneiVC.rote_ID = -15;
    guoneiVC.cityTitle = @"境外参团";
    [self.navigationController pushViewController:guoneiVC animated:YES];
}

//微旅推荐项目
- (void)gotoWeiLvRecommend:(UITapGestureRecognizer *)recommendTap {
    GuoneiViewController *guoneiVC = [[GuoneiViewController alloc]init];
    guoneiVC.rote_ID = -11;
    guoneiVC.cityTitle = @"微旅推荐";
    [self.navigationController pushViewController:guoneiVC animated:YES];
}

//温泉滑雪项目
- (void)gotoSpringAndSkilling:(UITapGestureRecognizer *)skillTap {
    NSLog(@"温泉滑雪");
    GuoneiViewController *guoneiVC = [[GuoneiViewController alloc]init];
    guoneiVC.rote_ID = -11;
    guoneiVC.cityTitle = @"踏青登山";
    guoneiVC.titles = @"踏青-登山";
    [self.navigationController pushViewController:guoneiVC animated:YES];
}

//海岛假日项目
- (void)gotoisLandListPage:(UITapGestureRecognizer *)isLandTap {
    GuoneiViewController *guoneiVC = [[GuoneiViewController alloc]init];
    guoneiVC.rote_ID = -11;
    guoneiVC.cityTitle = @"海岛假期";
    guoneiVC.category_id = 60;
    
    [self.navigationController pushViewController:guoneiVC animated:YES];
}

#pragma mark ---- 请求数据 ----
- (void)getHomePageDataFromUrl {
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = [NSDictionary dictionary];
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        parameters = @{@"assistant_id":[[LXUserTool sharedUserTool]getUid]};
    } else {
        parameters = nil;
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",LYHomePageURL,_city_id];
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *firstDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        //DLog(@"%@",firstDic);
        if ([firstDic[@"status"] integerValue]==1) {
            NSDictionary *dataDic = firstDic[@"data"];
            
            NSArray *adsArray = dataDic[@"index_ads"];
            for (NSDictionary *adsDic in adsArray) {
                TravelHomePageCycleImageModel *imageModel = [[TravelHomePageCycleImageModel alloc]init];
                [imageModel setValuesForKeysWithDictionary:adsDic];
                [self.cycleImageArray addObject:imageModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.headerView.travelCycleScrollView.delegate = self;
                [self configureCycleImage];
                [self layoutPageControl];
                
            });
  
        }else{
            return;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[LXAlterView sharedMyTools]createTishi:@"网络请求失败，请重试"];
        
    }];

}

#pragma mark 关于轮播图
//配置轮播图
- (void)configureCycleImage {
    
    for (int i = 0; i < self.cycleImageArray.count; i++) {
        TravelHomePageCycleImageModel *model = self.cycleImageArray[i];
        NSString *imageURL = [NSString stringWithFormat:@"%@%@",WLHTTP,model.src];
        [self.imageAllUrlArr addObject:imageURL];
    }
    if (UISCREEN_HEIGHT < 667) {
    self.headerView.travelCycleScrollView.contentSize = CGSizeMake(UISCREEN_WIDTH*(self.imageAllUrlArr.count+2), 160);
    } else {
    self.headerView.travelCycleScrollView.contentSize = CGSizeMake(UISCREEN_WIDTH*(self.imageAllUrlArr.count+2), cycleImageHeight);
    }
    
    self.headerView.travelCycleScrollView.contentOffset = CGPointMake(UISCREEN_WIDTH, 0);
    self.headerView.travelCycleScrollView.bounces = NO;
    self.headerView.travelCycleScrollView.pagingEnabled = YES;
    self.headerView.travelCycleScrollView.showsHorizontalScrollIndicator = NO;
    
    
    //添加最前面图片
    self.frontImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, cycleImageHeight)];
    
    [self.frontImageView sd_setImageWithURL:[self.imageAllUrlArr lastObject] placeholderImage:[UIImage imageNamed:@"默认图4"]];
    self.frontImageView.tag = self.indexNumber;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(EScrollerViewDidClicked:)];
    [self.frontImageView addGestureRecognizer:tap1];
    //    self.frontImageView.backgroundColor = [UIColor redColor];
    [self.headerView.travelCycleScrollView addSubview:self.frontImageView];
    
    //添加轮播图图片
    for (int i = 0; i < self.imageAllUrlArr.count; i++) {
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH*(i+1), 0, UISCREEN_WIDTH, cycleImageHeight)];
        [headImageView sd_setImageWithURL:self.imageAllUrlArr[i] placeholderImage:[UIImage imageNamed:@"默认图4"]];
        headImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(EScrollerViewDidClicked:)];
        headImageView.tag = i;
        [headImageView addGestureRecognizer:tap];
        
        [self.headerView.travelCycleScrollView addSubview:headImageView];
    }
    
    //添加最后面图片
    self.lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.imageAllUrlArr.count+1) * UISCREEN_WIDTH, 0, UISCREEN_WIDTH, cycleImageHeight)];

    [self.lastImageView sd_setImageWithURL:[self.imageAllUrlArr firstObject] placeholderImage:[UIImage imageNamed:@"默认图4"]];
    
    self.lastImageView.tag = self.indexNumber+1;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(EScrollerViewDidClicked:)];
    [self.lastImageView addGestureRecognizer:tap2];
    
    [self.headerView.travelCycleScrollView addSubview:self.lastImageView];
    
    //设置时钟动画定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(imageUpdate:) userInfo:nil repeats:YES];
}

#pragma mark ------------------轮播图跳转-------------------------
-(void)EScrollerViewDidClicked:(UITapGestureRecognizer *)tap
{
    
    UIImageView * tapImageView = (UIImageView *)tap.view;
    
//    DLog(@"%ld",tapImageView.tag);
    
    if (_cycleImageArray.count >0)
    {
#pragma mark ---------------获取点击的哪一张图片--------------------
        TravelHomePageCycleImageModel *model=[_cycleImageArray objectAtIndex:tapImageView.tag];
        NSDictionary *dic = model.gotoDic;//[LXTools dictionaryWithJsonString:model.gotoDic];
//        DLog(@"\ntravel_banner_ad === %@",dic);
        
        if ([[dic objectForKey:@"type"] isEqualToString:@"list"])
        {
            //跳转列表页
            if([self judgeString:[model.gotoDic objectForKey:@"keyword"]] == YES)
            {
                GuoneiViewController *screenVC = [[GuoneiViewController alloc]init];
                screenVC.lastViewControllerTag = @"300";
                screenVC.search_type = @"2";
                screenVC.productListTitle = [model.gotoDic objectForKey:@"keyword"];
                screenVC.cityTitle = @"旅游产品";
                screenVC.rote_ID = -11;
                [self.navigationController pushViewController:screenVC animated:YES];
            }
            else
            {
                GuoneiViewController *trave = [[GuoneiViewController alloc]init];
//                trave.traveType = [dic objectForKey:@"cate"];
                trave.traveType = [dic objectForKey:@"tour_cate"];
                trave.cityTitle = model.title;
                
                if ([self judgeString:[dic objectForKey:@"d_city"]])
                {
                    trave.t_city = [[[dic objectForKey:@"d_city"] componentsSeparatedByString:@"-"] objectAtIndex:0];
                }
                else if ([self judgeString:[dic objectForKey:@"d_province"]])
                {
                    trave.t_province = [[[dic objectForKey:@"d_province"] componentsSeparatedByString:@"-"] objectAtIndex:0];
                }
                else if ([self judgeString:[dic objectForKey:@"d_country"]])
                {
                    trave.t_country = [[[dic objectForKey:@"d_country"] componentsSeparatedByString:@"-"] objectAtIndex:0];
                }
                trave.rote_ID = -11;
                trave.lastViewControllerTag = @"首页轮播图";
                [self.navigationController pushViewController:trave animated:YES];
            }
            
        }
        else if([[dic objectForKey:@"type"] isEqualToString:@"detail"])
        {
            //跳转详情页
//            YXDetailTraveViewController *yxDetailVc=[[YXDetailTraveViewController alloc] init];
//            yxDetailVc.productId=[dic objectForKey:@"product_id"];
//            [self.navigationController pushViewController:yxDetailVc animated:YES];
            ProductDetailViewController *detailVC = [[ProductDetailViewController alloc]init];
            detailVC.productID = [dic objectForKey:@"product_id"];
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        else if ([[dic objectForKey:@"type"] isEqualToString:@"page"])
        {
            if ([[dic objectForKey:@"link"] hasPrefix:@"https://"] || [[dic objectForKey:@"link"] hasPrefix:@"http://"])
            {
                NSString *url=[model.link stringByReplacingOccurrencesOfString:@"android" withString:@"ios"];
//                DLog(@"点击了-%@",url);
                LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
                specialVc.loadUrl=url;
                specialVc.title=model.title;
                [self.navigationController pushViewController:specialVc animated:YES];
            }
            else
            {
                DLog(@"没有连接");
            }
            
        }
    }
}



//设置光标
- (void)layoutPageControl {
    if (UISCREEN_HEIGHT < 667) {
    self.control = [[UIPageControl alloc]initWithFrame:CGRectMake(0, cycleImageHeight - 20 , UISCREEN_WIDTH, 20)];
    } else {
    self.control = [[UIPageControl alloc]initWithFrame:CGRectMake(0, cycleImageHeight - 20 , UISCREEN_WIDTH, 20)];
    }
    
    self.control.numberOfPages = self.imageAllUrlArr.count;
    [self.control addTarget:self action:@selector(pageHandle:) forControlEvents:UIControlEventValueChanged];
//    self.control.currentPageIndicatorTintColor = [UIColor blackColor];
    [self.backScrollView addSubview:self.control];
}

//定时器方法实现
- (void)imageUpdate:(NSTimer *)timer {
    CGPoint point = self.headerView.travelCycleScrollView.contentOffset;
    point.x += UISCREEN_WIDTH;
    [self.headerView.travelCycleScrollView setContentOffset:point animated:YES];
}

//让scrollView跟着page页数改变而改变
- (void)pageHandle:(UIPageControl *)page {
    self.headerView.travelCycleScrollView.contentOffset = CGPointMake((self.control.currentPage + 1) * UISCREEN_WIDTH, 0);
}

//定时器打开
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(imageUpdate:) userInfo:nil repeats:YES];
    
}

//停止滚动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}

//计算偏移量并滚动视图
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.headerView.travelCycleScrollView) {
        
        CGPoint point = scrollView.contentOffset;
        
        if (point.x == scrollView.contentSize.width - UISCREEN_WIDTH) {
            scrollView.contentOffset = CGPointMake(UISCREEN_WIDTH, 0);
        }else if(point.x == 0){
            scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - 2 *UISCREEN_WIDTH,0);
        }
    }
    CGFloat x = self.headerView.travelCycleScrollView.contentOffset.x;
    
    self.control.currentPage = (x / [UIScreen mainScreen].bounds.size.width) - 1;
}

#pragma mark 关于精品线路
- (void) passDataArray {
    
    self.bTTViewController.lineDataArray = [NSMutableArray array];
    [self.bTTViewController.lineDataArray arrayByAddingObjectsFromArray:self.jpProductsArray];
    [self.bTTViewController.tableView reloadData];
    
}






@end
