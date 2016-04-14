//
//  CSProductDetailViewController.m
//  WelLv
//
//  Created by 吴伟华 on 16/3/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CSProductDetailViewController.h"
#import "YXBannerView.h"
#import "CSNavigationBar.h"
#import "CSProductBlackLineView.h"
#import "ZFJShipDetailModel.h"
#import "RoomAndLineView.h"

#define M_HeadImageHeight  self.view.frame.size.width * (333 / 640.0)
#define BACKGROUNDCOLOR  [UIColor colorWithRed:228/255.0 green:234/255.0 blue:239/255.0 alpha:1]
#define BLACKTEXTCOLER  [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1]

@interface CSProductDetailViewController ()<RoomAndLineViewDelegate>
@property (nonatomic,strong)UIScrollView *backGroundScrollView;
@property (nonatomic,strong)UITableView *productTableView;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic,strong)UIView *footShipView;
@property (nonatomic,strong)RoomAndLineView *roomAndLine;//行程介绍视图
@property (nonatomic,strong)NSArray *headImageArray;
@property (nonatomic,strong)UILabel *licenseLabel;//经营许可证



@property (nonatomic,strong)ZFJShipDetailModel *shipDetailModel;//邮轮详情Model
@end

@implementation CSProductDetailViewController
-(UIScrollView *)backGroundScrollView
{
    if (_backGroundScrollView == nil) {
        _backGroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - 80)];
        _backGroundScrollView.backgroundColor = BACKGROUNDCOLOR;
        [self.view addSubview:_backGroundScrollView];
    }
    return _backGroundScrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.backGroundScrollView.showsHorizontalScrollIndicator = NO;
    self.backGroundScrollView.showsVerticalScrollIndicator = NO;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self getData];//获取数据
    
}
#pragma mark -获取数据
-(void)getData
{

    NSMutableDictionary *pamaDic = [NSMutableDictionary dictionary];
    [pamaDic setValue:@"52011" forKey:@"product_id"];
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        NSString  *usergroup_str = [LXUserTool sharedUserTool].getuserGroup;
        [pamaDic setValue:usergroup_str forKey:@"assistant_id"];
    }
    AFHTTPSessionManager *mage = [AFHTTPSessionManager manager];
    [mage POST:M_URL_SHIP_PRODUCT_DETAIL parameters:pamaDic success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSString *statusStr = [NSString stringWithFormat:@"%@",dic[@"status"]];
        if ([statusStr isEqualToString:@"1"]) {
            NSDictionary *resultDic = dic[@"data"];
             self.shipDetailModel = [[ZFJShipDetailModel alloc] initWithDictionary:resultDic];
            id album_list = self.shipDetailModel.album_list;
            if (![album_list isEqual:[NSNull null]]) {
                self.headImageArray = (NSArray *)album_list;
                
            }
            [self addHeadMessageView];//创建头部视图
            [self addFootMessageView];//创建尾部视图
            [self creatButtomView];//创建底部视图
        }
        else
        {
        
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
#pragma mark -加载头部滚动视图
-(void)addHeadMessageView
{
    if (_headView == nil) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 500)];
        _headView.backgroundColor = [UIColor whiteColor];
        [self.backGroundScrollView addSubview:_headView];
    }
    else
    {
        for (UIView *subView in _headView.subviews) {
            [subView removeFromSuperview];
        }
    }
    NSMutableArray *array = [NSMutableArray array];
    if (self.headImageArray.count > 0) {
        for (NSDictionary *dic in self.headImageArray) {
            NSString *urlStr = [NSString stringWithFormat:@"%@%@",WLHTTP,dic[@"picture"]];
            [array addObject:urlStr];
        }
    }
    
    YXBannerView *bannerView = [[YXBannerView alloc] initWithFrameRect:CGRectMake(0, 0, windowContentWidth, M_HeadImageHeight) ImageArray:array];
    bannerView.isPageControlShow = NO;
    [_headView addSubview:bannerView];
    
    NSString *time = [self returnStrFromSeconds:[self.shipDetailModel.setoff_date doubleValue]];
    
    CSProductBlackLineView *addressAndTimeView = [[CSProductBlackLineView alloc] initWithFrame:CGRectMake(0, M_HeadImageHeight - 20, windowContentWidth, 20) imageName:@"port.png" starAddress:self.shipDetailModel.harbor_name andStarTime:time];
    [_headView addSubview:addressAndTimeView];
    
    NSArray *contents = @[[UIImage imageNamed:@"登录注册返回键"], @"", [UIImage imageNamed:@"分享1"]];
    CSNavigationBar *navBar = [[CSNavigationBar alloc] initWithStyle:CSNavBarStyleTransparent leftItemSize:CGSizeMake(15, 25) rightItemSize:CGSizeMake(25, 25) andContents:contents];
    [_headView addSubview:navBar];
    
    CGSize textSize = [self textSize:self.shipDetailModel.product_name];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(bannerView) + 10, windowContentWidth - 20, textSize.height)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = BLACKTEXTCOLER;
    titleLabel.text = self.shipDetailModel.product_name;
    [_headView addSubview:titleLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(titleLabel) + 10, windowContentWidth/2, textSize.height)];
    priceLabel.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=font-size:13px;color:#E53333;>微旅价</span><span style=color:#E53333;>：</span><span style=font-size:18px;color:#E53333;>¥<span style=font-size:18px;> %@</span></span><span style=font-size:16px;color:#E53333;></span><span style=color:#E53333;>起</span><span style=color:#E53333;></span>", [self judgeReturnString:self.shipDetailModel.min_price withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [_headView addSubview:priceLabel];
    
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, ViewBelow(priceLabel) + 10, windowContentWidth - 20, 1)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    
    [_headView addSubview:lineLabel];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(lineLabel) + 10, windowContentWidth - 40, 20)];
    numberLabel.backgroundColor = [UIColor clearColor];
    numberLabel.textColor = [UIColor grayColor];
    numberLabel.text = [NSString stringWithFormat:@"编号 : %@",self.shipDetailModel.product_sn];
    [_headView addSubview:numberLabel];
    
    
    _licenseLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(numberLabel)+10, windowContentWidth - 50, 20)];
    _licenseLabel.font = [UIFont systemFontOfSize:16];
    _licenseLabel.textColor = [UIColor grayColor];
    _licenseLabel.text = [NSString stringWithFormat:@"本产品由%@提供服务,经营许可证号:%@",self.shipDetailModel.supplier_name,self.shipDetailModel.license];
    _licenseLabel.numberOfLines = 0;
    _licenseLabel.backgroundColor = [UIColor clearColor];
    [_headView addSubview:_licenseLabel];
    
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.frame = CGRectMake(windowContentWidth - 30, ViewBelow(numberLabel)+5, 20, 30);
    [detailBtn setImage:[UIImage imageNamed:@"cs_detai_down"] forState:UIControlStateNormal];
    [detailBtn setImage:[UIImage imageNamed:@"cs_detail_up"] forState:UIControlStateSelected];
    [detailBtn addTarget:self action:@selector(headViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    detailBtn.selected = NO;
    [_headView addSubview:detailBtn];
    
    _headView.frame = CGRectMake(0, 0, windowContentWidth, ViewBelow(_licenseLabel) + 10);
}

-(void)headViewBtnClick:(UIButton *)btn
{
    CGRect licenseFrame = _licenseLabel.frame;

    CGSize textSize = [self returnTextCGRectText:[NSString stringWithFormat:@"本产品由%@提供服务,经营许可证号:%@",self.shipDetailModel.supplier_name,self.shipDetailModel.license] textFont:16 cGSize:CGSizeMake(windowContentWidth - 50, CGFLOAT_MAX)].size;
    btn.selected = !btn.selected;
    if (btn.selected) {
        DLog(@"选中");
        licenseFrame.size.height = textSize.height;
        
     } else {
        
       licenseFrame.size.height = 20; 
    }
    
    _licenseLabel.frame = licenseFrame;
    _headView.frame = CGRectMake(0, 0, windowContentWidth, ViewBelow(_licenseLabel) + 10);
    _footShipView.frame =  CGRectMake(0, ViewBelow(_headView) + 20, windowContentWidth, 220 + self.shipDetailModel.room.count*100);
    [self backScroViewSizeWithHeigh:ViewBelow(_footShipView)];
    
 }


#pragma mark -创建尾部视图
-(void)addFootMessageView
{
    if (_footShipView == nil) {
        _footShipView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(_headView) + 20, windowContentWidth, 220 + self.shipDetailModel.room.count*100)];
        _footShipView.backgroundColor = [UIColor whiteColor];
        [self.backGroundScrollView addSubview:_footShipView];
    }
    else
    {
        for (UIView *subView in _headView.subviews) {
            [subView removeFromSuperview];
        }
    }
    RoomAndLineView *roomAndLine = [[RoomAndLineView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 200+ self.shipDetailModel.room.count*100) andShipDetailModel:self.shipDetailModel];
    roomAndLine.delegate = self;
    [_footShipView addSubview:roomAndLine];
    
    [self backScroViewSizeWithHeigh:ViewBelow(_footShipView)];

}
#pragma mark -创建底部视图
-(void)creatButtomView
{
    UIView *buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight - 80, windowContentWidth, 80)];
    buttomView.backgroundColor = [UIColor redColor];

    [self.view addSubview:buttomView];
    
    UIButton *detalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detalBtn.frame = CGRectMake(20, 50, 50, 30);
    [detalBtn setTitle:@"返回" forState:UIControlStateNormal];
    [detalBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [buttomView addSubview:detalBtn];

}

-(void)btnClick
{
[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -计算时间簇
-(NSString *)returnStrFromSeconds:(double)seconds
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [formatter stringFromDate:date];
    return currentDateStr;
}

-(CGSize)textSize:(NSString *)text
{
    NSDictionary *dict =@{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGRect  dictSize = [text boundingRectWithSize:CGSizeMake(windowContentWidth - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return dictSize.size;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -RoomAndLineViewDelegate
//产品特色点击
-(void)feartureBtnClick:(UIView *)roomAndLineView andWebViewHigh:(CGFloat)webViewHigh{

}
//行程与舱房点击
-(void)RoomAndLineBtnClick:(UIView *)roomAndLineView andViewHigh:(CGFloat)viewHigh
{
    [self backScroViewSizeWithHeigh:ViewBelow(roomAndLineView) + 10];
   
    

}

-(void)backScroViewSizeWithHeigh:(CGFloat)webViewHeigh
{
    _backGroundScrollView.contentSize = CGSizeMake(windowContentWidth, webViewHeigh);

}
@end
