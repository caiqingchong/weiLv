//
//  ZFJVisaDetailVC.m
//  WelLv
//
//  Created by 张发杰 on 15/7/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJVisaDetailVC.h"
#import "ZFJVisaModel.h"
#import "UIDefines.h"
#import "IconAndTitleView.h"
#import "ZFJNoticeMessageVC.h"
#import "ZFJCallVC.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import "LXChooseDateViewController.h"
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import "ZFJCallStewardVC.h"
#import "ShareCustom.h"
#define M_HeadImageHeight self.view.frame.size.width * (333 / 640.0)
#define M_LEFT_WIDTH 15
#define M_COLL_RESERVE_BUT_HEIGHT 40
#define M_IMAGE_H_W 640 / 333.0

void alert(NSString* msg);

@interface ZFJVisaDetailVC ()<UIScrollViewDelegate, UIViewControllerTransitioningDelegate, SKPSMTPMessageDelegate, UITextFieldDelegate, UIActionSheetDelegate>
{
    NSString *shareImageURL;  //分享产品的图片
    NSString *shareURL;       //分享跳转的URL
    UIImage *_shareImage;
}
@property (nonatomic, strong) UIScrollView * detailScrollView;

@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UIView * visaInforView;
@property (nonatomic, strong) UIView *chooseView;
@property (nonatomic, strong) UIView *chooessLine;
@property (nonatomic, strong) UIButton * tempBut;

@property (nonatomic, strong) UIView * messageView;  //概述;
@property (nonatomic, strong) UIView * needMaterial; //所需材料;
@property (nonatomic, strong) UIView * commentView;  //评论;

@property (nonatomic, strong) ZFJVisaModel * visaModel; //签证Model;
@property (nonatomic, strong) NSMutableArray * downloadArr; //签证资料下载
@property (nonatomic, strong) NSMutableArray * chooseDownloadArr;//选择的资料下载

@property (nonatomic, assign) CGFloat tempHeight;

@property (nonatomic, strong) UIView * blurView; //模糊背景
@property (nonatomic, copy)   NSString * chooseEmailStr; //Email发送的;
@end

@implementation ZFJVisaDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签证详情";
    //创建分享按钮功能
    [self addNavChooseBut];
    [self loadVisaData];

    [self addDetailScrollView];
    [self addCollAndReserveBut];
     
}

#pragma mark ---- addVisadetailScrollView 加载滚动视图
- (void)addDetailScrollView
{
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    // 导航栏（navigationbar）
    CGRect rectNav = self.navigationController.navigationBar.frame;
    self.detailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - rectStatus.size.height - rectNav.size.height - M_COLL_RESERVE_BUT_HEIGHT)];
    self.detailScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.detailScrollView.contentSize = CGSizeMake( self.view.frame.size.width, ViewHeight(self.view));
    self.detailScrollView.delegate = self;
    
    [self.view addSubview:self.detailScrollView];
}

#pragma mark ---- addHeaderView 加载头部信息视图
- (void)addHeaderView
{
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, M_HeadImageHeight)];
    self.headImageView.backgroundColor = [UIColor whiteColor];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP, self.visaModel.thumb]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    [self.detailScrollView addSubview:self.headImageView];
    
    self.visaInforView  = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(self.headImageView), windowContentWidth, 105)];
    self.visaInforView.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake( M_LEFT_WIDTH , 5, windowContentWidth - M_LEFT_WIDTH * 2, 41)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = self.visaModel.product_name;
    titleLabel.numberOfLines = 2;
    [titleLabel sizeToFit];

    [self.visaInforView addSubview:titleLabel];
    
    UILabel * providerLabel = [[UILabel alloc] init];
    providerLabel.textAlignment = NSTextAlignmentLeft;
    providerLabel.textColor = [UIColor grayColor];
    providerLabel.numberOfLines = 0;
    providerLabel.font = [UIFont systemFontOfSize:13];
    providerLabel.text = [NSString stringWithFormat:@"本产品由%@提供服务", [self judgeReturnString:self.visaModel.company_name withReplaceString:@""]];
    
    providerLabel.frame = CGRectMake(M_LEFT_WIDTH, 41 + 5, windowContentWidth - M_LEFT_WIDTH * 2, [self returnTextCGRectText:providerLabel.text textFont:13 cGSize:CGSizeMake(windowContentWidth - M_LEFT_WIDTH *2, 0)].size.height);
    [self.visaInforView addSubview:providerLabel];
    
    UILabel * priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, ViewHeight(providerLabel) + ViewY(providerLabel), windowContentWidth - M_LEFT_WIDTH * 2, 30)];
    priceLabel.backgroundColor = [UIColor whiteColor];
    priceLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=font-size:13px;color:#E53333;>微旅价</span><span style=color:#E53333;>：</span><span style=font-size:18px;color:#E53333;>¥<span style=font-size:18px;> %@</span></span><span style=font-size:16px;color:#E53333;></span><span style=color:#E53333;>起</span><span style=color:#E53333;></span>", self.visaModel.sell_price] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [self.visaInforView addSubview:priceLabel];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(priceLabel), windowContentWidth, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.visaInforView addSubview:lineView];
    
    UILabel * productTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(M_LEFT_WIDTH, ViewBelow(lineView), windowContentWidth - M_LEFT_WIDTH * 2, 45)];

    productTimeLabel.text = @"产品日期";
    productTimeLabel.userInteractionEnabled = YES;
    productTimeLabel.textColor = [UIColor colorWithRed:123 /255.0 green:174 /255.0 blue:253 / 255.0 alpha:1.0];
    productTimeLabel.font = [UIFont systemFontOfSize:16];
    UIImageView * pushIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(productTimeLabel) - 15, (45 - 17) / 2, 10, 17)];
    pushIcon.image = [UIImage imageNamed:@"矩形-32"];
    [productTimeLabel addSubview:pushIcon];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reserveBut)];
    [productTimeLabel addGestureRecognizer:tap];
    [self.visaInforView addSubview:productTimeLabel];
    
    self.visaInforView.frame = CGRectMake(0, ViewBelow(self.headImageView), windowContentWidth, ViewBelow(productTimeLabel));

    UIView * gapView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(self.visaInforView), windowContentWidth, 15)];
    gapView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.detailScrollView addSubview:gapView];
    
    [self.detailScrollView addSubview:self.visaInforView];
    
    
    
    
    
    shareImageURL=[NSString stringWithFormat:@"%@/%@",WLHTTP, self.visaModel.thumb];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:shareImageURL]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _shareImage = [UIImage imageWithData:imageData];
        });
    });


}

#pragma mark ---- addChooseView 加载选择视图
- (void)addChooesView
{
    
    self.chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(self.visaInforView) + 15, windowContentWidth, 40)];
    self.tempHeight = ViewY(self.chooseView);
    self.chooseView.backgroundColor = [UIColor whiteColor];
    
    
    NSArray * chooseTitleArr = @[@"概述", @"所需材料"];  //, @"评论"
    for (int i = 0; i < chooseTitleArr.count; i++) {
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
}
//选择视图方法
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
        NSLog(@"0");
        if (self.messageView == nil)
        {
            self.needMaterial.hidden = YES;
            self.commentView.hidden = YES;
            [self addMessageView];
        }
        else
        {
            self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewY(_messageView) + ViewHeight(_messageView));
            self.messageView.hidden = NO;
            self.needMaterial.hidden = YES;
            self.commentView.hidden = YES;
        }
        
    } else if ([button.titleLabel.text isEqual:@"所需材料"]){
        NSLog(@"1");
        if (self.needMaterial == nil) {
            _messageView.hidden = YES;
            _commentView.hidden = YES;
            [self addNeedMaterial];
        }else  {
            self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_needMaterial));
            self.needMaterial.hidden = NO;
            self.messageView.hidden = YES;
            self.commentView.hidden = YES;
            
        }
        
    } else if ([button.titleLabel.text isEqual:@"评论"]){
        NSLog(@"2");
        if (self.commentView == nil) {
            self.messageView.hidden = YES;
            self.needMaterial.hidden = YES;
            [self addCommentView];
        }else  {
            self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_commentView));
            self.commentView.hidden = NO;
            self.needMaterial.hidden = YES;
            self.messageView.hidden = YES;
            
        }
        
    }
    
    button.enabled = YES;
}
#pragma mark ---- addCollAndReserve 打电话和预订
- (void)addCollAndReserveBut{
    
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
    [reserveButton addTarget:self action:@selector(reserveBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reserveButton];
    
}
//打电话
- (void)collButton:(UIButton *)button {
    button.enabled = NO;
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember && [[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteward])
    {
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"拨打管家电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拨打管家电话" otherButtonTitles:nil, nil];
        [actionsheet showInView:self.view];
    } else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        ZFJCallVC * callVC = [[ZFJCallVC alloc] init];
        callVC.memberType = WLMemberTypeSteward;
        callVC.prodductType = WLProductTypeVisa;
        callVC.admin_id = self.visaModel.admin_id;
        callVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        callVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:callVC animated:YES completion:nil];
        
    } else {
        
        ZFJCallVC * callVC = [[ZFJCallVC alloc] init];
        callVC.admin_id = self.visaModel.admin_id;
        callVC.memberType = [[WLSingletonClass defaultWLSingleton] wlUserType];
        callVC.prodductType = WLProductTypeVisa;
        callVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        callVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:callVC animated:YES completion:nil];
        
        __weak ZFJVisaDetailVC * detailVC = self;
        [callVC chooseMoreSteward:^(UIButton *but) {
            ZFJCallStewardVC * callStewardVC = [[ZFJCallStewardVC alloc] init];
            callStewardVC.admin_id = self.visaModel.admin_id;
            [detailVC.navigationController pushViewController:callStewardVC animated:YES];
        }];
    }
    button.enabled = YES;
}


//预订方法
- (void)reserveBut
{
    LXChooseDateViewController *lxchooseVC = [[LXChooseDateViewController alloc] init];
    lxchooseVC.visaModel = self.visaModel;
    lxchooseVC.shop_id=self.store_id;
    lxchooseVC.orderSouce=self.orderSource;
      // int a=365-[timeStr intValue];
    DLog(@"%@",self.visaModel.active_times);
    [lxchooseVC setTrainToDay:365 ToDateforString:nil price:[self.visaModel.sell_price intValue]];
    

    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"]){
        
        [self.navigationController pushViewController:lxchooseVC animated:YES];

    
        
    } else {
        [self.navigationController pushViewController:lxchooseVC animated:YES];
        
    }

    
}

#pragma mark  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
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


#pragma mark ---- addMessageView 加载概述
- (void)addMessageView {
    self.messageView = [[UIView alloc] init];
    self.messageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
   
    IconAndTitleView * transactionExplain = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 45) iconImageName:@"办理说明" titleLabel:@"办理说明"];
    transactionExplain.backgroundColor = [UIColor whiteColor];
    [self.messageView addSubview:transactionExplain];
    UIView * transactionDetailView = [[UIView alloc] init];
    transactionDetailView.backgroundColor = [UIColor whiteColor];
    
    NSArray * titleArr = @[@"签证有效期：", @"入境次数：", @"最长停留时间：", @"办理时长："];
    NSString *str1;NSString *str2;NSString *str3;NSString *str4;
    
    if (!self.visaModel.active_times) {
        str1=@"";
    } if(!self.visaModel.enter_times){
        str2=@"";
    } if (!self.visaModel.stay)
    {
        str3=@"";
    } if (!self.visaModel.deal_time){
       str4=@"";
    } if (self.visaModel.active_times&&self.visaModel.enter_times&&self.visaModel.stay&&self.visaModel.deal_time)
    {
        str1=self.visaModel.active_times;
        str2=self.visaModel.enter_times;
        str3=[NSString stringWithFormat:@"%@", self.visaModel.stay];
        str4=[NSString stringWithFormat:@"%@", self.visaModel.deal_time];
    }
    NSMutableArray *dataArr=[NSMutableArray arrayWithObjects:str1,str2,str3,str4, nil];
    //NSArray *dataArr=[NSArray arrayWithObjects:str1,str2,str3,str4, nil];
    //NSArray * dataArr = @[self.visaModel.active_times, self.visaModel.enter_times, [NSString stringWithFormat:@"%@", self.visaModel.stay], [NSString stringWithFormat:@"%@", self.visaModel.deal_time]];
    CGFloat titleWidth = [self returnTextCGRectText:@"  最长停留时间：" textFont:15 cGSize:CGSizeMake(0, 20)].size.width;
    CGFloat dataHeigth = 0;
    
    for (int i = 0; i < 4; i++) {
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, dataHeigth + 10 * i, titleWidth , 20)];
        titleLabel.text = [titleArr objectAtIndex:i];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:15];
        [transactionDetailView addSubview:titleLabel];

        UILabel * dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth, ViewY(titleLabel), windowContentWidth - titleWidth, [self returnTextCGRectText:[dataArr objectAtIndex:i] textFont:15 cGSize:CGSizeMake(windowContentWidth - titleWidth, 0)].size.height)];
        dataLabel.backgroundColor = [UIColor clearColor];
        dataLabel.text = [dataArr objectAtIndex:i];
        dataLabel.numberOfLines = 0;
        dataLabel.font = [UIFont systemFontOfSize:15];
        dataLabel.textColor = [UIColor grayColor];
        dataHeigth = dataHeigth +  [self returnTextCGRectText:[dataArr objectAtIndex:i] textFont:15 cGSize:CGSizeMake(windowContentWidth - titleWidth, 0)].size.height;
        transactionDetailView.frame = CGRectMake(0, ViewBelow(transactionExplain), windowContentWidth, ViewBelow(dataLabel) + 10);
        [transactionDetailView addSubview:dataLabel];
    }
    [self.messageView addSubview:transactionDetailView];
    
    IconAndTitleView * rangeView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewBelow(transactionDetailView) + 1, windowContentWidth, 45) iconImageName:@"受理范围" titleLabel:@"受理范围"];
    [self.messageView addSubview:rangeView];
    
    UIView * rangeBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(rangeView), windowContentWidth, 20)];
    rangeBackgroundView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel * rangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, windowContentWidth - 30, 20)];
    rangeLabel.backgroundColor = [UIColor whiteColor];
    //rangeLabel.text = self.visaModel.accept_conditions;
    rangeLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"%@: %@", self.visaModel.area_name, [self judgeReturnString:self.visaModel.area_province withReplaceString:@""]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    rangeLabel.textColor = [UIColor grayColor];
    rangeLabel.font = [UIFont systemFontOfSize:15];
    rangeLabel.numberOfLines = 0;
    [rangeLabel sizeToFit];
    
     rangeBackgroundView.frame = CGRectMake(0, ViewBelow(rangeView), windowContentWidth, ViewHeight(rangeLabel) + 10);
    
    [rangeBackgroundView addSubview:rangeLabel];
    [self.messageView addSubview:rangeBackgroundView];
    
    __weak ZFJVisaDetailVC * visaDetailVC = self;
    IconAndTitleView * reserveNotice = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewBelow(rangeBackgroundView) + 1, windowContentWidth, 45) iconImageName:@"new预定须知" titleLabel:@"预订须知"];
    reserveNotice.titleLabel.userInteractionEnabled = YES;
    reserveNotice.goIcon.hidden = NO;
    [reserveNotice chooseTop:^(NSInteger chooseTop) {
        
        ZFJNoticeMessageVC * noticeMessageVC = [[ZFJNoticeMessageVC alloc] init];
        noticeMessageVC.titleString = @"预订须知";
        noticeMessageVC.textString = self.visaModel.book_notice;
        [visaDetailVC.navigationController pushViewController:noticeMessageVC animated:YES];
        
    }];
    [self.messageView addSubview:reserveNotice];
    
    IconAndTitleView * problem = [[IconAndTitleView alloc] initWithFrame:CGRectMake(0, ViewBelow(reserveNotice) + 1, windowContentWidth, 45) iconImageName:@"温馨提示" titleLabel:@"常见问题"];
    problem.titleLabel.userInteractionEnabled = YES;
    problem.goIcon.hidden = NO;
    [problem chooseTop:^(NSInteger chooseTop) {
        
        NSString * str = self.visaModel.addon;
        [visaDetailVC pushNoticeMessageVCTitle:@"常见问题" Text:str];

    }];
    
    [self.messageView addSubview:problem];
    
    self.messageView.frame = CGRectMake(0, self.tempHeight + ViewHeight(_chooseView), windowContentWidth, ViewBelow(problem));

//    self.messageView.frame = CGRectMake(0, ViewBelow(self.chooseView), windowContentWidth, ViewBelow(rangeBackgroundView));
    self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(self.messageView));
    
     [self.detailScrollView addSubview:self.messageView];
    
}
#pragma mark ---- addNeedMaterial 加载所需材料
- (void)addNeedMaterial {
    self.needMaterial = [[UIView alloc] init];
    self.needMaterial.backgroundColor = [UIColor whiteColor];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, windowContentWidth - 15 * 2, 30)];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.text = @"请根据自身情况选择";
    //titleLabel.font = [UIFont systemFontOfSize:16];
    [self.needMaterial addSubview:titleLabel];
    
    NSArray * needMaterialClassArr = @[@"在职人员：", @"自由职业者：", @"退休人员：", @"在校学生：", @"学龄前儿童："];
    for (int i = 0; i < needMaterialClassArr.count; i++) {
        UILabel * materialClassBut = [[UILabel alloc] initWithFrame:CGRectMake(15, ViewBelow(titleLabel) + 35 * i + 5, windowContentWidth  - 35, 35)];
        materialClassBut.text = [needMaterialClassArr objectAtIndex:i];
        materialClassBut.font = [UIFont systemFontOfSize:16];
        materialClassBut.userInteractionEnabled = YES;
        materialClassBut.tag = 100 + i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(materialBut:)];
        [materialClassBut addGestureRecognizer:tap];
        UIImageView * goIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(materialClassBut) - 10, (ViewHeight(materialClassBut) - 17) / 2.0, 10, 17)];
        goIcon.image = [UIImage imageNamed:@"矩形-32"];
        [materialClassBut addSubview:goIcon];
        [self.needMaterial addSubview:materialClassBut];
    }
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(titleLabel) + 35 * needMaterialClassArr.count + 5, windowContentWidth, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.needMaterial addSubview:lineView];
    if (self.downloadArr.count > 0) {
        for (int i = 0; i < self.downloadArr.count; i++) {
            UILabel * downloadTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, ViewBelow(lineView) + 35 * i + 5, windowContentWidth  - 35, 35)];
            downloadTitle.text = [[self.downloadArr objectAtIndex:i] objectForKey:@"name"];
            downloadTitle.font = [UIFont systemFontOfSize:16];
            downloadTitle.userInteractionEnabled = YES;
            downloadTitle.tag = 200 + i;
            [self.needMaterial addSubview:downloadTitle];
            UIImageView * chooseIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(downloadTitle) - 15, (ViewHeight(downloadTitle) - 15) / 2, 20, 20)];
            chooseIcon.image = [UIImage imageNamed:@"未选中圆圈"];
            [downloadTitle addSubview:chooseIcon];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseMaterial:)];
            [downloadTitle addGestureRecognizer:tap];
        }
        
        UIButton * senderEmailBut = [UIButton buttonWithType:UIButtonTypeCustom];
        senderEmailBut.frame = CGRectMake((windowContentWidth - 280) / 2, ViewBelow(lineView) + 35 * self.downloadArr.count + 25, 280, 45);
        senderEmailBut.backgroundColor = kColor(40, 218, 171);
        senderEmailBut.layer.cornerRadius = 5.0;
        senderEmailBut.layer.masksToBounds = YES;
        [senderEmailBut setTitle:@"发送到邮箱" forState:UIControlStateNormal];
        [senderEmailBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [senderEmailBut addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
        [self.needMaterial addSubview:senderEmailBut];
        
        self.needMaterial.frame = CGRectMake(0, self.tempHeight + ViewHeight(_chooseView), windowContentWidth, ViewBelow(senderEmailBut) + 15);
        
    } else {
         self.needMaterial.frame = CGRectMake(0, self.tempHeight + ViewHeight(_chooseView), windowContentWidth, ViewBelow(lineView));
    }
    
    //self.needMaterial.frame = CGRectMake(0, ViewBelow(self.chooseView), windowContentWidth, ViewBelow(lineView));
    self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(self.needMaterial));
    [self.detailScrollView addSubview:self.needMaterial];
    
}

- (void)chooseMaterial:(UITapGestureRecognizer *)tap {
    UIImageView * tampImageView = [[tap.view subviews] objectAtIndex:0];
    if ([tampImageView.image isEqual:[UIImage imageNamed:@"未选中圆圈"]]) {
        tampImageView.image = [UIImage imageNamed:@"选中圆圈"];
    } else if ([tampImageView.image isEqual:[UIImage imageNamed:@"选中圆圈"]]) {
        tampImageView.image = [UIImage imageNamed:@"未选中圆圈"];
    }
}

/**
 *  获取邮箱
 *
 *  @param button 发送邮箱时当没有邮箱时弹出添加邮箱。
 */
- (void)sendEmail:(UIButton *)button
{
    
    self.chooseEmailStr = @"";
    for (int i = 0; i < self.downloadArr.count; i++)
    {
        UILabel * downLanel = (UILabel *)[self.detailScrollView viewWithTag:200 + i];
        UIImageView * tampImageView = [[downLanel subviews] objectAtIndex:0];
        if ([tampImageView.image isEqual:[UIImage imageNamed:@"选中圆圈"]])
        {
            self.chooseEmailStr = [NSString stringWithFormat:@"%@<div><ul><li><a href='%@/%@'_blank’>”%@”</a></li></ul></div>", self.chooseEmailStr, WLHTTP,[[self.downloadArr objectAtIndex:i] objectForKey:@"path"], [[self.downloadArr objectAtIndex:i] objectForKey:@"name"]];
        }
    }
    
    if (self.chooseEmailStr.length == 0)
    {
        alert(@"请根据自身情况选择所需材料");
        return;
    }

    [self addEmailView];
   
}
/**
 *  添加 Email 视图
 */
- (void)addEmailView
{
    if (self.blurView == nil)
    {
        self.blurView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
        self.blurView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBlurView:)];
        [self.blurView addGestureRecognizer:tap];
        [self.view addSubview:self.blurView];
        
        UIView * addEmailView = [[UIView alloc] initWithFrame:CGRectMake(25, -200, windowContentWidth - 50,(windowContentWidth - 50) *  0.8)];
        
        CGFloat addEmailHeight = (windowContentWidth - 50) *  0.8;
        
        addEmailView.backgroundColor = [UIColor whiteColor];
        addEmailView.layer.cornerRadius = 3.0;
        addEmailView.layer.masksToBounds = YES;
        addEmailView.tag = 2000;
        
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(addEmailView), addEmailHeight / 3.0)];
        titleLabel.text = @"请输入你的邮箱";
        titleLabel.font = [UIFont systemFontOfSize:19];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor orangeColor];
        [addEmailView addSubview:titleLabel];
        
        UITextField * emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(8, ViewBelow(titleLabel), ViewWidth(addEmailView) - 16, addEmailHeight * 2 / 3.0 / 5.0)];
        emailTextField.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //emailTextField.tintColor = [UIColor whiteColor];
        emailTextField.delegate = self;
        emailTextField.tag = 2001;
        emailTextField.borderStyle = UITextBorderStyleRoundedRect;
        emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //emailTextField.keyboardType = UIKeyboardTypeURL;
        emailTextField.returnKeyType = UIReturnKeyDone;
        [addEmailView addSubview:emailTextField];
        
        
        UIButton * confirmBut = [UIButton buttonWithType:UIButtonTypeCustom];
        confirmBut.frame = CGRectMake(8, ViewBelow(emailTextField) + 15, ViewWidth(addEmailView) - 16, addEmailHeight * 2 / 3.0 / 5.0);
        confirmBut.backgroundColor = kColor(40, 218, 171);
        confirmBut.layer.masksToBounds = YES;
        confirmBut.layer.cornerRadius = 3.0;
        [confirmBut setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBut addTarget:self action:@selector(addEmailBut:) forControlEvents:UIControlEventTouchUpInside];
        [addEmailView addSubview:confirmBut];
        
        addEmailView.frame = CGRectMake(25, -200, windowContentWidth - 50, ViewBelow(confirmBut) + 15);
        
        [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            addEmailView.center = CGPointMake(windowContentWidth / 2,  windowContentHeight / 2 - 60);
        } completion:nil];
        [self.blurView addSubview:addEmailView];
    }
    else if (self.blurView.hidden == YES)
    {
        [self.view viewWithTag:2000].center = CGPointMake(windowContentWidth / 2,  windowContentHeight / 2 - 60);
        
        self.blurView.hidden = NO;
    }
    else if (self.blurView.hidden == NO)
    {
        
        self.blurView.hidden = YES;
    }
}
/**
 *  隐藏添加邮箱页面
 *
 *  @param tap 点击事件
 */
- (void)hiddenBlurView:(UITapGestureRecognizer *)tap {
    [[self.view viewWithTag:2001] resignFirstResponder];
    
    self.blurView.hidden = YES;
}

/**
 *  邮箱确定
 *
 *  @param button 确定按钮
 */
- (void)addEmailBut:(UIButton *)button {
    UITextField * tempTextField = (UITextField *)[self.view viewWithTag:2001];
    
    if ([self judgeEmail:tempTextField.text])
    {
        [self sendMaterialToEmailWithEmail:tempTextField.text];
        [self hiddenBlurView:nil];
    }
    else
    {
        alert(@"请输入正确的邮箱号 ：）");
        return;
    }
}


#pragma mark ---- textFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self addEmailBut:nil];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];    
}


//当键盘出现或改变时调用
- (void)keyboardShow:(NSNotification *)aNotification
{
    
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    [self.view viewWithTag:2000].center = CGPointMake(windowContentWidth / 2,  windowContentHeight / 2 - 60 - height / 2);
}
- (void)keyboardHide:(NSNotification *)aNotification{
    [self.view viewWithTag:2000].center = CGPointMake(windowContentWidth / 2,  windowContentHeight / 2 - 60);

    
}

/**
 *  将选择的材料发送的邮箱
 *
 *  @param emailStr 邮箱号码
 */
- (void)sendMaterialToEmailWithEmail:(NSString *)emailStr
{
    /*
    NSString * chooseStr = @"";
    for (int i = 0; i < self.downloadArr.count; i++) {
        UILabel * downLanel = (UILabel *)[self.detailScrollView viewWithTag:200 + i];
        UIImageView * tampImageView = [[downLanel subviews] objectAtIndex:0];
        if ([tampImageView.image isEqual:[UIImage imageNamed:@"选中圆圈"]]) {
            chooseStr = [NSString stringWithFormat:@"%@<div><ul><li><a href='%@/%@'_blank’>”%@”</a></li></ul></div>", chooseStr, WLHTTP,[[self.downloadArr objectAtIndex:i] objectForKey:@"path"], [[self.downloadArr objectAtIndex:i] objectForKey:@"name"]];
        }
    }
    
    if (chooseStr.length == 0) {
        alert(@"请根据自身情况选择所需材料 :)");
        return;
    }
    */
    
    SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
    //发送者
    testMsg.fromEmail = @"service@weilv100.com";
    //发送给
    testMsg.toEmail = emailStr;
    //抄送联系人列表，如：@"664742641@qq.com;1@qq.com;2@q.com;3@qq.com"
    //testMsg.ccEmail = @"lanyuu@live.cn";
    //密送联系人列表，如：@"664742641@qq.com;1@qq.com;2@q.com;3@qq.com"
    //testMsg.bccEmail = @"664742641@qq.com";
    //发送有些的发送服务器地址
    testMsg.relayHost = @"smtp.ym.163.com";
    //需要鉴权
    testMsg.requiresAuth = YES;
    //发送者的登录账号
    testMsg.login = @"service@weilv100.com";
    //发送者的登录密码
    testMsg.pass = @"wlkj123";
    //邮件主题
    testMsg.subject = [NSString stringWithCString:"签证资料下载" encoding:NSUTF8StringEncoding ];
    
    testMsg.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
    
    // Only do this for self-signed certs!
    // testMsg.validateSSLChain = NO;
    testMsg.delegate = self;
    
    //内容
    //    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
    //                               @"This is a test message.\r\n支持中文。",kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    //<div><ul><li><a href='http://m.weilv100.com/front/travel'_blank’>”微旅”</a></li></ul></div>
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/html; charset=utf-8",kSKPSMTPPartContentTypeKey,
                               [NSString stringWithFormat:@"<html><head><title>签证资料下载</title></head><body>%@</body></html>", self.chooseEmailStr],kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    /*
    //附件
    NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"video.jpg" ofType:@""];
    NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
    
    
    //附件图片文件
    NSDictionary *vcfPart = [[NSDictionary alloc ]initWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"video.jpg\"",kSKPSMTPPartContentTypeKey,
                             @"attachment;\r\n\tfilename=\"video.jpg\"",kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
    //附件音频文件
    NSString *wavPath = [[NSBundle mainBundle] pathForResource:@"push" ofType:@"wav"];
    NSData *wavData = [NSData dataWithContentsOfFile:wavPath];
    NSDictionary *wavPart = [[NSDictionary alloc ]initWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"push.wav\"",kSKPSMTPPartContentTypeKey,
                             @"attachment;\r\n\tfilename=\"push.wav\"",kSKPSMTPPartContentDispositionKey,[wavData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
    */
    
    testMsg.parts = [NSArray arrayWithObjects:plainPart, nil];
    
    
    
    [testMsg send];
    

}
/**
 *  弹出提醒视图
 *
 *  @param message 邮箱发送成功时提醒内容
 */
- (void)messageSent:(SKPSMTPMessage *)message
{
    //发送成功
    NSLog(@"delegate - message sent");
    alert(@"发送成功");
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    //发送失败
    NSLog(@"delegate - error(%ld): %@", [error code], [error localizedDescription]);
    alert(@"发送失败");
}


- (void)materialBut:(UITapGestureRecognizer *)tap
{
    UILabel * aLabel = (UILabel *)tap.view;
    NSLog(@"%@ 所需材料页面", aLabel.text);
    if ([aLabel.text isEqualToString:@"在职人员："]) {
        [self pushNoticeMessageVCTitle:@"在职人员" Text:self.visaModel.onjob];
        //NSLog(@"%@ 所需材料页面", aLabel.text);
    } else if ([aLabel.text isEqualToString:@"自由职业者："]){
        [self pushNoticeMessageVCTitle:@"自由职业者" Text:self.visaModel.freelance];
       // NSLog(@"%@ 所需材料页面", aLabel.text);
    } else if ([aLabel.text isEqualToString:@"退休人员："]){
        [self pushNoticeMessageVCTitle:@"退休人员" Text:self.visaModel.retiree];
        //NSLog(@"%@ 所需材料页面", aLabel.text);
    } else if ([aLabel.text isEqualToString:@"在校学生："]){
        [self pushNoticeMessageVCTitle:@"在校学生" Text:self.visaModel.instudent];
        //NSLog(@"%@ 所需材料页面", aLabel.text);
    } else if([aLabel.text isEqualToString:@"学龄前儿童："]){
        [self pushNoticeMessageVCTitle:@"学龄前儿童" Text:self.visaModel.preschoolers];
    }
}
- (void)pushNoticeMessageVCTitle:(NSString *)title Text:(NSString *)text
{
    ZFJNoticeMessageVC * noticeMessageVC = [[ZFJNoticeMessageVC alloc] init];
    noticeMessageVC.titleString = title;
    noticeMessageVC.textString = text;
    [self.navigationController pushViewController:noticeMessageVC animated:YES];
}

#pragma mark ---- addCommentView 加载评论
- (void)addCommentView {
    
    self.commentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.tempHeight + ViewHeight(_chooseView), windowContentWidth, windowContentWidth - 40)];
    self.commentView.backgroundColor = [UIColor whiteColor];
    UIImageView * noCommImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, windowContentWidth - 60, windowContentWidth - 60)];
    noCommImage.image = [UIImage imageNamed:@"没找到相关内容"];
    noCommImage.backgroundColor = [UIColor whiteColor];
    [self.commentView addSubview:noCommImage];
    [self.detailScrollView addSubview:self.commentView];
    self.detailScrollView.contentSize = CGSizeMake(windowContentWidth, ViewBelow(_commentView));
    
}
#pragma mark ---- UIScrollViewDelegate 滑动视图代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= self.tempHeight) {
        self.chooseView.frame = CGRectMake(0, scrollView.contentOffset.y, self.view.frame.size.width, 40);
        [self.detailScrollView bringSubviewToFront:self.chooseView];
    } else {
        self.chooseView.frame = CGRectMake(0, self.tempHeight, self.view.frame.size.width, 40);
    }
    if (scrollView.contentOffset.y < 0) {
        self.headImageView.frame = CGRectMake(scrollView.contentOffset.y / 2 * M_IMAGE_H_W , scrollView.contentOffset.y, self.view.frame.size.width -  scrollView.contentOffset.y * M_IMAGE_H_W, M_HeadImageHeight -  scrollView.contentOffset.y);
        
    } else {
        self.headImageView.frame = CGRectMake(0, scrollView.contentOffset.y / 1.5, self.view.frame.size.width, M_HeadImageHeight);
    }

    
}

#pragma mark ---- loadData
- (void)loadVisaData{
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
    
    
    NSString *str=[NSString stringWithFormat:@"%@?product_id=%@&assistant_id=%@",VisaListUrl, self.product_id,assistant_id];
    NSLog(@"%@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        NSArray *arr=[dict objectForKey:@"data"];
        if (arr.count==0) {
            [[LXAlterView sharedMyTools]createTishi:@"没有该产品"];
            return;
        }
        self.visaModel = [[ZFJVisaModel alloc] initWithDictionary:[[dict objectForKey:@"data"] objectAtIndex:0]];
        NSLog(@"%@-%@-%@-%@",self.visaModel.active_times,self.visaModel.enter_times,self.visaModel.deal_time,self.visaModel.stay);
        //NSLog(@"product_id = %@", self.visaModel.product_id);
        [self downloadData];
        
        [self addHeaderView];
        [self addChooesView];
        [self addMessageView];
        
       
    
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
            [self loadVisaData];
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
    [chooseBut addTarget:self action:@selector(shareShop:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(chooseBut) - 18, (ViewHeight(chooseBut) - 21) / 2.0, 24, 24)];
    icon.image = [UIImage imageNamed:@"分享1"];
    [chooseBut addSubview:icon];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chooseBut];
    
    //分享跳转的URL
    shareURL=VISAS_SHARE_URL(self.product_id);

 
}

#pragma mark - 分享按钮 点击事件
- (void)shareShop:(UIButton *)sender
{
    
    //分享的内容
    NSString *content=self.visaModel.product_name;
    content=[content stringByAppendingString:@"\r\n"];
    content=[content stringByAppendingFormat:@"本产品由%@提供服务。微旅,您家门口的旅行管家", [self judgeReturnString:self.visaModel.company_name withReplaceString:@""]];
    
    
    
    
    //描述内容
    NSString *desc=[NSString stringWithFormat:@"本产品由%@提供服务。微旅,您家门口的旅行管家", [self judgeReturnString:self.visaModel.company_name withReplaceString:@""]];
 
    

    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:content
                                                image:[ShareSDK jpegImageWithImage:_shareImage quality:1]
                                                title:self.visaModel.product_name
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




//下载资料
- (void)downloadData
{
    self.downloadArr = [NSMutableArray array];
    NSLog(@"%@", self.visaModel.atts);
    NSString *str=[NSString stringWithFormat:@"%@?atts=%@", GetVisaDownLoadUrl,self.visaModel.atts];
    //NSString *str=[NSString stringWithFormat:@"http://202.104.102.2/api/visaApi/getAttachment?atts=%@", @"536,537,538,539,540"];
    NSLog(@"++++++++++++%@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        self.downloadArr = [dict objectForKey:@"data"];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //NSLog(@"发生错误！%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

@end

void alert(NSString* msg)
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alert show];
}



