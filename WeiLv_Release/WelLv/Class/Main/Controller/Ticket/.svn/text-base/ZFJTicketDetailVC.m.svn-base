//
//  ZFJTicketDetailVC.m
//  WelLv
//
//  Created by 张发杰 on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJTicketDetailVC.h"
#import "ChooseTitleView.h"
#import "TravelCalendarViewController.h"
#import "TicketListModel.h"
#import "ZFJCallVC.h"
#import "ZFJCallStewardVC.h"
#import "ZFJSecondView.h"
#import "ZFJTicketReserveView.h"
#import "LXTicketCalendarViewController.h"

#import "YXOrderViewController.h"
#import "ShareCustom.h"
#define M_CALL_RESERVE_BUT_HEIGHT 40

#define M_TICKET_HEIGHT 61
@interface ZFJTicketDetailVC ()<UIActionSheetDelegate, UIScrollViewDelegate>
{
    NSString *shareImageURL;  //分享产品的图片
    NSString *shareURL;       //分享跳转的URL
    
    UIImage *_shareImage;
}

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) TicketListModel * model;
@property (nonatomic, strong) NSMutableArray * ticketArrary;
@property (nonatomic, strong) ChooseTitleView * chooseView;
@property (nonatomic, strong) UIView * bookInforView;             //预订须知
@property (nonatomic, strong) UIView * scenicRegionView;          //景区介绍
@property (nonatomic, strong) UIView * commentView;               //评论页面；
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat chooseViewY;
@property (nonatomic, assign) CGFloat ticketViewHeight;
@property (nonatomic, strong) MBProgressHUD * hud;
@property (nonatomic,strong)NSDictionary *shareDic;//分享产品的图片

@end

@implementation ZFJTicketDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"产品详情";
    
    //创建分享功能
    [self addNavChooseBut];
    
    [self loadData];
    
    [self addCustomScrollView];
    [self addCollAndReserveBut];
    //[self addHeaderImageAndTitleView];
}

#pragma mark ---- 加载视图

/**
 *  加载ScrollView
 */
- (void)addCustomScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight - M_CALL_RESERVE_BUT_HEIGHT)];
    self.scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.scrollView.contentSize = CGSizeMake(windowContentWidth, 1000);
    self.scrollView.delegate = self;
    
    [self.view addSubview:_scrollView];
    [self setProgressHud];

}

/**
 *  加载图片和标题信息视图
 */
- (void)addHeaderImageAndTitleView {
    
    UIImageView * headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 150)];
    headerImage.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [headerImage sd_setImageWithURL:[NSURL URLWithString:[self judgeRetuRnImagesClass:[self.model.images objectForKey:@"image"]]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    
    [self.scrollView addSubview:headerImage];
    
    UIView * backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(headerImage), windowContentWidth, 100)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:backgroundView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, windowContentWidth - 20, 20)];
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.text = self.model.product_name;
    titleLabel.numberOfLines = 0;
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor blackColor];
    [backgroundView addSubview:titleLabel];
    
    UILabel * addressTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(titleLabel) + 5, 50, 25)];
    addressTitleLabel.text = @"景点地址";
    addressTitleLabel.font = [UIFont systemFontOfSize:16];
    addressTitleLabel.textColor = [UIColor blackColor];
    [addressTitleLabel sizeToFit];
    [backgroundView addSubview:addressTitleLabel];
    
    UILabel * addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(addressTitleLabel) + 10, ViewY(addressTitleLabel), windowContentWidth - ViewRight(addressTitleLabel) - 20, 25)];
    addressLabel.text = [self judgeReturnString:[self.model.scenic_attach objectForKey:@"placeToAddr"] withReplaceString:@" "];
    addressLabel.numberOfLines = 0;
    addressLabel.textColor = [UIColor grayColor];
    addressLabel.font = [UIFont systemFontOfSize:16];
    [addressLabel sizeToFit];
    [backgroundView addSubview:addressLabel];
    
    UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(addressLabel), ViewWidth(backgroundView) - 20, 30)];
    priceLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=font-size:13px;color:#E53333;>微旅价</span><span style=color:#E53333;>：</span><span style=font-size:18px;color:#E53333;>¥<span style=font-size:18px;> %@</span></span><span style=font-size:16px;color:#E53333;></span><span style=color:#E53333;>起</span><span style=color:#E53333;></span>", [self judgeReturnString:self.model.start_price withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    [backgroundView addSubview:priceLabel];
    backgroundView.frame = CGRectMake(0, ViewBelow(headerImage), windowContentWidth, ViewBelow(priceLabel));
    
    UIView * backTimeView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(backgroundView) + 1, windowContentWidth, 25)];
    backTimeView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:backTimeView];
    
    UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, windowContentWidth - 20, 25)];
    timeLabel.backgroundColor = [UIColor whiteColor];
    
    NSString * timeStr = nil;
    
    if ([self.model.scenic_attach objectForKey:@"openTimes"])
    {
        if ([[self judgeRetuRnImagesClass:[self.model.scenic_attach objectForKey:@"openTimes"]]isKindOfClass:[NSString class]] )
        {
            timeStr = @"依景区具体规定";
        }
        else
        {
            
            
            if ([(id)[[self.model.scenic_attach objectForKey:@"openTimes"] objectForKey:@"openTime" ] isKindOfClass:[NSArray class]])
            {
                  NSDictionary *dict1=[self.model.scenic_attach objectForKey:@"openTimes"];
                
                if ([dict1 isEqual:@""])
                {
                    timeStr = @"依景区具体规定";
                }
                else
                {
                    NSArray *array=[dict1 objectForKey:@"openTime"];
                    if (array.count==2)
                    {
                        //第一行
                        if (![[array[0] objectForKey:@"sightStart"] isEqual:@""] && ![[array[0] objectForKey:@"sightEnd"] isEqual:@""])
                        {
                            timeStr=[NSString stringWithFormat:@"%@-%@",[array[0] objectForKey:@"sightStart"],[array[0] objectForKey:@"sightEnd"]];
                           
                            
                            if (![[array[0] objectForKey:@"openTimeInfo"] isEqual:@""])
                            {
                                if ([array[0] objectForKey:@"openTimeInfo"]==nil)
                                {
                                    
                                }
                                else
                                {
                                    timeStr=[timeStr stringByAppendingString:@"("];
                                    timeStr=[timeStr stringByAppendingString:[array[0] objectForKey:@"openTimeInfo"]];
                                    timeStr=[timeStr stringByAppendingString:@")"];

                                }
                                
                            }
                        }
                        
                        //第二行
                        if (![[array[1] objectForKey:@"sightStart"] isEqual:@""] && ![[array[1] objectForKey:@"sightEnd"] isEqual:@""])
                        {
                            NSString  *timeStr2=[NSString stringWithFormat:@"%@-%@",[array[1] objectForKey:@"sightStart"],[array[1] objectForKey:@"sightEnd"]];
                            if (![[array[1] objectForKey:@"openTimeInfo"] isEqual:@""])
                            {
                                if ([array[1] objectForKey:@"openTimeInfo"]==nil) {
                                   
                                }else
                                {
                                    timeStr2=[timeStr2 stringByAppendingString:@"("];
                                    timeStr2=[timeStr2 stringByAppendingString:[array[1] objectForKey:@"openTimeInfo"]];
                                    timeStr2=[timeStr2 stringByAppendingString:@")"];
                                }
                            }
                            timeStr=[timeStr stringByAppendingString:@"\r"];
                            timeStr=[timeStr stringByAppendingString:@"                 "];
                            timeStr=[timeStr stringByAppendingString:timeStr2];
                        }
                        
                    }
                    else
                    {
                        if (![[array[0] objectForKey:@"sightStart"] isEqual:@""] && ![[array[0] objectForKey:@"sightEnd"] isEqual:@""])
                        {
                            timeStr=[NSString stringWithFormat:@"%@-%@",[array[0] objectForKey:@"sightStart"],[array[0] objectForKey:@"sightEnd"]];
                            if (![[array[0] objectForKey:@"openTimeInfo"] isEqual:@""])
                            {
                                
                                if ([array[0] objectForKey:@"openTimeInfo"]==nil) {
                                  

                                }else{
                                
                                    timeStr=[timeStr stringByAppendingString:@"("];
                                    timeStr=[timeStr stringByAppendingString:[array[0] objectForKey:@"openTimeInfo"]];
                                    timeStr=[timeStr stringByAppendingString:@")"];
                                }
                          }
                        }
                    }
                }

            }
            else
            {
                NSDictionary * dic = [self judgeRetuRnImagesClass:[[self.model.scenic_attach objectForKey:@"openTimes"] objectForKey:@"openTime"]];
                if ([dic isEqual:@""])
                {
                    timeStr = @"依景区具体规定";
                }
                else
                {
                                    
                    if ( [dic objectForKey:@"sightStart"] || [dic objectForKey:@"sightEnd"])
                    {
                        timeStr = [NSString stringWithFormat:@"%@-%@", [self judgeReturnString:[dic objectForKey:@"sightStart"] withReplaceString:@""], [self judgeReturnString:[dic objectForKey:@"sightEnd"] withReplaceString:@""]];
                    }
                    else if ([dic objectForKey:@"openTimeInfo"] || ![dic objectForKey:@"sightStart"])
                    {
                        timeStr = [self judgeReturnString:[dic objectForKey:@"openTimeInfo"] withReplaceString:@""];
                    }
                }
            }
            
            
            
            
            
        }
    }
    else
    {
        timeStr = [self judgeReturnString:self.model.openTime withReplaceString:@"依景区具体规定"];
    }
    
    timeLabel.text = [NSString stringWithFormat:@"营业时间: %@", timeStr];
    timeLabel.numberOfLines = 0;
    timeLabel.font = [UIFont systemFontOfSize:16];
    timeLabel.textColor = kColor(123, 174, 253);
    [timeLabel sizeToFit];
    [backTimeView addSubview:timeLabel];
    
    backTimeView.frame = CGRectMake(0, ViewBelow(backgroundView) + 1, windowContentWidth, ViewBelow(timeLabel));
    
    [self addTicketView:ViewBelow(backTimeView) + 15];

    
    
    
    //获取分享产品的图片
    shareImageURL=[self judgeRetuRnImagesClass:[self.model.images objectForKey:@"image"]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareImageURL]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _shareImage = [UIImage imageWithData:imageData];
        });
    });

    
    
}

/**
 *  加载门票视图
 *
 *  @param height 视图Y值
 */
- (void)addTicketView:(CGFloat)viewY {
    
    if (self.ticketArrary.count > 0) {
        ZFJTicketReserveView * ticketReserveView = [[ZFJTicketReserveView alloc] initWithFrame:CGRectMake(0, viewY, windowContentWidth, self.ticketArrary.count * M_TICKET_HEIGHT) withTicketArray:self.ticketArrary];

        __weak ZFJTicketDetailVC * detailVC = self;
        [ticketReserveView reserveTicket:^(UIButton *but) {
            
            LXTicketCalendarViewController * ticketCalendarVC = [[LXTicketCalendarViewController alloc] init];
            DLog(@"==============%ld=======================",but.tag-1000);
            TicketGoodsModel * model = [self.ticketArrary objectAtIndex:but.tag - 1000];
            ticketCalendarVC.goodId = model.goods_id;
            ticketCalendarVC.ticketModel = model;
            ticketCalendarVC.product_name=self.model.product_name;
            [detailVC.navigationController pushViewController:ticketCalendarVC animated:YES];
        
            
        }];
        
        [ticketReserveView returnInforViewHeight:^(CGFloat viewHeight)
        {
            ticketReserveView.frame = CGRectMake(0, viewY, windowContentWidth, viewHeight + ViewHeight(ticketReserveView));
            detailVC.chooseViewY = ViewY(detailVC.chooseView) + viewHeight;
            detailVC.chooseView.frame = CGRectMake(0, ViewY(detailVC.chooseView) + viewHeight, windowContentWidth, ViewHeight(detailVC.chooseView));
            detailVC.bookInforView.frame = CGRectMake(ViewX(_bookInforView), ViewY(_bookInforView) + viewHeight, ViewWidth(_bookInforView), ViewHeight(_bookInforView));
            detailVC.scenicRegionView.frame = CGRectMake(ViewX(_scenicRegionView), ViewY(_scenicRegionView) + viewHeight, ViewWidth(_scenicRegionView), ViewHeight(_scenicRegionView));
            detailVC.commentView.frame = CGRectMake(ViewX(_commentView), ViewY(_commentView) + viewHeight, ViewWidth(_commentView), ViewHeight(_commentView));
            detailVC.scrollView.contentSize = CGSizeMake(windowContentWidth, detailVC.scrollView.contentSize.height + viewHeight);
        }];
        
        [self.scrollView addSubview:ticketReserveView];
        [self addChooseView:ViewBelow(ticketReserveView) + 15];
    }
    else
    {
        [self addChooseView:viewY];

    }
   
}

- (void)tapTicketView:(UITapGestureRecognizer *)tap
{
    UIView * ticketInforView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(tap.view), windowContentWidth, 100)];
    ticketInforView.backgroundColor = [UIColor cyanColor];
    [self.scrollView addSubview:ticketInforView];
    
    for (int i = 0; i < self.ticketArrary.count - 1 - (tap.view.tag - 100); i++)
    {
        UIView * tempView = [self.view viewWithTag:tap.view.tag + 1 + i];
        tempView.frame = CGRectMake(0, ViewY(tempView) + ViewHeight(ticketInforView), windowContentWidth, ViewHeight(tempView));
    }
    
    
}

/**
 *  加载选择视图
 */
- (void)addChooseView:(CGFloat)height
{
    self.chooseViewY = height;
    self.chooseView = [[ChooseTitleView alloc] initWithFrame:CGRectMake(0, height, windowContentWidth, 45) withChooseTitleArray:@[@"预订须知", @"景点介绍"]];  //, @"评论"
    __weak ZFJTicketDetailVC * detailVC = self;
    [self.scrollView bringSubviewToFront:self.chooseView];
    [_chooseView chooseIndex:^(NSIndexPath *index) {
        if (index.row == 0)
        {
            if (detailVC.bookInforView == nil) {
                detailVC.scenicRegionView.hidden = YES;
                detailVC.commentView.hidden = YES;
                [detailVC addCustomBookInforView];
            }
            else
            {
                self.scrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_bookInforView));
                detailVC.scenicRegionView.hidden = YES;
                detailVC.commentView.hidden = YES;
                detailVC.bookInforView.hidden = NO;
                
            }
        }
        else if (index.row == 1)
        {
            if (detailVC.scenicRegionView == nil)
            {
                detailVC.bookInforView.hidden = YES;
                detailVC.commentView.hidden = YES;
                [detailVC addCustomScenicRegionView];
            }
            else
            {
                self.scrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_scenicRegionView));
                detailVC.bookInforView.hidden = YES;
                detailVC.commentView.hidden = YES;
                detailVC.scenicRegionView.hidden = NO;
                
            }

        }
        else if (index.row == 2)
        {
            if (detailVC.commentView == nil)
            {
                detailVC.bookInforView.hidden = YES;
                detailVC.scenicRegionView.hidden = YES;
                [detailVC addCustomCommentView];
            }
            else
            {
                self.scrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_commentView));
                detailVC.bookInforView.hidden = YES;
                detailVC.scenicRegionView.hidden = YES;
                detailVC.commentView.hidden = NO;
            }
        }
    }];
    [self.scrollView addSubview:_chooseView];
    [self addCustomBookInforView];
    
}

#pragma mark ---- 加载 预订须知，景区介绍，评论视图

/**
 *  加载预订须知视图
 */
- (void)addCustomBookInforView {
   self.bookInforView = [[UIView alloc] initWithFrame:CGRectMake(0, self.chooseViewY + ViewHeight(self.chooseView), windowContentWidth, 500)];
    self.bookInforView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.bookInforView];
    NSArray * keyArr = nil;
    if ([self.model.bookingInfo isKindOfClass:[NSDictionary class]]) {
        keyArr = [self.model.bookingInfo allKeys];
    }
    
    NSString * bookStr = @"<h2><span style=color:#666666;font-size:16px;>优惠政策:</span></h2>";
    for (int i = 0; i< keyArr.count; i++) {
        NSString * keyStr = [keyArr objectAtIndex:i];
        if ([keyStr isEqualToString:@"freePolicy"]) {
            //免票政策:
            NSString * str = [self.model.bookingInfo objectForKey:@"freePolicy"];

            bookStr = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:14px;>免票政策:</span></p><p>&nbsp;&nbsp;&nbsp;&nbsp;<span style=color:#999999;font-size:13px;>%@</span></p>", bookStr, [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />&nbsp;&nbsp;&nbsp;&nbsp;"]];

        } else if ([keyStr isEqualToString:@"offerCrowd"]) {
            //优惠人群:
            NSString * str = [self.model.bookingInfo objectForKey:@"offerCrowd"];

            bookStr = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:14px;>优惠人群:</span></p><p>&nbsp;&nbsp;&nbsp;&nbsp;<span style=color:#999999;font-size:13px;>%@</span></p>", bookStr, [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />&nbsp;&nbsp;&nbsp;&nbsp;"]];

        } else if ([keyStr isEqualToString:@"oldPeople"]) {
            //老人:
            NSString * str = [self.model.bookingInfo objectForKey:@"oldPeople"];

            bookStr = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:14px;>老人:</span></p><p>&nbsp;&nbsp;&nbsp;&nbsp;<span style=color:#999999;font-size:13px;>%@</span></p>", bookStr, [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />&nbsp;&nbsp;&nbsp;&nbsp;"]];

        } else if ([keyStr isEqualToString:@"age"]) {
            //年龄:
            NSString * str = [self.model.bookingInfo objectForKey:@"age"];

            bookStr = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:14px;>年龄:</span></p><p>&nbsp;&nbsp;&nbsp;&nbsp;<span style=color:#999999;font-size:13px;>%@</span></p>", bookStr, [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />&nbsp;&nbsp;&nbsp;&nbsp;"]];
        } else if ([keyStr isEqualToString:@"explanation"]) {
            //说明:
            NSString * str = [self.model.bookingInfo objectForKey:@"explanation"];
            //[str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"];
            bookStr = [NSString stringWithFormat:@"%@<p><span style=color:#999999;font-size:14px;>说明:</span></p><p>&nbsp;&nbsp;&nbsp;&nbsp;<span style=color:#999999;font-size:13px;>%@</span></p>", bookStr, [str stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />&nbsp;&nbsp;&nbsp;&nbsp;"]];

        }
    }
    
    if (self.model.product_reminder) {
        NSString * str = [self judgeReturnString:self.model.product_reminder withReplaceString:@""];
        bookStr = [NSString stringWithFormat:@"%@<h2><span style=color:#666666;font-size:16px;>温馨提示:</span></h2>%@", bookStr, [str stringByReplacingOccurrencesOfString:@"<p>" withString:@"<p>&nbsp;&nbsp;&nbsp;&nbsp;<span style=color:#999999;font-size:13px;>"]];
    }
    
    UILabel * bookView = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, windowContentWidth, 500)];
    bookView.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@", bookStr] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    bookView.numberOfLines = 0;
    [bookView sizeToFit];
    [self.bookInforView addSubview:bookView];
    self.bookInforView.frame = CGRectMake(0, self.chooseViewY + ViewHeight(self.chooseView), windowContentWidth, ViewHeight(bookView));
    self.scrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_bookInforView));

}

- (void)addCustomScenicRegionView{
    self.scenicRegionView = [[UIView alloc] initWithFrame:CGRectMake(0, self.chooseViewY + ViewHeight(self.chooseView), windowContentWidth, 1000)];
    self.scenicRegionView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.scenicRegionView];
    
    [self.scrollView bringSubviewToFront:self.chooseView];

    if (![self.model.playAttraction isKindOfClass:[NSArray class]] && self.model.playAttraction != NULL) {
        NSDictionary * dict = (NSDictionary *)self.model.playAttraction;
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, windowContentWidth, 25)];
        NSString * titleStr = [NSString stringWithFormat:@"<h3><span style=color:#666666;font-size:16px;>%@</span></h3><p>&nbsp;&nbsp;&nbsp;&nbsp;<span style=color:#666666;font-size:13px;>%@</span></p>", [dict objectForKey:@"playName"], [dict objectForKey:@"playInfo"]];
        titleLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@", titleStr] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        titleLabel.numberOfLines = 0;
        [titleLabel sizeToFit];
        [self.scenicRegionView addSubview:titleLabel];
        
        if ([[[dict objectForKey:@"playImages"] objectForKey:@"url"] isKindOfClass:[NSArray class]]) {
            NSArray * imageArr = [[dict objectForKey:@"playImages"] objectForKey:@"url"];
            //CGFloat tempImageHeight = ViewBelow(titleLabel);
            self.height = ViewBelow(titleLabel);
            for (int i = 0; i < imageArr.count; i++) {
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height, windowContentWidth, 200)];
                __weak ZFJTicketDetailVC * detailVC = self;
                [imageView sd_setImageWithURL:[NSURL URLWithString:[imageArr objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"默认图3"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    
                    if (imageURL != NULL) {
                        imageView.frame = CGRectMake(0, detailVC.height  , windowContentWidth,windowContentWidth * image.size.height / image.size.width);
                    } else {
                        imageView.frame = CGRectMake(0, detailVC.height , windowContentWidth, 0);
                        
                    }
                    
                    detailVC.height = windowContentWidth * image.size.height / image.size.width + detailVC.height;
                    [detailVC.scenicRegionView addSubview:imageView];
                    if (i == imageArr.count - 1) {
                        detailVC.scenicRegionView.frame = CGRectMake(0, ViewBelow(detailVC.chooseView), windowContentWidth, detailVC.height);
                        detailVC.scrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_scenicRegionView));
                        
                    }
                }];
                
                
            }
        } else if (![self.model.playAttraction isEqual:@"(null)"]){
            NSString * imageUrlStr = [[dict objectForKey:@"playImages"] objectForKey:@"url"];
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height, windowContentWidth, 200)];
            __weak ZFJTicketDetailVC * detailVC = self;
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"默认图3"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (imageURL != NULL) {
                    imageView.frame = CGRectMake(0, detailVC.height  , windowContentWidth,windowContentWidth * image.size.height / image.size.width);
                } else {
                    imageView.frame = CGRectMake(0, detailVC.height , windowContentWidth, 0);
                    
                }
                detailVC.height = windowContentWidth * image.size.height / image.size.width + detailVC.height;
                [detailVC.scenicRegionView addSubview:imageView];
                detailVC.scenicRegionView.frame = CGRectMake(0, ViewBelow(detailVC.chooseView), windowContentWidth, detailVC.height);
                detailVC.scrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_scenicRegionView));
                
            }];
        } else {
            
        }
        
    } else if ([self.model.playAttraction isKindOfClass:[NSArray class]]) {
        
        NSArray * scenicArr = self.model.playAttraction;
        
        self.height = 0.0;
        
        for (int i = 0; i < scenicArr.count; i++) {
            NSDictionary * dict = [scenicArr objectAtIndex:i];
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.height + 10, windowContentWidth, 25)];
            NSString * titleStr = [NSString stringWithFormat:@"<h3><span style=color:#666666;font-size:16px;>%@</span></h3><p>&nbsp;&nbsp;&nbsp;&nbsp;<span style=color:#666666;font-size:13px;>%@</span></p>", [dict objectForKey:@"playName"], [dict objectForKey:@"playInfo"]];
            titleLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@", titleStr] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            titleLabel.numberOfLines = 0;
            [titleLabel sizeToFit];
            [self.scenicRegionView addSubview:titleLabel];
           
            if ([[[dict objectForKey:@"playImages"] objectForKey:@"url"] isKindOfClass:[NSArray class]]) {
                
                NSArray * imageArr = [[dict objectForKey:@"playImages"] objectForKey:@"url"];
                for (int j = 0; j < imageArr.count; j++) {
                    UIImageView * imageView = nil;
                    
                    if (j == 0) {
                         imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ViewBelow(titleLabel), windowContentWidth, 200)];

                    } else {
                       imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height, windowContentWidth, 200)];

                    }
                    
                    [imageView sd_setImageWithURL:[NSURL URLWithString:[imageArr objectAtIndex:j]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
                    self.height = ViewBelow(imageView);
                    
                    [self.scenicRegionView addSubview:imageView];
                }
                
            } else {
                if ([dict objectForKey:@"playImages"]) {
                    NSString * imageUrlStr = [[dict objectForKey:@"playImages"] objectForKey:@"url"];
                    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ViewBelow(titleLabel), windowContentWidth, 200)];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:[UIImage imageNamed:@"默认图3"]];
                    self.height = ViewBelow(imageView);
                    [self.scenicRegionView addSubview:imageView];
                } else {
                    self.height = ViewBelow(titleLabel) ;

                }
            }
            
            
        }
    }
    self.scenicRegionView.frame =CGRectMake(0, self.chooseViewY + ViewHeight(self.chooseView), windowContentWidth, self.height);
    self.scrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_scenicRegionView));
}



/**
 *  加载评论视图
 */
- (void)addCustomCommentView {
    self.commentView = [[UIView alloc] initWithFrame:CGRectMake(0,self.chooseViewY + ViewHeight(self.chooseView), windowContentWidth, windowContentWidth - 20)];
    self.commentView.backgroundColor = [UIColor whiteColor];
    UIImageView * noCommImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 20, windowContentWidth - 60, windowContentWidth - 60)];
    noCommImage.image = [UIImage imageNamed:@"没找到相关内容"];
    noCommImage.backgroundColor = [UIColor whiteColor];
    [self.commentView addSubview:noCommImage];
    [self.scrollView addSubview:self.commentView];
    self.scrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_commentView));

}

#pragma mark ---- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= self.chooseViewY) {
        self.chooseView.frame = CGRectMake(0, scrollView.contentOffset.y, self.view.frame.size.width, 40);
        [self.scrollView bringSubviewToFront:self.chooseView];
    } else {
        self.chooseView.frame = CGRectMake(0, self.chooseViewY, self.view.frame.size.width, 40);
    }

}


#pragma mark ---- 加载电话咨询
/**
 * 加载电话
 */
- (void)addCollAndReserveBut
{
    
    UIButton * collButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collButton.frame = CGRectMake(0, self.view.frame.size.height - 64 - M_CALL_RESERVE_BUT_HEIGHT, windowContentWidth, M_CALL_RESERVE_BUT_HEIGHT);
    [collButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    collButton.backgroundColor = kColor(40, 218, 171);
    [collButton addTarget:self action:@selector(collButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collButton];
    
    
}

#pragma mark --- 方法
/**
 *  打电话
 *
 *  @param button 电话咨询
 */
- (void)collButton:(UIButton *)button {
    button.enabled = NO;

    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember && [[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteward])
    {
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"拨打管家电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拨打管家电话" otherButtonTitles:nil, nil];
        [actionsheet showInView:self.view];
    } else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        ZFJCallVC * callVC = [[ZFJCallVC alloc] init];
        callVC.memberType = WLMemberTypeSteward;
        callVC.prodductType = WLProductTypeTicket;
        callVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        callVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:callVC animated:YES completion:nil];

    } else {
        
        ZFJCallVC * callVC = [[ZFJCallVC alloc] init];
        callVC.admin_id = @"";
        callVC.memberType = [[WLSingletonClass defaultWLSingleton] wlUserType];
        callVC.prodductType = WLProductTypeTicket;
        callVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        callVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:callVC animated:YES completion:nil];
        
        __weak ZFJTicketDetailVC * detailVC = self;
        [callVC chooseMoreSteward:^(UIButton *but) {
            ZFJCallStewardVC * callStewardVC = [[ZFJCallStewardVC alloc] init];
            callStewardVC.admin_id = @"";
            [detailVC.navigationController pushViewController:callStewardVC animated:YES];
        }];
    }
    
    button.enabled = YES;

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

/**
 *  预订方法
 *
 *  @param button 立即预订
 */
- (void)reserveBut:(UIButton *)button
{
//    TraveCalendarViewController *lxchooseVC = [[TraveCalendarViewController alloc] init];
//    lxchooseVC.traveModel = nil;
//    lxchooseVC.price = @"123";
//    lxchooseVC.realBeginDate = @"2015/08/14";
//    [self.navigationController pushViewController:lxchooseVC animated:YES];

    
}

#pragma mark ---- 数据请求
/**
 *  数据加载
 */
- (void)loadData
{
    

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //[self setProgressHud];
    
    NSString *assistant_id=@"";
    if ([[[LXUserTool alloc] getKeeper] rangeOfString:@"null"].location!=NSNotFound) {
        assistant_id=@"0";
    }
    else
    {
        assistant_id=[[LXUserTool alloc] getKeeper];
    }

    NSDictionary *parameters = @{@"productid":self.product_id,@"assistant_id":assistant_id};
    DLog(@"product_id = %@", self.product_id);
    //接口
    NSString *url= M_TICKET_DETAIL_URL;
    //发送请求
    __weak ZFJTicketDetailVC * detailVC = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DLog(@"JSON: =========%@",  dic);
        [_hud hide:YES];
        if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]])
        {
            NSArray * arr = [dic objectForKey:@"data"];
            if (arr.count > 0)
            {
                
                for (NSDictionary * dict in [[arr objectAtIndex:0] objectForKey:@"goods"])
                {
                    TicketGoodsModel * ticketModel = [[TicketGoodsModel alloc] initWithDictionary:dict];
                    [detailVC.ticketArrary addObject:ticketModel];
                }
                
                detailVC.model = [[TicketListModel alloc] initWithDictionary:[arr objectAtIndex:0]];
                [detailVC addHeaderImageAndTitleView];
              
            }
            else
            {
                [[LXAlterView sharedMyTools] createTishi:@"暂无此产品"];

            }
        }
        else
        {
            [[LXAlterView sharedMyTools] createTishi:@"暂无此产品"];
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        DLog(@"ERROR: %@", error);
        [_hud hide:YES];
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [detailVC loadData];
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
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(chooseBut) - 18, (ViewHeight(chooseBut) - 21) / 2.0, 24, 24)];
    icon.image = [UIImage imageNamed:@"分享1"];
    [chooseBut addSubview:icon];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chooseBut];
    shareURL=TICKET_SHARE_URL(self.product_id);
    
    
   
}

#pragma mark - 分享按钮 点击事件
- (void)shareShop:(UIButton *)sender
{
    
    //分享的内容
    NSString *content=self.model.product_name;
    content=[content stringByAppendingString:@"_门票_"];
    content=[content stringByAppendingString:@"微旅,您家门口的旅行管家"];

    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:[ShareSDK jpegImageWithImage:_shareImage quality:1]
                                                title:self.model.product_name
                                                  url:shareURL
                                          description:content
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

- (NSMutableArray *)ticketArrary
{
    if (_ticketArrary == nil)
    {
        self.ticketArrary = [NSMutableArray array];
    }
    return _ticketArrary;
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


@end
