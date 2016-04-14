//
//  MainViewController.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "MainViewController.h"
#import "ShipViewController.h"
#import "VisaViewController.h"
#import "PriteOnlineViewController.h"
#import "HouseKeeperViewController.h"
#import "SurroundViewController.h"
#import "SpringViewController.h"
#import "TravelViewController.h"
#import "SearchResultViewController.h"
#import "YXHouseDetailViewController.h"
#import "LXGetCityIDTool.h"
#import "TraveSearchViewController.h"
#import "ZFJShipViewController.h"
#import "CSHomeViewController.h"
#import "LXAdvertModel.h"
#import "LXSpecialViewController.h"
#import "QRViewController.h"
#import "ZFJQRResultVC.h"
#import "ZFJChooseCityVC.h"
#import <AVFoundation/AVFoundation.h>
#import "ZFJTicketHomeVC.h"
#import "LXStudyTourViewController.h"
#import "JYCSelfDriveEatViewController.h"
#import "SearchHotelViewController.h"
#import "ProductDetailViewController.h"
#import "GuoneiViewController.h"
#import "TravelScreenViewController.h"

#import "MainIconAndTitleVIew.h"
#import "MainIconAndTitleVIews.h"
#import "SenicCellView.h"
#import "DestinationCellVIew.h"
#import "VerticalScrollView.h"
#import "AroundScenicLiscViewController.h"
#import "ChoiceDestinaViewController.h"
#import "weilvAnnounceModel.h"
#import "WeilvAnnounceDetailViewController.h"

#import "DestiationModel.h"
#import "aroundSceincmodel.h"



#import "LXTraveModel.h"
#import "YXDetailTraveViewController.h"
#import "LXTraveCellTableViewCell.h"
#import "LXTraveListViewController.h"

#import "ZFJVisaTableViewCell.h"
#import "ZFJVisaModel.h"
#import "ZFJVisaDetailVC.h"
#import "ZFJVIsaListVC.h"

#import "ZFJShipTableViewCell.h"
#import "ZFJShipListModel.h"
#import "ShipListModel.h"
#import "ZFJShipDetailVC.h"
#import "ZFJShipListVC.h"

#import "ZFJTicketListCell.h"
#import "ZFJTicketDetailVC.h"
#import "TicketListModel.h"
#import "ZFJTicketListVC.h"

#import "LXSTListModel.h"
#import "LXSTListCell.h"
//#import "LXSTModel.h"
#import "LXSTDetailViewController.h"
#import "LXSTListViewController.h"

#import "OpenShopViewController.h"
#import "ShopsManagementViewController.h"
#import "DestinationJTGViewController.h"



#define space   4
#define HotBtnWith (windowContentWidth -15*2-10*2)/3
#define M_TEXT_FONT 19

#define selectedColor kColor(255, 150, 0)
#define unselectedColor kColor(115, 115, 120)
#define selectedFont [UIFont systemFontOfSize:20]
#define unselectedFont [UIFont systemFontOfSize:17]


@interface MainViewController ()<VerticalScrollViewDelegate>
{
    YXBannerView *_headerView;
    NSMutableArray *_webSiteArr;
    NavSearchView *searchView;
    UIImageView *headerView;
    NSMutableArray *_adArray;
    float BannerHegit;
    
    
    UIView *chooesLinePage;
    UIScrollView * sortSCrollVIew;
    UIView *senicView;//周边景点
    UIImageView *houseKeeperIGV;//微旅广告
    UIView *destinationView;//精选旅行目的地
    UITableView *_tableView;//产品列表
    
    NSMutableArray *tableBtnArr;//tableView的标题数组
    UILabel *slidLine; //tableView的标题下滑线
    NSString *titleString;
    NSMutableArray *_titleArray;//微旅公告
    int count;
}

@property (nonatomic, strong) NSMutableArray *productListArr;
@property (nonatomic, strong) NSMutableArray *tableTitleArr;
@property (nonatomic, strong) NSMutableArray *tableArr;
@property (nonatomic, strong) NSMutableArray *choiceDestListArr;
@property (nonatomic, strong) NSMutableArray *aroundSenicListArr;



@property (nonatomic, strong) UIImageView * qrIcon;
@property (nonatomic, strong) UIButton *qrBut;
@property (nonatomic, strong) UILabel * cityLabel;
@property (nonatomic, strong) locationView * locationView;
@property (nonatomic, assign) BOOL isNeedLocation;
@end

@implementation MainViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:YES];
    [MobClick beginLogPageView:@"PageOne"];
    
    
    
    if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
    {
        //下拉刷新初始化
        //开始刷新
        count++;
        if (count==1)
        {
            NSString *assistant_id=@"";
            if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
                assistant_id=@"0";
            }
            else
            {
                assistant_id=[[LXUserTool alloc] getKeeper];
            }
            
            NSDictionary *paramers = @{@"city_id":[[NSUserDefaults standardUserDefaults] objectForKey:@"useCityID"],@"assistant_id":assistant_id};
            
            
            [self sendHomeContentUrl:newHomeURL WithParmers:paramers aTag:1];
        }
       
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
     self.navigationController.navigationBar.hidden = NO;
    [super viewWillDisappear:YES];
    //统计时长
    [MobClick endLogPageView:@"PageOne"];
    
    if([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward)
    {
        count=1;
    }
    else
    {
        count=0;
    }
}
- (void)viewDidLoad
{
    count=0;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [super viewDidLoad];
    BannerHegit = 220;
    if (iPhone4S)
    {
        BannerHegit = 180;
    }
    else if (iPhone5)
    {
        BannerHegit = 200;
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -20, windowContentWidth, windowContentHeight-49+20)];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = BgViewColor;
    [self.view addSubview:_scrollView];
    
    self.isNeedLocation = YES;
    
    //导航初始化
    [self initNav];
    
    //下拉刷新初始化
    [self refreshData];
    
    //轮播图初始化
    [self initScrollView];
    
    //分类和微旅广告初始化
//    [self initSecondView];
    
    //周边景点
    [self initSenic];
    
    //微旅管家广告初始化
    [self initHouserKeeperView];
    
    //精选旅行目的地初始化
    [self initDestinationView];
}

#pragma mark  生成navigation
- (void)initNav
{
    //创建头部区域视图
    headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 60)];
    [self.view addSubview:headerView];
    headerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    headerView.userInteractionEnabled = YES;
    
    //地理定位，获取当前设备所在城市
    [self judgeReturnString:self.locationView.city.text withReplaceString:@"郑州"];
    [[NSUserDefaults standardUserDefaults] setObject:@"149" forKey:@"useCityID"];
    [[NSUserDefaults standardUserDefaults] setObject:@"郑州" forKey:@"useCityName"];
    
    //创建当前所属区域视图
    self.locationView = [[locationView alloc] initWithFrame:CGRectMake(10, 15, 60, 44)];
    __weak typeof(self) weakSelf = self;
    self.locationView.block = ^(NSString * cityStr)
    {
        [[LXGetCityIDTool sharedMyTools] return_city_id_name:^(NSString *city_id, NSString *city_name)
        {
            weakSelf.locationView.city.text = city_name;
            [[NSUserDefaults standardUserDefaults] setObject:city_id forKey:@"LocationCityID"];
            [[NSUserDefaults standardUserDefaults] setObject:city_name forKey:@"LocationCityName"];
            [[NSUserDefaults standardUserDefaults] setObject:city_id forKey:@"useCityID"];
            [[NSUserDefaults standardUserDefaults] setObject:city_name forKey:@"useCityName"];
            
            [YXLocationManage shareManager].city=weakSelf.locationView.city.text;
            
            //开始刷新
            NSString *assistant_id=@"";
            if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
                assistant_id=@"0";
            }
            else
            {
                assistant_id=[[LXUserTool alloc] getKeeper];
            }

            NSDictionary *paramers = @{@"city_id":city_id,@"assistant_id":assistant_id};
            
            //根据当前城市ID，获取当前城市的广告
            [weakSelf sendRequestaUrl:AdvertUrl(@"75", city_id) aTag:1];
            
            //获取微旅公告数据
            [weakSelf sendRequestaUrl:WeiLvAnnounce aTag:2];
            
            //获取【首页】相关模块 数据
            [weakSelf sendHomeContentUrl:newHomeURL WithParmers:paramers aTag:1];
        }];

    };
    [_locationView.but addTarget:self action:@selector(chooseCityVC:) forControlEvents:UIControlEventTouchUpInside];
   
    NSMutableAttributedString *stringg = [[NSMutableAttributedString alloc] initWithString:@"景区/地区/关键字"];
    [stringg addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,[stringg length])];
    searchView = [[NavSearchView alloc] initWithFrame:CGRectMake(ViewWidth(_locationView)+ViewX(_locationView)+5, 24-1.5, windowContentWidth-125, 25+3) Feature:@"景区/地区/关键字"];
 
    searchView.searchBar.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    searchView.layer.borderColor = [UIColor whiteColor].CGColor;
    searchView.layer.borderWidth = 0.5;
    searchView.layer.cornerRadius = 5.0;
    [searchView.cancalBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchView.delegate = self;
    
    
    self.qrIcon = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, 26-0.5, 21+0.5, 20+0.5)];
    self.qrIcon.image = [UIImage imageNamed:@"扫一扫"];
    self.qrIcon.userInteractionEnabled = YES;
    
    
    self.qrBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _qrBut.frame = CGRectMake(windowContentWidth - 40, 0, 40, 60);
    [_qrBut addTarget:self action:@selector(openQR:) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:self.qrIcon];
    [headerView addSubview:_qrBut];
    [headerView addSubview:_locationView];
    [headerView addSubview:searchView];
    
}
#pragma mark ------ 跳转选择城市页面
- (void)chooseCityVC:(UIButton *)button
{
    ZFJChooseCityVC * chooseCityVC = [[ZFJChooseCityVC alloc] initWithAddress:^(NSString *cityAddress)
    {
        self.locationView.city.text = cityAddress;
        [self refreshData];
        
    }];
    chooseCityVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:chooseCityVC animated:YES completion:NULL];
}

#pragma mark ------扫描二维码页面
- (void)openQR:(UIButton *)button
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设置-隐私-相机中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        DLog(@"相机权限受限");
        return;
        
    }
    else
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
            [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
        {
            [self showQRViewController];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头或摄像头不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }


}

#pragma mark - 验证当前设备相机是否可用
- (BOOL)validateCamera
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

#pragma mark - 显示二维码扫描
- (void)showQRViewController
{
    __weak MainViewController * mianVC = self;
    QRViewController *qrVC = [[QRViewController alloc] initWithQRURL:^(NSString *url) {
        ZFJQRResultVC * resultVC = [[ZFJQRResultVC alloc] initWithURLString:url];
        [mianVC.navigationController pushViewController:resultVC animated:YES];
    }];
    //模态
    qrVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:qrVC animated:YES completion:nil];
}

#pragma mark 下拉刷新
- (void)refreshData
{
    __weak typeof(self) weakSelf = self;
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int a=0; a<2; a++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", a+2]];
        [imageAray addObject:image];
    }
    
    //-----------下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [_scrollView addGifHeaderWithRefreshingBlock:^{
        //模仿2秒后刷新成功
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (weakSelf.isNeedLocation)
            {
                [[LXGetCityIDTool sharedMyTools] return_city_id_name:^(NSString *city_id, NSString *city_name)
                {
                    weakSelf.locationView.city.text = city_name;
                    [[NSUserDefaults standardUserDefaults] setObject:city_id forKey:@"LocationCityID"];
                    [[NSUserDefaults standardUserDefaults] setObject:city_name forKey:@"LocationCityName"];
                    [[NSUserDefaults standardUserDefaults] setObject:city_id forKey:@"useCityID"];
                    [[NSUserDefaults standardUserDefaults] setObject:city_name forKey:@"useCityName"];
                    
                    DLog(@"当前区域所在城市：%@,城市代码：%@",weakSelf.locationView.city.text,city_id);
                    [YXLocationManage shareManager].city=weakSelf.locationView.city.text;
                    
                    //开始刷新
                    NSString *assistant_id=@"";
                    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
                        assistant_id=@"0";
                    }
                    else
                    {
                        assistant_id=[[LXUserTool alloc] getKeeper];
                    }
   
                    NSDictionary *paramers = @{@"city_id":city_id,@"assistant_id":assistant_id};
                    [weakSelf sendRequestaUrl:AdvertUrl(@"75", city_id) aTag:1];
                    [weakSelf sendRequestaUrl:WeiLvAnnounce aTag:2];
                    [weakSelf sendHomeContentUrl:newHomeURL WithParmers:paramers aTag:1];
                    //结束刷新
                    [weakSelf.scrollView.header endRefreshing];
                    weakSelf.isNeedLocation = NO;
                }];

            }
            else
            {
                NSString *assistant_id=@"";
                if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
                    assistant_id=@"0";
                }
                else
                {
                    assistant_id=[[LXUserTool alloc] getKeeper];
                }
                
                
                [weakSelf sendRequestaUrl:AdvertUrl(@"75", [[WLSingletonClass defaultWLSingleton] wlCityId]) aTag:1];
                [weakSelf sendRequestaUrl:WeiLvAnnounce aTag:2];
                NSDictionary *paramers = @{@"city_id":[[WLSingletonClass defaultWLSingleton] wlCityId],@"assistant_id":assistant_id};
                [weakSelf sendHomeContentUrl:newHomeURL WithParmers:paramers aTag:1];
                weakSelf.locationView.city.text = [[WLSingletonClass defaultWLSingleton] wlCityName];
                //结束刷新
                [weakSelf.scrollView.header endRefreshing];
            }

        });
        
    }];
    
    // 设置普通状态的动画图片
    [_scrollView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [_scrollView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [_scrollView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
    
    // 即将刷新 和 正在刷新 用的是一样的动画图片,马上进入刷新状态
    [_scrollView.gifHeader beginRefreshing];
    
}

#pragma mark 请求首页广告和微旅公告
-(void)sendRequestaUrl:(NSString *)url aTag:(NSUInteger)tag
{
    __weak MainViewController * weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
    {
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
         if(tag == 1)
         {
             _adArray=[NSMutableArray array];
             [_adArray removeAllObjects];
             NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             if (array != nil)
             {
                 for (int i=0; i<array.count; i++)
                 {
                     LXAdvertModel *detailModel = [[LXAdvertModel alloc] init];
                     NSDictionary *dic=[array objectAtIndex:i];
                     [detailModel setValuesForKeysWithDictionary:dic];
                     [_adArray addObject:detailModel];
                 }
                 [self initScrollView];
             }
         }
         else if (tag == 2)
         {
             NSString *html = operation.responseString;
             NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
             if (data!=nil)
             {
                 NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                 if ([dict isKindOfClass:[NSDictionary class]] &&[[dict objectForKey:@"state"] integerValue] == 1 && [dict objectForKey:@"data"] && [dict objectForKey:@"data"]!= nil && [[dict objectForKey:@"data"] isKindOfClass:[NSArray class]] && [[dict objectForKey:@"data"] count]>0)
                 {
                     NSArray *array = [dict objectForKey:@"data"];
                     _titleArray = [[NSMutableArray alloc] init];
                     [_titleArray removeAllObjects];
                     for (int i=0; i<array.count; i++)
                     {
                         weilvAnnounceModel *detailModel = [[weilvAnnounceModel alloc] init];
                         NSDictionary *dic=[array objectAtIndex:i];
                         [detailModel setValuesForKeysWithDictionary:dic];
                         [_titleArray addObject:detailModel];
                     }
//                     [self initSecondView];
                     
                 }
             }
             
         }
         [weakSelf.scrollView.header endRefreshing];
         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
         [weakSelf.scrollView.header endRefreshing];
     }];
  
}

//滑动轮播图
- (void)initScrollView

{
    NSMutableArray *arr = [NSMutableArray  array];
    for (int i=0; i<_adArray.count; i++)
    {
        LXAdvertModel *model=[_adArray objectAtIndex:i];
        NSString *imageUrl=[NSString stringWithFormat:@"%@%@",WLHTTP,model.src];
        [arr addObject:imageUrl];
    }
    
    NSArray *temp = [[NSUserDefaults standardUserDefaults] objectForKey:ImageLink];
    
    //获取的数据不为空，并且与上次获取的不一样的情况下将链接存到本地（如果为空则直接读取本地；如果不为空并且有新的变动，则将新的url地址存到本地）
    if (![temp isEqualToArray:arr] && arr.count > 0)
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:ImageLink];
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:ImageLink];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (_headerView != nil)
    {
        [_headerView removeFromSuperview];

    }
    
    _headerView = [[YXBannerView alloc] initWithFrameRect:CGRectMake(0, 0,windowContentWidth, BannerHegit) ImageArray:arr ];
    _headerView.delegate = self;
    [_scrollView addSubview:_headerView];
}

#pragma mark 分类列表和微旅广告
- (void)initSecondView1
{
    
    NSMutableArray * lineArray = [NSMutableArray arrayWithObjects:@"旅游度假",@"门票",@"邮轮",@"游学",@"签证", nil];
    NSInteger pageCount = lineArray.count / 5 < lineArray.count / 5.0 ?lineArray.count / 5 + 1 :lineArray.count / 5;
    
    if(sortSCrollVIew != nil){
        [sortSCrollVIew removeFromSuperview];
    }
    sortSCrollVIew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BannerHegit, windowContentWidth , 125)];
    sortSCrollVIew.contentSize = CGSizeMake(windowContentWidth * (lineArray.count / 5 < lineArray.count / 5.0 ? lineArray.count / 5 + 1 :lineArray.count / 5 ), 125);
    sortSCrollVIew.delegate = self;
    sortSCrollVIew.pagingEnabled = YES;
    sortSCrollVIew.backgroundColor = [UIColor grayColor];
    sortSCrollVIew.showsHorizontalScrollIndicator = NO;
    sortSCrollVIew.tag = 222;
    
    NSMutableArray * nameArr = [NSMutableArray array];
    NSMutableArray * iconImageArr = [NSMutableArray array];
    for (int i = 0; i < pageCount; i++)
    {
        [nameArr addObject:[NSMutableArray array]];
        [iconImageArr addObject:[NSMutableArray array]];
    }
    
    for (int i = 0; i < lineArray.count; i++)
    {
        [[nameArr objectAtIndex:i / 5] addObject:[lineArray objectAtIndex:i]];
        [[iconImageArr objectAtIndex:i / 5] addObject:[[lineArray objectAtIndex:i] stringByAppendingString:@"首页_"]];
    }
    
    
    for (int i = 0; i < nameArr.count; i++) {
        MainIconAndTitleVIews * iconAndTitile = [[MainIconAndTitleVIews alloc] initWithFrame:CGRectMake(windowContentWidth * i, 15, windowContentWidth, 220) MainTitleArray:[nameArr objectAtIndex:i] ImageURLArray:[iconImageArr objectAtIndex:i]];
        
        iconAndTitile.tapBut = ^(NSIndexPath * indexPath)
        {
            [self clickSortBtn:indexPath.row];
        };
        
        
        [sortSCrollVIew addSubview:iconAndTitile];
    }
    
    [_scrollView addSubview:sortSCrollVIew];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(sortSCrollVIew)-1, windowContentWidth*pageCount, 1)];
    line.backgroundColor = bordColor;
    [sortSCrollVIew addSubview:line];
    
    
    UIView *AdView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(sortSCrollVIew)+ViewHeight(sortSCrollVIew), windowContentWidth, 40)];
    AdView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:AdView];
    
    
    
    
    
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2.5, 38.5, 35)];
    NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"鸟的煽动动画0001.png"],
                         [UIImage imageNamed:@"鸟的煽动动画0002.png"],
                         [UIImage imageNamed:@"鸟的煽动动画0003"],
                         [UIImage imageNamed:@"鸟的煽动动画0004"],
                         [UIImage imageNamed:@"鸟的煽动动画0005"],
                         [UIImage imageNamed:@"鸟的煽动动画0006"],
                         [UIImage imageNamed:@"鸟的煽动动画0007"],
                         [UIImage imageNamed:@"鸟的煽动动画0008"],
                         [UIImage imageNamed:@"鸟的煽动动画0009"],
                         [UIImage imageNamed:@"鸟的煽动动画0010"],
                         [UIImage imageNamed:@"鸟的煽动动画0011"],nil];
    gifImageView.animationImages = gifArray; //动画图片数组
    gifImageView.animationDuration = 0.7; //执行一次完整动画所需的时长
    gifImageView.animationRepeatCount = 0;  //动画重复次数
    [gifImageView startAnimating];
    [AdView addSubview:gifImageView];
    
    UIImageView * gongGaoIGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(gifImageView) + ViewWidth(gifImageView),40/2-25/2, 57.5, 25)];
    gongGaoIGV.image = [UIImage imageNamed:@"微旅公告"];
    [AdView addSubview:gongGaoIGV];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(ViewX(gongGaoIGV) + ViewWidth(gongGaoIGV)+5, 7.5 , 1, ViewHeight(AdView) -7.5*2)];
    line2.backgroundColor = bordColor;
    line2.alpha = 0.8;
    [AdView addSubview:line2];
    
    UIImageView * volumeIGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(line2) + ViewWidth(line2) +5,40/2-12/2, 13.2, 12)];
    volumeIGV.image = [UIImage imageNamed:@"volume-首页"];
    [AdView addSubview:volumeIGV];
    
    
    if(_titleArray && _titleArray.count>0){
        NSMutableArray *arr = [NSMutableArray array];
        for (int i =0; i < _titleArray.count; i++) {
            weilvAnnounceModel *model = [_titleArray objectAtIndex:i];
            [arr addObject:model.title];
        }
        VerticalScrollView *vscrolllView = [[VerticalScrollView alloc] initWithFrame:CGRectMake(ViewX(volumeIGV) + ViewWidth(volumeIGV), 0, ViewWidth(AdView)- ViewX(volumeIGV) - ViewWidth(volumeIGV), ViewHeight(AdView))];
        vscrolllView.backgroundColor = [UIColor grayColor];
        vscrolllView.titleArray = arr;
        vscrolllView.Verdelegate = self;
        [AdView addSubview:vscrolllView];
    }
    
    
}

/*
- (void)initSecondView
{
    NSMutableArray * lineArray = [NSMutableArray arrayWithObjects:@"旅游度假",@"目的地参团",@"邮轮",@"签证",@"游学",@"门票", nil];
    NSInteger pageCount = lineArray.count / 4 < lineArray.count / 4.0 ?lineArray.count / 4 + 1 :lineArray.count / 4;
    
    if(sortSCrollVIew != nil){
        [sortSCrollVIew removeFromSuperview];
    }
    sortSCrollVIew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BannerHegit, windowContentWidth , 125)];
    sortSCrollVIew.contentSize = CGSizeMake(windowContentWidth * (lineArray.count / 4 < lineArray.count / 4.0 ? lineArray.count / 4 + 1 :lineArray.count / 4 ), 125);
    sortSCrollVIew.delegate = self;
    sortSCrollVIew.pagingEnabled = YES;
    sortSCrollVIew.backgroundColor = [UIColor whiteColor];
    sortSCrollVIew.showsHorizontalScrollIndicator = NO;
    sortSCrollVIew.tag = 222;
    
    NSMutableArray * nameArr = [NSMutableArray array];
    NSMutableArray * iconImageArr = [NSMutableArray array];
    for (int i = 0; i < pageCount; i++) {
        [nameArr addObject:[NSMutableArray array]];
        [iconImageArr addObject:[NSMutableArray array]];
    }
    
    for (int i = 0; i < lineArray.count; i++) {
        [[nameArr objectAtIndex:i / 4] addObject:[lineArray objectAtIndex:i]];
        [[iconImageArr objectAtIndex:i / 4] addObject:[[lineArray objectAtIndex:i] stringByAppendingString:@"首页_"]];
    }
    
    
    for (int i = 0; i < nameArr.count; i++) {
        MainIconAndTitleVIew * iconAndTitile = [[MainIconAndTitleVIew alloc] initWithFrame:CGRectMake(windowContentWidth * i, 15, windowContentWidth, 220) MainTitleArray:[nameArr objectAtIndex:i] ImageURLArray:[iconImageArr objectAtIndex:i]];
        
        iconAndTitile.tapBut = ^(NSIndexPath * indexPath){
            //DLog(@"%ld", indexPath.row);
            [self clickSortBtn:indexPath.row];
        };
        
        
        [sortSCrollVIew addSubview:iconAndTitile];
    }
    
    [_scrollView addSubview:sortSCrollVIew];
    if (pageCount >= 2) {
        UIView * pageTagView = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth(sortSCrollVIew) / 2 - (20 * pageCount + (pageCount - 1) * 10) / 2,ViewY(sortSCrollVIew) + ViewHeight(sortSCrollVIew) - 10, 20 * pageCount + (pageCount - 1) * 10, 3)];
        for (int i = 0; i < pageCount; i++) {
            UIView * pageTag = [[UIView alloc] initWithFrame:CGRectMake(20  * i + 10 * i, 0, 20, 3)];
            pageTag.layer.cornerRadius = 1.5;
            pageTag.layer.masksToBounds = YES;
            pageTag.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            [pageTagView addSubview:pageTag];
        }
        chooesLinePage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 3)];
        chooesLinePage.backgroundColor = [UIColor orangeColor];
        chooesLinePage.layer.cornerRadius = 1.5;
        chooesLinePage.layer.masksToBounds = YES;
        [pageTagView addSubview:chooesLinePage];
        
        pageTagView.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:pageTagView];
    }
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(sortSCrollVIew)-1, windowContentWidth*pageCount, 1)];
    line.backgroundColor = bordColor;
    [sortSCrollVIew addSubview:line];
    
    UIView *AdView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(sortSCrollVIew)+ViewHeight(sortSCrollVIew), windowContentWidth, 40)];
    AdView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:AdView];
    
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2.5, 38.5, 35)];
    NSArray *gifArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"鸟的煽动动画0001.png"],
                         [UIImage imageNamed:@"鸟的煽动动画0002.png"],
                         [UIImage imageNamed:@"鸟的煽动动画0003"],
                         [UIImage imageNamed:@"鸟的煽动动画0004"],
                         [UIImage imageNamed:@"鸟的煽动动画0005"],
                         [UIImage imageNamed:@"鸟的煽动动画0006"],
                         [UIImage imageNamed:@"鸟的煽动动画0007"],
                         [UIImage imageNamed:@"鸟的煽动动画0008"],
                         [UIImage imageNamed:@"鸟的煽动动画0009"],
                         [UIImage imageNamed:@"鸟的煽动动画0010"],
                         [UIImage imageNamed:@"鸟的煽动动画0011"],nil];
    gifImageView.animationImages = gifArray; //动画图片数组
    gifImageView.animationDuration = 0.7; //执行一次完整动画所需的时长
    gifImageView.animationRepeatCount = 0;  //动画重复次数
    [gifImageView startAnimating];
    [AdView addSubview:gifImageView];
    
    UIImageView * gongGaoIGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(gifImageView) + ViewWidth(gifImageView),40/2-25/2, 57.5, 25)];
    gongGaoIGV.image = [UIImage imageNamed:@"微旅公告"];
    [AdView addSubview:gongGaoIGV];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(ViewX(gongGaoIGV) + ViewWidth(gongGaoIGV)+5, 7.5 , 1, ViewHeight(AdView) -7.5*2)];
    line2.backgroundColor = bordColor;
    line2.alpha = 0.8;
    [AdView addSubview:line2];
    
    UIImageView * volumeIGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(line2) + ViewWidth(line2) +5,40/2-12/2, 13.2, 12)];
    volumeIGV.image = [UIImage imageNamed:@"volume-首页"];
    [AdView addSubview:volumeIGV];
    
    
    if(_titleArray && _titleArray.count>0){
        NSMutableArray *arr = [NSMutableArray array];
        for (int i =0; i < _titleArray.count; i++) {
            weilvAnnounceModel *model = [_titleArray objectAtIndex:i];
            [arr addObject:model.title];
        }
        VerticalScrollView *vscrolllView = [[VerticalScrollView alloc] initWithFrame:CGRectMake(ViewX(volumeIGV) + ViewWidth(volumeIGV), 0, ViewWidth(AdView)- ViewX(volumeIGV) - ViewWidth(volumeIGV), ViewHeight(AdView))];
        vscrolllView.backgroundColor = [UIColor whiteColor];
        vscrolllView.titleArray = arr;
        vscrolllView.Verdelegate = self;
        [AdView addSubview:vscrolllView];
    }
    
    
}
 
 */
 
#pragma mark - 微旅平台几大模块 点击事件
-(void)clickSortBtn:(long)sender
{
    if (sender - 1000 == 0)
    {
        //旅游度假
        TravelViewController *travalVC = [[TravelViewController alloc] init];
        [self.navigationController pushViewController:travalVC animated:YES];
    }
    else if(sender - 1000 == 1)
    {
        //目的地参团
        DestinationJTGViewController *DestinationVC=[[DestinationJTGViewController alloc] init];
        [self.navigationController pushViewController:DestinationVC animated:YES];
    }
    else if(sender - 1000 == 2)
    {
        //邮轮

        ZFJShipViewController * shipVC = [[ZFJShipViewController alloc] init];
        [self.navigationController pushViewController:shipVC animated:YES];

      
        
       // CSHomeViewController *csHomeController = [[CSHomeViewController alloc] init];
       // [self.navigationController pushViewController:csHomeController animated:YES];


    }
    else if(sender - 1000 == 3)
    {
        //签证
        VisaViewController *visaVC = [[VisaViewController alloc] init];
        [self.navigationController pushViewController:visaVC animated:YES];
    }
    else if(sender - 1000 == 4)
    {
        //游学
        LXStudyTourViewController *studyTourVC = [[LXStudyTourViewController alloc] init];
        [self.navigationController pushViewController:studyTourVC animated:YES];
    }
    else if(sender - 1000 == 5)
    {
        //门票
        ZFJTicketHomeVC * ticketHomeVC = [[ZFJTicketHomeVC alloc] init];
        [self.navigationController pushViewController:ticketHomeVC animated:YES];
    }
    else if(sender - 1000 == 6)
    {
        //自驾吃
        JYCSelfDriveEatViewController *shopmaVC = [[JYCSelfDriveEatViewController alloc] init];
        [self.navigationController pushViewController:shopmaVC animated:YES];
        
    } else if (sender-1000==7){
        //酒店
        SearchHotelViewController *visaVC = [[SearchHotelViewController alloc] init];
        [self.navigationController pushViewController:visaVC animated:YES];
        
    }
    
}
-(void)clickSortBtn1:(long)sender
{
    if (sender - 1000 == 0)
    {
        //旅游度假
        TravelViewController *travalVC = [[TravelViewController alloc] init];
//        travalVC.pushType = isPush;
        [self.navigationController pushViewController:travalVC animated:YES];
    }
    else if(sender - 1000 == 1)
    {
        //门票
        ZFJTicketHomeVC * ticketHomeVC = [[ZFJTicketHomeVC alloc] init];
        [self.navigationController pushViewController:ticketHomeVC animated:YES];
    }
    else if(sender - 1000 == 2)
    {
        //邮轮
        ZFJShipViewController * shipVC = [[ZFJShipViewController alloc] init];
        [self.navigationController pushViewController:shipVC animated:YES];
    }
    else if(sender - 1000 == 3)
    {
        //游学
        LXStudyTourViewController *studyTourVC = [[LXStudyTourViewController alloc] init];
        [self.navigationController pushViewController:studyTourVC animated:YES];
    }
    else if(sender - 1000 == 4)
    {
        //签证
        VisaViewController *visaVC = [[VisaViewController alloc] init];
        [self.navigationController pushViewController:visaVC animated:YES];
    }
    else if(sender - 1000 == 5)
    {
        //酒店
        SearchHotelViewController *visaVC = [[SearchHotelViewController alloc] init];
        [self.navigationController pushViewController:visaVC animated:YES];
    }
    else if(sender - 1000 == 6)
    {
        //自驾吃
        JYCSelfDriveEatViewController *shopmaVC = [[JYCSelfDriveEatViewController alloc] init];
        [self.navigationController pushViewController:shopmaVC animated:YES];

    }
    
}

#pragma mark -------VerticalScrollViewDelegate
-(void)verticalScrollViewDidSelectedRow:(NSInteger)row
{
   // DLog(@"row : %ld   content : ",row );
    /**
     *cate: 0 首页
     1 旅游
     2 签证
     3 邮轮
     4 游学
     5 门票
     6 旅行管家
     7 机票
     8 酒店
     9 个人中心
     */
    if (_titleArray && _titleArray.count >0)
    {
        weilvAnnounceModel *model = [_titleArray objectAtIndex:row];
        WeilvAnnounceDetailViewController *detail = [[WeilvAnnounceDetailViewController alloc] init];
        detail.model = model;
        [self.navigationController pushViewController:detail animated:YES];
    }
}


#pragma mark 请求首页刷新内容、数据
-(void) sendHomeContentUrl:(NSString *)url WithParmers:(NSDictionary *)parameters aTag:(NSUInteger)tag
{
    __weak MainViewController * weakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject)
    {
              
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];

              if ([[dict objectForKey:@"status"] integerValue] == 1)
              {
                  NSDictionary * dict1 = [[NSDictionary alloc] initWithDictionary:[dict objectForKey:@"data"]];
                  //热门目的地
                  if ([dict1 objectForKey:@"choiceDestList"] && [[dict1 objectForKey:@"choiceDestList"] isKindOfClass:[NSArray class]] && [[dict1 objectForKey:@"choiceDestList"] count]>0)
                  {
                      [_choiceDestListArr removeAllObjects];
                      _choiceDestListArr  = [[NSMutableArray alloc] init];
                      for (int i = 0 ; i < [[dict1 objectForKey:@"choiceDestList"] count]; i++)
                      {
                          DestiationModel *model = [[DestiationModel alloc] initWithDictionary:[[dict1 objectForKey:@"choiceDestList"] objectAtIndex:i]];
                          [_choiceDestListArr addObject:model];
                      }
                      [self initDestinationView];
                  }
                  else
                  {
                      [_choiceDestListArr removeAllObjects];
                      _choiceDestListArr  = [[NSMutableArray alloc] init];
                      [self initDestinationView];
                  }
                  //周边景点
                  if ([dict1 objectForKey:@"aroundScenicList"] && [[dict1 objectForKey:@"aroundScenicList"] isKindOfClass: [NSArray class]] && [[dict1 objectForKey:@"aroundScenicList"] count]>0)
                  {
                      [_aroundSenicListArr removeAllObjects];
                      _aroundSenicListArr  = [[NSMutableArray alloc] init];
                      for (int i = 0 ; i < [[dict1 objectForKey:@"aroundScenicList"] count]; i++)
                      {
                          aroundSceincmodel *model = [[aroundSceincmodel alloc] initWithDictionary:[[dict1 objectForKey:@"aroundScenicList"] objectAtIndex:i]];
                          [_aroundSenicListArr addObject:model];
                      }
                      [self initSenic];
                  }
                  else
                  {
                      [_aroundSenicListArr removeAllObjects];
                      _aroundSenicListArr  = [[NSMutableArray alloc] init];
                      [self initSenic];
                  }
                  
                  
                  [_productListArr removeAllObjects];
                  _productListArr = [[NSMutableArray alloc] init];
                  DLog(@"%@,%@",url,parameters);
                  //产品类别
                  if ([dict1 objectForKey:@"productTabList"] && [[dict1 objectForKey:@"productTabList"] count]>0)
                  {
                      [_tableTitleArr removeAllObjects];
                      _tableTitleArr = [[NSMutableArray alloc] init];
                      int countItem=(int)[[dict1 objectForKey:@"productTabList"] count];
                      for (int i = 0 ; i <countItem; i ++)
                      {
                          //获取产品类别的名称
                          NSString * titlestr = [[[dict1 objectForKey:@"productTabList"] objectAtIndex:i] objectForKey:@"title"];
                          //获取每一个类别的列表项总数
                          int prodcutListItemCount=(int)[[[[dict1 objectForKey:@"productTabList"] objectAtIndex:i] objectForKey:@"list"] count];
                          id item=[[[dict1 objectForKey:@"productTabList"] objectAtIndex:i] objectForKey:@"list"];
                          
                          if(item && [item isKindOfClass:[NSArray class]] && prodcutListItemCount> 4)
                          {
                              [_tableTitleArr addObject:titlestr];
                          }
                          
                          if (!(item && [item isKindOfClass:[NSArray class]] && prodcutListItemCount>4))
                          {
                              DLog(@"获取产品分类列表失败");
                          }
                          else
                          {
                              NSArray *listArray = [[NSArray alloc] initWithArray:[[[dict1 objectForKey:@"productTabList"] objectAtIndex:i] objectForKey:@"list"] ];
                              
                              
                              NSMutableArray *arr = [[NSMutableArray alloc] init];
                              for (int j =0 ; j < listArray.count;  j ++)
                              {
                                  
                                  if ([titlestr isEqualToString:@"旅游度假"])
                                  {
                                      //旅游度假
                                      NSDictionary *dict2 = [listArray objectAtIndex:j];
                                      LXTraveModel *model = [[LXTraveModel alloc] init];
                                      if (![YXTools stringReturnNull:[dict2 objectForKey:@"thumb"]]) {
                                          if ([[dict2 objectForKey:@"thumb"] hasPrefix:@"https://"]||[[dict2 objectForKey:@"thumb"] hasPrefix:@"http://"])
                                          {
                                              model.leftImage = [dict2 objectForKey:@"thumb"];
                                          }
                                          else
                                          {
                                              model.leftImage=[NSString stringWithFormat:@"%@/upload/thumb/%@",WLHTTP,[dict2 objectForKey:@"thumb"]];
                                          }
                                      }
                                      model.name=[dict2 objectForKey:@"product_name"];
                                      model.price=[dict2 objectForKey:@"sell_price"];
                                      model.info=[dict2 objectForKey:@"feature"];
                                      model.traveID=[dict2 objectForKey:@"id"];
                                      model.gj_commission=[dict2 objectForKey:@"gj_commission"];
                                      model.admin_id=[dict2 objectForKey:@"admin_id"];
                                      model.lastest=[dict2 objectForKey:@"lastest"];
                                      [arr  addObject:model];
                                      
                                  }
                                  else if ([titlestr isEqualToString:@"签证"])
                                  {
                                      //签证
                                      NSDictionary *dict2 = [listArray objectAtIndex:j];
                                      ZFJVisaModel * model = [[ZFJVisaModel alloc] initWithDictionary:dict2];
                                      [arr  addObject:model];
                                      
                                  }
                                  else if ([titlestr isEqualToString:@"邮轮"])
                                  {
                                      //邮轮
                                      NSDictionary *dict2 = [listArray objectAtIndex:j];
                                      ShipListModel * model = [[ShipListModel alloc] initWithDictionary:dict2];
                                      [arr  addObject:model];
                                      
                                  }
                                  else if ([titlestr isEqualToString:@"门票"])
                                  {
                                      //门票
                                      NSDictionary *dict2 = [listArray objectAtIndex:j];
                                      TicketListModel * model = [[TicketListModel alloc] initWithDictionary:dict2];
                                      if ([self judgeString:model.start_price])
                                      {
                                          if (![model.start_price isEqualToString:@"0"])
                                          {
                                              [arr  addObject:model];
                                          }
                                      }
                                      
                                  }
                                  else if ([titlestr isEqualToString:@"游学"])
                                  {
                                      //游学
                                      NSDictionary *dict2 = [listArray objectAtIndex:j];
                                      LXSTListModel *model=[[LXSTListModel alloc] initWithDictionary:dict2];
                                      model.st_id=[dict2 objectForKey:@"id"];
                                      [arr addObject:model];
                                      
                                  }
                              }
                              [_productListArr addObject:arr];
                              
                          }
 
                          
                      }
                      if (_productListArr.count == _tableTitleArr.count  && _productListArr.count>0)
                      {
                          
                          [weakSelf inittableViewList];
                          _scrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(_tableView)+ViewHeight(_tableView)-49 );
                      }
                      else
                      {
                          [_tableView removeFromSuperview];
                          _tableView = nil;
                          _scrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(destinationView)+ViewHeight(destinationView)-49);
                      }
                      
                      
                  }
                  
              }
              else
              {
                  [[LXAlterView sharedMyTools]createTishi:[dict valueForKey:@"msg"]];
              }
              [weakSelf.scrollView.header endRefreshing];
          }
          failure:^(AFHTTPRequestOperation *operation,NSError *error)
          {
              DLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
              [weakSelf.scrollView.header endRefreshing];
          }];
    
}


#pragma mark 周边景点
-(void)initSenic{
    float viewy = BannerHegit + 125 + 40 + 10;
    //边距10   图片间距5 图片比例35:22  标题高度37.5     “周边景点”字体：15 RGB#2f2f2f  “更多”字体：14 RGB#617378
    //图片长和宽
    float image_X = (windowContentWidth - 10 * 2 -5)/2;
    float image_Y = image_X / 35 * 22;
    
    if (senicView !=nil) {
        [senicView removeFromSuperview];
    }
    senicView = [[UIView alloc] initWithFrame:CGRectMake(0, viewy, windowContentWidth, 37.5 + 5 + 10 + image_Y * 2)];
    senicView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:senicView];
    
    if (!self.aroundSenicListArr || self.aroundSenicListArr.count<2) {
        [senicView setFrame:CGRectMake(0, viewy, windowContentWidth, 0)];
    }else{
        UILabel *leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, windowContentWidth/2, 37.5)];
        leftlabel.textAlignment = NSTextAlignmentLeft;
        leftlabel.text = @"周边景点";
        leftlabel.font = [UIFont systemFontOfSize:15];
        leftlabel.textColor = kColor(47, 47, 47);
        [senicView addSubview:leftlabel];
        
        float moreWidth = 12;
        UIImageView *moreIGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - moreWidth -10, 37.5/2 - moreWidth/2, moreWidth, moreWidth)];
        moreIGV.image = [UIImage imageNamed:@"更多-首页"];
        [senicView addSubview:moreIGV];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(moreIGV) - 100-2.5, 0, 100, 37.5)];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.text = @"更多";
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = kColor(97, 115, 120);
        [senicView addSubview:rightLabel];
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.frame = CGRectMake(windowContentWidth/2, 0, windowContentWidth/2, ViewHeight(leftlabel));
        moreBtn.backgroundColor = [UIColor clearColor];
        moreBtn.tag = 1;
        [moreBtn addTarget:self action:@selector(jumpToList:) forControlEvents:UIControlEventTouchUpInside];
        [senicView addSubview:moreBtn];
        int j = self.aroundSenicListArr.count>3 ? 4:2 ;
        [senicView setFrame:CGRectMake(0, viewy, windowContentWidth, 37.5 + 5 + 10 + image_Y * j/2)];

        for (int i = 0; i <j; i ++)
        {
            float x = i%2 == 0 ? 10:10+image_X+5;
            int heig = i/2;
            float y = 37.5 +(image_Y +5)*heig;
            NSString *imagestr = @"";
            NSString *titlestr = @"";
            NSString *detailstr = @"";
            if (self.aroundSenicListArr && self.aroundSenicListArr.count>i)
            {
                aroundSceincmodel *model = [self.aroundSenicListArr objectAtIndex:i];
                imagestr = model.src;
                titlestr = model.title;
                detailstr = model.descriptionn;
            }
            
            SenicCellView *seniccell = [[SenicCellView alloc] initWithFrame:CGRectMake(x,y,image_X,image_Y) AndImageString:imagestr AndTitle:titlestr AndDetailTitleString:detailstr];
            seniccell.btn.tag = i + 300;
            [seniccell.btn addTarget:self action:@selector(SenicClick:) forControlEvents:UIControlEventTouchUpInside];
            [senicView addSubview:seniccell];
            
        }

    }
    //添加视图的同时也在不断的改变scorollView的contentSize值
    _scrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(senicView)+ViewHeight(senicView)-49);
    [self initHouserKeeperView];
}


#pragma mark ------------------------周边景点跳转方法---------------------------------
-(void)SenicClick:(UIButton *)sender
{
    aroundSceincmodel *model  = [_aroundSenicListArr objectAtIndex:sender.tag-300];

    
    GuoneiViewController *screenVC = [[GuoneiViewController alloc]init];
    screenVC.lastViewControllerTag = @"100";
    screenVC.search_type = @"1";
    screenVC.productListTitle = model.title;
    screenVC.cityTitle = model.title;
    screenVC.rote_ID = -11;
    screenVC.city_id =[[WLSingletonClass defaultWLSingleton] wlCityId];
    screenVC.sortstr = model.title;
    [self.navigationController pushViewController:screenVC animated:YES];
    
}

-(void)jumpToList:(UIButton *)sender{
   // DLog(@"more button Tag = %ld",sender.tag);
    if (sender.tag == 1) {
        //跳转周边景点列表
        AroundScenicLiscViewController *asVC = [[AroundScenicLiscViewController alloc] init];
       // asVC.aroundSenicListArr = self.aroundSenicListArr;
        [self.navigationController pushViewController:asVC animated:YES];
        
    }else if (sender.tag == 2) {
        //跳转管家
        if ([[[LXUserTool alloc] getKeeper] intValue]==0)
        {
            //没有管家
            HouseKeeperViewController *keeperVC = [[HouseKeeperViewController alloc] init];
            keeperVC.pushType = isPush;
            [self.navigationController pushViewController:keeperVC animated:YES];
        }else{
            YXHouseDetailViewController *keeperDetailVc=[[YXHouseDetailViewController alloc] init];
            keeperDetailVc.pushType = isPush;
            keeperDetailVc.houseName = @"我的管家";
            [self.navigationController pushViewController:keeperDetailVc animated:YES];
        }
        
    }else if (sender.tag == 3) {
        //跳转精选旅行目的地
        ChoiceDestinaViewController *dest = [[ChoiceDestinaViewController alloc] init];
       // dest.destinaArr = self.choiceDestListArr;
        [self.navigationController pushViewController:dest animated:YES];
        
    }
}

#pragma mark 微旅管家广告
-(void)initHouserKeeperView{
    //图片比例75/26
    if(houseKeeperIGV ){
        [houseKeeperIGV removeFromSuperview];
    }
    
    houseKeeperIGV = [[UIImageView alloc] initWithFrame:CGRectMake(0, ViewY(senicView) + ViewHeight(senicView), windowContentWidth, windowContentWidth*26/75)];
    [houseKeeperIGV setImage:[UIImage imageNamed:@"home_assisant_ad"]];
    [_scrollView addSubview:houseKeeperIGV];
    
    houseKeeperIGV.userInteractionEnabled = YES;
    
    UIButton *ClickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ClickBtn.frame = CGRectMake(0, 0, ViewWidth(houseKeeperIGV), ViewHeight(houseKeeperIGV));
    ClickBtn.backgroundColor = [UIColor clearColor];
    ClickBtn.tag = 2;
    [ClickBtn addTarget:self action:@selector(jumpToList:) forControlEvents:UIControlEventTouchUpInside];
    [houseKeeperIGV addSubview:ClickBtn];
    
    _scrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(houseKeeperIGV)+ViewHeight(houseKeeperIGV)-49);
    [self initDestinationView];
}

#pragma mark 精选旅行目的地
-(void)initDestinationView
{
    float viewy = ViewY(houseKeeperIGV)+ViewHeight(houseKeeperIGV);
    //边距10   图片间距5 图片比例71:37  标题高度37.5     “精选目的地”字体：15 RGB#2f2f2f  “更多”字体：14 RGB#617378
    //图片长和宽
    float image_Width = (windowContentWidth - 10 * 2 );
    float image_Height = image_Width/ 71 * 37;
    if (destinationView !=nil)
    {
        [destinationView removeFromSuperview];
    }
    destinationView = [[UIView alloc] initWithFrame:CGRectMake(0, viewy, windowContentWidth, 37.5 + 10 + image_Height )];
    destinationView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:destinationView];
    
    if (_choiceDestListArr && _choiceDestListArr.count>0)
    {
        destinationView.frame = CGRectMake(0, viewy, windowContentWidth, 37.5 + 10 + image_Height);
        UILabel *leftlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, windowContentWidth/2, 37.5)];
        leftlabel.textAlignment = NSTextAlignmentLeft;
        leftlabel.text = @"精选旅行目的地";
        leftlabel.font = [UIFont systemFontOfSize:15];
        leftlabel.textColor = kColor(47, 47, 47);
        [destinationView addSubview:leftlabel];
        
        float moreWidth = 12;
        UIImageView *moreIGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - moreWidth -10, 37.5/2 - moreWidth/2, moreWidth, moreWidth)];
        moreIGV.image = [UIImage imageNamed:@"更多-首页"];
        [destinationView addSubview:moreIGV];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(moreIGV) - 100-2.5, 0, 100, 37.5)];
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.text = @"更多";
        rightLabel.font = [UIFont systemFontOfSize:14];
        rightLabel.textColor = kColor(97, 115, 120);
        [destinationView addSubview:rightLabel];
        
        UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        moreBtn.frame = CGRectMake(windowContentWidth/2, 0, windowContentWidth/2, ViewHeight(leftlabel));
        moreBtn.backgroundColor = [UIColor clearColor];
        moreBtn.tag = 3;
        [moreBtn addTarget:self action:@selector(jumpToList:) forControlEvents:UIControlEventTouchUpInside];
        [destinationView addSubview:moreBtn];
        
        NSString *imagestr = @"";
        NSString *cityTitStr = @"";
        if (_choiceDestListArr && _choiceDestListArr.count>0) {
            DestiationModel * model = [_choiceDestListArr objectAtIndex:0];
            imagestr = model.src;
            cityTitStr = model.title;
        }
        DestinationCellVIew *destinCV = [[DestinationCellVIew alloc] initWithFrame:CGRectMake(10, 37.5, image_Width,image_Height ) AndImageString:imagestr AndCityTitle:cityTitStr];
        [destinCV.btn addTarget:self action:@selector(destinationClick:) forControlEvents:UIControlEventTouchUpInside];
        [destinationView addSubview:destinCV];

    }
    else
    {
        destinationView.frame = CGRectMake(0, viewy, windowContentWidth, 0);
    }
    
    _scrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(destinationView)+ViewHeight(destinationView)-49);
}

-(void)destinationClick:(UIButton *)sender{
    //跳转精选目的地列表
    DestiationModel * model = [self.choiceDestListArr objectAtIndex:0];

#pragma mark ----------根据条件筛选页面---------------
//    TravelScreenViewController *travelScreenVC = [[TravelScreenViewController alloc]init];
//    travelScreenVC.productListTitle = model.title;
//    travelScreenVC.search_type = @"1";
//    travelScreenVC.lastViewControllerTag = @"100";
//    //    travelScreenVC.navigationItem.title = model.title;
//    travelScreenVC.navigationController.title = model.title;
//    [self.navigationController pushViewController:travelScreenVC animated:YES];
    
    
    GuoneiViewController *travelScreenVC = [[GuoneiViewController alloc]init];
    travelScreenVC.productListTitle = model.title;
    travelScreenVC.search_type = @"1";
    travelScreenVC.lastViewControllerTag = @"200";
    travelScreenVC.rote_ID = -11;
    travelScreenVC.cityTitle = model.title;
    travelScreenVC.city_id = [[WLSingletonClass defaultWLSingleton] wlCityId];
    [self.navigationController pushViewController:travelScreenVC animated:YES];
}


#pragma mark 生成tableView
- (void)inittableViewList
{
    //字体选中20  #ff9600  未选中 34 #6f7378
    UIView *titView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(destinationView) + ViewHeight(destinationView) +10, windowContentWidth, 45.5)];
    titView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:titView];
    if(_tableView!= nil){
        [_tableView removeFromSuperview];
        _tableView= nil;
    }
    self.tableArr = [self.productListArr objectAtIndex:0];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, ViewY(titView) + ViewHeight(titView) , windowContentWidth, 90*_tableArr.count)];
    _tableView.tableFooterView=[[UIView alloc] init];//去掉多余的cell
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_scrollView addSubview:_tableView];
    _scrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(_tableView)+ViewHeight(_tableView)-49 );
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }

    float sc_Width =(windowContentWidth -30*2 ) / self.tableTitleArr.count;
    
    slidLine =[[UILabel alloc]initWithFrame:CGRectMake(30 + sc_Width/2 -80/2 , 43.5, 80, 2)];
    slidLine.backgroundColor = selectedColor;
    [titView addSubview:slidLine];
    
    if (tableBtnArr)
    {
        [tableBtnArr removeAllObjects];
    }
    tableBtnArr = [[NSMutableArray alloc] init];
    for (int x=0; x<self.tableTitleArr.count; x++)
    {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(30 + sc_Width * x,0, sc_Width, 45.5)];
        [btn setTitleColor:unselectedColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:unselectedFont];
        [btn.titleLabel sizeToFit];
        btn.titleLabel.numberOfLines =0;
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:[self.tableTitleArr objectAtIndex:x] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(ChooseTabTitle:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=x;
        [titView addSubview:btn];
        [tableBtnArr addObject:btn];
        if (x == 0)
        {
            [self ChooseTabTitle:btn];
        }
    }
    
    
    
}
-(void)ChooseTabTitle:(UIButton*)btn
{
    CGFloat new_X=30 + (windowContentWidth - 30*2)/self.tableTitleArr.count*btn.tag + (windowContentWidth -30*2)/self.tableTitleArr.count/2 -80/2;
    [UIView animateWithDuration:0.4f animations:^{
        CGRect rect = slidLine.frame;
        rect.origin.x = new_X;
        slidLine.frame = rect;
    }];
    for(UIButton *myBtn in tableBtnArr)
    {
        if (myBtn == btn)
        {
            [myBtn setTitleColor:selectedColor forState:UIControlStateNormal];
        }
        else
        {
            [myBtn setTitleColor:unselectedColor forState:UIControlStateNormal];
        }
    }
    titleString = [self.tableTitleArr objectAtIndex:btn.tag];
    self.tableArr = [self.productListArr objectAtIndex:btn.tag];
    [_tableView reloadData];
}



#pragma mark ------EscrollViewDelegate
-(void)EScrollerViewDidClicked:(NSUInteger)index
{
/**
*cate: 0 首页
       1 旅游
       2 签证
       3 邮轮
       4 游学
       5 门票
       6 旅行管家
       7 机票
       8 酒店
       9 个人中心
*/

    
    if (_adArray.count >0)
    {
        LXAdvertModel *model=[_adArray objectAtIndex:index-1];
        NSDictionary *dic = model.gotoDic;

       if ([[dic objectForKey:@"type"] isEqualToString:@"list"])
       {
            //跳转列表页
            if ([[dic objectForKey:@"cate"] integerValue] == 1)
            {
                //旅游
                if([self judgeString:[model.gotoDic objectForKey:@"keyword"]] == YES)
                {
                    TraveSearchViewController *travelVC = [[TraveSearchViewController alloc] init];
                    travelVC.pushType = isPush;
                    travelVC.area = @"city";
                    travelVC.keywords = [model.gotoDic objectForKey:@"keyword"];
                    travelVC.navigationItem.title = [model.gotoDic objectForKey:@"keyword"];
                    [self.navigationController pushViewController:travelVC animated:YES];
                }
                else
                {
                    LXTraveListViewController *trave = [[LXTraveListViewController alloc] init];
                    trave.traveType = [dic objectForKey:@"tour_cate"];
                    trave.navigationItem.title = model.title;
                    if ([self judgeString:[dic objectForKey:@"d_city"]]) {
                        trave.t_city = [[[dic objectForKey:@"d_city"] componentsSeparatedByString:@"-"] objectAtIndex:0];
                    } else if ([self judgeString:[dic objectForKey:@"d_province"]]) {
                        trave.t_province = [[[dic objectForKey:@"d_province"] componentsSeparatedByString:@"-"] objectAtIndex:0];
                    } else if ([self judgeString:[dic objectForKey:@"d_country"]]) {
                        trave.t_country = [[[dic objectForKey:@"d_country"] componentsSeparatedByString:@"-"] objectAtIndex:0];
                    }
                    
                    [self.navigationController pushViewController:trave animated:YES];
                }
                
            }
            else if ([[dic objectForKey:@"cate"] integerValue] == 2)
            {
                //签证
                ZFJVIsaListVC *visa = [[ZFJVIsaListVC alloc] init];
                visa.region_id = [[WLSingletonClass defaultWLSingleton] wlCityId];
                visa.country_id = [dic objectForKey:@"visa_country"];;
                [self.navigationController pushViewController:visa animated:YES];
               
            }
            else if ([[dic objectForKey:@"cate"] integerValue] == 3)
            {
                //邮轮
                ZFJShipListVC *ship = [[ZFJShipListVC alloc] init];
                ship.line_id =[dic objectForKey:@"cruise_line"];
                [self.navigationController pushViewController:ship animated:YES];
                
            }
            else if ([[dic objectForKey:@"cate"] integerValue] == 4)
            {
                //游学
                LXSTListViewController *yoosure = [[LXSTListViewController alloc] init];
                
                if ([self judgeString:[dic objectForKey:@"d_country"]])
                {
                    yoosure.city_name = [[[dic objectForKey:@"d_country"] componentsSeparatedByString:@"-"] objectAtIndex:1];
                }
                if ([self judgeString:[dic objectForKey:@"yoosure_type"]])
                {
                    yoosure.themeType = [dic objectForKey:@"yoosure_type"];
                }
                
                [self.navigationController pushViewController:yoosure animated:YES];
                
            }
            else if ([[dic objectForKey:@"cate"] integerValue] == 5)
            {
                //门票
                if([self judgeString:[dic objectForKey:@"d_city"]] || [self judgeString:[dic objectForKey:@"d_province"]] || [self judgeString:[dic objectForKey:@"ticket_theme"]] )
                {
                    ZFJTicketListVC *ticker = [[ZFJTicketListVC alloc] init];
                    if ([self judgeString:[dic objectForKey:@"d_city"]])
                    {
                        NSString * cityIDStr = [[[dic objectForKey:@"d_city"] componentsSeparatedByString:@"-"] objectAtIndex:1];
                        ticker.isCity = YES;
                        ticker.keyStr = @"placecity";
                        ticker.valueStr = cityIDStr;
                    }
                    else if ([self judgeString:[dic objectForKey:@"d_province"]])
                    {
                        NSString * provinceIDStr = [[[dic objectForKey:@"d_province"] componentsSeparatedByString:@"-"] objectAtIndex:1];
                        ticker.keyStr = @"placecity";
                        ticker.valueStr = provinceIDStr;
                    }
                    if ([self judgeString:[dic objectForKey:@"ticket_theme"]])
                    {
                        ticker.keyStr =  @"producttheme";
                        ticker.valueStr = [dic objectForKey:@"ticket_theme"];
                    }
                    [self.navigationController pushViewController:ticker animated:YES];
                }

            }
            
        }else if([[dic objectForKey:@"type"] isEqualToString:@"detail"])
        {
                //跳转详情页
                if ([[dic objectForKey:@"cate"] integerValue] == 1) {
                    //旅游
//                    YXDetailTraveViewController *yxDetailVc=[[YXDetailTraveViewController alloc] init];
//                    yxDetailVc.productId=[dic objectForKey:@"product_id"];
//                    [self.navigationController pushViewController:yxDetailVc animated:YES];
                    ProductDetailViewController *productVC = [[ProductDetailViewController alloc]init];
                    productVC.productID = [dic objectForKey:@"product_id"];
                    productVC.gj_commission = [dic objectForKey:@"gj_adult_rebate"];
                    [self.navigationController pushViewController:productVC animated:YES];
                    
                    
                }else if ([[dic objectForKey:@"cate"] integerValue] == 2) {
                    //签证
                    ZFJVisaDetailVC *visaDtailVC = [[ZFJVisaDetailVC alloc] init];
                    visaDtailVC.product_id = [dic objectForKey:@"product_id"];
                    [self.navigationController pushViewController:visaDtailVC animated:YES];
                    
                }else if ([[dic objectForKey:@"cate"] integerValue] == 3) {
                    //邮轮
                    ZFJShipDetailVC * detailVC = [[ZFJShipDetailVC alloc] init];
                    detailVC.product_id = [dic objectForKey:@"product_id"];
                    [self.navigationController pushViewController:detailVC animated:YES];
                    
                }else if ([[dic objectForKey:@"cate"] integerValue] == 4) {
                    //游学
                    LXSTDetailViewController *yxDetailVc=[[LXSTDetailViewController alloc] init];
                    yxDetailVc.productId=[dic objectForKey:@"product_id"];
                    [self.navigationController pushViewController:yxDetailVc animated:YES];
                    
                }else if ([[dic objectForKey:@"cate"] integerValue] == 5) {
                    //门票
                    ZFJTicketDetailVC * detailVC = [[ZFJTicketDetailVC alloc] init];
                    detailVC.product_id = [dic objectForKey:@"product_id"];
                    [self.navigationController pushViewController:detailVC animated:YES];
                    
                }
        
        }
        else if ([[dic objectForKey:@"type"] isEqualToString:@"page"]){
            //跳转网页
            if ([[dic objectForKey:@"link"] hasPrefix:@"https://"] || [[dic objectForKey:@"link"] hasPrefix:@"http://"]) {
                NSString *url=[model.link stringByReplacingOccurrencesOfString:@"android" withString:@"ios"];
 
                LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
                specialVc.loadUrl=url;
                specialVc.title=model.title;
                [self.navigationController pushViewController:specialVc animated:YES];
            }else{
                DLog(@"没有连接");
            }

        }else if([[dic objectForKey:@"type"] isEqualToString:@"index"]) {
            //跳转首页
            if ([[dic objectForKey:@"cate"] integerValue] == 1) {
                //旅游
                TravelViewController *yxDetailVc=[[TravelViewController alloc] init];
                [self.navigationController pushViewController:yxDetailVc animated:YES];
                
            }else if ([[dic objectForKey:@"cate"] integerValue] == 2) {
                //签证
                VisaViewController *visaDtailVC = [[VisaViewController alloc] init];
                [self.navigationController pushViewController:visaDtailVC animated:YES];
                
            }else if ([[dic objectForKey:@"cate"] integerValue] == 3) {
                //邮轮
                ZFJShipViewController * detailVC = [[ZFJShipViewController alloc] init];
                [self.navigationController pushViewController:detailVC animated:YES];
                
            }else if ([[dic objectForKey:@"cate"] integerValue] == 4) {
                //游学
                LXStudyTourViewController *yxDetailVc=[[LXStudyTourViewController alloc] init];
                [self.navigationController pushViewController:yxDetailVc animated:YES];
                
            }else if ([[dic objectForKey:@"cate"] integerValue] == 5) {
                //门票
                ZFJTicketHomeVC * detailVC = [[ZFJTicketHomeVC alloc] init];
                [self.navigationController pushViewController:detailVC animated:YES];
                
            }
        }
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tableArr.count >10 ? 10 : self.tableArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([titleString isEqualToString:@"旅游度假"]) {
        //旅游度假
        static NSString *CellIdentifier101 = @"cell101";
        LXTraveCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier101];
        if (!cell)
        {
            cell = [[LXTraveCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier101];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.tableArr.count>0)
        {
            LXTraveModel *model=[self.tableArr objectAtIndex:indexPath.row];
            cell.item=model;
        }
        
        return cell;

    }else if ([titleString isEqualToString:@"签证"]){
        //签证
        static NSString * cellIndentifier102 = @"visaCell102";
        ZFJVisaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier102];
        if (!cell) {
            cell = [[ZFJVisaTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier102 customStyle:ZFJVisaTableViewCellStyleTwo];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.visaModel = [self.tableArr objectAtIndex:indexPath.row];
        return cell;

    }else if ([titleString isEqualToString:@"邮轮"]){
        //邮轮
        static NSString * cellIdentifier103 = @"Cell103";
        ZFJShipTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier103];
        if (!cell) {
            cell = [[ZFJShipTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier103 customStry:ZFJShipTableViewCellStyleThree];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.tableArr != 0) {
            cell.shipListModels= [self.tableArr objectAtIndex:indexPath.row];
        }
        return cell;
        
    }else if ([titleString isEqualToString:@"门票"]){
        //门票
        static NSString *cellIndentifier104 = @"listCell104";
        ZFJTicketListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier104];
        if (!cell) {
            cell = [[ZFJTicketListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier104];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = [self.tableArr objectAtIndex:indexPath.row];
        return cell;

    }else if ([titleString isEqualToString:@"游学"]){
        //游学
        static NSString *CellIdentifier105 = @"cellIdentifier105";
        LXSTListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier105];
        if (cell == nil)
        {
            cell = [[LXSTListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier105];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.tableArr.count>0) {
            LXSTListModel *model=[self.tableArr objectAtIndex:indexPath.row];
            cell.model=model;
        }
        
        return cell;

    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([titleString isEqualToString:@"旅游度假"]) {
        //旅游度假
        LXTraveModel *model=[self.tableArr objectAtIndex:indexPath.row];
//        YXDetailTraveViewController *yxDetailVc=[[YXDetailTraveViewController alloc] init];
//        yxDetailVc.productId=model.traveID;
//        yxDetailVc.productPrice=model.price;
//        yxDetailVc.realBeginDate=model.lastest;
//        [self.navigationController pushViewController:yxDetailVc animated:YES];
        ProductDetailViewController *productVC = [[ProductDetailViewController alloc]init];
        productVC.productID = model.traveID;
        productVC.gj_commission = model.gj_commission;
 
        [self.navigationController pushViewController:productVC animated:YES];
        
    }else if ([titleString isEqualToString:@"签证"]){
        //签证
        ZFJVisaDetailVC *visaDtailVC = [[ZFJVisaDetailVC alloc] init];
        ZFJVisaModel * visaModel = [self.tableArr objectAtIndex:indexPath.row];
        visaDtailVC.product_id = visaModel.product_id;
        [self.navigationController pushViewController:visaDtailVC animated:YES];
        
    }else if ([titleString isEqualToString:@"邮轮"]){
        //邮轮
        ZFJShipDetailVC * detailVC = [[ZFJShipDetailVC alloc] init];
        ZFJShipListModel * shipListModel = [self.tableArr objectAtIndex:indexPath.row];
        detailVC.product_id = shipListModel.product_id;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else if ([titleString isEqualToString:@"门票"]){
        //门票
        ZFJTicketDetailVC * detailVC = [[ZFJTicketDetailVC alloc] init];
        TicketListModel * model = [self.tableArr objectAtIndex:indexPath.row];
        detailVC.product_id = model.product_id;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else if ([titleString isEqualToString:@"游学"]){
        //游学
        LXSTListModel *model=[self.tableArr objectAtIndex:indexPath.row];
        LXSTDetailViewController *yxDetailVc=[[LXSTDetailViewController alloc] init];
        yxDetailVc.productId=model.st_id;
        yxDetailVc.productPrice=model.camper_price;
        yxDetailVc.realBeginDate=model.setoff_date;
        yxDetailVc.commissionStr = model.camper_rebate;
        [self.navigationController pushViewController:yxDetailVc animated:YES];

    }
    

    

}
#pragma mark 分割线左边对齐
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


#pragma mark ------NavSearchDelegate
- (void)beginEdit
{
    self.qrBut.hidden = YES;
    SearchViewController *searchVc=[[SearchViewController alloc] init];
    searchVc.searchType=1;
    [self.navigationController pushViewController:searchVc animated:YES];
}

- (void)cancalEdit
{
    self.qrBut.hidden = NO;
    [self deleteSearchView];
}
- (void)beginSearch:(NSString *)text
{
    if (text.length>0)
    {
        TraveSearchViewController *resultVC = [[TraveSearchViewController alloc] init];
        resultVC.keywords = text;
        resultVC.area = @"city";
        resultVC.pushType = isPush;
        resultVC.navigationItem.title = @"旅游产品";
        [self.navigationController pushViewController:resultVC animated:YES];
    }else
    {
        [[LXAlterView sharedMyTools] createTishi:@"请输入关键字"];
    }

}

- (void)deleteSearchView
{
    UIView *v = (UIView *)[[YXTools getApp].window viewWithTag:300];
    [v removeFromSuperview];
    
    UIView *v1 = (UIView *)[[YXTools getApp].window viewWithTag:301];
    [v1 removeFromSuperview];
}

- (void)loadHotSpots:(UIView *)view
{
    NSMutableArray *hotArr = [[NSMutableArray alloc] initWithObjects:@"泰国",@"厦门",@"温泉",@"日本",@"台湾",@"港澳",@"黄山",@"wifi",@"北京", nil];
    float height;
    if (hotArr.count%3==0) {
        height = hotArr.count/3;
    }else
    {
        height = hotArr.count/3+1;
    }
    view.frame = CGRectMake(0, 64, windowContentWidth, height*(35+10)+10);
    if (hotArr.count>0)
    {
        for (int i=0; i<hotArr.count; i++)
        {
            UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            hotBtn.frame = CGRectMake(10*(i%3+1)+(HotBtnWith+5)*(i%3), 10+10*(i/3)+i/3*35, HotBtnWith, 30);
            [hotBtn setTitle:[hotArr objectAtIndex:i] forState:UIControlStateNormal];
            [hotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            hotBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            hotBtn.layer.borderWidth = 0.5;
            [hotBtn.layer setCornerRadius:2.0];
            hotBtn.tag = 100+i;
            [hotBtn addTarget:self action:@selector(toClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:hotBtn];
        }
    }
    
}

- (void)toClick:(UIButton *)sender
{
    [searchView cancelSearch];
    SearchResultViewController *resultVC = [[SearchResultViewController alloc] init];
    resultVC.resultText = sender.titleLabel.text;
    [self.navigationController pushViewController:resultVC animated:YES];
}

#pragma mark --------UIScrollViewDelegate---- 滑动视图Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 222)
    {
        [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            chooesLinePage.frame = CGRectMake(scrollView.contentOffset.x / windowContentWidth * 30, 0, 20, 3);
        } completion:nil];
    }
    
    if (scrollView.contentOffset.y < -20)
    {
        
        headerView.hidden = YES;
    }
    else
    {
        headerView.hidden = NO;

    }
    
    if ( 20 < _scrollView.contentOffset.y < BannerHegit )
    {
        CGFloat xx = (_scrollView.contentOffset.y -20)/(BannerHegit -20);
        headerView.backgroundColor = [UIColor colorWithWhite:xx alpha:xx];
         searchView.layer.borderWidth = 0.5*(1-xx);
        searchView.searchBar.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.5+0.4*xx];
    }
    if (20< _scrollView.contentOffset.y)
    {
        NSMutableAttributedString *stringg = [[NSMutableAttributedString alloc] initWithString:@"景区/地区/关键字"];
        [stringg addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,[stringg length])];
        searchView.searchBar.attributedPlaceholder = stringg;
        searchView.leftview.image = [UIImage imageNamed:@"Search"];
        self.locationView.city.textColor = [UIColor orangeColor];
        [self.locationView.locaImage setImage:[UIImage imageNamed:@"定位2-首页"]];
        [self.qrIcon setImage:[UIImage imageNamed:@"扫一扫2"]];
    }
    else
    {
        NSMutableAttributedString *stringg = [[NSMutableAttributedString alloc] initWithString:@"景区/地区/关键字"];
        [stringg addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0,[stringg length])];
        searchView.searchBar.attributedPlaceholder =stringg ;
        searchView.leftview.image = [UIImage imageNamed:@"Search-1"];
        self.locationView.city.textColor = [UIColor whiteColor];
        [self.locationView.locaImage setImage:[UIImage imageNamed:@"定位1-首页"]];
        [self.qrIcon setImage:[UIImage imageNamed:@"扫一扫"]];
    }

}

@end