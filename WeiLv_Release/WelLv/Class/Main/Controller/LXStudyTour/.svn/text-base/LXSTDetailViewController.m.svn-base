//
//  LXSTDetailViewController.m
//  WelLv
//
//  Created by 刘鑫 on 15/8/20.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXSTDetailViewController.h"
#import "LXChooseDateViewController.h"
#import "YXWebDetailViewController.h"
#import "HouseKeeperViewController.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "ZFJCallStewardVC.h"
#import "LXGetCityIDTool.h"
#import "ZFJCallVC.h"

#import "YXOrderViewController.h"
#import "ShareCustom.h"
#define schedluImageHeight 100
#define M_COLL_RESERVE_BUT_HEIGHT 40
static CGFloat kImageOriginHight = 200.f;
@interface LXSTDetailViewController ()<UIActionSheetDelegate>
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
    
    LXSTDetailModel *traveData;
    //LXSTDetailModel *stDetailModel;
    CGFloat height ;
    UIView *grayView;
    NSMutableArray * nameArr ;          //管家名字数组
    NSMutableArray * iconImage;         //管家图像数组
    NSMutableArray * phoneArr;          //管家电话数组
    
    NSString *shareImageURL;  //分享产品的图片
    NSString *shareURL;       //分享跳转的URL
    UIImage *_shareImage;
}
@property (nonatomic, strong) NSMutableArray * stewardArray;//管家数组；

@end

@implementation LXSTDetailViewController
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
        self.productId = @"9";
    }
    
    //创建分享按钮功能
    [self addNavChooseBut];
    
    [self loadTraveData];
    height =0;
 
}

- (void)loadTraveData
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    NSMutableDictionary *parment = [NSMutableDictionary dictionary];
   
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward)
    {
        
        [parment setObject:[[WLSingletonClass defaultWLSingleton] wlUserStewardID] forKey:@"assistant_id"];
        
    }
    [parment setObject:self.productId forKey:@"id"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:StudyTourDetailUrl parameters:parment success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         
         NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         DLog(@"游学产品==%@",json);
         traveData = [[LXSTDetailModel alloc] init];
         traveData = JsonStringTransToObject([json objectForKey:@"data"], @"LXSTDetailModel");
         
         [self initScrollView];
     
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
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
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(chooseBut) - 18, (ViewHeight(chooseBut) - 21) / 2.0, 24,24)];
    icon.image = [UIImage imageNamed:@"分享1"];
    [chooseBut addSubview:icon];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chooseBut];
    
    
    shareURL=YOOSURE_SHARE_URL(self.productId);
    
}

#pragma mark - 分享按钮 点击事件
- (void)shareShop:(UIButton *)sender
{
    
    //分享的内容
    NSString *content=traveData.yoosure_name;
    content=[content stringByAppendingString:@"\r\n"];
    content=[content stringByAppendingFormat:@"本产品由%@提供服务。微旅,您家门口的旅行管家", [self judgeReturnString:traveData.company withReplaceString:@""]];
    
    
    NSString *desc=[NSString stringWithFormat:@"本产品由%@提供服务。微旅,您家门口的旅行管家", [self judgeReturnString:traveData.company withReplaceString:@""]];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:[ShareSDK jpegImageWithImage:_shareImage quality:1]
                                                title:traveData.yoosure_name
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

- (void)initScrollView
{
    _scrollVIew = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight- 64-40)];
    _scrollVIew.backgroundColor = [UIColor whiteColor];
    _scrollVIew.delegate = self;
    [self.view addSubview:_scrollVIew];
    [self showTopImageView];
    [self isOverView:traveData.feature];
    [self isDetailView];
    [self isCommitView];
    [self showButtomBtn];
    
}
- (void)showTopImageView
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    YXAlbum_list1 *albumData = [[YXAlbum_list1 alloc] init];
    for (int i=0; i<traveData.album.count; i++) {
        NSString *imageName ;
        albumData=[traveData.album objectAtIndex:i];
        //[albumData setValuesForKeysWithDictionary:[traveData.album objectAtIndex:i]];

        if (albumData.picture != nil) {
            if ([albumData.picture hasPrefix:@"https://"]||[albumData.picture hasPrefix:@"http://"]) {
                imageName = albumData.picture;
            }else{
                imageName = [WLHTTP stringByAppendingString:albumData.picture];
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
    if (traveData.album==nil) {
        _headerImageVIew.pageControl.hidden=YES;
    }
 
    [_scrollVIew addSubview:self.headerImageVIew];
    
    _productName = [YXTools allocLabel:traveData.yoosure_name font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(10,ViewHeight(self.headerImageVIew), windowContentWidth-10*2, 20) textAlignment:0];
    CGSize size=[self sizeWithString:traveData.yoosure_name font:systemFont(15)];
   
    _productName.numberOfLines=0;
    [_productName setFrame:CGRectMake(10, ViewBelow(self.headerImageVIew), windowContentWidth-10*2, size.height)];
    
    [_scrollVIew addSubview:_productName];
    
    _introductLabel = [YXTools allocLabel:[NSString stringWithFormat:@"本产品由%@提供服务",traveData.company] font:systemFont(13) textColor:[UIColor grayColor] frame:CGRectMake(10, ViewBelow(_productName)+5, windowContentWidth-10*2, 20) textAlignment:0];
    [_scrollVIew addSubview:_introductLabel];
    _priceLable = [YXTools allocLabel:@"" font:systemBoldFont(15) textColor:kColor(255, 96, 126) frame:CGRectMake(10,  ViewBelow(_introductLabel), windowContentWidth-20, 30) textAlignment:0];
    _priceLable.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=font-size:13px;color:#E53333;>微旅价</span><span style=color:#E53333;>：</span><span style=font-size:18px;color:#E53333;>¥<span style=font-size:18px;> %@</span></span><span style=font-size:16px;color:#E53333;></span><span style=color:#E53333;>起</span><span style=color:#E53333;></span>", [self judgeReturnString:traveData.camper_price withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    DLog(@"%@",traveData.yoosure_name);
   
    [_priceLable sizeToFit];
    [_scrollVIew addSubview:_priceLable];
    
    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"])
    {
        UILabel * commissionLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(_priceLable) + 5, ViewY(_priceLable), 80, ViewHeight(_priceLable))];
        commissionLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=font-size:13px;color:#009900;>返佣</span><span style=color:#009900;>：</span><span style=font-size:18px;color:#009900;>¥<span style=font-size:18px;> %@</span></span><span style=font-size:16px;color:#009900;></span>", [self judgeReturnString:[NSString stringWithFormat:@"%0.2f",[traveData.gj_camper_rebate floatValue]] withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        [commissionLabel sizeToFit];
        ;
        [_scrollVIew addSubview:commissionLabel];
    }

    
    
    
    grayView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(_priceLable) + 5, windowContentWidth, 20)];
    grayView.backgroundColor = kColor(240, 241, 242);
    grayView.layer.borderColor = bordColor.CGColor;
    grayView.layer.borderWidth = 0.5;
    [_scrollVIew addSubview:grayView];
    
    
    //切换按钮
    NSArray *btnArr = [NSArray arrayWithObjects:@"概述",@"详情", nil]; //@"评论(0)",
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
- (void)BookClick:(UIButton *)sender
{
    if (sender.tag == 101)
    {
        [self callPhone];
    }
    else
    {


        YXOrderViewController *yxOrderVc=[[YXOrderViewController alloc] init];
        yxOrderVc.orderSource = self.orderSource;
        yxOrderVc.store_id = self.store_id;
        yxOrderVc.visaRegion=traveData.yoosure_name ;
     
        yxOrderVc.isStudyTour=YES;
        yxOrderVc.stadyTourModel=traveData;
        DLog(@"%@",traveData.pay_way);
        [self.navigationController pushViewController:yxOrderVc animated:YES];
        
        
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
        callVC.prodductType = WLProductTypeStudyTour;
        callVC.admin_id = @"";
        callVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        callVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:callVC animated:YES completion:nil];
        
    } else {
        ZFJCallVC * callVC = [[ZFJCallVC alloc] init];
        callVC.admin_id = @"";
        callVC.memberType = [[WLSingletonClass defaultWLSingleton] wlUserType];
        callVC.prodductType = WLProductTypeStudyTour;
        callVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        callVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:callVC animated:YES completion:nil];
        
        __weak LXSTDetailViewController * detailVC = self;
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
        //NSLog(@"+++++++电话咨询+++++++++");
        NSString *url = [houseDetailUrl([[LXUserTool alloc] getKeeper]) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
         {
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             
             NSString * telString = [NSString stringWithFormat:@"tel:%@", [[dic objectForKey:@"data"]objectForKey:@"mobile"]];
             NSLog(@"%@", [[dic objectForKey:@"data"]objectForKey:@"mobile"]);
             NSURL * telUrl = [NSURL URLWithString:telString];
             [[UIApplication sharedApplication] openURL:telUrl];
         }failure:^(AFHTTPRequestOperation *operation,NSError *error){
             NSLog(@"%@", error);
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
             NSLog(@"%@", [[dic objectForKey:@"data"]objectForKey:@"mobile"]);
             NSURL * telUrl = [NSURL URLWithString:telString];
             [[UIApplication sharedApplication] openURL:telUrl];
         }failure:^(AFHTTPRequestOperation *operation,NSError *error){
             NSLog(@"%@", error);
         }];
        
    }
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
    
    NSArray *arr = [NSArray arrayWithObjects:@"费用说明",@"课程安排",@"营地安排",@"赠送项目",@"温馨提示",@"签证须知",@"行前准备", nil];
    NSArray *imageArr = [NSArray arrayWithObjects:@"new费用说明",@"课程安排",@"营地安排",@"赠送项目",@"温馨提示",@"new预定须知",@"行前准备", nil];
    
    CGFloat size = [YXTools returnTextCGRectText:proIntroduct textFont:15].size.height;
    overView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(sectionBtn), windowContentWidth, 50*arr.count+20+size)];
//    UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 25, 25)];
//    leftImage.image = [UIImage imageNamed:@"产品特色"];
//    [overView addSubview:leftImage];
//    UILabel *proTitle = [YXTools allocLabel:@"产品特色" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(leftImage)+ViewWidth(leftImage)+5,3, 150, 30) textAlignment:0];
//    [overView addSubview:proTitle];
    
//    UIWebView *proDuctDetail = [[UIWebView alloc] initWithFrame:CGRectMake(10, ViewY(proTitle)+ViewHeight(proTitle), windowContentWidth - 20, size)];
//    [proDuctDetail loadHTMLString:proIntroduct baseURL:nil];
//    proDuctDetail.tag = 1;
//    if (![YXTools stringIsNotNullTrim:proIntroduct]) {
//        proDuctDetail.delegate = self;
//    }
//    [overView addSubview:proDuctDetail];
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(proDuctDetail)+ViewHeight(proDuctDetail), windowContentWidth, 0.5)];
//    line.backgroundColor = bordColor;
//    line.tag = 1000;
//    [overView addSubview:line];
    
    
    for (int i=0; i<arr.count; i++) {
        YXSelectBtn *selectedBtn1 = [[YXSelectBtn alloc] initWithFrame:CGRectMake(0, 50*i, windowContentWidth, 50)];
        selectedBtn1.tag = i+2000;
        selectedBtn1.leftView.image = [UIImage imageNamed:[imageArr objectAtIndex:i]];
        selectedBtn1.title.text = [arr objectAtIndex:i];
        [selectedBtn1 addTarget:self action:@selector(clickProductDetail:) forControlEvents:UIControlEventTouchUpInside];
        //selectedBtn1.backgroundColor=[UIColor redColor];
        [overView addSubview:selectedBtn1];
    }
    _scrollVIew.contentSize=CGSizeMake(windowContentWidth, ViewHeight(overView)+ViewY(overView)+50);
    [_scrollVIew addSubview:overView];
}

//展示详细视图
- (void)isDetailView
{
    detailView = [[UIView alloc] initWithFrame:CGRectZero];
    NSArray *imge = [[NSArray alloc] initWithObjects:@"Location_fache", nil];
    NSArray *wenzi = [[NSArray alloc]  initWithObjects:@"出发城市: ", nil];
    
    YXDeparture_info1 *departureData = [[YXDeparture_info1 alloc] init];
    departureData =[traveData.departure_info objectAtIndex:0];
    for (int i=0; i<imge.count; i++) {
        NSString *name = [imge objectAtIndex:i];
        UIImageView *imageV = [YXTools allocImageView:CGRectMake(0, 5+35*i+5, 40, 20) image:[UIImage imageNamed:name]];
        [detailView addSubview:imageV];
        
        NSString *leftstr = [wenzi objectAtIndex:i];
        NSString *total = [NSString stringWithFormat:@"%@",leftstr];
//        if (i==0) {
//            if (departureData.time) {
//                total = [NSString stringWithFormat:@"%@ %@",leftstr,departureData.time];
//                
//            } else {
//                total = [NSString stringWithFormat:@"%@",leftstr];
//                
//            }
//        }else if (i==1)
//        {
            if (traveData.setoff_city) {
                
                total = [NSString stringWithFormat:@"%@ %@",leftstr,traveData.setoff_city];
                
            } else {
                
                total = [NSString stringWithFormat:@"%@",leftstr];
                
            }
//        }else
//        {
//            if (departureData.remark) {
//                
//                total = [NSString stringWithFormat:@"%@ %@",leftstr,departureData.remark];
//                
//            } else {
//                
//                total = [NSString stringWithFormat:@"%@",leftstr];
//                
//            }
//        }
        UILabel *contentLabel = [YXTools allocLabel:total font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(ViewWidth(imageV)+ViewX(imageV), ViewY(imageV)-5, windowContentWidth - ViewWidth(imageV), 30) textAlignment:0];
        [detailView addSubview:contentLabel];
    }
    UIView *Oline = [[UIView alloc] initWithFrame:CGRectMake(5, 35*imge.count+15, windowContentWidth-10, 0.5)];
    Oline.backgroundColor = bordColor;
    [detailView addSubview:Oline];
    
    for (int i=0; i<traveData.schedule.count; i++)
    {
        YXSchedule1 *scheduleData = [[YXSchedule1 alloc] init];
        scheduleData =[traveData.schedule objectAtIndex:i];

        UIView *scheduView =[[UIView alloc] initWithFrame:CGRectZero];
        scheduView.tag = 500+i;
        UIImageView *timePointView = [YXTools allocImageView:CGRectMake(0,ViewHeight(Oline)+ViewY(Oline)+10,30, 15) image:[UIImage imageNamed:@"日程"]];
        if (i>0) {
            timePointView.frame = CGRectMake(0, 10, 30, 15);
        }
        [scheduView addSubview:timePointView];
        UILabel *DayLable = [YXTools allocLabel:[NSString stringWithFormat:@"第%@天",scheduleData.day] font:systemFont(13) textColor:TimeGreenColor frame:CGRectMake(ViewX(timePointView)+ViewWidth(timePointView),ViewY(timePointView) ,50, 20) textAlignment:0];
        [scheduView addSubview:DayLable];
        UILabel *TitleLable = [YXTools allocLabel:scheduleData.title font:systemFont(13) textColor:TimeGreenColor frame:CGRectMake(ViewX(DayLable)+ViewWidth(DayLable),ViewY(timePointView) ,windowContentWidth - ViewWidth(DayLable) - ViewX(DayLable)-10, 20) textAlignment:0];
        [scheduView addSubview:TitleLable];
//        NSLog(@"%@***\n \n\n%@", scheduleData.description, [self filterHTML:scheduleData.description]);
//        CGFloat size = [YXTools returnTextCGRectText:[self filterHTML:scheduleData.description] textFont:18].size.height;
//        DLog(@"gaodu==%f",size);
        UIWebView *scheduleDetailView = [[UIWebView alloc] initWithFrame:CGRectMake(ViewX(DayLable), ViewY(TitleLable)+ViewHeight(TitleLable), windowContentWidth - ViewX(timePointView)-ViewWidth(timePointView), 100)];
        [scheduleDetailView loadHTMLString:scheduleData.description baseURL:nil];
        scheduleDetailView.delegate = self;
        scheduleDetailView.tag = 2+i;
        [scheduleDetailView sizeToFit];
        [scheduView addSubview:scheduleDetailView];
        
        float imageWith = ViewWidth(scheduleDetailView)/2-20;
        UIImageView *imageView1;
        UIImageView *imageView2;
        if (scheduleData.ablum.count >=1) {
            imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(timePointView)+ViewWidth(timePointView)+5, ViewHeight(scheduleDetailView)+ViewY(scheduleDetailView)+10,imageWith , schedluImageHeight)];
            imageView1.tag = 100+i;
            [scheduView addSubview:imageView1];
            imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewX(imageView1)+ViewWidth(imageView1)+10, ViewHeight(imageView1),imageWith , schedluImageHeight)];
            imageView2.tag = 300+i;
            [scheduView addSubview:imageView2];
        }
        for (int j = 0; j < scheduleData.ablum.count; j++) {
            YXAlbum_list1 *ImageData = [[YXAlbum_list1 alloc] init];
            ImageData =[scheduleData.ablum objectAtIndex:j];
            NSString *image;
            if ([ImageData.picture hasPrefix:@"https://"]||[ImageData.picture hasPrefix:@"http://"])
            {
                image=ImageData.picture;
            }else{
                image = [WLHTTP stringByAppendingString:ImageData.picture];
            }
            
            
            if (j==0) {
                DLog(@"图片1----%@",image);
                [imageView1 sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"默认图片3"]];
                imageView1.userInteractionEnabled = YES;
                UITapGestureRecognizer *imagTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBigImage:)];
                [imageView1 addGestureRecognizer:imagTap];
            }
            if (j==1) {
                DLog(@"图片2----%@",image);
                [imageView2 sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"默认图片3"]];
                imageView2.userInteractionEnabled = YES;
                UITapGestureRecognizer *imagTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBigImage1:)];
                [imageView2 addGestureRecognizer:imagTap];
            }
            
        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake((ViewX(timePointView)+ViewWidth(timePointView))/2, ViewY(timePointView)+ViewHeight(timePointView), 0.5, ViewHeight(scheduleDetailView)+15+schedluImageHeight*scheduleData.ablum.count)];
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
        
        if (i==0) {
            if (traveData.schedule.count==1 && [YXTools stringReturnNull:scheduleData.title]==YES) {
                line2.hidden=YES;
                line.hidden=YES;
                bedLable.hidden=YES;
                sleepImageView.hidden=YES;
                eveningLable.hidden=YES;
                AfterLable.hidden=YES;
                morningLable.hidden=YES;
                timePointView1.hidden=YES;
                fanImageView.hidden=YES;
                DayLable.hidden=YES;
                TitleLable.hidden=YES;
                timePointView.hidden=YES;
                
            }
        }
        
        //        scheduView.frame = CGRectMake(0, height+10, windowContentWidth, ViewHeight(bedLable)+ViewY(bedLable));
        //        height = ViewHeight(scheduView)+ height;
        [detailView addSubview:scheduView];
    }
    detailView.frame=CGRectMake(0, ViewY(overView), windowContentWidth, height);
    [_scrollVIew addSubview:detailView];
    detailView.hidden = YES;
}

//过滤html
-(NSString *)filterHTML:(NSString *)html

{
    
    NSScanner * scanner = [NSScanner scannerWithString:html];
    
    NSString * text = nil;
    
    while([scanner isAtEnd]==NO)
        
    {
        
        //找到标签的起始位置
        
        [scanner scanUpToString:@"<" intoString:nil];
        
        //找到标签的结束位置
        
        [scanner scanUpToString:@">" intoString:&text];
        
        //替换字符
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        
    }
    

    
    return html;
    
}

- (void)isCommitView
{
    commitView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(overView), windowContentWidth, windowContentHeight - 230-40)];
    YXCommitView *commitView1 = [[YXCommitView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ViewHeight(commitView)) commentArr:_commitArr];
    [commitView addSubview:commitView1];
    [_scrollVIew addSubview:commitView];
    commitView.hidden = YES;
    
}

- (void)clickProductDetail:(YXSelectBtn *)sender
{

        YXWebDetailViewController *webVC = [[YXWebDetailViewController alloc] init];
        if ([sender.title.text isEqualToString:@"费用说明"]) {
//            NSString *content = [NSString stringWithFormat:@"<span style=color:#99BB00;>费用包含</span><span style=color:#99BB00;></span>\n%@\n<span style=color:#99BB00;>费用不包含</span><span style=color:#99BB00;></span>\n%@",traveData.fee_notice,traveData.fee_not_include];
            NSString *content = [NSString stringWithFormat:@"<span style=color:#99BB00;>费用说明</span><span style=color:#99BB00;></span>\n%@",traveData.fee_notice];

            webVC.webContent = content;
        }else if ([sender.title.text isEqualToString:@"课程安排"])
        {
            NSString *bookStr = [NSString stringWithFormat:@"<span style=color:#99BB00;>课程安排</span><span style=color:#99BB00;></span>\n%@",traveData.course_arrangement];
            webVC.webContent = bookStr;
        }else if ([sender.title.text isEqualToString:@"营地安排"])
        {
            NSString *bookStr = [NSString stringWithFormat:@"<span style=color:#99BB00;>营地安排</span><span style=color:#99BB00;></span>\n%@",traveData.camp_arrangement];
            webVC.webContent = bookStr;
            
        }else if ([sender.title.text isEqualToString:@"赠送项目"])
        {
            NSString *bookStr = [NSString stringWithFormat:@"<span style=color:#99BB00;>赠送项目</span><span style=color:#99BB00;></span>\n%@",traveData.free_project];
            webVC.webContent = bookStr;
        }
        else if ([sender.title.text isEqualToString:@"温馨提示"])
        {
            NSString *bookstr=[NSString stringWithFormat:@"<span style=color:#99BB00;>温馨提示</span><span style=color:#99BB00;></span><br>%@<br>",traveData.notice];
            webVC.webContent = bookstr;
        }else if ([sender.title.text isEqualToString:@"签证须知"])
        {
            NSString *bookStr = [NSString stringWithFormat:@"<span style=color:#99BB00;>签证须知</span><span style=color:#99BB00;></span>\n%@",traveData.visa_notice];
            webVC.webContent = bookStr;
        }else if ([sender.title.text isEqualToString:@"行前准备"])
        {
            NSString *bookStr = [NSString stringWithFormat:@"<span style=color:#99BB00;>行前准备</span><span style=color:#99BB00;></span>\n%@",traveData.before_setoff];
            webVC.webContent = bookStr;
        }
        
        webVC.WebTitle = sender.title.text;
        [self.navigationController pushViewController:webVC animated:YES];
   
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= ViewBelow(grayView)) {
        sectionBtn.frame = CGRectMake(0, scrollView.contentOffset.y, self.view.frame.size.width, 40);
    } else {
        sectionBtn.frame = CGRectMake(0, ViewBelow(grayView), self.view.frame.size.width, 40);
    }
    [scrollView bringSubviewToFront:sectionBtn];
   
    
}

//点击第一张图片
- (void)clickBigImage:(UIGestureRecognizer *)tap
{
    YXSchedule1 *scheduleData = [[YXSchedule1 alloc] init];
    scheduleData =[traveData.schedule objectAtIndex:tap.view.tag - 100];
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [scheduleData.ablum count] ];
    for (int i = 0; i < [scheduleData.ablum count]; i++) {
        // 替换为中等尺寸图片
        YXAlbum_list1 *ImageData = [[YXAlbum_list1 alloc] init];
        ImageData =[scheduleData.ablum objectAtIndex:i];
        NSString * getImageStrUrl = [WLHTTP stringByAppendingString:ImageData.picture];
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
    YXSchedule1 *scheduleData = [[YXSchedule1 alloc] init];
    scheduleData =[traveData.schedule objectAtIndex:tap.view.tag - 300];
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [scheduleData.ablum count] ];
    for (int i = 0; i < [scheduleData.ablum count]; i++) {
        // 替换为中等尺寸图片
        YXAlbum_list1 *ImageData = [[YXAlbum_list1 alloc] init];
        ImageData =[scheduleData.ablum objectAtIndex:i];
        NSString * getImageStrUrl = [WLHTTP stringByAppendingString:ImageData.picture];
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
        YXSchedule1 *scheduleData = [[YXSchedule1 alloc] init];
        scheduleData =[traveData.schedule objectAtIndex:i];
        if (scheduleData.ablum.count >=1) {
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
        if (scheduleData.ablum.count>0) {
            scheduleNumber = 1;
        }else
        {
            scheduleNumber = 0;
        }
        
        UIView *line = (UIView *)[self.view viewWithTag:3000+i];
        line.frame = CGRectMake(ViewX(line),ViewY(line), ViewWidth(line), ViewHeight(webView)+15+scheduleNumber *schedluImageHeight);
        
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

#pragma mark---动态获取label的高度
// 定义成方法方便多个label调用 增加代码的复用性
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(windowContentWidth - 130, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
