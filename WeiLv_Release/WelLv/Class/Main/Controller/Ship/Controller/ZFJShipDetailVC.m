//
//  ZFJShipDetailVC.m
//  WelLv
//
//  Created by 张发杰 on 15/5/19.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJShipDetailVC.h"
#import "IamgeAndLabelView.h"
#import "ZFJShipDetailModel.h"
#import "ZFJNoticeMessageVC.h"
#import "ZFJImageAndTitleButton.h"
#import "ZFJCallStewardVC.h"
#import "YXChoosCabinViewController.h"
#import "LXGetCityIDTool.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "IconAndTitleView.h"
#import "ZFJCallVC.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "UIDefines.h"
#import "ChooseTitleView.h"

#import "ZFJShipItineraryView.h"
#import "ZFJShoreTravelDetailVC.h"
#import "WWHAllTripViewController.h"
#import "YXBannerView.h"
#import "ShareCustom.h"
#define M_TAGVIEW_HEIGHT 30
#define M_HeadImageHeight  self.view.frame.size.width * (333 / 640.0)

#define M_IMAGE_H_W 640 / 333.0
#define M_COLL_RESERVE_BUT_HEIGHT 40
#define M_LEFT_WIDTH 15
@interface ZFJShipDetailVC () <UIScrollViewDelegate, UIActionSheetDelegate, UIViewControllerTransitioningDelegate, UIWebViewDelegate>
{
    NSString *shareImageURL;  //分享产品的图片
    NSString *shareURL;       //分享跳转的URL
    
    UIImage *_shareImage;
}
@property (nonatomic, strong) UIScrollView *detailScrollView;

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIView * tagView;
@property (nonatomic, strong) IamgeAndLabelView * tagType;
@property (nonatomic, strong) IamgeAndLabelView * setSailCity;

@property (nonatomic, strong) UILabel * titleLbel;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * inforLabel;
@property (nonatomic, strong) UIImageView * inforImageView;


@property (nonatomic, strong) UIView * chooseView;
@property (nonatomic, strong) UIView *chooessLine;

@property (nonatomic, strong) UIView *messageView;
@property (nonatomic, strong) UIView *shipRouteView;//邮轮行程
@property (nonatomic, strong) UIView *shipAllDaysView;//邮轮行程所有天数

@property (nonatomic, strong) UILabel *productFeatureLabel;//产品特色视图；

@property (nonatomic, assign) CGFloat chooseViewY;
@property (nonatomic, assign) CGFloat shipRouteOneDayHeight;

@property (nonatomic, strong) ZFJShipDetailModel * shipDetailModel;
@property (nonatomic, strong) NSMutableArray * roomArray;
@property (nonatomic, strong) NSMutableArray * scheduleArray;
@property (nonatomic, strong) NSMutableArray * albumArray;
@property (nonatomic, strong) NSMutableArray * scenesArray;

@property (nonatomic, strong) NSMutableArray * stewardArray;//管家数组；
@property (nonatomic, strong) UIView *callStewardView;//拨打管家列表页面；
@property (nonatomic, strong) UIView *blurView;//模糊页面；

@property (nonatomic, strong) NSArray * roomArr;

@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger tempImageTag;
@property (nonatomic, strong) NSMutableArray *allRoomsArray;

@property (nonatomic, strong) NSMutableArray *allImagesArray;//头视图轮播图图片
//@property (nonatomic, strong) UIScrollView *headImageViewScrollView;

@property (nonatomic, strong) NSTimer *imageScrollTimer;
@property (nonatomic, assign) NSInteger imageCurrentPage;

////

@property (nonatomic, strong) UIButton * tempBut;
@property (nonatomic, strong) UIView * shipLineInforView;
@property (nonatomic, strong) UILabel * shipLineIntroduceBut;
@property (nonatomic, strong) UIImageView * upAndDownIcon;
@property (nonatomic ,strong) NSString *company_id;//公司ID
@property (nonatomic ,strong) NSString *line_id;//航线ID

@property (nonatomic, strong) UIView * commentView;//评论页面；

@property (nonatomic, strong)ChooseTitleView * callView;
/**
 *  修改邮轮增加的(!)
 */

//房间字典;
@property (nonatomic, strong) NSMutableDictionary * roomsDic;
//房间Model字典;
@property (nonatomic, strong) NSMutableDictionary * roomsModelDic;
//行程字典;
@property (nonatomic, strong) NSDictionary * scheduleDic;
//岸上观光线路数组
@property (nonatomic, strong) NSMutableArray *shoreTraveLineArr;
//所有观光天数数组
@property (nonatomic, strong) NSDictionary *allTraveTripArr;
@property (nonatomic, strong) NSMutableDictionary *sortedAllTripDict;
@property (nonatomic, strong) NSString *status;//状态
@property (nonatomic, strong) NSString *pay_way;

@end

@implementation ZFJShipDetailVC

static id _publishContent;//类方法中的全局变量这样用（类型前面加static）


#pragma mark -懒加载
- (NSMutableArray *)roomArray{
    if (_roomArray == nil) {
        _roomArray = [NSMutableArray array];
    }
    return _roomArray;
}
-(NSMutableArray *)allImagesArray
{
    if (_allImagesArray == nil) {
        _allImagesArray = [NSMutableArray array];
    }
    return _allImagesArray;

}
-(NSMutableArray *)allRoomsArray
{
    
    if (_allRoomsArray == nil) {
        _allRoomsArray = [NSMutableArray array];
    }
    return _allRoomsArray;
    
}
- (NSMutableArray *)scheduleArray{
    if (_scheduleArray == nil) {
        self.scheduleArray = [NSMutableArray array];
    }
    return _scheduleArray;
}

- (NSMutableArray *)scenesArray{
    if (_scenesArray == nil) {
        self.scenesArray = [NSMutableArray array];
    }
    return _scenesArray;
}

- (NSMutableArray *)albumArray{
    if (_albumArray == nil) {
        self.albumArray = [NSMutableArray array];
    }
    return _albumArray;
}

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.imageCurrentPage = 0;
    self.sortedAllTripDict = [NSMutableDictionary dictionary];
    self.title = @"邮轮详情";
    self.view.backgroundColor = [UIColor whiteColor];
    self.shipAllDaysView = [[UIView alloc] init];
    //创建分享按钮
    [self addNavChooseBut];
    [self loadData];
    [self addDetailScrollView];
}
#pragma mark - 内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 加载邮轮详情滑动图；
- (void)addDetailScrollView
{
    self.detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - self.navigationController.navigationBar.frame.size.height - M_COLL_RESERVE_BUT_HEIGHT - [[UIApplication sharedApplication] statusBarFrame].size.height)];
    self.detailScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, 1000);
    //self.detailScrollView.delegate = self;
    [self.view addSubview:_detailScrollView];
    [self addCollAndReserveBut];
}
#pragma mark - 加载头部信息视图
- (void)addHeadMessageView
{
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, M_HeadImageHeight)];
    [self.detailScrollView addSubview:self.headImageView];
    
    NSMutableArray *imageStrArray = [NSMutableArray array];
    if (self.allImagesArray != nil && self.allImagesArray.count > 0) {
        for (int i =0; i < self.allImagesArray.count; i++) {
            NSDictionary *imageDic = self.allImagesArray[i];
            NSString *imageStr = [NSString stringWithFormat:@"%@/%@", WLHTTP, imageDic[@"picture"]];
            [imageStrArray addObject:imageStr];
            if (i==0) {
                //获取分享产品的图片
                shareImageURL=imageStr;
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareImageURL]];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _shareImage = [UIImage imageWithData:imageData];
                    });
                });
            }
         }
         YXBannerView *bannerView = [[YXBannerView alloc] initWithFrameRect:CGRectMake(0, 0, self.view.frame.size.width, M_HeadImageHeight) ImageArray:imageStrArray];
        [self.detailScrollView addSubview:bannerView];
    }
    else
    {
        self.headImageView.image = [UIImage imageNamed:@"default_bg_view_750_400"];
    }
    
    self.tagView = [[UIView alloc] initWithFrame:CGRectMake(0, M_HeadImageHeight - M_TAGVIEW_HEIGHT, self.headImageView.frame.size.width, M_TAGVIEW_HEIGHT)];
    self.tagView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    self.tagType = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(10, 5, 90, 15)];
    self.tagType.infoLanel.text = [NSString stringWithFormat:@"%@",self.shipDetailModel.line_name];
    self.tagType.infoLanel.textColor = [UIColor whiteColor];
    self.tagType.infoLanel.font = [UIFont systemFontOfSize:12];
    self.tagType.iconIamge.image = [UIImage imageNamed:@"邮轮航线"];
    
    [self.tagView addSubview:_tagType];
    
    self.setSailCity = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(100, 5, 100, 15)];
    
    self.setSailCity.infoLanel.text = [NSString stringWithFormat:@"%@出发", [self judgeReturnString:self.shipDetailModel.harbor_name withReplaceString:@""]];
    self.setSailCity.infoLanel.textColor = [UIColor whiteColor];
    self.setSailCity.infoLanel.font = [UIFont systemFontOfSize:12];
    self.setSailCity.iconIamge.image = [UIImage imageNamed:@"送达1"];
    
    [self.tagView addSubview:_setSailCity];
    self.detailScrollView.userInteractionEnabled = YES;
    
    [self.detailScrollView addSubview:_tagView];
}



#pragma mark - 加载标题信息视图；
- (void)addTitilMsgView
{
    
    UIView * aView = [[UIView alloc] init];
    aView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.detailScrollView addSubview:aView];
    
    UIView * titleAndPriceView = [[UIView alloc] init];
    titleAndPriceView.backgroundColor = [UIColor whiteColor];
    
    
    self.titleLbel = [[UILabel alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, 5, windowContentWidth - 30, 60)];
    self.titleLbel.numberOfLines = 2;
    self.titleLbel.text = self.shipDetailModel.product_name;
    self.titleLbel.backgroundColor = [UIColor whiteColor];
    self.titleLbel.font = [UIFont systemFontOfSize:17];
    [self.titleLbel sizeToFit];
    [titleAndPriceView addSubview:_titleLbel];
    
    UILabel * providerLabel = [[UILabel alloc] init];
    providerLabel.textAlignment = NSTextAlignmentLeft;
    providerLabel.textColor = [UIColor grayColor];
    providerLabel.numberOfLines = 0;
    providerLabel.font = [UIFont systemFontOfSize:13];
    if ([self judgeString:self.shipDetailModel.company_name]) {
        providerLabel.text = [NSString stringWithFormat:@"本产品由%@提供服务",self.shipDetailModel.supplier_name];
    } else {
        providerLabel.text = @"";
    }
    
    providerLabel.frame = CGRectMake(M_LEFT_WIDTH, ViewY(_titleLbel) + ViewHeight(_titleLbel) + 5, windowContentWidth - M_LEFT_WIDTH *2, [self returnTextCGRectText:providerLabel.text textFont:13 cGSize:CGSizeMake(windowContentWidth - M_LEFT_WIDTH *2, 0)].size.height);
    
    [titleAndPriceView addSubview:providerLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, ViewHeight(providerLabel) + ViewY(providerLabel), windowContentWidth - M_LEFT_WIDTH * 2, 30)];
    self.priceLabel.backgroundColor = [UIColor whiteColor];
    self.priceLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=font-size:13px;color:#E53333;>微旅价</span><span style=color:#E53333;>：</span><span style=font-size:18px;color:#E53333;>¥<span style=font-size:18px;> %@</span></span><span style=font-size:16px;color:#E53333;></span><span style=color:#E53333;>起</span><span style=color:#E53333;></span>", [self judgeReturnString:self.shipDetailModel.min_price withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [titleAndPriceView addSubview:_priceLabel];
    
    titleAndPriceView.frame = CGRectMake(0, ViewBelow(_headImageView), windowContentWidth, ViewBelow(_priceLabel) + 5);
    [self.detailScrollView addSubview:titleAndPriceView];
    
    self.shipLineIntroduceBut = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewHeight(titleAndPriceView) + ViewY(titleAndPriceView) + 1, windowContentWidth, 45)];
    self.shipLineIntroduceBut.backgroundColor = [UIColor whiteColor];
    self.shipLineIntroduceBut.text = @"   邮轮介绍";
    self.shipLineIntroduceBut.userInteractionEnabled = YES;
    self.shipLineIntroduceBut.font = [UIFont systemFontOfSize:14];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showShipLineInforView:)];
    [self.shipLineIntroduceBut addGestureRecognizer:tap];
    
    self.upAndDownIcon = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 30, ViewHeight(titleAndPriceView) + ViewY(titleAndPriceView) + 1 +(45 - 10) / 2 , 10, 17)];
    self.upAndDownIcon.backgroundColor = [UIColor whiteColor];
    self.upAndDownIcon.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.upAndDownIcon.image = [UIImage imageNamed:@"矩形-32"];
    [self.detailScrollView addSubview:self.shipLineIntroduceBut];
    [self.detailScrollView addSubview:self.upAndDownIcon];
    
    self.shipLineInforView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(self.shipLineIntroduceBut), windowContentWidth, 10)];
    self.shipLineInforView.backgroundColor = [UIColor whiteColor];
    
    self.inforLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, 0, windowContentWidth - M_LEFT_WIDTH * 2, 10)];
    
    self.inforLabel.attributedText = [[NSAttributedString alloc] initWithData:[self.shipDetailModel.features dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.inforLabel.text = [self filterHTML:self.shipDetailModel.features_sub];//
    self.inforLabel.font = [UIFont systemFontOfSize:13];
    self.inforLabel.numberOfLines = 0;
    [self.inforLabel sizeToFit];
    self.inforLabel.textColor = [UIColor grayColor];
    [self.shipLineInforView addSubview:_inforLabel];
    
    self.inforImageView = [[UIImageView alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, ViewHeight(_inforLabel) + ViewY(_inforLabel) + 10, windowContentWidth - M_LEFT_WIDTH * 2 , 200)];
    if (self.shipDetailModel.line_thumb.length == 0) {
        self.inforImageView.frame = CGRectMake(M_LEFT_WIDTH, ViewHeight(_inforLabel) + ViewY(_inforLabel) + 10, windowContentWidth - M_LEFT_WIDTH * 2 , 0);
    }
    //[self.inforImageView sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:self.shipDetailModel.line_thumb]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    [self.shipLineInforView addSubview:_inforImageView];
    
    aView.frame = CGRectMake(0, ViewHeight(self.headImageView) + ViewY(self.headImageView), windowContentWidth, ViewBelow(self.inforImageView) + 15);
    self.shipLineInforView.frame = CGRectMake(0, ViewBelow(self.shipLineIntroduceBut), windowContentWidth, ViewBelow(_inforLabel) + 5);
    
    self.shipLineInforView.hidden = YES;
    [self.detailScrollView addSubview:self.shipLineInforView];
    
}


//“邮轮详情”中，“邮轮介绍”展示的内容（文字）
- (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        
        [scanner scanUpToString:@">" intoString:&text];
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return html;
}

- (void)showShipLineInforView:(UITapGestureRecognizer *)tap
{
    tap.enabled = NO;
    if (self.shipLineInforView.hidden == YES)
    {
        [UIView animateWithDuration:0 animations:^{
            self.upAndDownIcon.transform = CGAffineTransformMakeRotation(-M_PI_2);
            
            self.chooseView.frame = CGRectMake(0, ViewBelow(self.shipLineInforView) + 10, windowContentWidth, 40);
            self.chooseViewY = ViewBelow(self.shipLineInforView) + 10;
            self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, self.detailScrollView.contentSize.height + ViewHeight(self.shipLineInforView));
            self.shipLineInforView.hidden = NO;
        }];
    }
    else if (self.shipLineInforView.hidden == NO)
    {
        [UIView animateWithDuration:0 animations:^{
            self.upAndDownIcon.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.chooseView.frame = CGRectMake(0, ViewBelow(self.shipLineIntroduceBut) + 10, windowContentWidth, 40);
            self.chooseViewY = ViewBelow(self.shipLineIntroduceBut) + 10;
            self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, self.detailScrollView.contentSize.height - ViewHeight(self.shipLineInforView));
            self.shipLineInforView.hidden = YES;
            
        }];
    }
    
    [UIView animateWithDuration:0 animations:^{
        self.messageView.frame = CGRectMake(0, ViewBelow(self.chooseView), windowContentWidth, ViewHeight(self.messageView));
        self.shipRouteView.frame = CGRectMake(0, ViewBelow(self.chooseView), windowContentWidth, ViewHeight(self.shipRouteView));
        self.shipAllDaysView.frame = CGRectMake(0, ViewBelow(self.shipRouteView) + 10, windowContentWidth, ViewHeight(self.shipAllDaysView));
        [self.view viewWithTag:999].center = CGPointMake(SelfViewWidth/2.0 - 5, ViewBelow(_shipAllDaysView) - 30);
        self.commentView.frame = CGRectMake(0, ViewBelow(self.chooseView), windowContentWidth, ViewHeight(self.commentView));
    }];
    
    tap.enabled = YES;
    
}



#pragma mark - 加载选择概述、行程视图；
- (void)addChooesView
{
    self.chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(self.shipLineIntroduceBut) + 10, windowContentWidth, 40)];
    self.chooseViewY = ViewBelow(self.shipLineIntroduceBut) + 10;
    
    self.chooseView.backgroundColor = [UIColor whiteColor];
    
    
    NSArray * chooseTitleArr = @[@"概述", @"行程"]; //, @"评论"
    for (int i = 0; i < chooseTitleArr.count; i++)
    {
        UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(ViewWidth(_chooseView) / chooseTitleArr.count * i + 0.5 * i, 0, ViewWidth(_chooseView) / chooseTitleArr.count, ViewHeight(_chooseView));
        [but setTitle:[chooseTitleArr objectAtIndex:i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(chooseBut:) forControlEvents:UIControlEventTouchUpInside];
        but.backgroundColor = [UIColor whiteColor];
        if (i == 0)
        {
            [but setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            self.tempBut = but;
        }
        [self.chooseView addSubview:but];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(ViewX(but) - 0.5, 5, 0.5, ViewHeight(_chooseView) - 10)];
        lineView.backgroundColor = [UIColor orangeColor];
        [self.chooseView addSubview:lineView];
    }
    self.chooessLine = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth(_chooseView) / chooseTitleArr.count * 0.1, 40 - 2.5, ViewWidth(_chooseView) / chooseTitleArr.count * 0.8, 2)];
    self.chooessLine.backgroundColor = [UIColor orangeColor];
    [self.chooseView addSubview:_chooessLine];
    
    [self.detailScrollView addSubview:_chooseView];
    
    [self.view addSubview:_detailScrollView];
    
    
}

#pragma mark - 选择概述、行程视图  点击事件方法
- (void)chooseBut:(UIButton *)button
{
    button.enabled = NO;
    
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _chooessLine.frame = CGRectMake(ViewX(button) + ViewWidth(button) * 0.1, ViewHeight(_chooseView) - 2.5, ViewWidth(button) * 0.8, 2);
    } completion:nil];
    if (![button isEqual:self.tempBut])
    {
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.tempBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    self.tempBut = button;
    
    if ([button.titleLabel.text isEqual:@"概述"])
    {
        if (self.messageView == nil)
        {
            self.shipRouteView.hidden = YES;
            self.shipAllDaysView.hidden = YES;
            self.commentView.hidden = YES;
            [self addMessageView];
        }
        else
        {
            self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(_messageView) + ViewHeight(_messageView));
            self.messageView.hidden = NO;
            self.shipRouteView.hidden = YES;
            self.shipAllDaysView.hidden = YES;
            self.commentView.hidden = YES;
        }
        
    }
    else if ([button.titleLabel.text isEqual:@"行程"])
    {
        if (self.shipRouteView == nil)
        {
            _messageView.hidden = YES;
            _commentView.hidden = YES;
            [self addShipRouteView];
        }
        else
        {
            self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(_shipAllDaysView) + ViewHeight(_shipAllDaysView));
            _shipRouteView.hidden = NO;
            _shipAllDaysView.hidden = NO;
            _messageView.hidden = YES;
            _commentView.hidden = YES;
            
        }
        
    }
    else if ([button.titleLabel.text isEqual:@"评论"])
    {
        DLog(@"2");
        if (self.commentView == nil)
        {
            _messageView.hidden = YES;
            _shipRouteView.hidden = YES;
            _shipAllDaysView.hidden = YES;
            [self addCommentView];
        }
        else
        {
            self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_commentView));
            _commentView.hidden = NO;
            _shipRouteView.hidden = YES;
            _shipAllDaysView.hidden = YES;
            _messageView.hidden = YES;
            
        }
        
    }
    
    button.enabled = YES;
}

#pragma mark  - 加载评论视图
- (void)addCommentView
{
//    self.commentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.chooseViewY + ViewHeight(_chooseView), windowContentWidth, windowContentWidth - 40)];
//    self.commentView.backgroundColor = [UIColor whiteColor];
//    UIImageView * noCommImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, windowContentWidth - 60, windowContentWidth - 60)];
//    noCommImage.backgroundColor = [UIColor whiteColor];
//    noCommImage.image = [UIImage imageNamed:@"没找到相关内容"];
//    [self.commentView addSubview:noCommImage];
//    [self.detailScrollView addSubview:self.commentView];
//    self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_commentView));
}

- (void)addCollAndReserveBut
{
    
    UIButton * collButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collButton.frame = CGRectMake(0, self.view.frame.size.height - 64 - M_COLL_RESERVE_BUT_HEIGHT, self.view.frame.size.width / 2, M_COLL_RESERVE_BUT_HEIGHT);
    [collButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    collButton.backgroundColor = kColor(40, 218, 171);
    [collButton addTarget:self action:@selector(collButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collButton];
    
    UIButton * reserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reserveButton.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height - 64 - M_COLL_RESERVE_BUT_HEIGHT, self.view.frame.size.width / 2, M_COLL_RESERVE_BUT_HEIGHT);
    reserveButton.backgroundColor = kColor(254, 204, 65);
    [reserveButton setTitle:@"立即预订" forState:UIControlStateNormal];
    [reserveButton addTarget:self action:@selector(reserveBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reserveButton];
    
}

#pragma mark -添加概述视图
- (void)addMessageView
{
    
    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(0, self.chooseViewY + ViewHeight(_chooseView), windowContentWidth, 200)];
    self.messageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    IconAndTitleView * setsailTimeView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 45) iconImageName:@"开航日期" titleLabel:@"开航日期"];
    [self.messageView addSubview:setsailTimeView];
    
    
    UILabel * setsailTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth - 155, 0, 140, 30)];
    setsailTimeLabel.font = [UIFont systemFontOfSize:15];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[self.shipDetailModel.setoff_date doubleValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //[formatter setDateFormat:@"yyyy-MM-dd EE"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *setsailTimeDay=[self featureWeekdayWithDate:[formatter stringFromDate:date]];//周几
    NSString *setsailTimeDate=[formatter stringFromDate:date];//日期
    setsailTimeDate=[setsailTimeDate stringByAppendingString:@""];
    if (setsailTimeDay!=nil) {
        setsailTimeDate=[setsailTimeDate stringByAppendingString:setsailTimeDay];
    }
    
    
    setsailTimeLabel.text = setsailTimeDate;
    setsailTimeLabel.textAlignment = NSTextAlignmentRight;
    [setsailTimeView addSubview:setsailTimeLabel];
    
    
    IconAndTitleView * productFeatureView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewY(setsailTimeView) + ViewHeight(setsailTimeView) + 0.5, windowContentWidth, 45) iconImageName:@"产品特色" titleLabel:@"产品特色"];
    [self.messageView addSubview:productFeatureView];
    
    
    
    self.productFeatureLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, ViewHeight(productFeatureView) + ViewY(productFeatureView), windowContentWidth - M_LEFT_WIDTH * 2, 10)];
    self.productFeatureLabel.backgroundColor = [UIColor whiteColor];
    self.productFeatureLabel.textColor = [UIColor grayColor];
    self.productFeatureLabel.font = [UIFont systemFontOfSize:17];
    
    self.productFeatureLabel.attributedText = [[NSAttributedString alloc] initWithData:[self.shipDetailModel.features dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.productFeatureLabel.numberOfLines = 0;
    [self.productFeatureLabel sizeToFit];
    [self.messageView addSubview:_productFeatureLabel];
    
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(_productFeatureLabel), M_LEFT_WIDTH, ViewHeight(_productFeatureLabel))];
    leftView.backgroundColor = [UIColor whiteColor];
    [self.messageView addSubview:leftView];
    
    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(ViewX(_productFeatureLabel) + ViewWidth(_productFeatureLabel), ViewY(_productFeatureLabel), windowContentWidth - ViewX(_productFeatureLabel) + ViewWidth(_productFeatureLabel), ViewHeight(_productFeatureLabel))];
    rightView.backgroundColor = [UIColor whiteColor];
    [self.messageView addSubview:rightView];
    
    
    IconAndTitleView * costExplainView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewHeight(self.productFeatureLabel) + ViewY(self.productFeatureLabel) + 0.5, windowContentWidth, 45) iconImageName:@"new费用说明" titleLabel:@"费用说明"];
    costExplainView.titleLabel.userInteractionEnabled = YES;
    costExplainView.goIcon.hidden = NO;
    [costExplainView chooseTop:^(NSInteger chooseTop) {
        ZFJNoticeMessageVC * noticeMessageVC = [[ZFJNoticeMessageVC alloc] init];
        noticeMessageVC.titleString = @"费用说明";
        noticeMessageVC.sourceStr = @"邮轮";
        noticeMessageVC.textString = [NSString stringWithFormat:@"<h2><span style=color:#99BB00;>费用包含</span></h2>%@<h2><span style=color:#99BB00;>费用不包含</span></h2>%@", _shipDetailModel.cost_include, _shipDetailModel.cost_exclusive];
        [self.navigationController pushViewController:noticeMessageVC animated:YES];
    }];
    
    [self.messageView addSubview:costExplainView];
    
    
    
    IconAndTitleView * noticeView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewY(costExplainView) + ViewHeight(costExplainView) + 0.5, windowContentWidth, 45) iconImageName:@"new预定须知" titleLabel:@"预订须知"];
    noticeView.titleLabel.userInteractionEnabled = YES;
    noticeView.goIcon.hidden = NO;
    [noticeView chooseTop:^(NSInteger chooseTop) {
        ZFJNoticeMessageVC * noticeMessageVC = [[ZFJNoticeMessageVC alloc] init];
        noticeMessageVC.titleString = @"预订须知";
        noticeMessageVC.sourceStr = @"邮轮";
        noticeMessageVC.textString = self.shipDetailModel.book_notice;
        [self.navigationController pushViewController:noticeMessageVC animated:YES];
    }];
    [self.messageView addSubview:noticeView];
    
    
    self.messageView.frame = CGRectMake(0, self.chooseViewY + ViewHeight(_chooseView), windowContentWidth, ViewBelow(noticeView));
    
    
    
    
    [self addShoreTraveLine];
    self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(_messageView) + ViewHeight(_messageView));
    [self.detailScrollView addSubview:self.messageView];
    
}

/**
 *  获取未来某个日期是星期几
 *  注意：featureDate 传递过来的格式 必须 和 formatter.dateFormat 一致，否则endDate可能为nil
 *
 */
- (NSString *)featureWeekdayWithDate:(NSString *)featureDate{
    // 创建 格式 对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置 日期 格式 可以根据自己的需求 随时调整， 否则计算的结果可能为 nil
    formatter.dateFormat = @"yyyy-MM-dd";
    // 将字符串日期 转换为 NSDate 类型
    NSDate *endDate = [formatter dateFromString:featureDate];
    // 判断当前日期 和 未来某个时刻日期 相差的天数
    long days = [self daysFromDate:[NSDate date] toDate:endDate];
    // 将总天数 换算为 以 周 计算（假如 相差10天，其实就是等于 相差 1周零3天，只需要取3天，更加方便计算）
    long day = days >= 7 ? days % 7 : days;
    long week = [self getNowWeekday] + day;
    switch (week) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
            
        default:
            break;
    }
    return nil;
}

/**
 *  计算2个日期相差天数
 *  startDate   起始日期
 *  endDate     截至日期
 */
-(NSInteger)daysFromDate:(NSDate *)startDate toDate:(NSDate *)endDate {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //得到相差秒数
    NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
    int days = ((int)time)/(3600*24);
    int hours = ((int)time)%(3600*24)/3600;
    int minute = ((int)time)%(3600*24)/3600/60;
    if (days <= 0 && hours <= 0&&minute<= 0) {
        NSLog(@"0天0小时0分钟");
        return 0;
    }
    else {
        NSLog(@"%@",[[NSString alloc] initWithFormat:@"%i天%i小时%i分钟",days,hours,minute]);
        // 之所以要 + 1，是因为 此处的days 计算的结果 不包含当天 和 最后一天\
        （如星期一 和 星期四，计算机 算的结果就是2天（星期二和星期三），日常算，星期一——星期四相差3天，所以需要+1）\
        对于时分 没有进行计算 可以忽略不计
        return days + 1;
    }
}

// 获取当前是星期几
- (NSInteger)getNowWeekday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDate *now = [NSDate date];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps weekday];
}

#pragma mark - 行程点击事件
- (void)addShipRouteView
{
    //创建邮轮产品详情-行程视图
    self.shipRouteView = [[UIView alloc] initWithFrame:CGRectMake(0, self.chooseViewY + ViewHeight(_chooseView), windowContentWidth, 500)];
    
    self.shipAllDaysView = [[UIView alloc] initWithFrame:CGRectMake(0, self.chooseViewY + ViewHeight(_chooseView) + 500, windowContentWidth, 500)];
    
    //设置-行程视图背景颜色
    self.shipRouteView.backgroundColor = [UIColor whiteColor];
    self.shipAllDaysView.backgroundColor = [UIColor whiteColor];
    //显示房间类型
    for (int i = 0; i < self.roomArray.count; i++)
    {
        ZFJShipRoom * roomModel = [self.roomArray objectAtIndex:i];
        [self.shipRouteView addSubview:[self roomTypeViewFrame:CGRectMake(0, 95 * i, windowContentWidth, 95) roomModel:roomModel butTage:i]];
    }
    self.shipRouteView.frame = CGRectMake(0, self.chooseViewY + ViewHeight(_chooseView), windowContentWidth, self.roomArray.count * 95);
    
     // 显示时间天数
    NSArray *daysArray = [self.allTraveTripArr allKeys];
    
    NSMutableArray *compareBeforAry = [NSMutableArray array];
    for (NSString *dayStr in daysArray) {
        NSString *lastStr = dayStr.length < 2 ?[NSString stringWithFormat:@"0%@",dayStr]:dayStr;
        [compareBeforAry addObject:lastStr];
    }
    daysArray = [compareBeforAry sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableArray *compareAfterAry = [NSMutableArray array];
    
    for (NSString *dayStr in daysArray) {
        
        NSString *lastStr = [dayStr intValue] < 10 ?[NSString stringWithFormat:@"%@",[dayStr substringWithRange:NSMakeRange(1, 1)]]:dayStr;
        
        [compareAfterAry addObject:lastStr];
    }
    

    int default_line_high = 0;//表示岸上观光某一个view的高度
    int public_Y = 0;
    for (int j = 0; j < compareAfterAry.count; j++) {
        
        NSString *str = compareAfterAry[j];
        NSDictionary *daysDic = self.allTraveTripArr[str];
        if ([daysDic[@"schedule_type"] isEqualToString:@"1"]) {
            default_line_high = 95;
        }
        else
        {
            NSArray *line_array = daysDic[@"tour_list"];
            
            if (!([line_array isEqual:[NSNull null]] ||line_array == nil||line_array.count == 0) ) {
                if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
                    default_line_high = (int)line_array.count * 110  + 95;
                }
                else
                {
                    default_line_high = (int)line_array.count * 85  + 95;
                }
            }
            else {
                default_line_high = 110;
            }
        }
        
        
        UIView *lineView = [self shipAllDaysViewFrame:CGRectMake(0,public_Y, windowContentWidth,default_line_high) dayDic:daysDic butTage:j];
        
        [self.shipAllDaysView addSubview:lineView];
        
        public_Y=ViewBelow(lineView);
      }
    
    CGFloat allHieght;
    
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS){
    
        allHieght = public_Y + 60;
        
    }else{
    
        allHieght = public_Y + 50;
    }
    
    self.shipAllDaysView.frame = CGRectMake(0,10 + self.chooseViewY + ViewHeight(_chooseView) + ViewHeight(self.shipRouteView) , windowContentWidth, allHieght);
    
    self.detailScrollView.contentSize = CGSizeMake(windowContentWidth,ViewY(self.shipAllDaysView) + ViewHeight(self.shipAllDaysView));
    
    [self.detailScrollView addSubview:_shipRouteView];
    [self.detailScrollView addSubview:_shipAllDaysView];

    
    
    if (compareAfterAry.count > 0) {
        UIView *centView = [[UIView alloc] init];
        centView.tag = 999;
        centView.center = CGPointMake(SelfViewWidth/2.0 - 5, ViewBelow(_shipAllDaysView) - 16);
        centView.bounds = CGRectMake(0, 0, 160, 16);
        [self.detailScrollView addSubview:centView];
        self.detailScrollView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeAllTripClick)];
        
        [centView addGestureRecognizer:tap1];
        
       
        
        UIButton *seeAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        seeAllBtn.frame = CGRectMake(0, 0, 142, 16);
        [seeAllBtn setTitle:@"展开完整行程详情" forState:UIControlStateNormal];
        [seeAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        seeAllBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [seeAllBtn addTarget:self action:@selector(seeAllTripClick) forControlEvents:UIControlEventTouchUpInside];
        [centView addSubview:seeAllBtn];
        
        UIImageView *timaeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 40, 12, 12)];
        timaeImageView.frame = CGRectMake(142, 0, 18, 14);
        timaeImageView.image = [UIImage imageNamed:@"详情按钮"];
        [centView addSubview:timaeImageView];
        
        timaeImageView.userInteractionEnabled = YES;


        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeAllTripClick)];
        
        [timaeImageView addGestureRecognizer:tap2];
        centView.userInteractionEnabled = YES;
        self.detailScrollView.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = YES;
        

        
        
     }
}
#pragma  mark  - 展开完整行程详情
-(void)seeAllTripClick
{
    WWHAllTripViewController *allTripViewController = [[WWHAllTripViewController alloc] init];
    allTripViewController.allTripDic = self.sortedAllTripDict.count ? self.sortedAllTripDict : self.allTraveTripArr;
    [self presentViewController:allTripViewController animated:YES completion:nil];
}
#pragma  mark  - 房间类型
- (UIView *)roomTypeViewFrame:(CGRect)frame roomModel:(ZFJShipRoom *)roomModel butTage:(int)i
{
    UIView * roomView = [[UIView alloc] initWithFrame:frame];
    UIImageView * roomIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, 5, ViewHeight(roomView) - 10, ViewHeight(roomView) - 10)];
    if ([roomModel.cabin_thumb hasPrefix:@"http"])
    {
        [roomIconImageView sd_setImageWithURL:[NSURL URLWithString:roomModel.cabin_thumb] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    }
    else
    {
        [roomIconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WLHTTP, roomModel.cabin_thumb]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    }
    roomIconImageView.contentMode = UIViewContentModeScaleAspectFill;
    roomIconImageView.clipsToBounds = YES;
    [roomView addSubview:roomIconImageView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(roomIconImageView) + ViewWidth(roomIconImageView) + 5, 5, frame.size.width -ViewX(roomIconImageView) - ViewWidth(roomIconImageView) - 5 - frame.size.width / 4 -15, (frame.size.height - 10) / 4)];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = roomModel.cabin_name;
    [roomView addSubview:titleLabel];
    NSArray * msgLabelTitleArr = @[[NSString stringWithFormat:@"<span style=color:#999999;>房间面积</span>&nbsp; <span style=color:#ff6600;>%@</span>&nbsp; <span style=color:#999999;>㎡</span>", [self judgeReturnString:roomModel.size withReplaceString:@""]], [NSString stringWithFormat:@"<span style=color:#999999;>入住人数</span>&nbsp;&nbsp; <span style=color:#ff6600;>%@</span>&nbsp;&nbsp; <span style=color:#999999;>人</span>", [self judgeReturnString:roomModel.num withReplaceString:@""]], [NSString stringWithFormat:@"<span style=color:#999999;>楼层 &nbsp;</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span style=color:#ff6600;>%@</span>&nbsp; <span style=color:#999999;></span>", [self judgeReturnString:roomModel.floors withReplaceString:@""]]];
    for (int i = 0; i < msgLabelTitleArr.count; i++) {
        UILabel * msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(roomIconImageView) + ViewWidth(roomIconImageView) + 5, ViewY(titleLabel) + ViewHeight(titleLabel) + (frame.size.height - 10) / 4 * i, frame.size.width - ViewX(titleLabel), (frame.size.height - 10) / 4)];
        
        msgLabel.attributedText = [[NSAttributedString alloc] initWithData:[[msgLabelTitleArr objectAtIndex:i] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        
        msgLabel.font = [UIFont systemFontOfSize:12];
        
        [roomView addSubview:msgLabel];
    }
    UILabel * roomPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 3/ 4,30, frame.size.width / 4 - 15, frame.size.height  / 2 - 15)];
    roomPriceLabel.textAlignment = NSTextAlignmentCenter;
    
    CGFloat minPrice = 0.0;
    CGFloat third_price = [[self judgeReturnString:roomModel.third_price withReplaceString:@"0"] floatValue];
    CGFloat second_price = [[self judgeReturnString:roomModel.second_price withReplaceString:@"0"] floatValue];
    CGFloat first_price = [[self judgeReturnString:roomModel.first_price withReplaceString:@"0"] floatValue];
    minPrice = first_price > second_price ? second_price : first_price;
    minPrice = minPrice > third_price ? third_price : minPrice;
    
    if (minPrice == 0)
    {
        minPrice = first_price > second_price ? second_price : first_price;
        if (minPrice == 0)
        {
            minPrice = first_price;
        }
    }
    
    
    NSString *lastPriceStr = nil;
    NSString *decimal=nil;//小数点临时变量
    if (roomModel.first_price.intValue > 0 && roomModel.second_price.intValue > 0 && roomModel.third_price.intValue > 0) {
        lastPriceStr = roomModel.third_price;
    }
    else if(roomModel.first_price.intValue > 0 && roomModel.second_price.intValue > 0 && roomModel.third_price.intValue <= 0)
    {
        lastPriceStr = roomModel.second_price;
    
    }
    else
    {
        lastPriceStr = roomModel.first_price;
    }
    
    lastPriceStr=[NSString stringWithFormat:@"%.2f",[lastPriceStr floatValue] ];
    
    NSRange range = [lastPriceStr rangeOfString:@"."]; //现获取要截取的字符串位置
    decimal= [lastPriceStr substringFromIndex:range.location]; //截取字符串
    
    
    
    
    roomPriceLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#E53333;font-size:16px;>¥ %@</span><span style=color:#E53333;font-size:10px;>%@<span><span style=color:#999999;font-size:10>&nbsp;起</span>", [NSString stringWithFormat:@"%d", [lastPriceStr intValue]],decimal] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    [roomPriceLabel sizeToFit];
    [roomView addSubview:roomPriceLabel];
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward)
    {
        UILabel * commissionLab = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width * 3 / 4, ViewBelow(roomPriceLabel) + 5, frame.size.width / 4 -15, 15)];
        
        commissionLab.attributedText =[[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=color:#000000;font-size:12px;>返佣:</span><span style=font-size:12px;color:#FFA500;>￥%@</span><span style=font-size:18px;></span>", [self judgeReturnString:roomModel.rebate withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        commissionLab.font = [UIFont systemFontOfSize:12];
        commissionLab.adjustsFontSizeToFitWidth = YES;
        
        [roomView addSubview:commissionLab];
    }
    
    UIButton *reserveBut = [UIButton buttonWithType:UIButtonTypeCustom];
    reserveBut.backgroundColor = kColor(255, 164,97);
    [reserveBut setTitle:@"预定" forState:UIControlStateNormal];
    reserveBut.frame = CGRectMake(frame.size.width * 3 / 4, frame.size.height / 2  +10, frame.size.width / 4 -15, frame.size.height  / 2 - 15);
    reserveBut.layer.masksToBounds = YES;
    reserveBut.layer.cornerRadius = 3.0;
    reserveBut.tag = 50000 + i;
    
    [reserveBut addTarget:self action:@selector(reserveRoomBut:) forControlEvents:UIControlEventTouchUpInside];
    [roomView addSubview:reserveBut];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
    line.backgroundColor = bordColor;
    [roomView addSubview:line];
    return roomView;
}
#pragma  mark  -行程天数显示
-(UIView *)shipAllDaysViewFrame:(CGRect)frame dayDic:(NSDictionary *)dayDic butTage:(int)i
{
    UIView *allDaysView = [[UIView alloc] initWithFrame:frame];
    //显示第几天
    UILabel *dayLable = [YXTools allocLabel:[NSString stringWithFormat:@"第%d天   %@",i+1,dayDic[@"title"]] font:[UIFont systemFontOfSize:15] textColor:[UIColor blackColor] frame:CGRectMake(30,10 ,frame.size.width - 50, 20) textAlignment:0];
    [allDaysView addSubview:dayLable];
    
    //显示左边的线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    lineLabel.backgroundColor = TimeGreenColor;
    [allDaysView addSubview:lineLabel];
    
    //显示左边的图片
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 25, 25)];
    [allDaysView addSubview:backImageView];
    if (i == 0) {
        backImageView.frame = CGRectMake(8, 8, 18, 25);
        lineLabel.frame = CGRectMake(16.5, 32, 1, frame.size.height - 25);
        backImageView.image = [UIImage imageNamed:@"天数图片"];
    }
    else
    {

        lineLabel.frame = CGRectMake(16.5, 0, 1, frame.size.height);
        backImageView.frame = CGRectMake(14.5, 17, 5, 5);
        
        backImageView.image = [UIImage imageNamed:@"椭圆-26-副本"];
    }

    NSString *arrival_timeStr =dayDic[@"arrival_time"];
    NSString *sail_timeStr = dayDic[@"sail_time"];
    NSString *lastArrival_timeStr = [arrival_timeStr isEqualToString:@""]?@"":[NSString stringWithFormat:@"%@抵港",arrival_timeStr];
    NSString *lastSail_timeStr = [sail_timeStr isEqualToString:@""]?@"":[NSString stringWithFormat:@"%@启航",sail_timeStr];
    
    int dayHigh = 0;
     if (!([arrival_timeStr isEqualToString:@""] && [sail_timeStr isEqualToString:@""])) {
         dayHigh = 14;
        //显示航海时间
        UIImageView *timaeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 38, 15, 15)];
        timaeImageView.image = [UIImage imageNamed:@"Clock-2-副本"];
        [allDaysView addSubview:timaeImageView];
         
        UILabel *timaeLable = [YXTools allocLabel:[NSString stringWithFormat:@"航程: %@      %@",lastArrival_timeStr,lastSail_timeStr] font:[UIFont systemFontOfSize:14] textColor:[UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1] frame:CGRectMake(50,40 ,200,dayHigh) textAlignment:0];
         [allDaysView addSubview:timaeLable];
    }
    else
    {
        dayHigh = 0;
     }
    //显示自助餐
    UIImageView *buffetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(23, 50 + dayHigh, 15, 15)];
    buffetImageView.image = [UIImage imageNamed:@"餐饮"];
    [allDaysView addSubview:buffetImageView];
    
    
    NSString *breakfastStr = [dayDic[@"breakfast"] isEqualToString:@"1"]?@"含邮轮餐":@"敬请自理";
    NSString *lunchStr = [dayDic[@"lunch"] isEqualToString:@"1"]?@"含邮轮餐":@"敬请自理";
    NSString *dinnerStr = [dayDic[@"dinner"] isEqualToString:@"1"]?@"含邮轮餐":@"敬请自理";
    

    UILabel *buffetLable =  [[UILabel alloc] initWithFrame:CGRectMake(50,40 + dayHigh,windowContentWidth - 60, 14)];
    buffetLable.backgroundColor = [UIColor clearColor];
    buffetLable.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
    buffetLable.font = [UIFont systemFontOfSize:14];
    buffetLable.numberOfLines = 0;
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        
    buffetLable.frame = CGRectMake(50,45  + dayHigh,windowContentWidth - 60, 40);
    
    }
    else
    {
    buffetLable.frame = CGRectMake(50,50 + dayHigh,windowContentWidth - 60, 20);
    }
    buffetLable.text = [NSString stringWithFormat:@"早餐:%@    午餐:%@    晚餐:%@",breakfastStr,lunchStr,dinnerStr];
    [allDaysView addSubview:buffetLable];
    
    
    
    //岸上观光
    UIImageView *seeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25, ViewBelow(buffetLable) + 10, 15, 15)];
    seeImageView.image = [UIImage imageNamed:@"岸上光"];
    seeImageView.hidden = YES;
    [allDaysView addSubview:seeImageView];
    
    UILabel *seeLable = [YXTools allocLabel:@"岸上观光" font:[UIFont systemFontOfSize:14] textColor:[UIColor blackColor] frame:CGRectMake(50,ViewBelow(buffetLable) + 10,200, 12) textAlignment:0];
    
    UILabel *seeLine = [[UILabel alloc] initWithFrame:CGRectMake(25, ViewBelow(seeLable) + 10, frame.size.width - 30, 0.2)];
    seeLine.backgroundColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    [allDaysView addSubview:seeLine];
    seeLine.hidden = YES;
    
    seeLable.hidden = YES;
    if ([dayDic[@"schedule_type"] isEqualToString:@"1"]) {
        seeImageView.hidden = YES;
        seeLable.hidden = YES;
        seeLine.hidden = YES;
    }
    else
    {
        seeImageView.hidden = NO;
        seeLable.hidden = NO;
        seeLine.hidden = NO;
    }

    if ([dayDic[@"schedule_type"] isEqualToString:@"2"]) {
        NSArray *line_array = dayDic[@"tour_list"];
        CGFloat cellY = (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)?125:110;
       if (!([line_array isEqual:[NSNull null]] ||line_array == nil||line_array.count == 0) )
       {
           for (int a = 0; a < line_array.count; a++) {
               NSDictionary *listDic = line_array[a];
               UIView *view = [self loadLineView:listDic andFrame:CGRectMake(0,cellY, windowContentWidth, 60)];
               cellY = ViewBelow(view);
               
               [allDaysView addSubview:view];
           }
       }
      
    }
    
    [allDaysView addSubview:seeLable];
    return allDaysView;
}

#pragma mark -加载观光路线view
-(UIView *)loadLineView:(NSDictionary *)lineDic andFrame:(CGRect)frame
{
    
    
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width - 80, 10, 80, 20)];
    moneyLabel.backgroundColor = [UIColor clearColor];
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    moneyLabel.textColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    moneyLabel.font = [UIFont systemFontOfSize:14];
    [lineView addSubview:moneyLabel];
    
    NSString *titleAndMoneyStr = nil;
    
    if ([lineDic[@"fee_status"]  isEqualToString:@"1"]) {
        titleAndMoneyStr = [NSString stringWithFormat:@"%@",lineDic[@"tour_name"]];
        moneyLabel.text = @"免费";
    }
    else
    {
    titleAndMoneyStr = [NSString stringWithFormat:@"%@",lineDic[@"tour_name"]];
    moneyLabel.text = [NSString stringWithFormat:@"￥%@",lineDic[@"tour_price"]];
    
    }
    UILabel *lineLable = [YXTools allocLabel:titleAndMoneyStr font:[UIFont systemFontOfSize:14] textColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] frame:CGRectMake(50,10,frame.size.width  - 150, 20) textAlignment:NSTextAlignmentLeft];
    [lineView addSubview:lineLable];
    
    UIWebView *contextView = [[UIWebView alloc] initWithFrame:CGRectMake(40, 28, frame.size.width - 70, 30)];
    contextView.userInteractionEnabled = NO;
    
    NSString * formatString = @"<span style=\"font-size:14px;color:#808080\">%@</span>";
    NSString * htmlString = [NSString stringWithFormat:formatString,lineDic[@"detail"]];
    
    [contextView loadHTMLString:htmlString baseURL:nil];
    [lineView addSubview:contextView];
    
    UILabel *buttomLineLabel = [YXTools allocLabel:nil font:[UIFont systemFontOfSize:14] textColor:[UIColor redColor] frame:CGRectMake(35,63,frame.size.width - 30, 0.2) textAlignment:NSTextAlignmentLeft];
    
    buttomLineLabel.backgroundColor = [UIColor grayColor];
    [lineView addSubview:buttomLineLabel];
    return lineView;
}

#pragma mack ----
- (void)clickBigImage:(UIGestureRecognizer *)tap
{
    
    NSArray * scenesAlbumArr = [[[self.scenesArray objectAtIndex:[tap.view superview].tag - 10000] objectAtIndex:0] objectForKey:@"scenes_album"];
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity: [scenesAlbumArr count] ];
    for (int i = 0; i < scenesAlbumArr.count; i++) {
        // 替换为中等尺寸图片
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@", WLHTTP, [[scenesAlbumArr objectAtIndex:i] objectForKey:@"picture"]] ]; // 图片路径
        
        UIImageView * imageView = (UIImageView *)[self.view viewWithTag: 15000 + ([tap.view superview].tag - 10000) * 2 + i];
        photo.srcImageView = imageView;
        [photos addObject:photo];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.photos = photos; // 设置所有的图片
    NSInteger tapImageTag = tap.view.tag - ([tap.view superview].tag - 10000) * 2 - 15000;
    browser.currentPhotoIndex = tapImageTag;
    [browser show];
}



#pragma mack ---- ChooseButton

//邮轮概述
- (void)messageButton:(UIButton *)button{
    button.enabled = NO;
    UIButton * shipRouteBut = (UIButton *)[self.chooseView viewWithTag:201];
    shipRouteBut.enabled = YES;
    
    self.chooessLine.frame = CGRectMake(10, 40 - 2.5, self.view.frame.size.width / 2 - 20, 2);
    
    if (self.messageView == nil) {
        self.shipRouteView.hidden = YES;
        [self addMessageView];
    } else{
        self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(_messageView) + ViewHeight(_messageView));
        self.messageView.hidden = NO;
        self.shipRouteView.hidden = YES;
    }
}



//邮轮航程
- (void)shipRouteBut:(UIButton *)button{
    button.enabled = NO;
    UIButton * messageBut = (UIButton *)[self.chooseView viewWithTag:200];
    messageBut.enabled  = YES;
    
    self.chooessLine.frame = CGRectMake(self.view.frame.size.width / 2 + 10, 40 - 2.5, self.view.frame.size.width / 2 - 20, 2);
    if (self.shipRouteView == nil) {
        _messageView.hidden = YES;
        [self addShipRouteView];
    }else  {
        self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(_shipRouteView) + ViewHeight(_shipRouteView));
        
        _shipRouteView.hidden = NO;
        _messageView.hidden = YES;
        
    }
}


#pragma mark -房间预订
- (void)reserveRoomBut:(UIButton *)button{
    button.enabled = NO;
    [self addShoreTraveLine];
    YXOrderViewController * chooseCabinVC = [[YXOrderViewController alloc] init];
    chooseCabinVC.orderSource = self.orderSource;
    chooseCabinVC.store_id = self.store_id;
    ZFJShipRoom * roomModel = [self.roomArray objectAtIndex:button.tag - 50000];
    chooseCabinVC.ShoreTraveLineArr = self.shoreTraveLineArr;
    chooseCabinVC.roomsModelDic = self.roomsModelDic;
    chooseCabinVC.shipTypeName = roomModel.type_name;
    chooseCabinVC.shipDataDci = self.roomsDic;
    chooseCabinVC.shipModel = self.shipDetailModel;
    chooseCabinVC.isShip = YES;
    chooseCabinVC.shipTypeId = roomModel.cabin_id;
    chooseCabinVC.visaRegion = self.shipDetailModel.product_name;
    chooseCabinVC.company_id = self.company_id;
    chooseCabinVC.line_id = self.line_id;
    chooseCabinVC.status = self.status;
    chooseCabinVC.pay_way = self.pay_way;
    chooseCabinVC.departureDate = [YXTools getDate:self.shipDetailModel.setoff_date];//行程时间
    [self.navigationController pushViewController:chooseCabinVC animated:YES];
    
    button.enabled = YES;
    
}
#pragma mark -立即预订
- (void)reserveBut:(UIButton *)button{
    button.enabled = NO;
    
    if (![self judgeString:self.shipDetailModel.product_id]) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"对不起!\n当前产品不可预订。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    //岸上
    [self addShoreTraveLine];
    
    /*新下单页面所需参数*/
    YXOrderViewController * chooseCabinVC = [[YXOrderViewController alloc] init];
    chooseCabinVC.orderSource = self.orderSource;
    chooseCabinVC.store_id = self.store_id;
    chooseCabinVC.ShoreTraveLineArr = self.shoreTraveLineArr;
    chooseCabinVC.roomsModelDic = self.roomsModelDic;
    chooseCabinVC.shipDataDci = self.roomsDic;
    chooseCabinVC.shipModel = self.shipDetailModel;
    chooseCabinVC.isShip = YES;
    chooseCabinVC.company_id = self.company_id;
    chooseCabinVC.line_id = self.line_id;
    chooseCabinVC.visaRegion = self.shipDetailModel.product_name;
    chooseCabinVC.departureDate = [YXTools getDate:self.shipDetailModel.setoff_date];
    chooseCabinVC.status = self.status;
    chooseCabinVC.pay_way = self.pay_way;
    [self.navigationController pushViewController:chooseCabinVC animated:YES];
    
    button.enabled = YES;
    
}
/**
 *  加载岸上观光数组
 */
#pragma mark -加载观光数组
- (void)addShoreTraveLine {
    self.shoreTraveLineArr = [NSMutableArray array];
    NSArray * daysArr = @[];
    if ([self.scheduleDic isKindOfClass:[NSDictionary class]] ) {
        daysArr = [[self.scheduleDic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    }
    for (int i = 0; i < daysArr.count; i++) {
        NSString * typeStr = [NSString stringWithFormat:@"%@", [[self.scheduleDic objectForKey:[daysArr objectAtIndex:i]] objectForKey:@"schedule_type"]];
        if ([typeStr isEqualToString:@"2"]){
            if ([[[self.scheduleDic objectForKey:[daysArr objectAtIndex:i]] objectForKey:@"tour_list"] isKindOfClass:[NSArray class]]) {
                NSArray * arr = [[self.scheduleDic objectForKey:[daysArr objectAtIndex:i]] objectForKey:@"tour_list"];
                NSMutableDictionary * shoreTravelDic = [NSMutableDictionary dictionary];
                for (NSDictionary * scheduleDic in arr) {
                    ZFJShoreTraveModel * shoreTraveModel = [[ZFJShoreTraveModel alloc] initWithDictionary:scheduleDic];
                    [shoreTravelDic setObject:shoreTraveModel forKey:shoreTraveModel.tour_id];
                    
                }
                self.shoreTraveLineArr = [NSMutableArray arrayWithArray:[shoreTravelDic allValues]];
            }
        }
    }
}
#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [[PresentingAnimator alloc] init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DismissingAnimator alloc] init];
}

//拨打电话；
- (void)collButton:(UIButton *)button{
    button.enabled = NO;
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember && [[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteward])
    {
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"拨打管家电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拨打管家电话" otherButtonTitles:nil, nil];
        [actionsheet showInView:self.view];
    } else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        ZFJCallVC * callVC = [[ZFJCallVC alloc] init];
        callVC.memberType = WLMemberTypeSteward;
        callVC.prodductType = WLProductTypeVisa;
        callVC.admin_id = self.shipDetailModel.admin_id;
        callVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        callVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:callVC animated:YES completion:nil];
        
    } else {
        ZFJCallVC * callVC = [[ZFJCallVC alloc] init];
        callVC.admin_id = self.shipDetailModel.admin_id;
        callVC.memberType = [[WLSingletonClass defaultWLSingleton] wlUserType];
        callVC.prodductType = WLProductTypeVisa;
        callVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        callVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:callVC animated:YES completion:nil];
        __weak ZFJShipDetailVC * detailVC = self;
        [callVC chooseMoreSteward:^(UIButton *but) {
            ZFJCallStewardVC * callStewardVC = [[ZFJCallStewardVC alloc] init];
            callStewardVC.admin_id = self.shipDetailModel.admin_id;
            [detailVC.navigationController pushViewController:callStewardVC animated:YES];
        }];
    }
    
    button.enabled = YES;
    
}

- (void)hiddenChooesView:(UITapGestureRecognizer *)tap
{
    self.callStewardView.hidden = YES;
    self.blurView.hidden = YES;
    
}

- (void)moreButton:(UIButton *)button {
    self.callStewardView.hidden = YES;
    self.blurView.hidden = YES;
    ZFJCallStewardVC * callStewardVC = [[ZFJCallStewardVC alloc] init];
    [self.navigationController pushViewController:callStewardVC animated:YES];
    
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
             DLog(@"%@", [[dic objectForKey:@"data"]objectForKey:@"mobile"]);
             NSURL * telUrl = [NSURL URLWithString:telString];
             [[UIApplication sharedApplication] openURL:telUrl];
         }failure:^(AFHTTPRequestOperation *operation,NSError *error){
             DLog(@"%@", error);
             
         }];
    }
    
}

//预订需知
- (void)noticeButton:(UIButton *)buton{
    ZFJNoticeMessageVC * noticeMessageVC = [[ZFJNoticeMessageVC alloc] init];
    noticeMessageVC.titleString = @"预订须知 ";
    noticeMessageVC.sourceStr = @"邮轮";
    noticeMessageVC.textString = self.shipDetailModel.notice;
    [self.navigationController pushViewController:noticeMessageVC animated:YES];
    
}
//费用说明
- (void)costExplainButton:(UIButton *)button{
    ZFJNoticeMessageVC * noticeMessageVC = [[ZFJNoticeMessageVC alloc] init];
    noticeMessageVC.titleString = @"费用说明";
    noticeMessageVC.sourceStr = @"邮轮";
    noticeMessageVC.textString = [NSString stringWithFormat:@"%@%@", self.shipDetailModel.cost_include, self.shipDetailModel.cost_exclusive];
    [self.navigationController pushViewController:noticeMessageVC animated:YES];
    
}

#pragma mark ---- LoadData
- (void)loadData{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    NSString * str = [NSString stringWithFormat:@"%@/%@", M_URL_SHIP_DETAIL, self.product_id];
    DLog(@"游轮详情界面URL_str %@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    WS(ws);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        
        if ([dict isKindOfClass:[NSDictionary class]] && [[dict objectForKey:@"status"] integerValue] == 1 && [[dict objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
            if ([[dict objectForKey:@"data"] objectForKey:@"room"] && [[[dict objectForKey:@"data"] objectForKey:@"room"] isKindOfClass:[NSDictionary class]]) {
                ws.roomsModelDic = [NSMutableDictionary dictionary];
                ws.roomsDic = [[dict objectForKey:@"data"] objectForKey:@"room"];
                // self.allRoomsArray  = (NSMutableArray *)[[dict objectForKey:@"data"] objectForKey:@"room"];
                self.status = [[dict objectForKey:@"data"] objectForKey:@"status"];
                self.company_id = [[dict objectForKey:@"data"] objectForKey:@"company_id"];
                self.line_id = [[dict objectForKey:@"data"] objectForKey:@"line_id"];
               id album_list = [[dict objectForKey:@"data"] objectForKey:@"album_list"];
                self.pay_way = [[dict objectForKey:@"data"] objectForKey:@"pay_way"];
                if (![album_list isEqual:[NSNull null]]) {
                   self.allImagesArray = [[dict objectForKey:@"data"] objectForKey:@"album_list"];
                }
                
                NSArray * roomKeyArr = [[[dict objectForKey:@"data"] objectForKey:@"room"] allKeys];
                for (int i = 0; i < roomKeyArr.count; i++) {
                    if ([[[[dict objectForKey:@"data"] objectForKey:@"room"] objectForKey:[roomKeyArr objectAtIndex:i]] isKindOfClass:[NSArray class]]) {
                        NSArray * roomTypeArr = [[[dict objectForKey:@"data"] objectForKey:@"room"] objectForKey:[roomKeyArr objectAtIndex:i]];
                        NSMutableArray * tempArr = [NSMutableArray array];
                        for (NSDictionary * roomDic in roomTypeArr) {
                            
                            ZFJShipRoom * shipRoomModel = [[ZFJShipRoom alloc] initWithDictionary:roomDic];
                            [ws.roomArray addObject:shipRoomModel];
                            [tempArr addObject:shipRoomModel];
                        }
                        [ws.roomsModelDic setValue:tempArr forKey:[roomKeyArr objectAtIndex:i]];
                    }
                }
                
            }
            id schedule = [[dict objectForKey:@"data"] objectForKey:@"schedule"];
            if (![schedule isEqual:[NSNull null]]) {
                
                NSDictionary *scheduleDict = (NSDictionary *)schedule;
                
                NSArray *scheduleKeys = [scheduleDict allKeys];
                
                for(int i = 0; i < scheduleKeys.count; i++){
                    
                    NSMutableDictionary *tourDict = [NSMutableDictionary dictionaryWithDictionary:[scheduleDict objectForKey:[scheduleKeys objectAtIndex:i]]];
                    
                    NSMutableDictionary *sortedTourDict = [NSMutableDictionary dictionary];
                
                    id tourList = [tourDict objectForKey:@"tour_list"];
                    
                    if([tourList isKindOfClass:[NSNull class]]){
                        
                        [tourDict setObject:@"1" forKey:@"schedule_type"];
                    
                        NSArray *tourKeys = [tourDict allKeys];
                        
                        for(int j = 0; j < tourKeys.count; j++){
                        
                            if([[tourKeys objectAtIndex:j] isEqualToString:@"tour_list"]){
                            
                                [sortedTourDict setObject:[NSArray arrayWithObject:tourDict] forKey:@"tour_list"];
                                
                            }else{
                            
                                [sortedTourDict setObject:[tourDict objectForKey:[tourKeys objectAtIndex:j]] forKey:[tourKeys objectAtIndex:j]];
                            }
                        }
                        
                        [ws.sortedAllTripDict setObject:sortedTourDict forKey:[scheduleKeys objectAtIndex:i]];
                    }
                }
                
                ws.allTraveTripArr = [[dict objectForKey:@"data"] objectForKey:@"schedule"];
                ws.scheduleDic = [[dict objectForKey:@"data"] objectForKey:@"schedule"];
            }
            
           
            ws.shipDetailModel = [[ZFJShipDetailModel alloc] initWithDictionary:[dict objectForKey:@"data"]];
            ws.status = [dict objectForKey:@"data"][@"status"];
            [ws addHeadMessageView];
            [ws addTitilMsgView];
            [ws addChooesView];
            [ws addMessageView];
            //分享跳转的URL
            shareURL=CRUIS_SHARE_URL(self.shipDetailModel.product_id);

        } else {
            [[LXAlterView sharedMyTools] createTishi:@"产品不可预订!"];
            [[WLSingletonClass defaultWLSingleton] wlAddNoDataViewWithSuperView:ws.view];
        }
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"发生错误！%@",error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:ws] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:ws] showErrorMsgInView:ws.view evn:^{
            [ws loadData];
        }];
        
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}




#pragma mark --- 添加分享
- (void)addNavChooseBut
{
    
    //创建分享按钮
    UIButton * chooseBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseBut.frame = CGRectMake(0, 0 , ViewHeight(self.navigationController.navigationBar) - 5, ViewHeight(self.navigationController.navigationBar) - 5);
    chooseBut.backgroundColor = [UIColor whiteColor];
    [chooseBut addTarget:self action:@selector(shareShip:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(chooseBut) - 18, (ViewHeight(chooseBut) - 21) / 2.0, 24, 24)];
    icon.image = [UIImage imageNamed:@"分享1"];
    [chooseBut addSubview:icon];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chooseBut];
    
    
}

#pragma mark - 分享按钮 点击事件
- (void)shareShip:(UIButton *)sender
{
    
    //分享的内容
    NSString *content=self.shipDetailModel.product_name;
    content=[content stringByAppendingString:@"\r\n"];
    content=[content stringByAppendingFormat:@"本产品由%@提供服务。微旅,您家门口的旅行管家", [self judgeReturnString:self.shipDetailModel.supplier_name withReplaceString:@""]];
    
    
    
    NSString *desc=[NSString stringWithFormat:@"本产品由%@提供服务。微旅,您家门口的旅行管家", [self judgeReturnString:self.shipDetailModel.supplier_name withReplaceString:@""]];
    

    
     //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:[ShareSDK jpegImageWithImage:_shareImage quality:1]
                                                title:self.shipDetailModel.product_name
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
- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}
#pragma mark -获取label的自适应高度
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(windowContentWidth - 60, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}
@end
