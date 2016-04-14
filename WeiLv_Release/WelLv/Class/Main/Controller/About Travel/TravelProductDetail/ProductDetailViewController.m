//
//  ProductDetailViewController.m
//  TraveDetail
//
//  Created by WeiLv on 16/1/11.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "ProductDetailViewController.h"

#import "TopView.h"

#import "MiddleView.h"

#import "MView.h"

#import "ScenicView.h"

#import "DetailView.h"

#import "BackView.h"

#import "NextView.h"

#import "DownView.h"

#import "ProximalView.h"
//新版管家列表
#import "ButlerViewController.h"
//原版管家列表
#import "ZFJCallStewardVC.h"

#import "ChooseDayViewController.h"

#import "DayListViewCell.h"

#import "ProductModel.h"

#import "TravelProductDetailCollectionViewCell.h"

#import "ShortViewCell.h"

#import "AFNetworking.h"

//最近团期
#import "TravelCalendarViewController.h"
//订单
#import "TravelOrderDetailModel.h"
//团期model
#import "TravelLoopDateModel.h"

#import "PhotoAlbumViewController.h"

#import "LoginAndRegisterViewController.h"

#import "LXAlterView.h"

#import "MBProgressHUD.h"

#import "YXWebDetailViewController.h"

#import "TravelAllHeader.h"


#import <ShareSDK/ShareSDK.h>

#import "ShareCustom.h"

#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

//#import "DownView.h"

@interface ProductDetailViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIWebViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;

//定义 TopView
@property (nonatomic,strong) TopView *topView;
//定义 BackView
@property (nonatomic,strong) BackView *backView;
//定义 MidleView 简略行程
@property (nonatomic,strong) MiddleView *middleView;
@property (nonatomic,strong) MView *mView;
//定义 DetailView 产品详情
@property (nonatomic,strong) DetailView *detailView;
//定义 NextView
@property (nonatomic,strong) NextView *nextView;
//定义 DownView
@property (nonatomic,strong) DownView *downView;
//最简行程
@property (nonatomic,strong) UIScrollView *proximalView;
//产品特色
@property (nonatomic,strong) ScenicView *scenicView;


//查看详情和简略行程 Button
@property (nonatomic, strong) UIButton *changeBtn;
//最简行程Button
@property (nonatomic, strong) UIButton *proximalBtn;

@property (nonatomic,assign) CGFloat topMaxY;
@property (nonatomic,assign) CGFloat midMinY;

//用来判断 Button上文字的转换
@property (nonatomic,assign) BOOL isChange;
@property (nonatomic,assign) BOOL isCollect;

//定义 DownView
@property (nonatomic,strong) UICollectionView *collectionView;

//查看每天的行程详情
@property (nonatomic,strong) ChooseDayViewController *dayViewControl;
@property (nonatomic,strong) ChooseDayViewController *detaiViewControl;

//*********头部视图*********
@property (nonatomic,strong) UIImageView *headerView;
//返回按钮
@property (nonatomic,strong) UIButton *backButton;
//分享按钮
@property (nonatomic,strong) UIButton *shareButton;
//大标题
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *lineLable;



//展示行程天数
@property (nonatomic,strong) UITableView *tableView;
//展示行程详情
@property (nonatomic,strong) UITableView *DetailTableView;
//简略行程
@property (nonatomic,strong) UITableView *shortTableView;
//转换选定天数和默认状态的图片
//@property (nonatomic,strong) UIImageView *changeImage;
//设置选中状态和未选中状态
@property (nonatomic,assign) NSInteger indexNumber;
@property (nonatomic,assign) NSInteger iNumber;
@property (nonatomic,assign) NSInteger iCount;
@property (nonatomic,strong) NSIndexPath *selectindex;


@property (nonatomic,strong) NSMutableArray *cycleArray;
@property (nonatomic,strong) NSMutableArray *topArr;
@property (nonatomic,strong) NSMutableArray *midleArr;
@property (nonatomic,strong) NSMutableArray *collectionArr;
@property (nonatomic,strong) NSMutableArray *albumsArr;
@property (nonatomic,strong) NSMutableDictionary *dataDictionary;


@property (nonatomic,strong) ProductModel *productModel;
@property (nonatomic,strong) ProductModel *pModel;

//订单所需model
@property (nonatomic, strong) TravelOrderDetailModel *orderModel;
//团期所需model
@property (nonatomic, strong) TravelLoopDateModel *loopDate;
//团期数组
@property (nonatomic, strong) NSMutableArray *loopArray;

@property (nonatomic,strong) NSString *str;
@property (nonatomic,strong) NSMutableString *date_time;

//转动菊花
@property (nonatomic,strong) MBProgressHUD *HUD;

/*预定须知所需数据  勿删*/
//费用包含
@property (nonatomic, strong)NSString *fee_include;
//费用不包含
@property (nonatomic, strong)NSString *fee_not_include;
//特殊限制
@property (nonatomic, strong)NSString *special_limit;
//预定须知
@property (nonatomic, strong)NSString *sign_way;
//温馨提示
@property (nonatomic, strong)NSString *warm_prompt;
//付款方式
@property (nonatomic, strong)NSString *payway;
//所有 Cell的高度和
@property (nonatomic,assign) CGFloat heigthOfCell;
@property (nonatomic,assign) CGFloat heigthOfScrol;
@property (nonatomic,assign) CGFloat heigthOfDay;
@property (nonatomic,copy) NSString *getKeeper;
@property (nonatomic,strong) NSMutableArray *yArray;
@property (nonatomic,assign) CGFloat titleHeight;
//网络接口字符串
@property (nonatomic,strong) NSString *stringNet;

@end

@implementation ProductDetailViewController

-(NSString *)getKeeper
{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:@"assistant_id"];
    
}

- (NSMutableArray *)cycleArray {
    if (!_cycleArray) {
        self.cycleArray = [NSMutableArray array];
    }
    return _cycleArray;
}
- (NSMutableArray *)topArr{
    if (!_topArr) {
        self.topArr = [NSMutableArray array];
    }
    return _topArr;
}
- (NSMutableArray *)midleArr{
    if (!_midleArr) {
        self.midleArr = [NSMutableArray array];
    }
    return _midleArr;
}
- (NSMutableArray *)collectionArr{
    if (!_collectionArr) {
        self.collectionArr = [NSMutableArray array];
    }
    return _collectionArr;
}

- (NSMutableDictionary *)dataDictionary{
    if (!_dataDictionary) {
        self.dataDictionary = [NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}

- (NSMutableArray *)albumsArr{
    if (!_albumsArr) {
        self.albumsArr = [NSMutableArray array];
    }
    return _albumsArr;
}

- (NSMutableArray *)yArray{
    if (!_yArray) {
        self.yArray = [NSMutableArray array];
    }
    return _yArray;
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    [super viewWillDisappear:YES];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isChange = YES;
    
    //调用菊花方法
    [self setProgressHUD];
    
    //调用解析数据的方法
    [self readDataFromNet:self.productID];
    
    //订单模型初始化
    self.orderModel = [[TravelOrderDetailModel alloc]init];
    //团期数组初始化
    self.loopArray = [NSMutableArray array];
    
    //预订须知获取数据方法
    //[self getDataFromURL];
    
    
    
}

#pragma mark *******数据加载转动菊花******
-(void)setProgressHUD{
    
    self.HUD = [[MBProgressHUD alloc]initWithView:self.view];
    _HUD.frame = self.view.bounds;
    _HUD.minSize = CGSizeMake(100, 100);
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.labelText = @"加载中...";
    [self.view addSubview:_HUD];
    [_HUD show:YES];
}

#pragma mark ********网络数据请求 ********
- (void)readDataFromNet:(NSString *)IDString{
    
    self.cycleArray = nil;
    self.topArr = nil;
    self.midleArr = nil;
    self.collectionArr = nil;
    self.albumsArr = nil;
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        NSString *assit_id = [NSString stringWithFormat:@"assistant_id=%@",[[LXUserTool sharedUserTool]getKeeper]];
        NSString *check_see = @"&check=see";
        NSString *string = [NSString stringWithFormat:@"%@%@%@",PRODUCT_DETAIL_NET,IDString,check_see];
        self.stringNet = [NSString stringWithFormat:@"%@&%@",string,assit_id];
        
    }else{
        NSString *check_see = @"&check=see";
        self.stringNet = [NSString stringWithFormat:@"%@%@%@",PRODUCT_DETAIL_NET,IDString,check_see];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:_stringNet parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //菊花隐藏,刷新数据
        [_HUD hide:YES];
        
        if (responseObject != nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            if ([dictionary[@"status"] intValue]==1) {
                NSDictionary *dataDic = dictionary[@"data"];
                
                id str = dataDic[@"albums"];
                if ([str isEqual:[NSNull null]]) {
                    
                }else if (![str isEqual:[NSNull null]]){
                    NSArray *albumsArr = dataDic[@"albums"];
                    if (albumsArr.count != 0) {
                        //轮播图数据
                        int i=0;
                        for (NSDictionary *dict in albumsArr) {
                            
                            ProductModel *model = [ProductModel new];
                            [model setValuesForKeysWithDictionary:dict];
                            if ([model.picture hasPrefix:@"http"]) {
                               
                                NSURL *url = [NSURL URLWithString:model.picture];
                                [self.cycleArray addObject:url];
                                if (i==0) {
                                    shareImageURL=model.picture;
                                    
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                        
                                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareImageURL]];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                            _shareImage = [UIImage imageWithData:imageData];
                                        });
                                    });
                                }
                            }else{
                                NSString *string = [NSString stringWithFormat:@"%@/%@",WLHTTP,model.picture];
                                NSURL *url = [NSURL URLWithString:string];
                                [self.cycleArray addObject:url];
                                if (i==0) {
                                    shareImageURL=string;
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                        
                                        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareImageURL]];
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            
                                            _shareImage = [UIImage imageWithData:imageData];
                                        });
                                    });
                                }
                            }
                            i++;
                        }
                    }
                }
                //topView 模块数据
                NSDictionary *topDic = dataDic[@"product_info"];
                ProductModel *topModel = [ProductModel new];
                self.productModel = topModel;
                
                
                //预定须知模块
                if (topDic[@"fee_include"] != [NSNull null]) {
                    self.fee_include = topDic[@"fee_include"];
                }
                if (topDic[@"fee_not_include"] != [NSNull null]) {
                    self.fee_not_include = topDic[@"fee_not_include"];
                    
                }
                if (topDic[@"special_limit"] != [NSNull null]) {
                    self.special_limit = topDic[@"special_limit"];
                }
                if (topDic[@"warm_prompt"] != [NSNull null]) {
                    self.warm_prompt = topDic[@"warm_prompt"];
                }
                if (topDic[@"sign_way"] != [NSNull null]) {
                    self.sign_way = topDic[@"sign_way"];
                }
                
                
                
                //订单模型赋值
                [self.orderModel setValuesForKeysWithDictionary:topDic];
                [topModel setValuesForKeysWithDictionary:topDic];
                
                //行程介绍和产品特色模块
                id schedule = dataDic[@"schedules"];
                if ([self judgeString:schedule] == NO) {
                    
                }else if([self judgeString:schedule] == YES){
                    NSArray *middleArr = dataDic[@"schedules"];
                    int i = 0;
                    for (NSDictionary *dic in middleArr) {
                        ProductModel *midleModel = [ProductModel new];
                        [midleModel setValuesForKeysWithDictionary:dic];
                        [self.midleArr addObject:midleModel];
                        
                        NSArray *aArr = dic[@"albums"];
                        
                        NSMutableArray *group = [NSMutableArray arrayWithCapacity:0];
                        for (NSDictionary *aDict in aArr) {
                            
                            ProductModel *albumModel = [ProductModel new];
                            [albumModel setValuesForKeysWithDictionary:aDict];
                            [group addObject:albumModel];
                            
                        }
                        
                        [self.dataDictionary setObject:group forKey:[NSString stringWithFormat:@"%d",i++]];
                        
                    }
                    
                }
                
                
                //CollectionView 模块数据
                id collect = dataDic[@"tj_products"];
                if ([self judgeString:collect] == NO) {
                    
                }else if([self judgeString:collect] == YES){
                    NSArray *colleArr = dataDic[@"tj_products"];
                    for (NSDictionary *dict in colleArr) {
                        
                        ProductModel *model = [ProductModel new];
                        [model setValuesForKeysWithDictionary:dict];
                        [self.collectionArr addObject:model];
                    }
                }
                
                //获取团期数据
                id loop = dataDic[@"loop_dates"];
                if ([self judgeString:loop] == NO) {
                    
                }else if([self judgeString:loop] == YES){
                    NSArray *loopArray = dataDic[@"loop_dates"];
                    for (NSDictionary *loopDic in loopArray) {
                        TravelLoopDateModel *model = [[TravelLoopDateModel alloc]init];
                        [model setValuesForKeysWithDictionary:loopDic];
                        
                        NSString *sell_priceStr = loopDic[@"sell_price"];
                        NSString *child_sell_priceStr = loopDic[@"child_sell_price"];
                        
                        if ([_productModel.belongs isEqual:@"2"]&&[_productModel.supply_type isEqual:@"1"]) {
                            if (![sell_priceStr isEqual:[NSNull null]] && ![child_sell_priceStr isEqual:[NSNull null]]) {
                                model.adult = sell_priceStr;
                                model.child = child_sell_priceStr;
                                
                            } else {
                                
                                model.adult = self.productModel.sell_price;
                                model.child = self.productModel.child_sell_price;
                            }
                            
                        }
                        
                        
                        [self.loopArray addObject:model];
                    }
                    
                }
                
                self.argumentNum = self.midleArr.count;
                //调用ScrollView布局的方法
                [self addModules:self.argumentNum];
                
                
                //获取分享信息
                //[self getShareContent];
                shareURL=TRAVEL_SHARE_URL(self.productModel.product_id);
                [self.collectionView reloadData];
                [self.tableView reloadData];
                
                
                
            }else{
                
                [[LXAlterView sharedMyTools]createTishi:@"暂无数据"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //[self readDataFromNet:self.productID];
        [[LXAlterView sharedMyTools]createTishi:@"请求失败,请检查网络!"];
    }];
}


#pragma mark *********ScrollView,添加相关功能模块**********
- (void)addModules:(NSInteger)number{
    
    //自身视图上添加滚动视图
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -20, UISCREEN_WIDTH, UISCREEN_HEIGHT)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:222/255.0 green:229/255.0 blue:235/255.0 alpha:1];;
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.scrollView];
    
    [self creatDownView];
    
    [self creatHeaderView];
    
    [self creatTopView];
    
    [self creatBackView];
    
    [self creatMidleView:number];
    
    [self creatNextView];
    
    [self creatCollectionView];
    
//    if (self.midleArr.count != 0) {
//         self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, self.topView.frame.size.height + self.backView.frame.size.height +self.middleView.frame.size.height + self.nextView.frame.size.height + self.collectionView.frame.size.height + UISCREEN_HEIGHT / 43.67 * 3);
//    }else{
//         self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, self.topView.frame.size.height + self.backView.frame.size.height +self.DetailTableView.frame.size.height + self.nextView.frame.size.height + self.collectionView.frame.size.height + UISCREEN_HEIGHT / 43.67 * 3);
//    }
    
}
#pragma mark ************添加头部视图 ********
- (void)creatHeaderView{
    //添加头部消失显示视图
    self.headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, 64)];
    self.headerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    self.headerView.userInteractionEnabled = YES;
  
    
    //标题
    self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 2 - UISCREEN_WIDTH / 4, 64 / 2.4, UISCREEN_WIDTH / 2, UISCREEN_WIDTH / 14.63)];
    self.titleLable.alpha = 0.0;
    self.titleLable.text = @"产品详情";
    self.titleLable.font = [UIFont systemFontOfSize:6];
    self.titleLable.font = [UIFont boldSystemFontOfSize:17.5];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:self.titleLable];
    
    //分隔线
    self.lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 63.5, UISCREEN_WIDTH, 0.3)];
    self.lineLable.alpha = 0.0;
    self.lineLable.backgroundColor = [UIColor grayColor];
    [self.headerView addSubview:self.lineLable];
    
    //返回按钮
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:@"返回按钮"];
    [_backButton setImage:backImage forState:UIControlStateNormal];
    
    if (UISCREEN_WIDTH == 320) {
        self.backButton.frame = CGRectMake(UISCREEN_WIDTH/ 35.55, 64 / 2.6, 30, 30);
        
    }else{
        self.backButton.frame = CGRectMake(UISCREEN_WIDTH/ 35.55, 64 / 2.6, backImage.size.width, backImage.size.height);
        
    }
    
    [_backButton setImage:backImage forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_backButton];
    
    //添加分享按钮
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * imgae = [UIImage imageNamed:@"分享"];
    
    [_shareButton setImage:imgae forState:UIControlStateNormal];
    
//    _shareButton.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 35.55 - UISCREEN_WIDTH / 14.63, 64 / 2.4, imgae.size.width, imgae.size.height);
    
    if (UISCREEN_WIDTH == 320) {
        self.shareButton.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 35.55 - 30, 64 / 2.6, 30, 30);
        
    }else{
        self.shareButton.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 35.55 - imgae.size.width, 64 / 2.6, imgae.size.width, imgae.size.height);
        
    }
    
    
    DLog(@"%@",NSStringFromCGSize(_shareButton.size));
    
    [_shareButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:_shareButton];
    [self.view addSubview:self.headerView];
    
    
}
#pragma mark ********ButtonAction 返回上一页面 ********
- (void)backButtonAction:(UIButton *)backBtn{
    //    NSLog(@"返回到上一页面");
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark **********ShareAction 第三方分享 ********
- (void)shareButtonAction:(UIButton *)shareBtn{
    
    //分享的内容
    NSString *content=self.productModel.product_name;
    content=[content stringByAppendingString:@"\r\n"];
    content=[content stringByAppendingFormat:@"本产品由%@提供服务。微旅,您家门口的旅行管家", [self judgeReturnString:self.productModel.company_name withReplaceString:@""]];
    
    
    NSString *desc=[NSString stringWithFormat:@"本产品由%@提供服务。微旅,您家门口的旅行管家", [self judgeReturnString:self.productModel.company_name withReplaceString:@""]];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:[ShareSDK jpegImageWithImage:_shareImage quality:1]
                                                title:self.productModel.product_name
                                                  url:shareURL
                                          description:desc
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //微信好友显示内容样式
    [publishContent addWeixinSessionUnitWithType:INHERIT_VALUE content:INHERIT_VALUE title:INHERIT_VALUE url:INHERIT_VALUE image:[ShareSDK jpegImageWithImage:_shareImage quality:1] musicFileUrl:nil extInfo:nil fileData:nil emoticonData:nil];
    
    //微信朋友圈显示内容样式
    [publishContent addWeixinTimelineUnitWithType:[NSNumber numberWithInteger:SSPublishContentMediaTypeNews]
                                          content:INHERIT_VALUE
                                            title:content
                                              url:INHERIT_VALUE
                                       thumbImage:[ShareSDK jpegImageWithImage:_shareImage quality:1]
                                            image:INHERIT_VALUE
                                     musicFileUrl:nil
                                          extInfo:nil
                                         fileData:nil
                                     emoticonData:nil];
    
    
    //QQ空间、好友显示内容样式
    [publishContent addQQUnitWithType:INHERIT_VALUE
                              content:INHERIT_VALUE
                                title:INHERIT_VALUE
                                  url:INHERIT_VALUE
                                image:INHERIT_VALUE];
    
    //调用自定义分享
    [ShareCustom shareWithContent:publishContent];
}

#pragma mark *****创建 TopView********
- (void)creatTopView{
    
    //添加 TopView
    //    self.topView = [[TopView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - UISCREEN_HEIGHT / 5.2 + UISCREEN_HEIGHT / 28)];
    self.topView = [[TopView alloc]init];
    if ([self judgeString:_productModel.travel_tag] == NO) {
        
        if ([self judgeString:_productModel.businesslicNo] == NO) {
            self.topView.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - UISCREEN_HEIGHT / 5.2 - UISCREEN_WIDTH / 16 - 9 - UISCREEN_HEIGHT / 88.75 - UISCREEN_HEIGHT / 51.6 * 2);
            self.topMaxY = UISCREEN_HEIGHT - UISCREEN_HEIGHT / 5.2 - UISCREEN_WIDTH / 16 - 9 - UISCREEN_HEIGHT / 88.75 - UISCREEN_HEIGHT / 51.6 * 2;
        }else{
            self.topView.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - UISCREEN_HEIGHT / 5.2 - UISCREEN_WIDTH / 16 - 6.5);
            self.topMaxY = UISCREEN_HEIGHT - UISCREEN_HEIGHT / 5.2 - UISCREEN_WIDTH / 16 - 6.5;
        }
        
    }else{
       
        if ([self judgeString:_productModel.businesslicNo] == NO) {
            self.topView.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - UISCREEN_HEIGHT / 5.2 + UISCREEN_HEIGHT / 28 - 8 - UISCREEN_HEIGHT / 88.75 - UISCREEN_HEIGHT / 51.6 * 2);
            self.topMaxY = UISCREEN_HEIGHT - UISCREEN_HEIGHT / 5.2 + UISCREEN_HEIGHT / 28 - 8 - UISCREEN_HEIGHT / 88.75 - UISCREEN_HEIGHT / 51.6 * 2;
        }else{
            self.topView.frame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - UISCREEN_HEIGHT / 5.2 + UISCREEN_HEIGHT / 28 - 7);
            self.topMaxY = UISCREEN_HEIGHT - UISCREEN_HEIGHT / 5.2 + UISCREEN_HEIGHT / 28 - 7;
        }
    }
    
    
    [self.topView assignValueWithModel:_productModel];
    self.topView.cycle.imageURLsGroup = self.cycleArray;
    self.str = [NSString stringWithFormat:@"最近团期:"];
    for (int i = 0; i < self.loopArray.count; i++) {
        self.loopDate = self.loopArray[i];
        self.str = [_str stringByAppendingString:[NSString stringWithFormat:@"%@,",_loopDate.date_time]];
    }
    self.date_time = [NSMutableString stringWithString:_str];
    if ([_productModel.status integerValue] == 5) {
        self.topView.newlyLable.text = [NSString stringWithFormat:@"%@",_date_time];
    }else{
        self.topView.newlyLable.text = @"最近团期:无班期";
        self.topView.button.userInteractionEnabled = NO;
        self.shareButton.hidden = YES;
    }
    
    //给轮播图添加一个手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.topView.cycle addGestureRecognizer:tapGesture];
    
    self.topView.backgroundColor = [UIColor whiteColor];
    //最近团期
    [self.topView.button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.topView];
    
}
#pragma mark *****轮播图详情页******
- (void)tapGestureAction:(UITapGestureRecognizer *)tap{
    
    PhotoAlbumViewController *photoVC = [PhotoAlbumViewController new];
    
    photoVC.product_ID = self.productID;
    
    [self.navigationController pushViewController:photoVC animated:YES];
}


#pragma mark *****创建 BackView*******
- (void)creatBackView{
    
    //添加 BackView
    self.backView = [[BackView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + UISCREEN_HEIGHT / 43.67, UISCREEN_WIDTH , UISCREEN_HEIGHT /16.7)];
    self.backView.backgroundColor = [UIColor whiteColor];
    
    //行程 Button
    self.midMinY = self.topMaxY + UISCREEN_HEIGHT / 43.67;
    [self.backView.firstButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //特色 Button
    [self.backView.secondButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.backView];
}

#pragma mark *****创建 NextView *******
- (void)creatNextView{
    
    //添加 NextView
    
    if (self.midleArr.count <= 1) {
        self.nextView = [[NextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.DetailTableView.frame) + UISCREEN_HEIGHT / 43.67, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 15)];
        self.nextView.backgroundColor = [UIColor whiteColor];
        [self.nextView.detailButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:self.nextView];
    }else{
        self.nextView = [[NextView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.middleView.frame) + UISCREEN_HEIGHT / 43.67, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 15)];
        self.nextView.backgroundColor = [UIColor whiteColor];
        [self.nextView.detailButton addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:self.nextView];
    }
}

#pragma mark *****创建 CollectionView *******
- (void)creatCollectionView{
    
    //添加 DownView即 collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.nextView.frame) + UISCREEN_HEIGHT / 43.67, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2.5) collectionViewLayout:flowLayout];
    
    //判断有无相关推荐产品
    if (self.collectionArr.count == 0) {
        self.collectionView.hidden = YES;
//        self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT * 2 - UISCREEN_WIDTH /2.2 -20 - UISCREEN_HEIGHT / 2.5);
        
        if (self.midleArr.count <= 1) {
            if ([self judgeString:_productModel.travel_tag] == YES) {
                
                if ([self judgeString:_productModel.businesslicNo] == NO) {
                    self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT * 2 - UISCREEN_WIDTH / 1.1 + _heigthOfCell - UISCREEN_HEIGHT / 14 - UISCREEN_HEIGHT / 88.75 - UISCREEN_HEIGHT / 51.6 * 2 - UISCREEN_HEIGHT / 2.5);
                }else{
                    self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT * 2 - UISCREEN_WIDTH / 1.1 + _heigthOfCell - UISCREEN_HEIGHT / 14 - UISCREEN_HEIGHT / 2.5);
                }
                
            }else{
                if ([self judgeString:_productModel.businesslicNo] == NO) {
                    self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT * 2 - UISCREEN_WIDTH / 1.1 + _heigthOfCell - UISCREEN_HEIGHT / 16 * 2 - - UISCREEN_HEIGHT / 88.75 - UISCREEN_HEIGHT / 51.6 * 3 - UISCREEN_HEIGHT / 2.5);
                }else{
                    
                    self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT * 2 - UISCREEN_WIDTH / 1.1 + _heigthOfCell - UISCREEN_HEIGHT / 16 * 2 - UISCREEN_HEIGHT / 51.6 - UISCREEN_HEIGHT / 2.5);
                }
            }

        }else{
            
            self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, self.topView.frame.size.height + self.backView.size.height + self.middleView.frame.size.height + self.nextView.frame.size.height + UISCREEN_HEIGHT / 37 * 3);
            
        }
        
//        self.collectionView.frame = CGRectMake(0, 0, 0, 0);
        
    }else{
        self.collectionView.hidden = NO;
        
    }
    
    //添加代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    //注册 Cell
    [self.collectionView registerClass:[TravelProductDetailCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionView reloadData];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.collectionView];
    
}
#pragma mark *****创建 DownView *******
- (void)creatDownView{
    
    //添加 DownView
    self.downView = [[DownView alloc]init];
    self.downView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - UISCREEN_HEIGHT / 14.2, [UIScreen mainScreen].bounds.size.width,UISCREEN_HEIGHT / 14.2);
    self.downView.backgroundColor = [UIColor whiteColor];
    
    //调用判断收藏状态的方法
    [self reDataFromBackGround];
    
    //电话咨询按钮关联事件
    [self.downView.referBU addTarget:self action:@selector(clickDownButton:) forControlEvents:UIControlEventTouchUpInside];
  
    if ([_productModel.status integerValue] == 5) {
        //关注按钮关联事件
        [self.downView.attentionBU addTarget:self action:@selector(clickDownButton:) forControlEvents:UIControlEventTouchUpInside];
        
        //立即预订按钮
        [self.downView.scheduleBU addTarget:self action:@selector(clickDownButton:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        self.downView.scheduleBU.backgroundColor = [UIColor grayColor];
        self.downView.attentionBU.userInteractionEnabled = NO;
        self.downView.scheduleBU.userInteractionEnabled = NO;
        
    }
  
    [self.view addSubview:self.downView];
    
    
}
#pragma mark ********根据条件判断收藏的状态**********
- (void)reDataFromBackGround{
    
    NSString *user_id = [[[LXUserTool alloc]init] getUid];
    if (user_id != nil) {
        NSString *str = [NSString stringWithFormat:@"%@/api/newtravel/guanzhu?member_id=%ld&offset=1",WLHTTP,(long)[user_id integerValue]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager POST:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if (responseObject != nil) {
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                
                if ([dictionary[@"msg"] isEqualToString:@"请求数据成功"]) {
                    NSDictionary *dataDict = dictionary[@"data"];
                    NSArray *array = dataDict[@"attentionList"];
                    //                DLog(@"%@",array);
                    //遍历数组中的字典
                    for (NSDictionary *dict in array) {
                        self.pModel = [ProductModel new];
                        [self.pModel setValuesForKeysWithDictionary:dict];
                        
                        if([self.productID isEqualToString:dict[@"product_id"]]) {
                            
                            self.downView.firstImage.image = [UIImage imageNamed:@"6-已关注"];
                            self.downView.firstLabel.text = @"已收藏";
                            self.downView.firstLabel.textColor = [UIColor colorWithRed:255/255.0 green:153/255.0 blue:102/255.0 alpha:1];
                            _isCollect = YES;
                            
                        }
                        
                        
                    }
                    
                }
                
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }else{
        self.downView.firstImage.image = [UIImage imageNamed:@"关注"];
        self.downView.firstLabel.text = @"收藏";
        self.downView.firstLabel.textColor = [UIColor grayColor];
    }
    
}
#pragma mark *****创建 MidleView *******
- (void)creatMidleView:(NSInteger) num{
    
    //添加 MiddleView 行程介绍和产品特色
    self.middleView = [[MiddleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backView.frame), UISCREEN_WIDTH,UISCREEN_HEIGHT / 5 * num)];
    self.middleView.hidden = NO;
    self.middleView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.middleView];
    
    
    // ******行程详情*****
    //调用计算 Cell总高度的方法,为 DetailTableView的 frame 赋值
    [self allCellHeight];
    self.DetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.topView.frame) + self.backView.bounds.size.height, UISCREEN_WIDTH, _heigthOfCell) style:UITableViewStylePlain];
    self.DetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //添加代理
    self.DetailTableView.delegate = self;
    self.DetailTableView.dataSource = self;
    self.DetailTableView.hidden = YES;
    self.DetailTableView.scrollEnabled = NO;
    [self.DetailTableView reloadData];
    //注册 cell
    [self.DetailTableView registerClass:[ShortViewCell class] forCellReuseIdentifier:@"shortcell"];
    [self.scrollView addSubview:self.DetailTableView];
    
    
    
    if (num <= 1) {
        
        self.DetailTableView.hidden = NO;
        self.middleView.hidden = YES;
        
        if ([self judgeString:_productModel.travel_tag] == YES) {
           
            if ([self judgeString:_productModel.businesslicNo] == NO) {
                 self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT * 2 - UISCREEN_WIDTH / 1.1 + _heigthOfCell - UISCREEN_HEIGHT / 16 - UISCREEN_HEIGHT / 88.75 - UISCREEN_HEIGHT / 51.6 * 2);
            }else{
                 self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT * 2 - UISCREEN_WIDTH / 1.1 + _heigthOfCell - UISCREEN_HEIGHT / 16);
            }
            
        }else{
            if ([self judgeString:_productModel.businesslicNo] == NO) {
                 self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT * 2 - UISCREEN_WIDTH / 1.1 + _heigthOfCell - UISCREEN_HEIGHT / 16 * 2 - - UISCREEN_HEIGHT / 88.75 - UISCREEN_HEIGHT / 51.6 * 3);
            }else{
                
                 self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT * 2 - UISCREEN_WIDTH / 1.1 + _heigthOfCell - UISCREEN_HEIGHT / 16 * 2 - UISCREEN_HEIGHT / 51.6);
            }
        }
        
    }else{
        for (int i = 0; i < num; i++) {
            ProductModel *model = self.midleArr[i];
            self.mView = [[MView alloc]initWithFrame:CGRectMake(0, UISCREEN_HEIGHT / 5 * i, UISCREEN_WIDTH,[MView cellHeight:model])];
            [self.mView assignValueWithModel:model];
            [self.middleView addSubview:self.mView];
            if (i == 0) {
                
                self.mView.lineLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /18.4 /2, CGRectGetMaxY(self.mView.locationImage.frame) - 2, 0.4, CGRectGetHeight(self.mView.frame))];
                self.mView.lineLable.backgroundColor = [UIColor greenColor];
                [self.mView addSubview:self.mView.lineLable];
                
                
            }else if (i > 0 && i < num - 1) {
                self.mView.locationImage.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /19.2 / 2.9, UISCREEN_HEIGHT / 23.5, UISCREEN_WIDTH / 90.65 * 2, UISCREEN_WIDTH / 90.65 * 2);
                self.mView.locationImage.image = [UIImage imageNamed:@"椭圆-26-副本"];
                
                UILabel *pointLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /18.4 /2, CGRectGetMaxY(self.mView.locationImage.frame), 0.4, CGRectGetHeight(self.mView.frame))];
                pointLable.backgroundColor = [UIColor greenColor];
                [self.mView addSubview:pointLable];
                
                
            }else if(i == num - 1){
                self.mView.locationImage.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /19.2 / 2.9, UISCREEN_HEIGHT / 23.5, UISCREEN_WIDTH / 90.65 * 2, UISCREEN_WIDTH / 90.65 * 2);
                self.mView.locationImage.image = [UIImage imageNamed:@"椭圆-26-副本"];
                
                UILabel *pointLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /18.4 /2, CGRectGetMaxY(self.mView.locationImage.frame), 0.4, CGRectGetHeight(self.mView.frame) - UISCREEN_HEIGHT / 14.2)];
                pointLable.backgroundColor = [UIColor greenColor];
                [self.mView addSubview:pointLable];
                
                
                
                
            }
        }
        if ([self judgeString:_productModel.travel_tag] == NO) {
            self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT * 2 - UISCREEN_WIDTH / 2.2 + (num - 1) * UISCREEN_HEIGHT / 5 - 8 - UISCREEN_HEIGHT / 14 - UISCREEN_HEIGHT / 28 - UISCREEN_WIDTH / 16);
        }else{
            self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT * 2 - UISCREEN_WIDTH / 2.2 + (num - 1) * UISCREEN_HEIGHT / 5 - 8 - UISCREEN_HEIGHT / 14);
        }
    }
    
    
    //相关 Button关联事件
    
    //查看详情与简略行程按钮
    self.changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeBtn.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 8, UISCREEN_HEIGHT /1.5, UISCREEN_WIDTH / 10, UISCREEN_WIDTH / 10);
    self.changeBtn.tag = 201;
    self.changeBtn.hidden = YES;
    [self.changeBtn setBackgroundImage:[UIImage imageNamed:@"查看详情"] forState:UIControlStateNormal];
    [self.changeBtn setTitle:@"查看详情" forState:UIControlStateNormal];
    self.changeBtn.titleLabel.numberOfLines = 0;
    self.changeBtn.titleLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 29];
    //简略与详情 Button
    [self.changeBtn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.changeBtn];
    
    //添加最简行程 Button
    self.proximalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.proximalBtn.frame = CGRectMake(CGRectGetMinX(self.changeBtn.frame), CGRectGetMaxY(self.changeBtn.frame)+UISCREEN_WIDTH / 80, UISCREEN_WIDTH / 10, UISCREEN_WIDTH /10);
    //设置属性
    self.proximalBtn.tag = 202;
    self.proximalBtn.hidden = YES;
    [self.proximalBtn setBackgroundImage:[UIImage imageNamed:@"简略行程"] forState:UIControlStateNormal];
    
    //添加关联事件
    [self.proximalBtn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.proximalBtn];
    
    
    //*******景点介绍*******
    self.scenicView = [[ScenicView alloc]init];
    self.scenicView.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame) + 1, UISCREEN_WIDTH, [ScenicView lableHeight:_productModel]);
    [_scenicView assignValueWithModel:_productModel];
    self.scenicView.hidden = YES;
    self.scenicView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.scenicView];
    
    
    
}

#pragma mark ********管家列表**********
- (void)clickDownButton:(UIButton *)sender{
    
    if (sender.tag == 301) {
        
        //判断会员登录状态
        NSString * user_id = [[[LXUserTool alloc] init] getUid];
        if (user_id == nil) {
            LoginAndRegisterViewController * vc = [[LoginAndRegisterViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        
        if(_isCollect){
            
            //取消收藏
            
            NSString *collectStr = COLLECT_NET;
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            //1 取消收藏 ， 0 收藏
            NSDictionary *parameters = @{@"member_id":user_id,@"product_id":self.productID,@"product_type":self.productModel.route_type,@"is_delete":@"1"};
            [manager POST:collectStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                
                self.downView.firstImage.image = [UIImage imageNamed:@"关注"];
                self.downView.firstLabel.text = @"收藏";
                self.downView.firstLabel.textColor = [UIColor grayColor];
                [[LXAlterView sharedMyTools] createTishi:[dictionary objectForKey:@"msg"]];
                
                if ([self.delegate respondsToSelector:@selector(productDetailControllerWith:)]) {
                    [self.delegate productDetailControllerWith:self.productID];
                }else
                {
                    NSLog(@"没有实现代理");
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [[LXAlterView sharedMyTools] createTishi:@"取消失败"];
            }];
            
            
            
        }else{
            
            //收藏成功
            
            NSString *collectStr = COLLECT_NET;
            
            NSDictionary *parameters = @{@"member_id":user_id,@"product_id":self.productID,@"product_type":self.productModel.route_type,@"is_delete":@"0"};
            
            
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            
            
            [manager POST:collectStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                
                self.downView.firstImage.image = [UIImage imageNamed:@"6-已关注"];
                self.downView.firstLabel.text = @"已收藏";
                self.downView.firstLabel.textColor = [UIColor colorWithRed:255/255.0 green:153/255.0 blue:102/255.0 alpha:1];
                [[LXAlterView sharedMyTools] createTishi:[dictionary objectForKey:@"msg"]];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
                [[LXAlterView sharedMyTools] createTishi:@"收藏失败"];
            }];
            
        }
        _isCollect = !_isCollect;
        
    }else if(sender.tag == 302){
        
        //合伙人登录,则咨询自身绑定的管家的电话
        if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember && [[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteward]) {
            
            NSString *url = [houseDetailUrl([[LXUserTool alloc] getKeeper])stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
             {
                 NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                 
                 NSString * telString = [NSString stringWithFormat:@"tel:%@", [[dic objectForKey:@"data"]objectForKey:@"mobile"]];
                 DLog(@"%@", [[dic objectForKey:@"data"]objectForKey:@"mobile"]);
                 NSURL * telUrl = [NSURL URLWithString:telString];
                 [[UIApplication sharedApplication] openURL:telUrl];
             }failure:^(AFHTTPRequestOperation *operation,NSError *error){
                 DLog(@"%@", error);
                 
             }];
            
        }else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
            
            //管家登录状态,则咨询行政电话
            NSString *mobileStr = [NSString stringWithFormat:@"tel:%@",_productModel.admin_mobile];
            NSURL *url = [NSURL URLWithString:mobileStr];
            [[UIApplication sharedApplication] openURL:url];
            
        }else{
            //新版管家列表
//                        ButlerViewController *butlerVC = [[ButlerViewController alloc]initWithStyle:UITableViewStylePlain];
//                        //客服电话
//                        butlerVC.admin_Mobile = self.productModel.admin_mobile;
//                        butlerVC.admin_ID = self.productModel.admin_id;
//                        butlerVC.navigationController.navigationBar.hidden = NO;
//                        [self.navigationController pushViewController:butlerVC animated:YES];
            
//            会员未绑定管家,则进入管家列表页
            ZFJCallStewardVC * callStewardVC = [[ZFJCallStewardVC alloc] init];
            callStewardVC.admin_id = _productModel.admin_id;
            callStewardVC.admin_Mobile = _productModel.admin_mobile;
            [self.navigationController pushViewController:callStewardVC animated:YES];
        }
        
    }else if(sender.tag == 303){
        //        NSLog(@"立即预订");
#pragma mark ------------------------立即预定按钮-------------------
        
        TravelCalendarViewController *calendarVC = [[TravelCalendarViewController alloc]init];
        calendarVC.orderModel = self.orderModel;
        calendarVC.loopArray = [NSMutableArray array];
        calendarVC.shop_id=self.shop_id;
        [calendarVC.loopArray addObjectsFromArray:self.loopArray];
        [self.navigationController pushViewController:calendarVC animated:YES];
        
    }
}

/**
 *  ScrollView 的代理方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.scrollView) {
        if (_scrollView.contentOffset.y <= 0) {
            
            self.headerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
            self.titleLable.alpha = 0.0;
            self.lineLable.alpha = 0.0;
            
        }else{
            CGFloat xx = _scrollView.contentOffset.y / 200;
            self.lineLable.alpha = xx;
            self.titleLable.alpha = xx;
            self.headerView.backgroundColor = [UIColor colorWithWhite:xx alpha:xx];
    
        }
        
        if (100 < _scrollView.contentOffset.y) {
            
            UIImage *image = [UIImage imageNamed:@"back"];
            if (UISCREEN_WIDTH == 320) {
                self.backButton.frame = CGRectMake(UISCREEN_WIDTH/ 35.55 * 2, 64 / 2.3, 15, 25);
                  self.shareButton.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 35.55 - 30, 64 / 2.6, 32, 32);

                
            }else{
                self.backButton.frame = CGRectMake(UISCREEN_WIDTH/ 35.55 * 2, 64 / 2.2, image.size.width, image.size.height);
                
            }
            
            
            [self.backButton setImage:image forState:UIControlStateNormal];
            
            UIImage *shareImage = [UIImage imageNamed:@"分享-2"];
            
            if (UISCREEN_WIDTH == 320) {
                self.shareButton.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 35.55 - 30, 64 / 2.6, 30, 30);
                
            }else{
                self.shareButton.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 35.55 - shareImage.size.width, 64 / 2.6, shareImage.size.width, shareImage.size.height);
                
            }

            
            [self.shareButton setImage:[UIImage imageNamed:@"分享-2"] forState:UIControlStateNormal];
            
            DLog(@"%@",NSStringFromCGSize(_shareButton.frame.size));
        }else{
            
            UIImage *backImage = [UIImage imageNamed:@"返回按钮"];
            if (UISCREEN_WIDTH == 320) {
                self.backButton.frame = CGRectMake(UISCREEN_WIDTH/ 35.55, 64 / 2.6, 30, 30);
                
            }else{
                self.backButton.frame = CGRectMake(UISCREEN_WIDTH/ 35.55, 64 / 2.6, backImage.size.width, backImage.size.height);
                
            }
            
            [self.backButton setImage:backImage forState:UIControlStateNormal];
            
            UIImage *image = [UIImage imageNamed:@"分享"];
            if (UISCREEN_WIDTH == 320) {
                self.shareButton.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 35.55 - 30, 64 / 2.6, 30, 30);
                
            }else{
                self.shareButton.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 35.55 - image.size.width, 64 / 2.6, image.size.width, image.size.height);
                
            }
            
            [self.shareButton setImage:image forState:UIControlStateNormal];
            
            
        }
        if (_scrollView.contentOffset.y >= self.midMinY - 84) {
            
            
            if (self.middleView.hidden == NO) {
                self.changeBtn.hidden = NO;
                self.proximalBtn.hidden = NO;
                self.dayViewControl.view.hidden = YES;
            }else if(self.DetailTableView.hidden == NO && self.midleArr.count > 1){
                
                self.changeBtn.hidden = NO;
                self.proximalBtn.hidden = NO;
                self.dayViewControl.view.hidden = NO;
                
                for (int i = 0; i < self.midleArr.count; i++) {
                    if (i < self.midleArr.count - 1) {
                        CGFloat y = [self.yArray[i] floatValue];
                        CGFloat secY = [self.yArray[i + 1] floatValue];
                        if (_scrollView.contentOffset.y >= y - 84 && _scrollView.contentOffset.y <= secY - 84) {
                            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
                            DayListViewCell *cell = [_tableView cellForRowAtIndexPath:index];
                         cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            cell.selected = YES;
                            cell.dayLable.frame = CGRectMake(0, 0, UISCREEN_HEIGHT / 17.75, UISCREEN_HEIGHT / 21.846);
                            
                            if (self.selectindex != index) {
                                DayListViewCell *beforcell = [_tableView cellForRowAtIndexPath:_selectindex];
                                beforcell.selected = NO;
                                beforcell.dayLable.frame = CGRectMake(6, 0, UISCREEN_HEIGHT / 21.846, UISCREEN_HEIGHT / 21.846);
                                _selectindex = index;
                            }
                        }
                    }else if(i == self.midleArr.count - 1){
                        
                        CGFloat y = [self.yArray.lastObject floatValue];
                      
                        if (_scrollView.contentOffset.y >= y - 84) {
                            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
                            DayListViewCell *cell = [_tableView cellForRowAtIndexPath:index];
                            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                            cell.selected = YES;
                            cell.dayLable.frame = CGRectMake(0, 0, UISCREEN_HEIGHT / 17.75, UISCREEN_HEIGHT / 21.846);
                            
                            if (self.selectindex != index) {
                                DayListViewCell *beforcell = [_tableView cellForRowAtIndexPath:_selectindex];
                                beforcell.selected = NO;
                                beforcell.dayLable.frame = CGRectMake(6, 0, UISCREEN_HEIGHT / 21.846, UISCREEN_HEIGHT / 21.846);
                                _selectindex = index;
                            }
                        }

                        
                    }
                    
                    
                }
                
                
                
            }else if(self.scenicView.hidden == NO){
                self.changeBtn.hidden = YES;
                self.proximalBtn.hidden = YES;
                self.dayViewControl.view.hidden = YES;
            }
            
            self.backView.frame = CGRectMake(0,scrollView.contentOffset.y + 84, UISCREEN_WIDTH, UISCREEN_HEIGHT / 16.7);
            
        }else{
            
            if (self.middleView.hidden == NO) {
                self.changeBtn.hidden = YES;
                self.proximalBtn.hidden = YES;
                self.dayViewControl.view.hidden = YES;
            }else if(self.DetailTableView.hidden == NO){
                
                self.changeBtn.hidden = YES;
                self.proximalBtn.hidden = YES;
                self.dayViewControl.view.hidden = YES;
                
            }else if(self.scenicView.hidden == NO){
                self.changeBtn.hidden = YES;
                self.proximalBtn.hidden = YES;
                self.dayViewControl.view.hidden = YES;
                
            }
            
            self.backView.frame = CGRectMake(0, self.midMinY, UISCREEN_WIDTH, UISCREEN_HEIGHT /16.7);
        }
        [self.scrollView bringSubviewToFront:self.backView];
        
    }else if(scrollView == self.tableView){
        
        self.backView.frame = CGRectMake(0,_scrollView.contentOffset.y + 84, UISCREEN_WIDTH, UISCREEN_HEIGHT / 16.7);
        
    }
}

#pragma mark *********页面相关 /Users/zhangziqian/Desktop/WelLv-main-2016_1_13/WelLv/Class/Main/Controller/About Travel/TravelProductDetailButton 关联事件 ********
#pragma mark *********页面相关 Button 关联事件 ********
- (void)clickButtonAction:(UIButton *)button{
    
    if (button.tag == 101) {
        
        
        //最近团期
        TravelCalendarViewController *calendarVC = [[TravelCalendarViewController alloc]init];
        calendarVC.orderModel = self.orderModel;
        calendarVC.loopArray = [NSMutableArray array];
        [calendarVC.loopArray addObjectsFromArray:self.loopArray];
        [self.navigationController pushViewController:calendarVC animated:YES];
        
        
        
    }else if(button.tag == 102){
        //********行程介绍*********
        [UIView animateWithDuration:0.5 animations:^{
            self.backView.lineImage.frame = CGRectMake(UISCREEN_WIDTH /10, CGRectGetMaxY(self.backView.longLine.frame) - 2, ([UIScreen mainScreen].bounds.size.width - 20) /3, 4);
        }];
        [self.backView.firstButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.backView.secondButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        if (self.midleArr.count <= 1) {
            //改变视图的属性
            self.dayViewControl.view.hidden = YES;
            self.DetailTableView.hidden = NO;
            self.scenicView.hidden = YES;
            self.middleView.hidden = YES;
            self.changeBtn.hidden = YES;
            self.proximalBtn.hidden = YES;
            
            
            //改变 scrollView 的 contentSize的
            self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, UISCREEN_HEIGHT * 2 - UISCREEN_HEIGHT / 1.8 + self.DetailTableView.bounds.size.height - 20);
            self.nextView.frame = CGRectMake(0, CGRectGetMaxY(self.DetailTableView.frame) + UISCREEN_HEIGHT / 43, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 15);
            
            self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.nextView.frame) + UISCREEN_HEIGHT / 43, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2.5);
            
        }else{
            //改变视图的属性
            self.dayViewControl.view.hidden = YES;
            self.DetailTableView.hidden = YES;
            self.scenicView.hidden = YES;
            self.middleView.hidden = NO;
            self.changeBtn.hidden = NO;
            self.proximalBtn.hidden = NO;
            [self.changeBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            self.changeBtn.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 8, UISCREEN_HEIGHT /1.5, UISCREEN_WIDTH / 10, UISCREEN_WIDTH / 10);
            
            self.proximalBtn.frame = CGRectMake(CGRectGetMinX(self.changeBtn.frame), CGRectGetMaxY(self.changeBtn.frame)+UISCREEN_WIDTH / 80, UISCREEN_WIDTH / 10, UISCREEN_WIDTH /10);
            
            
            //改变 scrollView 的 contentSize的
            self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, UISCREEN_HEIGHT * 2 - UISCREEN_HEIGHT / 1.8 + UISCREEN_HEIGHT / 5 * self.argumentNum - 20);
            self.nextView.frame = CGRectMake(0, CGRectGetMaxY(self.middleView.frame) + UISCREEN_HEIGHT / 43, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 15);
            
            self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.nextView.frame) + UISCREEN_HEIGHT / 43, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2.5);
            
        }
        
        
        
    }else if(button.tag == 103){
        //*******产品特色*******
        [UIView animateWithDuration:0.5 animations:^{
            self.backView.lineImage.frame = CGRectMake(CGRectGetMaxX(self.backView.firstButton.frame) + UISCREEN_WIDTH / 10.6, CGRectGetMaxY(self.backView.longLine.frame)- 2 , ([UIScreen mainScreen].bounds.size.width - 20) /3, 4);
        }];
        [self.backView.firstButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.backView.secondButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.dayViewControl.view.hidden = YES;
        self.changeBtn.hidden = YES;
        self.proximalBtn.hidden = YES;
        self.middleView.hidden = YES;
        self.scenicView.hidden = NO;
        self.DetailTableView.hidden = YES;
        
        //点击按钮时改变模块的大小
        self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, self.topView.bounds.size.height + self.scenicView.bounds.size.height + self.backView.bounds.size.height + self.nextView.bounds.size.height + self.collectionView.bounds.size.height + UISCREEN_HEIGHT / 43.67 * 3);
        self.nextView.frame = CGRectMake(0, CGRectGetMaxY(self.scenicView.frame) + UISCREEN_HEIGHT / 43.67, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 15);
        self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.nextView.frame) + UISCREEN_HEIGHT / 43.67, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2.5);
        
    }else if(button.tag == 104){
#pragma mark ---------------------预定须知跳转------------------------------
   
        self.payway = @"<br>本平台产品通过支付宝、微信等第三方平台进行付款交易。<br/>";
 
//        NSString *content = [NSString stringWithFormat:@"<span style=color:#ff9600;>费用包含</span><span style=color:#ff9600;></span>%@<span style=color:#ff9600;>费用不包含</span><span style=color:#ff9600;></span>\n%@<span style=color:#ff9600;>付款方式</span>\n<span style=color:#ff9600;></span><br>%@<br/>\n<span style=color:#ff9600;>特殊限制</span><span style=color:#ff9600;></span><br>%@<br/><span style=color:#ff9600;>温馨提示</span><span style=color:#ff9600;></span><br>%@<br/><span style=color:#ff9600;>预定须知</span><span style=color:#99BB00;></span><br>%@",self.fee_include,self.fee_not_include,self.payway,self.special_limit,self.warm_prompt,self.sign_way];
//        
//        
        NSString *content =@"";
        //费用包含
        self.fee_include=[self judgeReturnString:self.fee_include withReplaceString:@""];
        
        if (![self.fee_include isEqualToString:@""]) {
            content=[content stringByAppendingString:[NSString stringWithFormat:@"<span style=color:#ff9600;>费用包含</span><span style=color:#ff9600;></span>%@",self.fee_include]];
        }
        //费用不包含
        self.fee_not_include=[self judgeReturnString:self.fee_not_include withReplaceString:@""];
        
        if (![self.fee_not_include isEqualToString:@""]) {
            content=[content stringByAppendingString:[NSString stringWithFormat:@"<span style=color:#ff9600;>费用不包含</span><span style=color:#ff9600;></span>\n%@",self.fee_not_include
                                                      ]];
        }
        //付款方式
        self.payway=[self judgeReturnString:self.payway withReplaceString:@""];
        
        if (![self.payway isEqualToString:@""]) {
            content=[content stringByAppendingString:[NSString stringWithFormat:@"<span style=color:#ff9600;>付款方式</span>\n<span style=color:#ff9600;></span><br>%@<br/>\n",self.payway
                                                      ]];
        }
        //特殊限制
        self.special_limit=[self judgeReturnString:self.special_limit withReplaceString:@""];
        
        if ((![self.special_limit isEqualToString:@""]&&self.special_limit!=nil)) {
            content=[content stringByAppendingString:[NSString stringWithFormat:@"<span style=color:#ff9600;>特殊限制</span><span style=color:#ff9600;></span><br>%@<br/>",self.special_limit
                                                      ]];
        }
        //温馨提示
        self.warm_prompt=[self judgeReturnString:self.warm_prompt withReplaceString:@""];
        
        if (![self.warm_prompt isEqualToString:@""]) {
            content=[content stringByAppendingString:[NSString stringWithFormat:@"<span style=color:#ff9600;>温馨提示</span><span style=color:#ff9600;></span><br>%@<br/>",self.warm_prompt
                                                      ]];
        }
        //预定须知
        self.sign_way=[self judgeReturnString:self.sign_way withReplaceString:@""];
        
        if (![self.sign_way isEqualToString:@""]) {
            content=[content stringByAppendingString:[NSString stringWithFormat:@"<span style=color:#ff9600;>预定须知</span><span style=color:#99BB00;></span><br>%@",self.sign_way
                                                      ]];
        }
        
        YXWebDetailViewController *webVC = [[YXWebDetailViewController alloc] init];
        webVC.webContent = content;
        webVC.WebTitle = @"费用&预定须知";
        [self.navigationController pushViewController:webVC animated:YES];
        
        
        
        
    }else if(button.tag == 201){
        if (_isChange) {
            [self.changeBtn setTitle:@"简略行程" forState:UIControlStateNormal];
            
            self.DetailTableView.hidden = NO;
            self.middleView.hidden  = YES;
            self.scenicView.hidden = YES;
            self.changeBtn.hidden = NO;
            self.proximalBtn.hidden = NO;
            
            
            //展示天数列表
            self.dayViewControl = [ChooseDayViewController new];
            
            if (self.midleArr.count <= 1) {
                
                self.dayViewControl.view.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 10, 74 + UISCREEN_HEIGHT / 16.7 , UISCREEN_WIDTH / 10, UISCREEN_HEIGHT / 19.93);
                
                
            }else if(self.midleArr.count <= 11){
                self.dayViewControl.view.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 10,  74 + UISCREEN_HEIGHT / 16.7 , UISCREEN_WIDTH / 10, UISCREEN_HEIGHT / 17 * self.midleArr.count);
                
            }else{
                self.dayViewControl.view.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 10,  74 + UISCREEN_HEIGHT / 16.7 , UISCREEN_WIDTH / 10, UISCREEN_HEIGHT / 17 * 11);
            }
            
            /*
             [self 计算高度];
             
             */
            
            
            //添加 tableView 用来展示D1,D2,D3,D4,D5.....
            [self addChildViewController:self.dayViewControl];
            [self creatTableView];
            [self.view addSubview:self.dayViewControl.view];
            
            
            self.changeBtn.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 8, CGRectGetMaxY(self.dayViewControl.view.frame) + UISCREEN_HEIGHT / 56.8 , UISCREEN_WIDTH / 10, UISCREEN_WIDTH / 10);
            [self.view addSubview:self.changeBtn];
            
            self.proximalBtn.frame = CGRectMake(CGRectGetMinX(self.changeBtn.frame), CGRectGetMaxY(self.changeBtn.frame)+UISCREEN_WIDTH / 80, UISCREEN_WIDTH / 10, UISCREEN_WIDTH /10);
            [self.view addSubview:self.proximalBtn];
            
            [self.view bringSubviewToFront:self.changeBtn];
            [self.view bringSubviewToFront:self.proximalBtn];
            
            self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.topView.bounds.size.height + UISCREEN_HEIGHT / 43.67 * 3 + self.backView.bounds.size.height + self.nextView.bounds.size.height + self.collectionView.bounds.size.height + self.DetailTableView.bounds.size.height);
            self.nextView.frame = CGRectMake(0, CGRectGetMaxY(self.DetailTableView.frame) + UISCREEN_HEIGHT / 43.67, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 15);
            self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.nextView.frame) + UISCREEN_HEIGHT / 43.67, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2.5);
            
            
        }else{
            
            
            [self.changeBtn setTitle:@"查看详情" forState:UIControlStateNormal];
            self.dayViewControl.view.hidden = YES;
            self.middleView.hidden = NO;
            self.DetailTableView.hidden = YES;
            self.scenicView.hidden = YES;
            self.changeBtn.hidden = NO;
            self.proximalBtn.hidden = NO;
            
            self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, UISCREEN_HEIGHT * 2 - UISCREEN_HEIGHT / 1.737 + self.middleView.bounds.size.height - 20);
            
            self.nextView.frame = CGRectMake(0, CGRectGetMaxY(self.middleView.frame) + UISCREEN_HEIGHT / 43, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 15);
            self.collectionView.frame = CGRectMake(0, CGRectGetMaxY(self.nextView.frame) + UISCREEN_HEIGHT / 43, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 2.5);
            
            self.changeBtn.frame = CGRectMake(UISCREEN_WIDTH - UISCREEN_WIDTH / 8, 64 + UISCREEN_HEIGHT / 16.7 + UISCREEN_HEIGHT / 16.7, UISCREEN_WIDTH / 10, UISCREEN_WIDTH / 10);
            self.proximalBtn.frame = CGRectMake(CGRectGetMinX(self.changeBtn.frame), CGRectGetMaxY(self.changeBtn.frame)+UISCREEN_WIDTH / 80, UISCREEN_WIDTH / 10, UISCREEN_WIDTH /10);
            
        }
        _isChange = !_isChange;
        
    }else if(button.tag == 202){
        //        最简行程页面
        
        self.proximalView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, UISCREEN_WIDTH, UISCREEN_HEIGHT -64)];
        self.proximalView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT *1.8);
        self.proximalView.backgroundColor = [UIColor blackColor];
        self.proximalView.alpha = 0.7;
        
        for (int i = 0 ; i < _argumentNum; i++) {
            ProductModel *model = self.midleArr[i];
            UIImageView *ellipseImage = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 40, UISCREEN_HEIGHT / 19.58 + i * (UISCREEN_HEIGHT / 15), UISCREEN_WIDTH / 45.7, UISCREEN_WIDTH /45.7)];
            ellipseImage.image = [UIImage imageNamed:@"椭圆-26-副本"];
            
            //调用计算标题高度的方法
            [self titleLabelHeight:model.title];
            
            [self.proximalView addSubview:ellipseImage];
            UILabel *journeyLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(ellipseImage.frame) + UISCREEN_WIDTH / 29.09, CGRectGetMinY(ellipseImage.frame) - 4,UISCREEN_WIDTH / 1.1, _titleHeight)];
            journeyLable.numberOfLines = 0;
            journeyLable.text = [NSString stringWithFormat:@"第%@天  %@",model.day,model.title];
            journeyLable.textColor = [UIColor whiteColor];
            journeyLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 24.6];
            
            [self.proximalView addSubview:journeyLable];
        }
        
        //添加一个手势,返回主页面
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeFromSuperView)];
        [self.proximalView addGestureRecognizer:tapGesture];
        [self.view addSubview:self.proximalView];
        
    }
    
    
}
#pragma mark *********计算标题的高度*********
- (void)titleLabelHeight:(NSString *)title{
    
    CGSize contextSize = CGSizeMake(UISCREEN_WIDTH / 1.5, 0);
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:UISCREEN_WIDTH / 24.6]};
    CGRect titleRect = [title boundingRectWithSize:contextSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    self.titleHeight = titleRect.size.height;
}


#pragma mark **********计算所有 Cell的高度和*******
-(void)allCellHeight
{
    CGFloat allCellHeight = 0;
    
    CGFloat cellY = UISCREEN_HEIGHT / 1.15;
    NSMutableArray *beforCellH = [NSMutableArray array];
    CGFloat a = 0;
    for (int i = 0; i < self.midleArr.count; i++) {
        
        ProductModel *modle = self.midleArr[i];
        
        NSArray *arrar = self.dataDictionary[[NSString stringWithFormat:@"%d",i]];
        
        if ([self judgeString:arrar.firstObject] == YES) {
            
            a = [ShortViewCell cellHeight:modle] + UISCREEN_HEIGHT / 7.88;
            
        }else{
            a = [ShortViewCell cellHeight:modle];
            
        }
        
        [beforCellH addObject:[NSNumber numberWithFloat:a]];
        if (i == 0) {
            if ([self judgeString:_productModel.travel_tag] == NO) {
                cellY = UISCREEN_HEIGHT / 1.15 - UISCREEN_HEIGHT / 28 - UISCREEN_HEIGHT / 16;
            }else{
                cellY = UISCREEN_HEIGHT / 1.15;
            }
        }
        else
        {
            cellY = cellY + [beforCellH[i-1] floatValue];
        }
        
        NSNumber *number = [NSNumber numberWithFloat:cellY];
        [self.yArray addObject:number];
        
        allCellHeight = allCellHeight + a;
        
    }
    
    
    self.heigthOfCell = allCellHeight;
    
}

#pragma mark -------------------预定须知相关内容-------------------------------
/**
 *关于预定须知  勿删
 */

//获取数据并解析
- (void)getDataFromURL {
    
    
    NSDictionary *parameters = @{@"pid":self.productID};
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:kTravelNoctioceUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *firstDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dataDic = firstDic[@"data"];
        NSDictionary *productDic = dataDic[@"product_info"];
        if (productDic[@"fee_include"] != [NSNull null]) {
            //            [self.dataDic setValue:productDic[@"fee_include"] forKey:@"fee_include"];
            self.fee_include = productDic[@"fee_include"];
        }
        if (productDic[@"fee_not_include"] != [NSNull null]) {
            //            [self.dataDic setValue:productDic[@"fee_not_include"] forKey:@"fee_not_include"];
            self.fee_not_include = productDic[@"fee_not_include"];
            
        }
        if (productDic[@"special_limit"] != [NSNull null]) {
            //            [self.dataDic setValue:productDic[@"special_limit"] forKey:@"special_limit"];
            self.special_limit = productDic[@"special_limit"];
        }
        if (productDic[@"warm_prompt"] != [NSNull null]) {
            //            [self.dataDic setValue:productDic[@"warm_prompt"] forKey:@"warm_prompt"];
            self.warm_prompt = productDic[@"warm_prompt"];
        }
        if (productDic[@"sign_way"] != [NSNull null]) {
            //            [self.dataDic setValue:productDic[@"sign_way"] forKey:@"sign_way"];
            self.sign_way = productDic[@"sign_way"];
        }
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        nil;
    }];
}


/**
 *  最简行程界面轻拍手势事件
 */
- (void)removeFromSuperView{
    
    [self.proximalView removeFromSuperview];
    
}

#pragma mark *******TableView,显示 D1,D2,D3,D4,D5*******
- (void)creatTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:self.dayViewControl.view.bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    //添加代理
    self.tableView.delegate = self;
    //忽略了这一步,导致无法显示,引以为戒
    self.tableView.dataSource = self;
    //注册 cell
    [self.tableView registerClass:[DayListViewCell class] forCellReuseIdentifier:@"tableCell"];
    
    [self.dayViewControl.view addSubview:self.tableView];
    //这也一步也是经常会被忽略,细节,细节,细节
    //    [self.tableView reloadData];
}

#pragma mark ********tableView 的数据源代理*********
/**
 *  TableView 的数据源代理
 */
//返回分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//返回分区中 Cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.midleArr.count;
    
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
        DayListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];

        cell.separatorInset = UIEdgeInsetsZero;
        if (indexPath.row == 0) {
            cell.selected = YES;
            
        }else{
            cell.selected = NO;
        }
        ProductModel *model= self.midleArr[indexPath.row];
        
        cell.dayLable.text = [NSString stringWithFormat:@"D%@",model.day];
        cell.dayLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 29];
        cell.dayLable.textAlignment = NSTextAlignmentCenter;
        return cell;
        
    }else{
        ShortViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shortcell" forIndexPath:indexPath];
        
        ProductModel *model = self.midleArr[indexPath.row];
        
        [cell assignValueWithModel:model];
        
        if (indexPath.row == 0) {
            if ([self judgeString:model.albums] == YES) {
                cell.lineLable.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /17.58 /2 , CGRectGetMaxY(cell.locationImage.frame), 0.4, [ShortViewCell cellHeight:model] + UISCREEN_HEIGHT /7.88 - UISCREEN_WIDTH / 16 );
            }else{
                cell.lineLable.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /17.58 /2 , CGRectGetMaxY(cell.locationImage.frame), 0.4, [ShortViewCell cellHeight:model] - UISCREEN_WIDTH / 8);
            }
           
        }else if (indexPath.row > 0 && indexPath.row < self.midleArr.count - 1) {
           
            if ([self judgeString:model.albums] == YES) {
                cell.lineLable.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /17.58 /2 , 0, 0.4, [ShortViewCell cellHeight:model] + UISCREEN_HEIGHT /7.88 );
            }else{
                cell.lineLable.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /17.58 /2 , 0, 0.4, [ShortViewCell cellHeight:model] - UISCREEN_WIDTH / 16);
            }
            cell.locationImage.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /19.2 / 2.9, UISCREEN_HEIGHT / 23.5, UISCREEN_WIDTH / 90.65 * 2, UISCREEN_WIDTH / 90.65 * 2);
            cell.locationImage.image = [UIImage imageNamed:@"椭圆-26-副本"];
       
        }else if(indexPath.row == self.midleArr.count - 1){
            
            if ([self judgeString:model.albums] == YES) {
                cell.lineLable.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /17.58 /2 , 0, 0.4, [ShortViewCell cellHeight:model] );
            }else{
                cell.lineLable.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /17.58 /2 , 0, 0.4, [ShortViewCell cellHeight:model] - 7);
            }

            cell.locationImage.frame = CGRectMake(UISCREEN_WIDTH / 40 + UISCREEN_WIDTH /19.2 / 2.9, UISCREEN_HEIGHT / 23.5, UISCREEN_WIDTH / 90.65 * 2, UISCREEN_WIDTH / 90.65 * 2);
            cell.locationImage.image = [UIImage imageNamed:@"椭圆-26-副本"];
           
        }
        
        NSArray *array = self.dataDictionary[[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        for (int i = 0; i < array.count; i++) {
            cell.albumsImage = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(cell.webLable.frame) + i * (UISCREEN_WIDTH /2.72+ UISCREEN_WIDTH / 26.66), CGRectGetMaxY(cell.webLable.frame), UISCREEN_WIDTH / 2.72, UISCREEN_HEIGHT / 7.88)];
            
            if ([[array[i] picture] hasPrefix:@"http"]) {
                [cell.albumsImage sd_setImageWithURL:[NSURL URLWithString:[array[i] picture]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
            }else{
                [cell.albumsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WLHTTP,[array[i] picture]]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
            }
            cell.albumsImage.layer.cornerRadius = 2;
            cell.albumsImage.layer.masksToBounds = YES;
            [cell.contentView addSubview:cell.albumsImage];
        }
        
        
        return cell;
    }
    
    
}

#pragma mark *******UIWebViewDelegate *****
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //改变字体的大小
    NSString *str = [NSString stringWithFormat:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '%.2f%%'",UISCREEN_WIDTH /4.1];
    //    NSString *str = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '60%'";
    //改变字体的颜色
    [webView stringByEvaluatingJavaScriptFromString:str];
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= 'gray'"];
}

//返回cell的高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.DetailTableView) {
        
        NSArray *arr = self.dataDictionary[[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        
        if ([self judgeString:arr.firstObject] == YES) {
            
            return [ShortViewCell cellHeight:self.midleArr[indexPath.row]] + UISCREEN_HEIGHT / 7.88;
            
        }else{
            return [ShortViewCell cellHeight:self.midleArr[indexPath.row]];
        }
        
    }else{
        
        return UISCREEN_HEIGHT / 17;
        
    }
    
}
#pragma mark *******TableView 的业务代理 ***********
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tableView) {
    
        //选中状态
        DayListViewCell *cell = (DayListViewCell *)[_tableView cellForRowAtIndexPath:indexPath];
        cell.selected = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dayLable.frame = CGRectMake(0, 0, UISCREEN_HEIGHT / 17.75, UISCREEN_HEIGHT / 21.846);
       
        //未选中状态
        if (self.selectindex != indexPath) {
            
            DayListViewCell *listCell = (DayListViewCell *)[_tableView cellForRowAtIndexPath:_selectindex];
            //            listCell.changeImage.image = [UIImage imageNamed:@"默认状态"];
            listCell.selected = NO;
            listCell.dayLable.frame = CGRectMake(6, 0, UISCREEN_HEIGHT / 21.846, UISCREEN_HEIGHT / 21.846);
             _selectindex = indexPath;
        }
        //计算 cell 的偏移量
        [self scrollToHeight];
    
        self.scrollView.contentOffset = CGPointMake(0,  _heigthOfScrol - 82.7);
     
    
    }else if(tableView == self.DetailTableView){
        
        ShortViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
}

#pragma mark **********点击对应天数查看具体详情************
- (void)scrollToHeight{
    
    _heigthOfScrol = 0;
    
    _heigthOfScrol = [self.yArray[_selectindex.row] floatValue];
}


#pragma mark ******CollectionView 的代理方法********

/**
 *  CollectionView 的数据源代理
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.collectionArr.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 32, 0, cell.frame.size.width - UISCREEN_HEIGHT / 71, cell.frame.size.height)];
        label.text = @"相关产品推荐";
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 21];
        [cell addSubview:label];
        return cell;
    }else{
        
        TravelProductDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
        ProductModel *model = self.collectionArr[indexPath.item - 1];
        [cell assignValueForItemWithModel:model];
        
        return cell;
        
    }
}

/**
 *  CollectionView的业务代理
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item == 0)
    {
        return CGSizeMake(UISCREEN_WIDTH, UISCREEN_WIDTH / 10.6);
    }
    else
    {
        return CGSizeMake(UISCREEN_WIDTH / 2.2, UISCREEN_HEIGHT / 3.5);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, UISCREEN_WIDTH / 32, UISCREEN_WIDTH / 64, UISCREEN_HEIGHT / 71);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item != 0) {
        
        ProductDetailViewController *productVC = [ProductDetailViewController new];
        ProductModel *model = self.collectionArr[indexPath.item - 1];
        productVC.productID = model.product_id;
        [self.navigationController pushViewController:productVC animated:YES];
        
    }else{
        
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
