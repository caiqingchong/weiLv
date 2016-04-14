//
//  VisaDetailVC.m
//  WelLv
//
//  Created by 张发杰 on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "VisaDetailVC.h"

#import "IamgeAndLabelView.h"
#import "LXChooseDateViewController.h"

#import "FJDownloadFolderView.h"

#import "VisaCommentCell.h"
#import "ZFJVisaModel.h"

#import "ZFJNoticeMessageVC.h"
#import "ZFJCallStewardVC.h"

#import "ZFJImageAndTitleButton.h"

#import "LXUserTool.h"
#import "LXGuanJiaModel.h"
#import "LXGetCityIDTool.h"
#import "ChooseTitleView.h"
#import "ZFJCallVC.h"
#define M_COLL_RESERVE_BUT_HEIGHT 40

#define M_TAGVIEW_HEIGHT 40


#define M_VISA_TITLE_HEIGHT 30

#define M_HeadImageHeight  self.view.frame.size.width * (333 / 640.0)
#define M_IMAGE_H_W 640 / 333.0
@interface VisaDetailVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *visaDetailScrollView;


@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *chooseView;

@property (nonatomic, strong) UIView * tagView;
@property (nonatomic, strong) IamgeAndLabelView * visaType;
@property (nonatomic, strong) IamgeAndLabelView * addressToVisa;
@property (nonatomic, strong) UIView * satisfactionView;
@property (nonatomic, strong) UILabel *satisfactionLabel;

@property (nonatomic, strong) UILabel * visaTitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIView * backView;

@property (nonatomic, strong) UIView *chooessLine;


@property (nonatomic, strong) UIView *messageView;
@property (nonatomic, strong) UIView *commentView;



@property (nonatomic, strong) UILabel * validityLabel; //有效期；
@property (nonatomic, strong) UILabel * timesLabel;//次数；
@property (nonatomic, strong) UILabel * stopTimeLabel;//停留时长；
@property (nonatomic, strong) UILabel * transactionTimeLabel;//办理时长；

@property (nonatomic, strong) UILabel * rangeLabel;//受理范围label；


@property (nonatomic, strong) UILabel *commentSatisfactionLabel;

@property (nonatomic, strong) UIView *callStewardView;//拨打管家列表页面；
@property (nonatomic, strong) UIView *blurView;//模糊页面；


//评论
@property (nonatomic, strong) UIView * oneCommentView;

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *visaTapy;
@property (nonatomic, assign) NSInteger starNumber;

@property (nonatomic, strong) UILabel *commentTextLabel;
@property (nonatomic, strong) UILabel *timeLabel;


@property (nonatomic, strong) UILabel * productID;//产品ID


@property (nonatomic, assign) CGFloat commentHeight;


@property (nonatomic, strong) NSMutableArray * dataArray;


@property (nonatomic, strong) UILabel *noCommentLabel;

@property (nonatomic, strong) NSMutableArray * downloadArr;

@property (nonatomic, strong) NSMutableArray * stewardArray;//管家数组；




@end

@implementation VisaDetailVC




- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"签证详情";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadVisaData];
    [self downloadData];
    
}

//加载滚动视图；
- (void)addScrollView
{
    self.visaDetailScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - M_COLL_RESERVE_BUT_HEIGHT )];
    self.visaDetailScrollView.backgroundColor = [UIColor whiteColor];
    self.visaDetailScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1520);
    self.visaDetailScrollView.delegate = self;
    
    [self.view addSubview:self.visaDetailScrollView];
    
}


//加载头部信息视图；

- (void)addHeadMessageView
{
    
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, M_HeadImageHeight)];
    self.headImageView.backgroundColor = [UIColor cyanColor];
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://www.weilv100.com/%@", self.visaModel.thumb]] placeholderImage:[UIImage imageNamed:@"默认图3"]];

    
    
    self.tagView = [[UIView alloc] initWithFrame:CGRectMake(0, M_HeadImageHeight - M_TAGVIEW_HEIGHT, self.headImageView.frame.size.width, M_TAGVIEW_HEIGHT)];
    self.tagView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
    //    self.tagView.alpha = 0.8;
    
    
    self.visaType = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(10, 10, 90, 20)];
    self.visaType.infoLanel.text = [NSString stringWithFormat:@"%@签证", self.visaModel.visa_type];
    self.visaType.infoLanel.textColor = [UIColor whiteColor];
    self.visaType.infoLanel.font = [UIFont systemFontOfSize:12];
    self.visaType.iconIamge.image = [UIImage imageNamed:@"签证1"];
    
    [self.tagView addSubview:_visaType];
    
    self.addressToVisa = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(100, 10, 100, 20)];
    self.addressToVisa.infoLanel.text = [NSString stringWithFormat:@"%@", self.visaModel.complete_addr];
    self.addressToVisa.infoLanel.textColor = [UIColor whiteColor];
    self.addressToVisa.infoLanel.font = [UIFont systemFontOfSize:12];
    self.addressToVisa.iconIamge.image = [UIImage imageNamed:@"送达1"];
    
    [self.tagView addSubview:_addressToVisa];
    
    [self.headImageView addSubview:_tagView];
    
    
    
    [self.visaDetailScrollView addSubview:_headImageView];
    
    
    
    self.visaTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headImageView.frame.size.height , self.view.frame.size.width, M_VISA_TITLE_HEIGHT)];
    self.visaTitleLabel.backgroundColor = [UIColor whiteColor];
    self.visaTitleLabel.text = [NSString stringWithFormat:@"  %@", self.visaModel.product_name];
    
    [self.visaDetailScrollView addSubview:_visaTitleLabel];
    
    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headImageView.frame.size.height + M_VISA_TITLE_HEIGHT, windowContentWidth, M_VISA_TITLE_HEIGHT)];
    aView.backgroundColor = [UIColor whiteColor];
    [self.visaDetailScrollView addSubview:aView];
    UILabel * weiLvPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.headImageView.frame.size.height + M_VISA_TITLE_HEIGHT, 50, M_VISA_TITLE_HEIGHT)];
    weiLvPriceLabel.text = @"微旅价：";
    weiLvPriceLabel.backgroundColor = [UIColor whiteColor];
    weiLvPriceLabel.font = [UIFont systemFontOfSize:12];
    weiLvPriceLabel.textColor = kColor(255, 96, 126);
    [self.visaDetailScrollView addSubview:weiLvPriceLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, self.headImageView.frame.size.height + M_VISA_TITLE_HEIGHT , 100, M_VISA_TITLE_HEIGHT)];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@", self.visaModel.sell_price];
    self.priceLabel.font = [UIFont systemFontOfSize:19];
    self.priceLabel.textColor = kColor(255, 96, 126);
    self.priceLabel.backgroundColor = [UIColor whiteColor];
    [self.visaDetailScrollView addSubview:_priceLabel];
    
    CGRect width = [self returnWidthTextCGRectText:[NSString stringWithFormat:@"¥%@", self.visaModel.sell_price] textFont:19];
    UILabel * startLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.priceLabel.frame.origin.x +  width.size.width + 5, self.headImageView.frame.size.height + M_VISA_TITLE_HEIGHT , 50, M_VISA_TITLE_HEIGHT)];
    startLabel.text = @"起";
    startLabel.textColor = [UIColor grayColor];
    [self.visaDetailScrollView addSubview:startLabel];
    
    
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headImageView.frame.size.height + M_VISA_TITLE_HEIGHT * 2 - 0.5, self.view.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.visaDetailScrollView addSubview:lineView];
    
}
- (CGRect)returnWidthTextCGRectText:(NSString *)str textFont:(CGFloat)font
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(0, M_VISA_TITLE_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return rect;
}
//加载选择视图；
- (void)addChooesView
{
    self.chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, self.priceLabel.frame.origin.y + self.priceLabel.frame.size.height + 2, self.view.frame.size.width, 40)];
    _chooseView.backgroundColor = [UIColor whiteColor];
    
    UIButton * messageBut = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBut.frame = CGRectMake(0, 0, self.view.frame.size.width / 2, 40);
    [messageBut setTitle:@"签证概述" forState:UIControlStateNormal];
    [messageBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [messageBut addTarget:self action:@selector(messageButton:) forControlEvents:UIControlEventTouchUpInside];
    messageBut.tag = 200;
    messageBut.backgroundColor = [UIColor whiteColor];
    [self.chooseView addSubview:messageBut];
    
    UIButton *commentBut = [UIButton buttonWithType:UIButtonTypeCustom];
    commentBut.frame = CGRectMake(self.view.frame.size.width / 2, 0, self.view.frame.size.width / 2, 40);
    [commentBut setTitle:@"评论(0)" forState:UIControlStateNormal];
    [commentBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    commentBut.tag = 201;
    [commentBut addTarget:self action:@selector(commentButton:) forControlEvents:UIControlEventTouchUpInside];
    messageBut.backgroundColor = [UIColor whiteColor];
    [self.chooseView addSubview:commentBut];
    
    //俩个Button之间的分界线；
    UIView * messageAndCommentLine = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 0.3, 5, 0.6, 30)];
    messageAndCommentLine.backgroundColor = [UIColor grayColor];
    [self.chooseView addSubview:messageAndCommentLine];
    
    UIView * buttonLine = [[UIView alloc] initWithFrame:CGRectMake(0, commentBut.frame.origin.y + 40, self.view.frame.size.width, 0.5)];
    buttonLine.backgroundColor = [UIColor grayColor];
    [self.chooseView addSubview:buttonLine];
    
    self.chooessLine = [[UIView alloc] initWithFrame:CGRectMake(10, commentBut.frame.origin.y + 40 - 1, self.view.frame.size.width / 2 - 20, 2)];
    self.chooessLine.backgroundColor = [UIColor orangeColor];
    [self.chooseView addSubview:_chooessLine];
    
    //    self.commentHeight = self.chooseView.frame.origin.y + self.chooseView.frame.size.height + 10;
    //    NSLog(@"%g", self.commentHeight);
    [self.visaDetailScrollView addSubview:_chooseView];
    
    [self.view addSubview:_visaDetailScrollView];
    
    [self addMessageView];
    
    
    
    UIButton * collButton = [UIButton buttonWithType:UIButtonTypeCustom];
    collButton.frame = CGRectMake(0, self.view.frame.size.height - M_COLL_RESERVE_BUT_HEIGHT, self.view.frame.size.width / 2, M_COLL_RESERVE_BUT_HEIGHT);
    [collButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    collButton.backgroundColor = kColor(40, 218, 171);
    [collButton addTarget:self action:@selector(collButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:collButton];
    
    UIButton * reserveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reserveButton.frame = CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height  - M_COLL_RESERVE_BUT_HEIGHT, self.view.frame.size.width / 2, M_COLL_RESERVE_BUT_HEIGHT);
    reserveButton.backgroundColor = kColor(254, 204, 65);
    [reserveButton setTitle:@"立即预订" forState:UIControlStateNormal];
    [reserveButton addTarget:self action:@selector(reserveVisaBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reserveButton];
    
}

//选择左边视图；

- (void)addMessageView
{
    self.messageView = [[UIView alloc] initWithFrame:CGRectMake(0, M_HeadImageHeight + M_VISA_TITLE_HEIGHT * 2 + 40, self.view.frame.size.width, 1500)];
    self.messageView.backgroundColor = [UIColor whiteColor];
    UIButton * chooesTimeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    chooesTimeBut.frame = CGRectMake(0, 0, windowContentWidth, 50);
    IamgeAndLabelView * chooseTimeView = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width, 30)];
    chooseTimeView.infoLanel.font = [UIFont systemFontOfSize:14];
    chooseTimeView.infoLanel.text = @"选择时间";
    chooseTimeView.infoLanel.frame = CGRectMake(25, 5, 200, 20);
    chooseTimeView.iconIamge.frame = CGRectMake(0, 6, 18, 18);
    chooseTimeView.iconIamge.image = [UIImage imageNamed:@"选择时间old"];
    UIImageView *arrowMarkTime = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, 5, 30, 20)];
    arrowMarkTime.image = [UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"];
    [chooseTimeView addSubview:arrowMarkTime];
    
    UIView * lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, chooesTimeBut.frame.size.height, self.view.frame.size.width, 0.5)];
    lineOne.backgroundColor = [UIColor grayColor];
    
    [chooesTimeBut addTarget:self action:@selector(reserveVisaBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.messageView addSubview:chooseTimeView];
    [self.messageView addSubview:chooesTimeBut];
    [self.messageView addSubview:lineOne];
    
    
    IamgeAndLabelView *transactionExplain = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(0, chooesTimeBut.frame.origin.y + 50, self.view.frame.size.width, 50)];
    transactionExplain.infoLanel.text = @"办理说明";
    transactionExplain.iconIamge.image = [UIImage imageNamed:@"办理说明old"];
    transactionExplain.iconIamge.frame = CGRectMake(10, 17.5, 15, 15);
    transactionExplain.infoLanel.frame = CGRectMake(35, 10, 60, 30);
    transactionExplain.infoLanel.font = [UIFont systemFontOfSize:14];
    [self.messageView addSubview:transactionExplain];
    NSArray * titleArr = @[@"签证有效期：", @"入境次数：", @"最长停留时间：", @"办理时长："];
    for (int i = 0; i < 4; i++) {
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, transactionExplain.frame.origin.y  + 50 + 30 * i, 100 , 30)];
        titleLabel.text = [titleArr objectAtIndex:i];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self.messageView addSubview:titleLabel];
    }
    
    self.validityLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, transactionExplain.frame.origin.y  + 50 , windowContentWidth - 120 , 30)];
    self.validityLabel.text = self.visaModel.active_times;
    self.validityLabel.textColor = [UIColor grayColor];
    self.validityLabel.font = [UIFont systemFontOfSize:14];
    self.validityLabel.textAlignment = NSTextAlignmentRight;
    [self.messageView addSubview:_validityLabel];
    self.timesLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, transactionExplain.frame.origin.y  + 50 + 30, windowContentWidth - 120 , 30)];
    
    self.timesLabel.text = self.visaModel.enter_times;
    self.timesLabel.textColor = [UIColor grayColor];
    self.timesLabel.font = [UIFont systemFontOfSize:14];
    self.timesLabel.textAlignment = NSTextAlignmentRight;
    [self.messageView addSubview:_timesLabel];
    
    self.stopTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, transactionExplain.frame.origin.y  + 50  + 30 + 30, windowContentWidth - 120 , 30)];
    self.stopTimeLabel.text = [NSString stringWithFormat:@"%@", self.visaModel.stay];
    self.stopTimeLabel.textColor = [UIColor grayColor];
    self.stopTimeLabel.font = [UIFont systemFontOfSize:14];
    self.stopTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.messageView addSubview:_stopTimeLabel];
    
    self.transactionTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, transactionExplain.frame.origin.y  + 50 + 30 +30 +30, windowContentWidth - 85 , 30)];
    self.transactionTimeLabel.text = [NSString stringWithFormat:@"%@", self.visaModel.deal_time];
    self.transactionTimeLabel.textColor = [UIColor grayColor];
    self.transactionTimeLabel.font = [UIFont systemFontOfSize:14];
    self.transactionTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.messageView addSubview:_transactionTimeLabel];
    
    
    UIView * lineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, self.transactionTimeLabel.frame.origin.y + self.transactionTimeLabel.frame.size.height + 5, self.view.frame.size.width, 0.5)];
    lineTwo.backgroundColor = [UIColor grayColor];
    
    [self.messageView addSubview:lineTwo];
    
    IamgeAndLabelView * rangeView = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(0, lineTwo.frame.origin.y + 1, windowContentWidth, 50)];//受理范围
    rangeView.infoLanel.text = @"受理范围";
    rangeView.iconIamge.image = [UIImage imageNamed:@"受理范围old"];
    rangeView.iconIamge.frame = CGRectMake(10, 17.5, 15, 15);
    rangeView.infoLanel.frame = CGRectMake(35, 10, 60, 30);
    rangeView.infoLanel.font = [UIFont systemFontOfSize:14];
    [self.messageView addSubview:rangeView];
    
    //
    NSString * str = self.visaModel.accept_conditions;
    NSDictionary * textDic =[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(windowContentWidth - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    self.rangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, rangeView.frame.origin.y + rangeView.frame.size.height, windowContentWidth - 20, rect.size.height)];
    self.rangeLabel.text = str;
    self.rangeLabel.numberOfLines = 0;
    self.rangeLabel.font = [UIFont systemFontOfSize:14];
    self.rangeLabel.textColor = [UIColor grayColor];
    //self.rangeLabel.backgroundColor = [UIColor orangeColor];
    [self.messageView addSubview:self.rangeLabel];
    
    UIView *lineThree = [[UIView alloc] initWithFrame:CGRectMake(0, self.rangeLabel.frame.origin.y + self.rangeLabel.frame.size.height + 9, windowContentWidth, 0.5)];
    lineThree.backgroundColor = [UIColor grayColor];
    [self.messageView addSubview:lineThree];
    
    IamgeAndLabelView * needMaterialView = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(0, lineThree.frame.origin.y + 0.5, windowContentWidth, 50)];
    needMaterialView.infoLanel.text = @"所需材料（请根据自身情况选择）";
    needMaterialView.iconIamge.image = [UIImage imageNamed:@"所需材料old"];
    needMaterialView.iconIamge.frame = CGRectMake(10, 17.5, 15, 15);
    needMaterialView.infoLanel.frame = CGRectMake(35, 10, windowContentWidth, 30);
    needMaterialView.infoLanel.font = [UIFont systemFontOfSize:14];
    [self.messageView addSubview:needMaterialView];
    
    NSArray * needMaterialArr = @[@"在职人员", @"自由职业者", @"退休人员", @"在校学生", @"学龄前儿童"];
    for (int i = 0; i < needMaterialArr.count; i++) {
        UIButton *needMaterialBut = [UIButton buttonWithType:UIButtonTypeCustom];
        needMaterialBut.frame = CGRectMake(10, needMaterialView.frame.origin.y  + 50 + 30 * i, windowContentWidth , 30);
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, needMaterialView.frame.origin.y  + 50 + 30 * i, windowContentWidth, 30)];
        titleLabel.text = [needMaterialArr objectAtIndex:i];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:14];
        UIImageView *arrowMark = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, 5, 30, 20)];
        arrowMark.image = [UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"];
        [titleLabel addSubview:arrowMark];
        titleLabel.tag =  150 + i;
        needMaterialBut.tag = 160 + i;
        
        [self.messageView addSubview:titleLabel];
        
        [needMaterialBut addTarget:self action:@selector(materialButton:) forControlEvents:UIControlEventTouchUpInside];
        //needMaterialBut.backgroundColor = [UIColor orangeColor];
        [self.messageView addSubview:needMaterialBut];
    }
    
    UIView * lineFour = [[UIView alloc] initWithFrame:CGRectMake(0, needMaterialView.frame.origin.y + 50 + 30 * needMaterialArr.count + 0.5, windowContentWidth, 0.5)];
    lineFour.backgroundColor = [UIColor grayColor];
    [self.messageView addSubview:lineFour];
    
    
    //NSArray * floderArr = @[@"在职模版", @"个人信息模版", @"在职模版", @"行程单"];
    CGFloat lineFive_y = lineFour.frame.origin.y;
    //NSLog(@"模版 ++++++++++++++++++++++++++++++++++++++++%ld", _downloadArr.count);
    if (_downloadArr.count != 0) {
        IamgeAndLabelView * downloadFolder = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(0, lineFour.frame.origin.y, windowContentWidth, 50)];
        
        downloadFolder.infoLanel.text = @"资料下载";
        downloadFolder.iconIamge.image = [UIImage imageNamed:@"资料下载"];
        downloadFolder.iconIamge.frame = CGRectMake(10, 17.5, 15, 15);
        downloadFolder.infoLanel.frame = CGRectMake(35, 10, windowContentWidth, 30);
        downloadFolder.infoLanel.font = [UIFont systemFontOfSize:14];
        [self.messageView addSubview:downloadFolder];
        for (int i = 0; i < self.downloadArr.count; i++) {
            FJDownloadFolderView *downloadFloderView = [[FJDownloadFolderView alloc] initWithFrame:CGRectMake(0, downloadFolder.frame.origin.y + downloadFolder.frame.size.height + 30 * i, windowContentWidth, 30)];
            downloadFloderView.titleLabel.text = [[_downloadArr objectAtIndex:i] objectForKey:@"name"];
            //downloadFloderView.chooesIcon.backgroundColor = [UIColor orangeColor];
            downloadFloderView.chooesIcon.layer.borderWidth = 1.0;
            downloadFloderView.chooesIcon.layer.borderColor = [UIColor orangeColor].CGColor;
            //downloadFloderView.chooesIcon.image = [UIImage imageNamed:@"选择"];
            [downloadFloderView.chooesButton addTarget:self action:@selector(chooesDownloderBut:) forControlEvents:UIControlEventTouchUpInside];
            downloadFloderView.tag = 400 + i;
            [self.messageView addSubview:downloadFloderView];
        }
        
        
        UIButton *sendToEmailBut = [UIButton buttonWithType:UIButtonTypeCustom];
        sendToEmailBut.frame = CGRectMake((windowContentWidth - 150) / 2, downloadFolder.frame.origin.y + 30 * (self.downloadArr.count + 2), 180, 40);
        
        //    if (_downloadArr.count == 0) {
        //        sendToEmailBut.frame = CGRectMake((windowContentWidth - 150) / 2, downloadFolder.frame.origin.y + 30 * (self.downloadArr.count + 2), 180, 0);
        //    }
        
        
        [sendToEmailBut setTitle:@"发送到邮箱" forState:UIControlStateNormal];
        sendToEmailBut.backgroundColor = [UIColor orangeColor];
        [sendToEmailBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sendToEmailBut addTarget:self action:@selector(sendToEmail:) forControlEvents:UIControlEventTouchUpInside];
        [self.messageView addSubview:sendToEmailBut];
        
        
        UIView *lineFive = [[UIView alloc] initWithFrame:CGRectMake(0, sendToEmailBut.frame.origin.y + sendToEmailBut.frame.size.height + 10, windowContentWidth, 0.5)];
        lineFive.backgroundColor = [UIColor grayColor];
        lineFive_y = lineFive.frame.origin.y;
        [self.messageView addSubview:lineFive];
        
    }
    
    //预定须知
    IamgeAndLabelView * noticeView = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(0, lineFive_y + 0.5, windowContentWidth, 40)];
    noticeView.infoLanel.text = @"预定须知";
    noticeView.iconIamge.image = [UIImage imageNamed:@"预定须知old"];
    noticeView.iconIamge.frame = CGRectMake(10, 17.5, 15, 15);
    noticeView.infoLanel.frame = CGRectMake(35, 10, windowContentWidth, 30);
    noticeView.infoLanel.font = [UIFont systemFontOfSize:14];
    UIButton *noticeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    noticeBut.frame = CGRectMake(0, lineFive_y + 0.5, windowContentWidth, 50);
    [noticeBut addTarget:self action:@selector(noticeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *arrowMarkNotice = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, 10+5, 30, 20)];
    arrowMarkNotice.image = [UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"];
    [noticeView addSubview:arrowMarkNotice];
    [self.messageView addSubview:noticeView];
    [self.messageView addSubview:noticeBut];
    
    
    
    UIView *lineSix = [[UIView alloc] initWithFrame:CGRectMake(0, noticeView.frame.origin.y + noticeView.frame.size.height + 10, windowContentWidth, 0.5)];
    lineSix.backgroundColor = [UIColor grayColor];
    [self.messageView addSubview:lineSix];
    
    //常见问题
    IamgeAndLabelView * questionView = [[IamgeAndLabelView alloc] initWithFrame:CGRectMake(0, lineSix.frame.origin.y + 0.5, windowContentWidth, 45)];
    questionView.infoLanel.text = @"常见问题";
    questionView.iconIamge.image = [UIImage imageNamed:@"常见问题"];
    questionView.iconIamge.frame = CGRectMake(10, 17.5, 15, 15);
    questionView.infoLanel.frame = CGRectMake(35, 10, windowContentWidth, 30);
    questionView.infoLanel.font = [UIFont systemFontOfSize:14];
    UIButton *questionBut = [UIButton buttonWithType:UIButtonTypeCustom];
    questionBut.frame = CGRectMake(0, lineSix.frame.origin.y + 0.5, windowContentWidth, 50);
    [questionBut addTarget:self action:@selector(questionButton:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *arrowMarkQuestion = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, 10+5, 30, 20)];
    arrowMarkQuestion.image = [UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"];
    [questionView addSubview:arrowMarkQuestion];
    [self.messageView addSubview:questionView];
    [self.messageView addSubview:questionBut];
    
    
    UIView *lineSeven = [[UIView alloc] initWithFrame:CGRectMake(0, questionView.frame.origin.y + questionView.frame.size.height + 5, windowContentWidth, 0.5)];
    lineSeven.backgroundColor = [UIColor grayColor];
    
    [self.messageView addSubview:lineSeven];
    
    //self.messageView.frame = CGRectMake(0, 312, self.view.frame.size.width, 1500);
    //    NSLog(@"%g", lineSeven.frame.origin.y + 1 + 300 + 40 + 1);
    //    NSLog(@"%g", questionView.frame.origin.y + questionView.frame.size.height + 5);
    
    self.visaDetailScrollView.contentSize  = CGSizeMake(self.view.frame.size.width, lineSeven.frame.origin.y + 4 + M_VISA_TITLE_HEIGHT * 2 + M_HeadImageHeight + 40);
    [self.visaDetailScrollView addSubview:_messageView];
    [self.visaDetailScrollView bringSubviewToFront:_chooseView];
    
}


//选择右边视图；
- (void)addAllCommentView
{
    self.commentHeight = M_VISA_TITLE_HEIGHT * 2 + M_HeadImageHeight;
    
    NSInteger commentCount = 0;
    
    if (commentCount == 0) {
        
        UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, self.commentHeight, windowContentWidth, self.view.frame.size.height - self.commentHeight)];
        aView.backgroundColor = [UIColor whiteColor];
        [self.visaDetailScrollView addSubview:aView];
        self.noCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.commentHeight + 50, windowContentWidth, self.view.frame.size.height - self.commentHeight)];
        //self.noCommentLabel.backgroundColor = [UIColor whiteColor];
        UIImageView * noCommImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, windowContentWidth - 40, windowContentWidth - 40)];
        noCommImage.backgroundColor = [UIColor whiteColor];
        noCommImage.image = [UIImage imageNamed:@"没找到相关内容"];
        [self.noCommentLabel addSubview:noCommImage];
        //self.noCommentLabel.text = @"暂无评论...";
        self.noCommentLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.visaDetailScrollView addSubview:self.noCommentLabel];
        self.visaDetailScrollView.contentSize = CGSizeMake(windowContentWidth, self.commentHeight + 50 + windowContentWidth - 40);
        
    } else{
        for (int i = 0; i < 10; i++) {
            [self.visaDetailScrollView addSubview:[self addACommentView]];
            self.oneCommentView.tag = 1000 + i;
        }
        
    }
    
    [self.visaDetailScrollView bringSubviewToFront:_chooseView];
}

- (UIView *)addACommentView
{
    self.oneCommentView = [[UIView alloc] init];
    self.oneCommentView.backgroundColor = [UIColor whiteColor];
    UIImageView * userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 15, 15)];
    userIcon.image = [UIImage imageNamed:@"data1"];
    [self.oneCommentView addSubview:userIcon];
    
    self.userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(userIcon.frame.origin.x + userIcon.frame.size.width + 5, 5, 200, 20)];
    self.userNameLabel.text = @"南笙";
    self.userNameLabel.font = [UIFont systemFontOfSize:15];
    [self.oneCommentView addSubview:_userNameLabel];
    
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(windowContentWidth - 90, 5, 80, 20)];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.text = @"2015-04-11";
    [self.oneCommentView addSubview:_timeLabel];
    
    
    self.commentTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.userNameLabel.frame.origin.y + self.userNameLabel.frame.size.height, windowContentWidth - 20, 100)];
    self.commentTextLabel.font = [UIFont systemFontOfSize:14];
    self.commentTextLabel.numberOfLines = 0;
    self.commentTextLabel.text = @"客服虽然很忙，但是有问必答，真的很有耐心，签证也很快，我拍正常签证，3天就签了，一出签就寄回来了，服务很好，下次还会再来！客服虽然很忙，但是有问必答，真的很有耐心，签证也很快，我拍正常签证，3天就签了，一出签就寄回来了，服务很好，下次还会再来！！";
    CGFloat textY = self.userNameLabel.frame.origin.y + self.userNameLabel.frame.size.height;
    self.commentTextLabel.frame = CGRectMake(10, textY, windowContentWidth - 20, [self returnTextCGRectText:self.commentTextLabel.text textFont:14].size.height);
    //self.commentTextLabel.backgroundColor = [UIColor orangeColor];
    [self.oneCommentView addSubview:_commentTextLabel];
    
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, self.commentTextLabel.frame.origin.y + self.commentTextLabel.frame.size.height + 10, windowContentWidth , 0.5)];
    line.backgroundColor = [UIColor grayColor];
    [self.oneCommentView addSubview:line];
    
    self.oneCommentView.frame = CGRectMake(0, self.commentHeight, windowContentWidth, line.frame.origin.y + line.frame.size.height);
    
    self.commentHeight = self.commentHeight + line.frame.origin.y + line.frame.size.height;
    
    self.visaDetailScrollView.contentSize = CGSizeMake(windowContentWidth, self.commentHeight);
    
    return self.oneCommentView;
}

#pragma mark ---

- (CGRect)returnTextCGRectText:(NSString *)str textFont:(CGFloat)font
{
    NSDictionary * textDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(windowContentWidth - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil];
    return rect;
}


#pragma mack ---- ChooseButton

//签证概述按钮；
- (void)messageButton:(UIButton *)button
{
    button.enabled = NO;
    UIButton * commentBut = (UIButton *)[self.chooseView viewWithTag:201];
    commentBut.enabled = YES;
    self.chooessLine.frame= CGRectMake(10, commentBut.frame.origin.y + 40 - 1, self.view.frame.size.width / 2 - 20, 2);
    
    for (int i = 0; i < 10; i++) {
        UIView * aView = [self.visaDetailScrollView viewWithTag:1000 + i];
        [aView removeFromSuperview];
    }
    self.noCommentLabel.hidden = YES;
    [self addMessageView];
}

//评论按钮；
- (void)commentButton:(UIButton *)button
{
    button.enabled = NO;
    UIButton * messageBut = (UIButton *)[self.chooseView viewWithTag:200];
    messageBut.enabled  = YES;
    self.chooessLine.frame = CGRectMake(self.view.frame.size.width / 2 + 10, messageBut.frame.origin.y + 40 - 1, self.view.frame.size.width / 2 - 20, 2);
    
    self.messageView.hidden = YES;
    
    [self addAllCommentView];
    self.noCommentLabel.hidden = NO;
    
}

#pragma mack --- scrollViewDidScroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //[UIView beginAnimations:nil context:nil];
    //[UIView setAnimationDelay:3.0];
    
    self.commentView.frame = CGRectMake(self.commentView.frame.origin.x, self.commentView.frame.origin.y, windowContentWidth, self.commentHeight);
    
    
    
    if (scrollView.contentOffset.y >= M_HeadImageHeight + M_VISA_TITLE_HEIGHT * 2) {
        self.chooseView.frame = CGRectMake(0, scrollView.contentOffset.y, self.view.frame.size.width, 40);
    } else {
        self.chooseView.frame = CGRectMake(0, M_HeadImageHeight + M_VISA_TITLE_HEIGHT * 2, self.view.frame.size.width, 40);
    }
    
    
    
    if (scrollView.contentOffset.y < 0) {
        self.headImageView.frame = CGRectMake(scrollView.contentOffset.y / 2 * M_IMAGE_H_W , scrollView.contentOffset.y, self.view.frame.size.width -  scrollView.contentOffset.y * M_IMAGE_H_W, M_HeadImageHeight -  scrollView.contentOffset.y);
        self.tagView.frame = CGRectMake(-scrollView.contentOffset.y / 2 * M_IMAGE_H_W, self.headImageView.frame.size.height - M_TAGVIEW_HEIGHT, self.view.frame.size.width, M_TAGVIEW_HEIGHT);
        self.satisfactionView.frame = CGRectMake(self.headImageView.frame.size.width - 90, self.headImageView.frame.size.height - 85, 80, 80);
        
    } else {
        self.headImageView.frame = CGRectMake(0, scrollView.contentOffset.y / 1.5, self.view.frame.size.width, M_HeadImageHeight);
        self.tagView.frame = CGRectMake(0, self.headImageView.frame.size.height - M_TAGVIEW_HEIGHT - scrollView.contentOffset.y / 1.5, self.headImageView.frame.size.width, M_TAGVIEW_HEIGHT);
        self.satisfactionView.frame = CGRectMake(self.headImageView.frame.size.width - 90, self.headImageView.frame.size.height - 85, 80, 80);
    }
    
}


#pragma mark - Button
//电话咨询按钮方法；
- (void)collButton:(UIButton *)button
{
    button.enabled = NO;
    
    LXUserTool * userTool = [[LXUserTool alloc] init];
    NSString * userKeeper =  userTool.getKeeper;
    if (![[NSString stringWithFormat:@"%@", userKeeper] isEqual:@"0"] && [userTool getUid] != nil) {
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"拨打管家电话" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拨打管家电话" otherButtonTitles:nil, nil];
        [actionsheet showInView:self.view];
    } else {
        
        ZFJCallVC * callVC = [[ZFJCallVC alloc] init];
        
        callVC.admin_id = self.visaModel.admin_id;
        callVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        callVC.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:callVC animated:YES completion:nil];
        __weak VisaDetailVC * visaDetailVC = self;
        [callVC chooseMoreSteward:^(UIButton *but) {
            ZFJCallStewardVC * callStewardVC = [[ZFJCallStewardVC alloc] init];
            [visaDetailVC.navigationController pushViewController:callStewardVC animated:YES];
        }];
    }
    
    button.enabled = YES;
    
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

#pragma mark ----- 订单预定按钮方法；跳转到预定页面；
//订单预定按钮方法；跳转到预定页面；
- (void)reserveVisaBut:(UIButton *)button
{
    LXChooseDateViewController *lxchooseVC = [[LXChooseDateViewController alloc] init];
    lxchooseVC.visaModel = self.visaModel;
    [lxchooseVC setTrainToDay:365 ToDateforString:nil price:[self.visaModel.sell_price intValue]];
    [self.navigationController pushViewController:lxchooseVC animated:YES];
/*
    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"]){
         NSLog(@"%@*******%@", [[LXUserTool alloc] getHouseAdmin_id], self.visaModel.admin_id);
        if ([[[LXUserTool alloc] getHouseAdmin_id] isEqual:self.visaModel.admin_id]) {
            [self.navigationController pushViewController:lxchooseVC animated:YES];
        } else {
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:AssitBookMsg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } else {
        [self.navigationController pushViewController:lxchooseVC animated:YES];

    }
 */
}



- (void)noticeButton:(UIButton *)button
{
    NSLog(@"预定须知");
    
    ZFJNoticeMessageVC * noticeMessageVC = [[ZFJNoticeMessageVC alloc] init];
    noticeMessageVC.titleString = @"预定须知";
    noticeMessageVC.textString = self.visaModel.book_notice;
    [self.navigationController pushViewController:noticeMessageVC animated:YES];
    
}

- (void)questionButton:(UIButton *)button
{
    NSLog(@"常见问题");
    NSString * str = self.visaModel.addon;
    [self pushNoticeMessageVCTitle:@"常见问题" Text:str];
}


- (void)pushNoticeMessageVCTitle:(NSString *)title Text:(NSString *)text
{
    ZFJNoticeMessageVC * noticeMessageVC = [[ZFJNoticeMessageVC alloc] init];
    noticeMessageVC.titleString = title;
    noticeMessageVC.textString = text;
    [self.navigationController pushViewController:noticeMessageVC animated:YES];
}


//资料下载
- (void)chooesDownloderBut:(UIButton *)button
{
    FJDownloadFolderView * downloadView = (FJDownloadFolderView *)[button superview];
    if ([downloadView.chooesIcon.image isEqual:[UIImage imageNamed:@"选中"]]) {
        NSLog(@"-----------选择资料");
        //downloadView.chooesIcon.backgroundColor = [UIColor whiteColor];
        downloadView.chooesIcon.image = [UIImage imageNamed:@""];
        downloadView.chooesIcon.layer.borderWidth = 1.0;
        downloadView.chooesIcon.layer.borderColor = [UIColor orangeColor].CGColor;
        
    } else {
        downloadView.chooesIcon.image = [UIImage imageNamed:@"选中"];
        downloadView.chooesIcon.layer.borderWidth = 0.0;
        downloadView.chooesIcon.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    NSLog(@"选择资料");
}

//发送到邮箱；
- (void)sendToEmail:(UIButton *)button
{
    LXUserTool * userTool = [[LXUserTool alloc] init];
    
    NSMutableArray * chooesArr = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        FJDownloadFolderView * downloadView = (FJDownloadFolderView *)[self.messageView viewWithTag:400 + i];
        if ([downloadView.chooesIcon.image isEqual:[UIImage imageNamed:@"选中"]]) {
            NSLog(@"发送%d邮箱", i);
            
            [chooesArr addObject:[NSString stringWithFormat:@"发送%d邮箱", i]];
        }
    }
    
    if ([self validateEmail:userTool.getEmail] && chooesArr.count != 0) {
        
        NSLog(@"**********************%@++++", userTool.getEmail);
        
        UIAlertView * emailAlertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"邮件发送成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [emailAlertView show];
    } else if(chooesArr.count != 0 && ![self validateEmail:userTool.getEmail]){
        UIAlertView * emailAlertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"你还未添加邮箱，请输入邮箱地址！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        emailAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField * emailText = [emailAlertView textFieldAtIndex:0];
        emailText.placeholder = @"请输入邮箱...";
        [emailAlertView show];
    }
    
    
}
//添加邮箱；
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    LXUserTool * userTool = [[LXUserTool alloc] init];
    
    BOOL isEmail = [self validateEmail:[alertView textFieldAtIndex:0].text];
    if (buttonIndex == 1 && isEmail == YES) {
        NSLog(@"邮箱：%@", [alertView textFieldAtIndex:0].text);
        
        if ([[LXUserTool alloc] getUid] ) {
            NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
            [settings setObject: [alertView textFieldAtIndex:0].text forKey:@"email"];
            //上传服务器
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            
            NSDictionary *parameters = @{@"uid":[[LXUserTool alloc] getUid],@"email": [alertView textFieldAtIndex:0].text};
            
            [manager POST:SendEmailUrl parameters:parameters
             
                  success:^(AFHTTPRequestOperation *operation,id responseObject) {
                      
                  }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                      
                      NSLog(@"Error: %@", error);
                      
                  }];
        }
        
        
        [userTool saveUserEmail:[alertView textFieldAtIndex:0].text];
        UIAlertView * emailAlertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"邮件发送成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [emailAlertView show];
    }else if(buttonIndex == 1 && isEmail == NO) {
        //[[LXAlterView sharedMyTools] createTishi:@"邮箱格式不正确"];
        UIAlertView * emailAlertView = [[UIAlertView alloc] initWithTitle:@"提醒" message:@"发送失败（邮箱格式不正确!）" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [emailAlertView show];
        
    }
    
}


//保存
-(void)conserve{
}




- (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


- (void)materialButton:(UIButton *)button
{
    UILabel * aLabel = (UILabel *)[self.messageView.superview viewWithTag:button.tag - 10];
    NSLog(@"%@ 所需材料页面", aLabel.text);
    if ([aLabel.text isEqualToString:@"在职人员"]) {
        [self pushNoticeMessageVCTitle:aLabel.text Text:self.visaModel.onjob];
        NSLog(@"%@ 所需材料页面", aLabel.text);
    } else if ([aLabel.text isEqualToString:@"自由职业者"]){
        [self pushNoticeMessageVCTitle:aLabel.text Text:self.visaModel.freelance];
        NSLog(@"%@ 所需材料页面", aLabel.text);
    } else if ([aLabel.text isEqualToString:@"退休人员"]){
        [self pushNoticeMessageVCTitle:aLabel.text Text:self.visaModel.retiree];
        NSLog(@"%@ 所需材料页面", aLabel.text);
    } else if ([aLabel.text isEqualToString:@"在校学生"]){
        [self pushNoticeMessageVCTitle:aLabel.text Text:self.visaModel.instudent];
        NSLog(@"%@ 所需材料页面", aLabel.text);
    } else if([aLabel.text isEqualToString:@"学龄前儿童"]){
        [self pushNoticeMessageVCTitle:aLabel.text Text:self.visaModel.preschoolers];
    }
    
    //[self pushNoticeMessageVCTitle:aLabel.text Text:self.visaModel.onjob];
    
}



#pragma mark --- loadData

- (void)loadData
{
    
    NSString *str=[NSString stringWithFormat:@"%@?limit＝8",getHouseListUrl];
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        
        //[self.visaDetailScrollView reloadInputViews];
        
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}


//下载资料
- (void)downloadData
{
    self.downloadArr = [NSMutableArray array];
    
    // NSLog(@"******************%@", self.visaModel.product_id);
    NSLog(@"%@", self.visaModel.atts);
    NSString *str=[NSString stringWithFormat:@"%@?atts= %@", GetVisaDownLoadUrl,self.visaModel.atts];
    NSLog(@"++++++++++++%@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        //        NSArray * arr = [dict objectForKey:@"data"];
        //        for (int i = 0; i < arr.count; i++) {
        //            [self.downloadArr addObject:[arr objectAtIndex:i]];
        //        }
        
        
        self.downloadArr = [dict objectForKey:@"data"];
        NSLog(@"++++++++%@+++++++++", _downloadArr);
        
        //[self addMessageView];
        //        [self.visaDetailScrollView reloadInputViews];
        
        
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
    
}


- (void)loadVisaData{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    NSString *str=[NSString stringWithFormat:@"%@?product_id=%@",VisaListUrl, self.product_id];
    //NSLog(@"%@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        self.visaModel = [[ZFJVisaModel alloc] initWithDictionary:[[dict objectForKey:@"data"] objectAtIndex:0]];
        NSLog(@"product_id = %@", self.visaModel.product_id);
        [self addScrollView];
        [self addHeadMessageView];
        [self addChooesView];
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


- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

@end
