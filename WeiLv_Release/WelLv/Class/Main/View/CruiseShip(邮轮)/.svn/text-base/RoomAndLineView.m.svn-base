//
//  RoomAndLineView.m
//  WelLv
//
//  Created by 吴伟华 on 16/3/21.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "RoomAndLineView.h"
#import "ZFJShipDetailModel.h"
#import "CSRoomDetailView.h"
typedef NS_ENUM(NSInteger,BtnclickType)
{
    BtnclickTypeDefault,
    BtnclickTypeRoom,
    BtnclickTypeLine
};


#define BACKGROUNDCOLOR  [UIColor colorWithRed:228/255.0 green:234/255.0 blue:239/255.0 alpha:1]
#define ROOMCOLOR  [UIColor colorWithRed:255/255.0 green:153/255.0 blue:102/255.0 alpha:1]

@interface RoomAndLineView ()<UIWebViewDelegate>
@property (nonatomic,strong) ZFJShipDetailModel *shipDetailModel;
@property (nonatomic,assign)BtnclickType  btnclickType;
@property (nonatomic,strong)UIButton *clickBtn;
@property (nonatomic,weak)UILabel *selectLine;
@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIView *rightView;
@property (nonatomic,strong)UIWebView *featureView;
@property (nonatomic,assign)CGFloat webViewHigh;
@end

@implementation RoomAndLineView

-(instancetype)initWithFrame:(CGRect)frame andShipDetailModel:(ZFJShipDetailModel *)shipDetailModel
{

    if (self = [super initWithFrame:frame]) {
        self.shipDetailModel = shipDetailModel;
        
        [self creatRoomAndLineView];
        self.btnclickType = BtnclickTypeRoom;
    }
    return self;

}
#pragma mark -创建左右按钮视图
-(void)creatRoomAndLineView
{
    NSArray *array = [NSArray arrayWithObjects:@"舱房信息",@"行程介绍",nil];
    
    for (NSInteger i = 0; i < 2; i++) {
        NSString *name = array[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*windowContentWidth/2.0, 10, windowContentWidth/2.0, 30);
        [btn setTitle:name forState:UIControlStateNormal];
        [btn setTitle:name forState:UIControlStateSelected];
        [btn setTitleColor:ROOMCOLOR forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = 100+i;
        if (i == 0) {
            btn.selected = YES;
            self.clickBtn = btn;
        }
        
        [btn addTarget:self action:@selector(rooTypeClik:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }

    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45, windowContentWidth, 0.5)];
    lineLabel.backgroundColor = BACKGROUNDCOLOR;
    [self addSubview:lineLabel];
    
    
    UILabel *selectLine = [[UILabel alloc] initWithFrame:CGRectMake((windowContentWidth/2.0 - 100)/2.0,43, 100, 2)];
    selectLine.backgroundColor = ROOMCOLOR;
    self.selectLine = selectLine;
    [self addSubview:selectLine];
    
    [self creatLeftView];//创建左视图
    [self creatRirhtView];//创建右视图
    
    



}
#pragma mark -创建左显示视图
-(void)creatLeftView
{
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, windowContentWidth, self.frame.size.height - 45)];
    self.leftView.backgroundColor = [UIColor whiteColor];
    self.leftView.hidden = NO;
    [self addSubview:self.leftView];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    imageView.image = [UIImage imageNamed:@"cs_proudict_characteristic"];
    [self.leftView addSubview:imageView];
    
    UILabel *characterLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 80, 20)];
    characterLabel.backgroundColor = [UIColor clearColor];
    characterLabel.font = [UIFont systemFontOfSize:14];
    characterLabel.text = @"产品特色";
    [self.leftView addSubview:characterLabel];
    
    
    NSString * formatString = @"<span style=\"font-size:14px;color:#868686\">%@</span>";
    NSString * htmlString = [NSString stringWithFormat:formatString,@"<p>隶属于全球邮轮业翘楚嘉年华集团的意大利歌诗达邮轮公司，大西洋号做为歌诗达船队中的旗舰船，以\"意大利风情\"为品牌定位，被业界誉为“艺术之船”。它混合了梦境和巴洛克艺术：费里尼和《甜蜜生活》、《蝴蝶夫人》、历史悠久的威尼斯Caffè Florian、史皮卡大道、十八世纪的Tiziano餐厅。在这里您可入住健康客舱与套房，这里配有特供家具，让客人享受极致舒适，并可直通 Ischia 健身中心。大西洋是一座名副其实的“The Ideal City”,带你开启“海上威尼斯”的艺术之旅。</p>"];
    
    _featureView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 40, windowContentWidth - 40, 45)];
    _featureView.backgroundColor = [UIColor clearColor];
    _featureView.delegate = self;
    _featureView.userInteractionEnabled = NO;
    [_featureView loadHTMLString:htmlString baseURL:nil];
    [self.leftView addSubview:_featureView];
    
    NSMutableArray *roomArray = [NSMutableArray array];
    [roomArray removeAllObjects];
    
    
   //取出舱房类型
    NSArray *keyArray = [self.shipDetailModel.room allKeys];
    
    for (NSString *key in keyArray) {
        
        //获取每种舱房的房间字典
        NSDictionary *roomDic = self.shipDetailModel.room[key];
        
        //删出每种房间cabin_rebate的关键字
        NSArray *roomKeyArrays = [roomDic allKeys];
         for (NSString *roomKey in roomKeyArrays) {
            if ([roomKey isEqualToString:@"cabin_rebate"]) {
                [roomArray removeObject:roomKey];
            }
        }
        
      //取出每种舱房的所有房间
        
        
        
        //
        
        
        
        
    }
    
    for (int i = 0; i < roomArray.count; i++) {
        CSRoomDetailView *roomDtail = [[CSRoomDetailView alloc] initWithFrame:CGRectMake(10, ViewBelow(_featureView) + i*100, windowContentWidth - 20, 100)];
        [self.leftView addSubview:roomDtail];
    }
    
 }
#pragma mark -创建右显示视图
-(void)creatRirhtView
{
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 46, windowContentWidth, self.frame.size.height - 45)];
    self.rightView.backgroundColor = [UIColor purpleColor];
    self.rightView.hidden = YES;
    [self addSubview:self.rightView];
    
}

#pragma mark -行程与舱房按钮点击
-(void)rooTypeClik:(UIButton *)btn
{
    NSInteger btnTag = btn.tag - 100;
    self.clickBtn.selected = NO;
    btn.selected = YES;
    self.clickBtn = btn;
    self.btnclickType = btnTag==0?BtnclickTypeRoom:BtnclickTypeLine;
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.selectLine.frame = CGRectMake((windowContentWidth/2.0 - 100)/2.0 + (btnTag * windowContentWidth/2.0),43, 100, 2);
    }];
    
    if (self.btnclickType == BtnclickTypeRoom) {
        self.leftView.hidden = NO;
        self.rightView.hidden = YES;
    }
    else
    {
        self.leftView.hidden = YES;
        self.rightView.hidden = NO;
     }
}

#pragma mark  -计算每种舱房的最低价格

//-(NSArray *)lowPriceArray:(NSDictionary *)rooDic
//{
//
//
//}

#pragma mark  -webview代理
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    if (fittingSize.height > 45) {
        
        UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        detailBtn.frame = CGRectMake(windowContentWidth - 30, 65, 20, 30);
        [detailBtn setImage:[UIImage imageNamed:@"cs_detai_down"] forState:UIControlStateNormal];
        [detailBtn setImage:[UIImage imageNamed:@"cs_detail_up"] forState:UIControlStateSelected];
        [detailBtn addTarget:self action:@selector(headViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        detailBtn.selected = NO;
        [self.leftView addSubview:detailBtn];
        
        _webViewHigh = fittingSize.height;
        
    }
    _featureView.frame = CGRectMake(10, 40, windowContentWidth - 40, 45);
}


-(void)headViewBtnClick:(UIButton *)btn
{
    CGRect licenseFrame = _featureView.frame;
     btn.selected = !btn.selected;
    if (btn.selected) {
        DLog(@"选中");
        licenseFrame.size.height = _webViewHigh + 10;
        
    } else {
        
        licenseFrame.size.height = 45;
    }
    
    _featureView.frame = licenseFrame;
    
    if ([_delegate respondsToSelector:@selector(feartureBtnClick:andWebViewHigh:)]) {
        [_delegate feartureBtnClick:self andWebViewHigh:_webViewHigh + 10];
    }
}

@end
