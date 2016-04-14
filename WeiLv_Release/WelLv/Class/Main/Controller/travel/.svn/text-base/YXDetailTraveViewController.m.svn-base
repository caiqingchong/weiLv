//
//  YXDetailTraveViewController.m
//  WelLv
//
//  Created by lyx on 15/4/20.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXDetailTraveViewController.h"
#import "LXChooseDateViewController.h"
#import "YXWebDetailViewController.h"
#import "HouseKeeperViewController.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "ZFJCallStewardVC.h"
#import "LXGetCityIDTool.h"
#import "ZFJCallVC.h"
#import "GroupHomeViewController.h"
#import "ShareCustom.h"
#define schedluImageHeight 100
#define M_COLL_RESERVE_BUT_HEIGHT 40
static CGFloat kImageOriginHight = 150.f;
@interface YXDetailTraveViewController ()<UIActionSheetDelegate>
{
    UITableView *_tableView;
    UIScrollView *_scrollVIew;
    IamgeAndLabelView *_traveType;         //旅游类型
    IamgeAndLabelView *_beginWhere;        //出发地点
    
    UILabel *_priceLable;       //价格
    UILabel *_productName;        //产品名字
    UILabel *_introductLabel;    //介绍
    
    UIView *alpView;
    YXTabbarBtn *sectionBtn;
    
    UIView *overView;
    UIView *detailView;
    UIView *commitView;
    
    YXTraveDetailModel *traveData;
    CGFloat height ;
    
    NSMutableArray * nameArr ;          //管家名字数组
    NSMutableArray * iconImage;         //管家图像数组
    NSMutableArray * phoneArr;          //管家电话数组
    CGSize  size1;
    CGSize size2;
    GroupHomeViewController *ghvc;
    CGSize si;
    NSString *shareImageURL;  //分享产品的图片
    NSString *shareURL;       //分享跳转的URL
    
    UIImage *_shareImage;
    
}
@property (nonatomic, strong) NSMutableArray * stewardArray;//管家数组；

@end

@implementation YXDetailTraveViewController
@synthesize headerImageVIew = _headerImageVIew;
@synthesize productId = _productId;
@synthesize productPrice = _productPrice;

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品详情";
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.productId == nil) {
        self.productId = @"70";
    }
    //创建分享按钮
    [self addNavChooseBut];
    [self loadTraveData];
    height =0;

}

- (void)loadTraveData
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    NSDictionary *parment = @{@"id":self.productId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:TraveDetailUrl parameters:parment success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
          NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        // DLog(@"json === %@", json);
         DLog(@"loop_json %@", [[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:[[json objectForKey:@"data"] objectForKey:@"loop_json"]]);
         traveData = [[YXTraveDetailModel alloc] init];
         traveData = JsonStringTransToObject([json objectForKey:@"data"], @"YXTraveDetailModel");
        
         DLog(@"%@",traveData.timetable_custom);
         
         if (traveData.route_type!=nil)
         {
             if ([traveData.route_type intValue]==10)
             {
                 [self initScrollView];
                 _beginWhere.infoLanel.text = @"全国出发";
             }
             else
             {
                 [self getCity:traveData.f_city];
             }
         
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
         [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
             [self loadTraveData];
         }];
     }];
    
    
}
#pragma mark --- 添加分享
- (void)addNavChooseBut
{
    //创建分享按钮
    UIButton * chooseBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBut.frame = CGRectMake(0, 0 , ViewHeight(self.navigationController.navigationBar) - 5, ViewHeight(self.navigationController.navigationBar) - 5);
    chooseBut.backgroundColor = [UIColor whiteColor];
    [chooseBut addTarget:self action:@selector(shareShop:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(chooseBut) - 18, (ViewHeight(chooseBut) - 21) / 2.0, 18, 21)];
    icon.image = [UIImage imageNamed:@"分享1"];
    [chooseBut addSubview:icon];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chooseBut];
    shareURL=TRAVEL_SHARE_URL(self.productId);
}

#pragma mark - 分享按钮 点击事件
- (void)shareShop:(UIButton *)sender
{
    
    //分享的内容
    NSString *content=traveData.product_name;
    content=[content stringByAppendingString:@"\r\n"];
    content=[content stringByAppendingFormat:@"本产品由%@提供服务。微旅,您家门口的旅行管家", [self judgeReturnString:traveData.company withReplaceString:@""]];
    
    
    
    NSString *desc=[NSString stringWithFormat:@"本产品由%@提供服务。微旅,您家门口的旅行管家", [self judgeReturnString:traveData.company withReplaceString:@""]];
    
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:[ShareSDK jpegImageWithImage:_shareImage quality:1]
                                                title:traveData.product_name
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

- (void)getCity:(NSString *)cityId
{
    NSDictionary *parment = @{@"region_id":cityId};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:GetCityUrl parameters:parment success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         [self initScrollView];
         if (json != nil) {
             NSArray *array=[json objectForKey:@"data"];
             if (array.count >0) {
                 NSString *beginCity = [[[json objectForKey:@"data"] objectAtIndex:0] objectForKey:@"region_name"];
                 _beginWhere.infoLanel.text = [NSString stringWithFormat:@"%@出发",beginCity];
                 
             }
         }
         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
    }];
 
}
- (void)initScrollView
{
    _scrollVIew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight- 64-40)];
    _scrollVIew.backgroundColor = [UIColor whiteColor];
    _scrollVIew.delegate = self;
    
    [self.view addSubview:_scrollVIew];
    [self showTopImageView];
    [self isOverView:traveData.feature];
    DLog(@"%@",traveData.feature);
    [self isDetailView];
    [self isCommitView];
    [self showButtomBtn];
    
    
}
- (void)showTopImageView
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    YXAlbum_list *albumData = [[YXAlbum_list alloc] init];
    for (int i=0; i<traveData.album_list.count; i++) {
        NSString *imageName ;
            albumData =[traveData.album_list objectAtIndex:i];
        if (albumData.picture != nil) {
            if ([albumData.picture hasPrefix:@"https://"]||[albumData.picture hasPrefix:@"http://"]) {
                imageName = albumData.picture;
            }else{
                 imageName = [PathImagelUrl stringByAppendingString:albumData.picture];
            }
            if (i==0) {
                //获取分享产品的图片
                shareImageURL=imageName;
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareImageURL]];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _shareImage = [UIImage imageWithData:imageData];
                    });
                });

            }
        }else
        {
            imageName = @"";
        }
        [arr addObject:imageName];
    }

    self.headerImageVIew = [[YXTopImageView alloc] initWithFrameRect:CGRectMake(0, 0, self.view.frame.size.width, kImageOriginHight) ImageArray:arr];
    alpView = [[UIView alloc] initWithFrame:CGRectMake(0, kImageOriginHight- 40, self.headerImageVIew.frame.size.width, 40)];
    alpView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];

    _traveType = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(10, 10, 90, 20)];
    _traveType.infoLanel.text = traveData.category;
    _traveType.infoLanel.textColor = [UIColor whiteColor];
    _traveType.infoLanel.font = [UIFont systemFontOfSize:12];
    _traveType.iconIamge.image = [UIImage imageNamed:@"跟团游"];
    
    [alpView addSubview:_traveType];
    
    _beginWhere = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(100, 10, 90, 20)];
    _beginWhere.infoLanel.text = [NSString stringWithFormat:@"%@出发",traveData.f_city];
    _beginWhere.infoLanel.textColor = [UIColor whiteColor];
    _beginWhere.infoLanel.font = [UIFont systemFontOfSize:12];
    _beginWhere.iconIamge.image = [UIImage imageNamed:@"送达1"];
    
    [alpView addSubview:_beginWhere];
    [self.headerImageVIew addSubview:alpView];
    [_scrollVIew addSubview:self.headerImageVIew];
    
    _productName = [YXTools allocLabel:traveData.product_name font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(10,ViewHeight(self.headerImageVIew), windowContentWidth-10*2, 20) textAlignment:0];
    [_scrollVIew addSubview:_productName];
    
    _introductLabel = [YXTools allocLabel:[NSString stringWithFormat:@"本产品由%@提供服务",traveData.company] font:systemFont(13) textColor:[UIColor grayColor] frame:CGRectMake(10, ViewHeight(_productName)+ViewY(_productName), windowContentWidth-10*2, 20) textAlignment:0];
    [_scrollVIew addSubview:_introductLabel];
    
    UILabel * weiLvPriceLabel = [YXTools allocLabel:@"微旅价：" font:systemFont(13) textColor:kColor(255, 96, 126) frame:CGRectMake(10, ViewHeight(_introductLabel)+ViewY(_introductLabel), 60, 30) textAlignment:0];
    [_scrollVIew addSubview:weiLvPriceLabel];
    
    _priceLable = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",traveData.sell_price] font:systemBoldFont(15) textColor:kColor(255, 96, 126) frame:CGRectMake(ViewWidth(weiLvPriceLabel)+ViewX(weiLvPriceLabel)+5, ViewY(weiLvPriceLabel), 80, 30) textAlignment:0];
    [_scrollVIew addSubview:_priceLable];
    UILabel *unitLabel = [YXTools allocLabel:@"起" font:systemFont(13) textColor:kColor(255, 96, 126) frame:CGRectMake(ViewX(_priceLable)+ViewWidth(_priceLable), ViewHeight(_introductLabel)+ViewY(_introductLabel), 30, 30) textAlignment:0];
    [_scrollVIew addSubview:unitLabel];
    
    YXSelectBtn *selectedBtn = [[YXSelectBtn alloc] initWithFrame:CGRectMake(0, ViewHeight(_priceLable)+ViewY(_priceLable), windowContentWidth, 50)];
    selectedBtn.tag = 1;
    selectedBtn.title.frame = CGRectMake(Begin_X, 0, 150, 50);
    selectedBtn.title.textColor = kColor(134, 184, 255);
    selectedBtn.title.text = @"最近团期";
    selectedBtn.title.font = systemBoldFont(15);
    selectedBtn.layer.borderColor = bordColor.CGColor;
    selectedBtn.layer.borderWidth = 0.5;
    [selectedBtn addTarget:self action:@selector(clickProductDetail:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollVIew addSubview:selectedBtn];
    
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(selectedBtn)+ViewY(selectedBtn), windowContentWidth, 20)];
    grayView.backgroundColor = kColor(240, 241, 242);
    grayView.layer.borderColor = bordColor.CGColor;
    grayView.layer.borderWidth = 0.5;
    [_scrollVIew addSubview:grayView];

    
    //切换按钮
    NSArray *btnArr = [NSArray arrayWithObjects:@"概述",@"详情", nil];//,@"评论(0)"
    sectionBtn = [[YXTabbarBtn alloc] initWithNomal:btnArr frame: CGRectMake(0, ViewHeight(grayView)+ViewY(grayView), windowContentWidth, 40)];
    sectionBtn.layer.borderColor = bordColor.CGColor;
    sectionBtn.backgroundColor = [UIColor whiteColor];
    sectionBtn.layer.borderWidth = 0.5;
    sectionBtn.delegate = self;
    [sectionBtn setSelectIndex:0];
    [_scrollVIew addSubview:sectionBtn];
  
}

- (void)showButtomBtn
{
    UIButton * collButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collButton.frame = CGRectMake(0, windowContentHeight - 64-40, self.view.frame.size.width / 2, 40);
    [collButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    [collButton setBackgroundImage:[UIImage imageNamed:@"hjxqBtn"] forState:UIControlStateNormal];
    collButton.titleLabel.font = systemFont(14);
    [collButton addTarget:self action:@selector(BookClick:) forControlEvents:UIControlEventTouchUpInside];
    collButton.tag = 101;
    [self.view addSubview:collButton];
    
    UIButton * reserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reserveButton.frame = CGRectMake(self.view.frame.size.width / 2, windowContentHeight - 64 - 40, self.view.frame.size.width / 2, 40);
    [reserveButton setBackgroundImage:[UIImage imageNamed:@"gjbd"] forState:UIControlStateNormal];
    [reserveButton setTitle:@"立即预订" forState:UIControlStateNormal];
    reserveButton.titleLabel.font = systemFont(14);
    [reserveButton addTarget:self action:@selector(BookClick:) forControlEvents:UIControlEventTouchUpInside];
    reserveButton.tag = 102;
    [self.view addSubview:reserveButton];
}

#pragma mark -立即预定
- (void)BookClick:(UIButton *)sender
{
    if (sender.tag == 101) {
        [self callPhone];
    }else
    {

//        NSString *adminId =[NSString stringWithFormat:@"%@",[[LXUserTool alloc] getHouseAdmin_id]];
//        
//        //DLog(@"%@",[[LXUserTool alloc] getHouseAdmin_id]);
//        //DLog(@"%@",[[LXUserTool alloc]getuserGroup]);
//        
//        if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"] && ![adminId isEqualToString:traveData.admin_id]) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:AssitBookMsg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alertView show];
//            return;
//        }

//        NSString *adminId =[NSString stringWithFormat:@"%@",[[LXUserTool alloc] getHouseAdmin_id]];
//        if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"] && ![adminId isEqualToString:traveData.admin_id]) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:AssitBookMsg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alertView show];
//            return;
//        }

        if (traveData.lastest==nil)
        {
             [[LXAlterView sharedMyTools]createTishi:@"此旅游产品是暂无班期，请选择其他同类产品!"];
             return;
        }
        else
        {
        
            TraveCalendarViewController *lxchooseVC = [[TraveCalendarViewController alloc] init];
//            lxchooseVC.orderSource = self.orderSource;
//            lxchooseVC.store_id = self.store_id;
//            lxchooseVC.traveModel = traveData;
//            lxchooseVC.price =traveData.adult_price;
//            lxchooseVC.childprice=traveData.child_price;
//            lxchooseVC.realBeginDate=traveData.lastest;
            DLog(@"%@",traveData.lastest);
//            lxchooseVC.pay_way=traveData.pay_way;
            [self.navigationController pushViewController:lxchooseVC animated:YES];
        }
    }
}

- (void)callPhone
{
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember && [[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteward])
    {
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"拨打管家电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拨打管家电话" otherButtonTitles:nil, nil];
        [actionsheet showInView:self.view];
    } else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        ZFJCallVC * callVC = [[ZFJCallVC alloc] init];
        callVC.memberType = WLMemberTypeSteward;
        callVC.prodductType = WLProductTypeVisa;
        callVC.admin_id = traveData.admin_id;
        callVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        callVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:callVC animated:YES completion:nil];
        
    } else {
        ZFJCallVC * callVC = [[ZFJCallVC alloc] init];
        callVC.admin_id = traveData.admin_id;
        callVC.memberType = [[WLSingletonClass defaultWLSingleton] wlUserType];
        callVC.prodductType = WLProductTypeVisa;
        callVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        callVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:callVC animated:YES completion:nil];
        
        __weak YXDetailTraveViewController * detailVC = self;
        [callVC chooseMoreSteward:^(UIButton *but) {
            ZFJCallStewardVC * callStewardVC = [[ZFJCallStewardVC alloc] init];
            callStewardVC.admin_id = traveData.admin_id;
            [detailVC.navigationController pushViewController:callStewardVC animated:YES];
        }];
    }

}

#pragma mark  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //DLog(@"+++++++电话咨询+++++++++");
        NSString *url = [houseDetailUrl([[LXUserTool alloc] getKeeper]) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
         {
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             
             NSString * telString = [NSString stringWithFormat:@"tel:%@", [[dic objectForKey:@"data"]objectForKey:@"mobile"]];
             DLog(@"%@", dic);
             DLog(@"%@", [[dic objectForKey:@"data"]objectForKey:@"mobile"]);
             NSURL * telUrl = [NSURL URLWithString:telString];
             [[UIApplication sharedApplication] openURL:telUrl];
         }failure:^(AFHTTPRequestOperation *operation,NSError *error){
             DLog(@"%@", error);
         }];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString *url = [houseDetailUrl([[LXUserTool alloc] getKeeper]) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark YXTabBtnDelegate
- (void)segmentedButtonSelectedIndex:(NSUInteger)segment button:(UIButton *)btn
{
    if (segment == 0) {
        overView.hidden = NO;
        detailView.hidden = YES;
        commitView.hidden = YES;
        float height1 = ViewHeight(overView)+ViewY(overView);
        if (height1 > windowContentHeight) {
            _scrollVIew.contentSize = CGSizeMake(0, ViewHeight(overView)+ViewY(overView)+50);
        }else
        {
            _scrollVIew.contentSize = CGSizeMake(0, 736);
        }
        
    }else if (segment == 1)
    {
        overView.hidden = YES;
        detailView.hidden = NO;
        commitView.hidden = YES;
        float height1 = ViewHeight(detailView)+ViewY(detailView);
        if (height1 > windowContentHeight) {
           _scrollVIew.contentSize = CGSizeMake(0, ViewHeight(detailView)+ViewY(detailView)+30);
        }else
        {
            _scrollVIew.contentSize = CGSizeMake(0, 736);
        }
    }else
    {
        overView.hidden = YES;
        detailView.hidden = YES;
        commitView.hidden = NO;
        float height1 = ViewHeight(commitView)+ViewY(commitView);
        if (height1 > windowContentHeight) {
           _scrollVIew.contentSize = CGSizeMake(0, ViewHeight(commitView)+ViewY(commitView)+30);
        }else
        {
            _scrollVIew.contentSize = CGSizeMake(0, 736);
        }

    }
}

//展示概述视图
- (void )isOverView:(NSString *)proIntroduct
{
    NSString *str=[self filterHTML:proIntroduct];
    DLog(@"%@",str);
    
    CGFloat size = [YXTools returnTextCGRectText:proIntroduct textFont:15].size.height;
    overView = [[UIView alloc] initWithFrame:CGRectMake(0, 330, windowContentWidth, 170+size)];
    UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 25, 25)];
    leftImage.image = [UIImage imageNamed:@"产品特色"];
    [overView addSubview:leftImage];
    UILabel *proTitle = [YXTools allocLabel:@"产品特色" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(leftImage)+ViewWidth(leftImage)+5,5, 150, 30) textAlignment:0];
    [overView addSubview:proTitle];
   
    UIWebView *proDuctDetail = [[UIWebView alloc] initWithFrame:CGRectMake(10, ViewY(proTitle)+ViewHeight(proTitle), windowContentWidth - 20, size)];
    [proDuctDetail loadHTMLString:proIntroduct baseURL:nil];
    proDuctDetail.tag = 1;
    if (![YXTools stringIsNotNullTrim:proIntroduct]) {
         proDuctDetail.delegate = self;
    }
    [overView addSubview:proDuctDetail];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(proDuctDetail)+ViewHeight(proDuctDetail), windowContentWidth, 0.5)];
    line.backgroundColor = bordColor;
    line.tag = 1000;
    [overView addSubview:line];
    
    NSArray *arr = [NSArray arrayWithObjects:@"费用说明",@"预订须知",@"退改规则", nil];
    NSArray *imageArr = [NSArray arrayWithObjects:@"new费用说明",@"new预定须知",@"退订须知", nil];
    for (int i=0; i<arr.count; i++) {
        YXSelectBtn *selectedBtn1 = [[YXSelectBtn alloc] initWithFrame:CGRectMake(0, 50*i+ViewY(line)+ViewHeight(line), windowContentWidth, 50)];
        selectedBtn1.tag = i+2000;
        selectedBtn1.leftView.image = [UIImage imageNamed:[imageArr objectAtIndex:i]];
        selectedBtn1.title.text = [arr objectAtIndex:i];
        [selectedBtn1 addTarget:self action:@selector(clickProductDetail:) forControlEvents:UIControlEventTouchUpInside];
        [overView addSubview:selectedBtn1];
    }
    [_scrollVIew addSubview:overView];
    
}
-(NSString *)filterHTML:(NSString *)html
{
//    NSScanner * scanner = [NSScanner scannerWithString:html];
//    NSString * text = nil;
//    while([scanner isAtEnd]==NO)
//    {
//        //找到标签的起始位置
//        [scanner scanUpToString:@"<" intoString:nil];
//        //找到标签的结束位置
//        [scanner scanUpToString:@">" intoString:&text];
//        //替换字符
        html = [html stringByReplacingOccurrencesOfString:@"" withString:@"??"];
   // }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(windowContentWidth - 130, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}
//展示详细视图
- (void)isDetailView
{
    detailView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *imge = [[NSArray alloc] initWithObjects:@"Clock_time",@"Location_fache",@"List_mark", nil];
    NSArray *wenzi = [[NSArray alloc]  initWithObjects:@"发车时间: ",@"发车地点: ",@"备  注: ", nil];
    
    YXDeparture_info *departureData = [[YXDeparture_info alloc] init];
    departureData =[traveData.departure_info objectAtIndex:0];
    for (int i=0; i<imge.count; i++)
    {
        NSString *name = [imge objectAtIndex:i];
        UIImageView *imageV = [YXTools allocImageView:CGRectMake(0, 5+30*i, 40, 20) image:[UIImage imageNamed:name]];
        [detailView addSubview:imageV];
        NSString *leftstr = [wenzi objectAtIndex:i];
        UILabel *contentLabel1 = [YXTools allocLabel:leftstr font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(ViewWidth(imageV)+ViewX(imageV), ViewY(imageV)-5, 75, 30) textAlignment:0];
        [detailView addSubview:contentLabel1];
        NSString *total;
        if (i==0) {
            if (departureData.time) {
                total = [NSString stringWithFormat:@"%@",departureData.time];
            
            } else {
                total =@"";

            }
        }else if (i==1)
        {
            if (departureData.f_place) {
                
                total = [NSString stringWithFormat:@"%@",departureData.f_place];
               size1=[self sizeWithString:departureData.f_place font:systemFont(15)];
                DLog(@"%f",size1.height);
                
            } else {
                
                total =@"";
                
            }
        }else
        {
            if (departureData.remark) {
                
                total = [NSString stringWithFormat:@"%@",departureData.remark];
                size2=[self sizeWithString:departureData.remark font:systemFont(15)];
                 DLog(@"%f",size2.height);
            } else {
                
                total =@"";

            }
        }
        UILabel *contentLabel = [YXTools allocLabel:total font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(ViewRight(contentLabel1), ViewY(imageV)-5, windowContentWidth - ViewWidth(imageV), 30) textAlignment:0];
        contentLabel.numberOfLines=0;
       [detailView addSubview:contentLabel];
        if (i==1) {
            
            [contentLabel setFrame:CGRectMake(ViewRight(contentLabel1), 40-2, windowContentWidth - 120,size1.height)];
        }else if(i==2)
    {
        
        [imageV setFrame:CGRectMake(0, 45+size1.height, 40, 20)];
        [contentLabel1 setFrame:CGRectMake(ViewRight(imageV), 45+size1.height-5, 75, 30)];
        [contentLabel setFrame:CGRectMake(ViewRight(contentLabel1), ViewY(contentLabel1)+5+2, windowContentWidth - 120,size2.height)];
    }

    }
    UIView *Oline = [[UIView alloc] initWithFrame:CGRectMake(5, 45+size1.height+size2.height+10, windowContentWidth-10, 0.5)];
    Oline.backgroundColor = bordColor;
    [detailView addSubview:Oline];
    //DLog(@"traveData.schedule = %@", traveData.schedule);
    for (int i=0; i<traveData.schedule.count; i++)
    {
        YXSchedule *scheduleData = [[YXSchedule alloc] init];
        scheduleData =[traveData.schedule objectAtIndex:i];
        UIView *scheduView =[[UIView alloc] initWithFrame:CGRectZero];
        scheduView.tag = 500+i;
        UIImageView *timePointView = [YXTools allocImageView:CGRectMake(0,ViewHeight(Oline)+ViewY(Oline)+10,30, 15) image:[UIImage imageNamed:@"日程"]];
        if (i>0) {
            timePointView.frame = CGRectMake(0, 10, 30, 15);
        }
        [scheduView addSubview:timePointView];
        UILabel *DayLable = [YXTools allocLabel:[NSString stringWithFormat:@"第%@天",scheduleData.day] font:systemFont(13) textColor:TimeGreenColor frame:CGRectMake(ViewX(timePointView)+ViewWidth(timePointView),ViewY(timePointView)-3,50, 20) textAlignment:0];
        [scheduView addSubview:DayLable];
        scheduleData.title=[scheduleData.title stringByReplacingOccurrencesOfString:@"" withString:@"-"];
         si = [self sizeWithString:scheduleData.title font:systemFont(13)];
        //DLog(@"%f",si.height);
        UILabel *TitleLable = [YXTools allocLabel:scheduleData.title font:systemFont(13) textColor:TimeGreenColor frame:CGRectMake(ViewX(DayLable)+ViewWidth(DayLable),ViewY(timePointView) ,windowContentWidth - ViewWidth(DayLable) - ViewX(DayLable)-10,20) textAlignment:0];
        TitleLable.numberOfLines=0;
        [TitleLable setFrame:CGRectMake(ViewX(DayLable)+ViewWidth(DayLable),ViewY(timePointView),windowContentWidth - ViewWidth(DayLable) - ViewX(DayLable)-10,si.height)];
        [scheduView addSubview:TitleLable];
        //DLog(@"%@",scheduleData.activities);
        CGFloat size = [YXTools returnTextCGRectText:scheduleData.activities textFont:18].size.height;
        UIWebView *scheduleDetailView = [[UIWebView alloc] initWithFrame:CGRectMake(ViewX(DayLable), ViewBelow(TitleLable), windowContentWidth - ViewX(timePointView)-ViewWidth(timePointView), size)];
        [scheduleDetailView loadHTMLString:scheduleData.activities baseURL:nil];
        scheduleDetailView.delegate = self;
        scheduleDetailView.tag = 2+i;
        scheduleDetailView.dataDetectorTypes=UIDataDetectorTypeNone;
        [scheduView addSubview:scheduleDetailView];
        
        float imageWith = ViewWidth(scheduleDetailView)/2-20;
        UIImageView *imageView1;
        UIImageView *imageView2;
        if (scheduleData.schedule_images.count >=1) {
           imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(timePointView)+ViewWidth(timePointView)+5, ViewHeight(scheduleDetailView)+ViewY(scheduleDetailView)+10,imageWith , schedluImageHeight)];
            imageView1.tag = 100+i;
            [scheduView addSubview:imageView1];
            imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(imageView1)+ViewWidth(imageView1)+10, ViewHeight(imageView1)+ViewY(scheduleDetailView)+10,imageWith , schedluImageHeight)];
            imageView2.tag = 300+i;
            [scheduView addSubview:imageView2];
        }
        for (int j = 0; j < scheduleData.schedule_images.count; j++) {
            YXAlbum_list *ImageData = [[YXAlbum_list alloc] init];
            ImageData =[scheduleData.schedule_images objectAtIndex:j];
            NSString *image = [[WLSingletonClass defaultWLSingleton] wlJudgeAlbumImageViewURLStr:ImageData.picture];
            
//            if ([ImageData.picture hasPrefix:@"http"]) {
//               image = ImageData.picture;
//            } else {
//               image = [PathImagelUrl stringByAppendingString:ImageData.picture];
//            }
            
            if (j==0) {
                [imageView1 sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"默认图4"]];
                imageView1.userInteractionEnabled = YES;
                UITapGestureRecognizer *imagTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBigImage:)];
                [imageView1 addGestureRecognizer:imagTap];
            }
            if (j==1) {
                [imageView2 sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"默认图4"]];
                imageView2.userInteractionEnabled = YES;
                UITapGestureRecognizer *imagTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBigImage1:)];
                [imageView2 addGestureRecognizer:imagTap];
            }

        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake((ViewX(timePointView)+ViewWidth(timePointView))/2, ViewY(timePointView)+ViewHeight(timePointView), 0.5, ViewHeight(scheduleDetailView)+schedluImageHeight*scheduleData.schedule_images.count)];
        line.tag = 3000+i;
        line.backgroundColor = TimeGreenColor;
        [scheduView addSubview:line];
        
        UIImageView *timePointView1 = [YXTools allocImageView:CGRectMake(ViewX(timePointView), ViewY(line)+ViewHeight(line),30, 15) image:[UIImage imageNamed:@"日程"]];
        timePointView1.tag = 4000+i;
        [scheduView addSubview:timePointView1];
        UIImageView *fanImageView = [YXTools allocImageView:CGRectMake(ViewX(timePointView1)+ViewWidth(timePointView1), ViewY(timePointView1), 8, 20) image:[UIImage imageNamed:@"吃饭"]];
        fanImageView.tag = 5000+i;
        [scheduView addSubview:fanImageView];
        
        YXTraveAutoView *morningLable = [[YXTraveAutoView alloc] initWithFrame:CGRectMake(ViewX(fanImageView)+ViewWidth(fanImageView)+5,ViewY(fanImageView) ,windowContentWidth - ViewX(fanImageView)-ViewWidth(fanImageView), 20)];
        morningLable.titleLable.text = @"早餐:";
        morningLable.tag = 6000+i;
        if ([scheduleData.breakfast isEqualToString:@"1"]) {
           morningLable.contentLabel.text = @"提供";
        }else
        {
            morningLable.contentLabel.text = @"敬请自理";
        }
        [scheduView addSubview:morningLable];
        
        YXTraveAutoView *AfterLable = [[YXTraveAutoView alloc] initWithFrame:CGRectMake(ViewX(morningLable),ViewY(morningLable)+ViewHeight(morningLable) ,ViewWidth(morningLable), 20)];
        AfterLable.titleLable.text = @"午餐:";
        AfterLable.tag = 7000+i;
        if ([scheduleData.lunch isEqualToString:@"1"]) {
            AfterLable.contentLabel.text = @"提供";
        }else
        {
            AfterLable.contentLabel.text = @"敬请自理";
        }
        [scheduView addSubview:morningLable];
        [scheduView addSubview:AfterLable];
        
        YXTraveAutoView *eveningLable = [[YXTraveAutoView alloc] initWithFrame:CGRectMake(ViewX(morningLable),ViewY(AfterLable)+ViewHeight(AfterLable) ,ViewWidth(morningLable), 20)];
        eveningLable.titleLable.text = @"晚餐:";
        eveningLable.tag = 8000+i;
        if ([scheduleData.dinner isEqualToString:@"1"]) {
            eveningLable.contentLabel.text = @"提供";
        }else
        {
            eveningLable.contentLabel.text = @"敬请自理";
        }
        [scheduView addSubview:morningLable];
        [scheduView addSubview:eveningLable];
        
        UIImageView *sleepImageView = [YXTools allocImageView:CGRectMake(ViewX(timePointView1)+ViewWidth(timePointView1), ViewY(eveningLable)+ViewHeight(eveningLable), 23/2, 20) image:[UIImage imageNamed:@"住宿"]];
        sleepImageView.tag = 10000+i;
        [scheduView addSubview:sleepImageView];
        YXTraveAutoView *bedLable = [[YXTraveAutoView alloc] initWithFrame:CGRectMake(ViewX(morningLable),ViewY(eveningLable)+ViewHeight(eveningLable) ,ViewWidth(morningLable), 20)];
        bedLable.titleLable.text = @"住宿:";
        bedLable.tag = 11000+i;
        [bedLable setContentText:scheduleData.room];
        [scheduView addSubview:bedLable];
        
       
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(ViewX(line), ViewY(timePointView1)+ViewHeight(timePointView1), 0.5, ViewHeight(bedLable)+ViewY(bedLable) - ViewY(timePointView1)-ViewHeight(timePointView1)+10)];
        line2.backgroundColor =  TimeGreenColor;
        line2.tag = 12000+i;
        [scheduView addSubview:line2];
        
//        scheduView.frame = CGRectMake(0, height+10, windowContentWidth, ViewHeight(bedLable)+ViewY(bedLable));
//        height = ViewHeight(scheduView)+ height;
        [detailView addSubview:scheduView];
    }
    detailView.frame=CGRectMake(0, ViewY(overView), windowContentWidth, height);
    [_scrollVIew addSubview:detailView];
    detailView.hidden = YES;
}



- (void)isCommitView
{
    commitView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(overView), windowContentWidth, windowContentHeight - 230-40)];
    YXCommitView *commitView1 = [[YXCommitView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ViewHeight(commitView)) commentArr:_commitArr];
    [commitView addSubview:commitView1];
    [_scrollVIew addSubview:commitView];
    commitView.hidden = YES;
    
}
#pragma mark -最近团期跳转
- (void)clickProductDetail:(YXSelectBtn *)sender
{
    if (sender.tag == 1) {
 
        
        if (traveData.lastest==nil)
        {
            [[LXAlterView sharedMyTools]createTishi:@"此旅游产品是暂无班期，请选择其他同类产品!"];
            return;
        }
        else
        {
            TraveCalendarViewController *lxchooseVC = [[TraveCalendarViewController alloc] init];
            lxchooseVC.orderSource = self.orderSource;
            lxchooseVC.store_id = self.store_id;
            lxchooseVC.traveModel = traveData;
            lxchooseVC.price =traveData.adult_price;
            lxchooseVC.childprice=traveData.child_price;
            lxchooseVC.realBeginDate=traveData.lastest;
            lxchooseVC.pay_way=traveData.pay_way;
            [self.navigationController pushViewController:lxchooseVC animated:YES];
        }
        
    }else
    {
        YXWebDetailViewController *webVC = [[YXWebDetailViewController alloc] init];
        if ([sender.title.text isEqualToString:@"费用说明"]) {
            NSString *content = [NSString stringWithFormat:@"<span style=color:#99BB00;>费用包含</span><span style=color:#99BB00;></span>\n%@\n<span style=color:#99BB00;>费用不包含</span><span style=color:#99BB00;></span>\n%@",traveData.fee_include,traveData.fee_not_include];
            
            webVC.webContent = content;
        }else if ([sender.title.text isEqualToString:@"预订须知"])
        {
            NSString *strYUdin;
            NSString *Teshu;
            NSString *dataLast;
            NSString *Telltitle;
            if ([self judgeString:traveData.sign_way]) {
                 strYUdin = [NSString stringWithFormat:@"<span style=color:#99BB00;>预订须知</span><span style=color:#99BB00;></span><br>%@<br>",traveData.sign_way];
            }
            else
            {
                 strYUdin = [NSString stringWithFormat:@""];
            }
            if ([self judgeString:traveData.special_limit]) {
                 Teshu = [NSString stringWithFormat:@"<span style=color:#99BB00;>特殊限制</span><span style=color:#99BB00;></span><br>%@<br>",traveData.special_limit];
            }
            else
            {
                Teshu = [NSString stringWithFormat:@""];
            }
            
            NSString *Offer = [NSString stringWithFormat:@"<span style=color:#99BB00;>付款方式</span><span style=color:#99BB00;></span><br><br>本平台产品通过翼支付第三方平台进行付款交易。<br><br>"];
            if ([self judgeString:traveData.apply_close]) {
                dataLast = [NSString stringWithFormat:@"<br><br><span style=color:#99BB00;>报名截止日期</span><span style=color:#99BB00;></span><br>%@<br>",traveData.apply_close];
            }
            else
            {
                 dataLast = [NSString stringWithFormat:@""];
            }
            if ([self judgeString:traveData.notice]) {
                 Telltitle = [NSString stringWithFormat:@"<span style=color:#99BB00;>温馨提示</span><span style=color:#99BB00;></span><br>%@",traveData.notice];
            }
            else{
            Telltitle = [NSString stringWithFormat:@""];
            }
           // NSString *bookStr = [NSString stringWithFormat:@"<span style=color:#99BB00;>预订须知</span><span style=color:#99BB00;></span><br>%@<br><span style=color:#99BB00;>特殊限制</span><span style=color:#99BB00;></span><br>%@<br><span style=color:#99BB00;>付款方式</span><span style=color:#99BB00;></span><br><br>本平台产品通过翼支付第三方平台进行付款交易。<br><br><span style=color:#99BB00;>报名截止日期</span><span style=color:#99BB00;></span><br>%@<br><span style=color:#99BB00;>温馨提示</span><span style=color:#99BB00;></span><br>%@", traveData.sign_way,traveData.special_limit,traveData.apply_close,traveData.notice];
            NSString *bookStr = [NSString stringWithFormat:@"%@%@%@%@%@",strYUdin,Teshu,Offer,dataLast,Telltitle];
            webVC.webContent = bookStr;
        }else if ([sender.title.text isEqualToString:@"退改规则"])
        {
            if ([traveData.refund_schema intValue]==0) {
                //标准退订
                if ([traveData.route_type intValue]==5 || [traveData.route_type intValue]==6 || [traveData.route_type intValue]==7 || [traveData.route_type intValue]==10) {
                    NSString *bookStr = [NSString stringWithFormat:@"<span style=color:#E53333;>平台参照“国家旅游局示范合同”关于的规定，制定标准退改规则如下：</span><span style=color:#E53333;></span><p style=font-size:15px;><span style=font-family:'微软雅黑 Regular', '微软雅黑';font-weight:400;font-size:15pxcolor:#333333;line-height:22px;>1、出发7天前（不含7日）通知取消，游客承担旅行社预订实际损失费。</span></p><p style=font-size:15px;><span style=font-family:'微软雅黑 Regular', '微软雅黑';font-weight:400;font-size:15px;color:#333333;line-height:22px;>2、出发7日至4日，按订单费用总额50%%，支付旅行社业务损失费。</span></p><p style=font-size:15px;><span style=font-family:'微软雅黑 Regular', '微软雅黑';font-weight:400;font-size:15px;color:#333333;line-height:22px;>3、出发3日至1日，按订单费用总额60%%，支付旅行社业务损失费。</span></p><p style=font-size:15px;><span style=font-family:'微软雅黑 Regular', '微软雅黑';font-weight:400;font-size:15px;color:#333333;line-height:22px;>4、出发当日，按订单费用总额80%%，支付旅行社业务损失费。<span></p>"];
                    
                    webVC.webContent = bookStr;
                }else if ([traveData.route_type intValue]==8 || [traveData.route_type intValue]==9){
                    NSString *bookStr = [NSString stringWithFormat:@"<span style=color:#E53333;>平台参照“国家旅游局示范合同”关于的规定，制定标准退改规则如下：</span><span style=color:#E53333;></span><p style=font-size:15px;><span style=font-family:'微软雅黑 Regular', '微软雅黑';font-weight:400;font-size:15px;color:#333333;line-height:22px;><span style=font-size:15px;>1、出发30天前（不含30日）通知取消，游客承担旅行社预订实际损失费。</span><br /><span style=font-size:15px;> 2、出发30日至15日，按订单费用总额5%%，支付旅行社业务损失费。</span><br /><span style=font-size:15px;> 3、出发14日至7日，按订单费用总额15%%，支付旅行社业务损失费。</span><br /><span style=font-size:15px;> 4、出发6日至4日，按订单费用总额70%%，支付旅行社业务损失费。</span><br /><span style=font-size:15px;> 5、出发3日至1日，按订单费用总额85%%，支付旅行社业务损失费。</span><br /><span style=font-size:15px;> 6、出发当日，按订单费用总额90%%，支付旅行社业务损失费。</span><br /><span style=font-size:15px;> 备注：1、如按上述比例支付的业务损失费不足以赔偿旅行社的实际损失，游客应当按实际损失对旅行社予以赔偿，但最高额不应当超过订单费用总额。</span></span></p><p style=font-size:15px;><span style=font-family:'微软雅黑 Regular', '微软雅黑';font-weight:400;font-size:15px;color:#333333;line-height:22px;></span></p>"];
                    webVC.webContent = bookStr;
                }
            }else if ([traveData.refund_schema intValue]==1){
                //自定义退订
                NSString *bookStr = [NSString stringWithFormat:@"%@",traveData.custom_schema];
                webVC.webContent = bookStr;
            }else if ([traveData.refund_schema intValue]==2){
                //不支持退订
                NSString *bookStr = [NSString stringWithFormat:@"本商品为特价商品，在订单确认后（或完成预约后），不得做任何更改，也不予退款，请您认真阅读商品详情后下单。"];
                webVC.webContent = bookStr;
            }
            
        }

        webVC.WebTitle = sender.title.text;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= 280) {
        sectionBtn.frame = CGRectMake(0, scrollView.contentOffset.y, self.view.frame.size.width, 40);
    } else {
        sectionBtn.frame = CGRectMake(0, 280, self.view.frame.size.width, 40);
    }
    [scrollView bringSubviewToFront:sectionBtn];
//    if (scrollView.contentOffset.y < 0) {
//        self.headerImageVIew.frame = CGRectMake(scrollView.contentOffset.y / 2, scrollView.contentOffset.y, self.view.frame.size.width -  scrollView.contentOffset.y , kImageOriginHight -  scrollView.contentOffset.y);
//        alpView.frame = CGRectMake(-scrollView.contentOffset.y / 2, self.headerImageVIew.frame.size.height - 40, self.view.frame.size.width, 40);
//        
//    } else {
//        self.headerImageVIew.frame = CGRectMake(0, 0, self.view.frame.size.width, kImageOriginHight);
//        alpView.frame = CGRectMake(0, self.headerImageVIew.frame.size.height - 40, self.headerImageVIew.frame.size.width, 40);
//    }
    
}

//点击第一张图片
- (void)clickBigImage:(UIGestureRecognizer *)tap
{
    YXSchedule *scheduleData = [[YXSchedule alloc] init];
    scheduleData =[traveData.schedule objectAtIndex:tap.view.tag - 100];
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [scheduleData.schedule_images count] ];
    for (int i = 0; i < [scheduleData.schedule_images count]; i++) {
        // 替换为中等尺寸图片
        YXAlbum_list *ImageData = [[YXAlbum_list alloc] init];
        ImageData =[scheduleData.schedule_images objectAtIndex:i];
        NSString * getImageStrUrl = [[WLSingletonClass defaultWLSingleton] wlJudgeAlbumImageViewURLStr:ImageData.picture];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
        
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag: tap.view.tag ];
        photo.srcImageView = imageView;
        [photos addObject:photo];
    }
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}

//点击第二张图片
- (void)clickBigImage1:(UIGestureRecognizer *)tap
{
    YXSchedule *scheduleData = [[YXSchedule alloc] init];
    scheduleData =[traveData.schedule objectAtIndex:tap.view.tag - 300];
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [scheduleData.schedule_images count] ];
    for (int i = 0; i < [scheduleData.schedule_images count]; i++) {
        // 替换为中等尺寸图片
        YXAlbum_list *ImageData = [[YXAlbum_list alloc] init];
        ImageData =[scheduleData.schedule_images objectAtIndex:i];
        NSString * getImageStrUrl = [[WLSingletonClass defaultWLSingleton] wlJudgeAlbumImageViewURLStr:ImageData.picture];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
        
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag: tap.view.tag ];
        photo.srcImageView = imageView;
        [photos addObject:photo];
    }
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 1; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
}
#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *result1 = [webView stringByEvaluatingJavaScriptFromString:@"Math.max( document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight );"];
    int height1 = [result1 intValue];
    webView.frame = CGRectMake(ViewX(webView),ViewY(webView),ViewWidth(webView),height1);
    if (webView.tag == 1)
    {
        UIView *line = (UIView *)[self.view viewWithTag:1000];
        line.frame = CGRectMake(0, ViewY(webView)+ViewHeight(webView), windowContentWidth, 0.5);
        for (int i=0; i<3; i++)
        {
            UIView *selectBtn = (UIView *)[self.view viewWithTag:i+2000];
            selectBtn.frame = CGRectMake(0, 50*i+ViewY(line)+ViewHeight(line), windowContentWidth, 50);
        }
        overView.frame = CGRectMake(0, 330, windowContentWidth, 170+height1);
        CGFloat H = ViewHeight(overView)+ViewY(overView);
        if (H >windowContentHeight) {
            _scrollVIew.contentSize = CGSizeMake( self.view.frame.size.width, H+30);
        }else
        {
            _scrollVIew.contentSize = CGSizeMake( self.view.frame.size.width, 736);
        }
    }else
    {
        NSInteger i = webView.tag - 2;
        YXSchedule *scheduleData = [[YXSchedule alloc] init];
        scheduleData =[traveData.schedule objectAtIndex:i];
        if (scheduleData.schedule_images.count >=1) {
            UIView *imageView = (UIView *)[self.view viewWithTag:100+i];
            imageView.frame = CGRectMake(ViewX(imageView),ViewY(webView)+ViewHeight(webView), ViewWidth(imageView), schedluImageHeight);
            UIView *imageView1 = (UIView *)[self.view viewWithTag:300+i];
            imageView1.frame = CGRectMake(ViewX(imageView1),ViewY(webView)+ViewHeight(webView), ViewWidth(imageView1), schedluImageHeight);
        }
//        for (int j=0; j<scheduleData.schedule_images.count; j++) {
//            UIView *imageView = (UIView *)[self.view viewWithTag:900+i];
//            if (scheduleData.schedule_images.count>1) {
//                imageView.frame = CGRectMake(ViewX(imageView),ViewY(imageView), ViewWidth(imageView), schedluImageHeight);
//            }else
//            {
//                imageView.frame = CGRectMake(ViewX(imageView),ViewY(webView)+ViewHeight(webView), ViewWidth(imageView), schedluImageHeight);
//            }
//        }
        int scheduleNumber;
        if (scheduleData.schedule_images.count>0) {
            scheduleNumber = 1;
        }else
        {
            scheduleNumber = 0;
        }
        
        UIView *line = (UIView *)[self.view viewWithTag:3000+i];
        line.frame = CGRectMake(ViewX(line),ViewY(line), ViewWidth(line), ViewHeight(webView)+scheduleNumber *schedluImageHeight+si.height+15+15);
        
        UIView *timePointView1 = (UIView *)[self.view viewWithTag:4000+i];
        timePointView1.frame = CGRectMake(ViewX(timePointView1), ViewY(line)+ViewHeight(line),30, 15);
        
        UIView *fanImageView = (UIView *)[self.view viewWithTag:5000+i];
        fanImageView.frame = CGRectMake(ViewX(timePointView1)+ViewWidth(timePointView1), ViewY(timePointView1), 8, 20);
        
        YXTraveAutoView *morningLable = (YXTraveAutoView *)[self.view viewWithTag:6000+i];
        morningLable.frame = CGRectMake(ViewX(fanImageView)+ViewWidth(fanImageView)+5,ViewY(fanImageView) ,windowContentWidth - ViewX(fanImageView)-ViewWidth(fanImageView), 20);
        
        YXTraveAutoView *AfterLable = (YXTraveAutoView *)[self.view viewWithTag:7000+i];
        AfterLable.frame = CGRectMake(ViewX(morningLable),ViewY(morningLable)+ViewHeight(morningLable) ,ViewWidth(morningLable), 20);
        
        YXTraveAutoView *eveningLable = (YXTraveAutoView *)[self.view viewWithTag:8000+i];
        eveningLable.frame = CGRectMake(ViewX(morningLable),ViewY(AfterLable)+ViewHeight(AfterLable) ,ViewWidth(morningLable), 20);
        
        UIView *sleepImageView =(UIView *) [self.view viewWithTag: 10000+i];
        sleepImageView.frame = CGRectMake(ViewX(timePointView1)+ViewWidth(timePointView1), ViewY(eveningLable)+ViewHeight(eveningLable), 23/2, 20);
        YXTraveAutoView *bedLable = (YXTraveAutoView *)[self.view viewWithTag:11000+i];
        bedLable.frame = CGRectMake(ViewX(morningLable),ViewY(eveningLable)+ViewHeight(eveningLable) ,ViewWidth(morningLable), 20);
        [bedLable setContentText:scheduleData.room];
        
        UIView *line2 =(UIView *) [self.view viewWithTag: 12000+i];
        line2.frame = CGRectMake(ViewX(line), ViewY(timePointView1)+ViewHeight(timePointView1), 0.5, ViewHeight(bedLable)+ViewY(bedLable) - ViewY(timePointView1)-ViewHeight(timePointView1)+10);
        
        UIView *scheduView = (UIView *)[self.view viewWithTag:500+i];
        
        scheduView.frame = CGRectMake(0, height+10, windowContentWidth, ViewHeight(bedLable)+ViewY(bedLable));
        height = ViewHeight(scheduView)+ height;
        detailView.frame=CGRectMake(0, ViewY(overView), windowContentWidth, height);
    }
}


@end

