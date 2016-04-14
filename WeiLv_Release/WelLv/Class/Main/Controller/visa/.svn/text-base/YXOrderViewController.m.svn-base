//
//  YXOrderViewController.m
//  WelLv
//
//  Created by lyx on 15/4/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXOrderViewController.h"
#import "YXVisaPayViewController.h"
#import "LXUserTool.h"
#import "ZFJOrderPeopleModel.h"
#import "YXTraveDetailModel.h"
#import "ZFJVisaModel.h"
#import "YXWebDetailViewController.h"
#import "TicketListModel.h"
#import "LXSTDetailModel.h"
#import "CheckIDNumber.h"
#import "LoginAndRegisterViewController.h"

@interface YXOrderViewController ()
{
    UIView *bottomView;
    int totalPeople;  //总人数
    UIView *lineDivider3;
    BOOL _isAgree;
    UIButton *detailBtn;
    
    
    UIView *view1;        //出发日期view1;
    UIView *view2;        //放可变化的内容
    OrderTextFieldView *bookView;
    UIButton *agreeBtn;
    UIButton *tiaokuangBtn;
    
    //旅游订单
    UILabel *adultNumLabel;  //成人数
    UILabel *childNunLabel;  //儿童数
    
    //签证订单
     NSMutableArray *_visaPerArray;
     YXExitArrayItem *_visaNumberView;
    
    //邮轮订单
    YXShipOrderView *_shipView;
    NSArray *keys;         //type_id
    UITableView *_bottomView;        //邮轮订单弹出详情
    
    //--------游学--------//
    BOOL _isSelectTime;
    NSUInteger _selectBtnIndex;
    NSUInteger _selectBtnIndex1;
    NSMutableArray *_setoffDateArray; //出发日期
    
    CGFloat _childPrice;
    CGFloat _adultPrice;
    //int count;
    BOOL _isSum;//是否是全额付款
    UILabel *_earnestLab;
    UILabel *_earnestpriceLab;
    NSString *_pay_type;  //支付方式1全款， 2定金
    //--------游学--------//
    
}

@property (nonatomic, strong) UIView *chooseTypeView;
@property (nonatomic, strong) UIButton *tempBut;
@property (nonatomic, strong) ZFJOrderPeopleModel * reservePeople;

@property (nonatomic, strong) NSDictionary * dataDic;
@property (nonatomic, assign) BOOL isShowShipPriceDetail;//表示价格详情的显示状态


@property (nonatomic, strong) UILabel * sumLabel;
@property (nonatomic, strong) UIButton * addBut;
@property (nonatomic, strong) UIButton * minusBut;
@property (nonatomic, copy) NSString *allPrice;//游轮订单总价
@property (nonatomic, assign)NSInteger allPriceHigh;//游轮订单总价详情高度
@property (nonatomic, strong) UILabel *allPeopleLabel;//订单显示的总人数
@property (nonatomic,strong)NSMutableArray *roomPeopleArray;//用来存放选中房间的成人与儿童的人数
@property (nonatomic,strong)NSMutableArray *selectRoomNum;//用于存放选中房间的用户预定的房间个数
@property (nonatomic,strong)NSString *tourId;//用户选择的观光路线ID
@property (nonatomic,strong)NSMutableArray *selectRoomPriceAndNum;//用于存放选中房间的价格和人数
@property (nonatomic,strong)NSMutableArray *selectRoomCellSelect;//用于存放选中房间cell的选中状态
@property (nonatomic,strong)ZFJShoreTraveModel *traveLineModel;//观光线路model
@end

@implementation YXOrderViewController
@synthesize visaRegion = _visaRegion,departureDate = _departureDate,adultNumber = _adultNumber,childrenNumber = _childrenNumber,totalPrice = _totalPrice;
@synthesize isTrave = _isTrave;

#pragma mark -懒加载
-(NSMutableArray *)selectRoomCellSelect
{
    if (_selectRoomCellSelect == nil) {
        _selectRoomCellSelect = [NSMutableArray array];
    }
    return _selectRoomCellSelect;

}
-(NSMutableArray *)selectRoomPriceAndNum
{

    if (_selectRoomPriceAndNum == nil) {
        _selectRoomPriceAndNum = [NSMutableArray array];
    }
    return _selectRoomPriceAndNum;

}
-(NSMutableArray *)selectRoomNum
{

    if (_selectRoomNum == nil) {
        _selectRoomNum = [NSMutableArray array];
    }
    return _selectRoomNum;

}
-(NSMutableArray *)shipArr
{

    if (_shipArr == nil) {
        _shipArr = [NSMutableArray array];
    }
    return _shipArr;
}
-(NSMutableArray *)roomPeopleArray
{
    if (_roomPeopleArray == nil) {
        _roomPeopleArray = [NSMutableArray array];
    }
    return _roomPeopleArray;

}
-(UILabel *)allPeopleLabel
{

    if (_allPeopleLabel == nil) {
        _allPeopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    return _allPeopleLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isShowShipPriceDetail = NO;
    self.allPriceHigh = 0;
    //count=0;
    self.view.backgroundColor = BgViewColor;
    self.title = @"填写订单";
    _isAgree = YES;
    self.totalPrice = [NSString stringWithFormat:@"%.2f",[self.totalPrice floatValue]];
    if (_isVisa)
    {
        self.totalPrice = [NSString stringWithFormat:@"%.2f",[self.visaModel.sell_price floatValue]];
    }
    else if (_isTicket)
    {
        self.totalPrice = [NSString stringWithFormat:@"%.2f",[self.ticketGoodsModel.sell_price floatValue]];
    }
    totalPeople = [self.adultNumber intValue] +[self.childrenNumber intValue];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    [self initView];
}

- (void)close
{
    if (_pushType == isPush)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
}

- (void)initView
{
    DLog(@"%@",self.ticketGoodsModel.goods_id);
    placeLabel = [YXTools allocLabel:self.visaRegion font:systemBoldFont(15) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, Begin_X, ViewWidth(_scrollView)-Begin_X*2, 30) textAlignment:0];
    CGSize size=[self sizeWithString:self.visaRegion font:systemBoldFont(15)];
    [placeLabel setFrame:CGRectMake(Begin_X, Begin_X, ViewWidth(_scrollView)-Begin_X*2, size.height)];
    placeLabel.numberOfLines = 0;
    
    [_scrollView addSubview:placeLabel];
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(placeLabel)+ViewY(placeLabel)+5, windowContentWidth, 40)];
    view1.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:view1];
    
    UILabel *orderLabel = [YXTools allocLabel:@"出发日期 :" font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, 5, 70, 30) textAlignment:0];
    [view1 addSubview:orderLabel];
    
    if (_isStudyTour)
    {
        //游学产品
        _setoffDateArray=[[NSMutableArray alloc] initWithCapacity:0];
        view1.frame=CGRectMake(0, ViewHeight(placeLabel)+ViewY(placeLabel)+5, windowContentWidth, 40+_stadyTourModel.timetable.count*40);
        
        for (int i=0; i<_stadyTourModel.timetable.count; i++)
        {
            LXTimeTableModel *timeModel=[_stadyTourModel.timetable objectAtIndex:i];
            if (i==0) {
                self.departureDate=timeModel.setoff_date;
                self.remanentPeople=timeModel.quota;
            }
            
            [_setoffDateArray addObject:timeModel];
            [self selectTimeView:timeModel index:i];
        }
        
        if ([_stadyTourModel.pay_type integerValue]==1)
        {
            //全款
            LXTimeTableModel *timeModel1=[_setoffDateArray objectAtIndex:0];
            _childPrice=[timeModel1.camper_price floatValue];
            _adultPrice=[timeModel1.teacher_price floatValue];
        }
        else if ([_stadyTourModel.pay_type integerValue]==2)
        {
            //定金
            _childPrice=[_stadyTourModel.earnest floatValue];
            _adultPrice=[_stadyTourModel.earnest floatValue];
        }
        else
        {
            //都可以(默认选择定金)
            _childPrice=[_stadyTourModel.earnest floatValue];
            _adultPrice=[_stadyTourModel.earnest floatValue];
        }
        
    }
    else
    {
       // DLog(@"%@",self.traveModel);
        
        //self.departureDate
        float with = ViewWidth(orderLabel)+ViewX(orderLabel);
        if (_isTrave==YES)
        {
            _beginDateLabel = [YXTools allocLabel:[NSString stringWithFormat:@"%@(余位%@)",self.departureDate,self.remanentPeople]  font:systemFont(14) textColor:[UIColor orangeColor] frame:CGRectMake(with, ViewY(orderLabel),windowContentWidth - with -Begin_X*2, 30) textAlignment:2];
        }
        else
        {
            _beginDateLabel = [YXTools allocLabel:self.departureDate  font:systemFont(14) textColor:[UIColor orangeColor] frame:CGRectMake(with, ViewY(orderLabel),windowContentWidth - with -Begin_X*2, 30) textAlignment:2];
        }
        
        [view1 addSubview:_beginDateLabel];
    }
    
   
    if (_isShip)
    {
        [self loadShipView];//游轮
    }
    else if (_isTrave)
    {
          [self loadTravelView];//旅游度假
    }
    else if (_isTicket)
    {
        [self loadTicketView];//门票
    }
    else if (_isStudyTour)
    {
        [self loadStudyTourView];//游学
    }
    else
    {
        [self loadVisaView];//签证
    }
    
    
    if (_isTicket)
    {
        bookView = [[OrderTextFieldView alloc] initWithFrame:CGRectMake(0, ViewHeight(view2)+ViewY(view2)+20, windowContentWidth, 200) placderName:@"请输入联系人姓名" placderPhone:@"请输入手机号" emial:@"邮箱"];
        bookView.contactImagV.image = [UIImage imageNamed:@"order联系人"];
        bookView.phoneImagV.image = [UIImage imageNamed:@"手机号"];
        bookView.emailImageView.image = [UIImage imageNamed:@"邮箱Order"];
        bookView.nameTextField.delegate = self;
        bookView.phoneTextField.delegate = self;
        bookView.emailTF.delegate = self;
        bookView.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        bookView.tag = 201;
        [_scrollView addSubview:bookView];
        //hjxqBtn常用联系人
        UIButton *contactBtn = [YXTools allocButton:@"常用联系人" textColor:[UIColor whiteColor] nom_bg:[UIImage imageNamed:@"咨询"] hei_bg:nil frame:CGRectMake(20, 140, windowContentWidth-40, 40)];
        [contactBtn addTarget:self action:@selector(selectedContact) forControlEvents:UIControlEventTouchUpInside];
        contactBtn.titleLabel.font = systemBoldFont(15);
        contactBtn.layer.cornerRadius = 5.0;
        [bookView addSubview:contactBtn];
        
    }
    else
    {
        bookView = [[OrderTextFieldView alloc] initWithFrame:CGRectMake(0, ViewHeight(view2)+ViewY(view2)+20, windowContentWidth, 160) placderName:@"请输入联系人姓名" placderPhone:@"请输入手机号"];
        bookView.contactImagV.image = [UIImage imageNamed:@"order联系人"];
        bookView.phoneImagV.image = [UIImage imageNamed:@"手机号"];
        bookView.nameTextField.delegate = self;
        bookView.phoneTextField.delegate = self;
        bookView.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        bookView.tag = 201;
        [_scrollView addSubview:bookView];
        //hjxqBtn常用联系人
        UIButton *contactBtn = [YXTools allocButton:@"常用联系人" textColor:[UIColor whiteColor] nom_bg:[UIImage imageNamed:@"咨询"] hei_bg:nil frame:CGRectMake(20, 100, windowContentWidth-40, 40)];
        [contactBtn addTarget:self action:@selector(selectedContact) forControlEvents:UIControlEventTouchUpInside];
        contactBtn.titleLabel.font = systemBoldFont(15);
        contactBtn.layer.cornerRadius = 5.0;
        
        [bookView addSubview:contactBtn];
    }
    
    
    agreeBtn = [YXTools allocButton:@"" textColor:[UIColor whiteColor] nom_bg:nil hei_bg:nil frame:CGRectMake(Begin_X,ViewHeight(bookView)+ViewY(bookView)+20,125,30)];
    agreeBtn.tag = 1;
    [agreeBtn addTarget:self action:@selector(clickAgree:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:agreeBtn];
    UIImageView *leftView = [YXTools allocImageView:CGRectMake(0, 5, 20, 20) image:[UIImage imageNamed:@"已同意"]];
    [agreeBtn addSubview:leftView];
    
    UILabel *tishiLabel = [YXTools allocLabel:@"我已阅读并接受" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewWidth(leftView)+ViewX(leftView)+5, 0, 100, 30) textAlignment:2];
    [agreeBtn addSubview:tishiLabel];
    
    if (_isTicket)
    {
        tiaokuangBtn = [YXTools allocButton:@"《微旅平台门票预订条款》" textColor:[UIColor redColor] nom_bg:nil hei_bg:nil frame:CGRectMake(ViewRight(tishiLabel),ViewY(agreeBtn),175,30)];
    }
    else if (_isStudyTour)
    {
      tiaokuangBtn = [YXTools allocButton:@"《微旅平台游学预订条款》" textColor:[UIColor redColor] nom_bg:nil hei_bg:nil frame:CGRectMake(ViewWidth(agreeBtn)+ViewX(agreeBtn),ViewY(agreeBtn),175,30)];
    }
    else
    {
          tiaokuangBtn = [YXTools allocButton:@"《微旅平台预订重要条款》" textColor:[UIColor redColor] nom_bg:nil hei_bg:nil frame:CGRectMake(ViewWidth(agreeBtn)+ViewX(agreeBtn),ViewY(agreeBtn),175,30)];
    }
 
    
    
    tiaokuangBtn.tag = 2;
    tiaokuangBtn.titleLabel.font = systemFont(14);
    [tiaokuangBtn addTarget:self action:@selector(clickAgree:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:tiaokuangBtn];
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ControllerViewHeight - 40, windowContentWidth, 40)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    detailBtn = [YXTools allocButton:@"" textColor:[UIColor whiteColor] nom_bg:nil hei_bg:nil frame:CGRectMake(Begin_X, 0, windowContentWidth/2-10, 40)];
    [detailBtn addTarget:self action:@selector(orderDetail:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:detailBtn];
    
    _priceLabel = [YXTools allocLabel:@"订单总额￥0.00" font:systemBoldFont(14) textColor:[UIColor redColor] frame:CGRectMake(0, 0, windowContentWidth/2-35, 40) textAlignment:1];
    [detailBtn addSubview:_priceLabel];
    if (_isVisa) {
        _priceLabel.text = [NSString stringWithFormat:@"订单总额￥%@",_visaModel.sell_price];
    } else if (_isTicket) {
        _priceLabel.text = [NSString stringWithFormat:@"订单总额￥%@",[self judgeReturnString:self.ticketGoodsModel.sell_price withReplaceString:@"0.00"]];
    }
    
    UIImageView *imageView = [YXTools allocImageView:CGRectMake(ViewWidth(_priceLabel)+ViewX(_priceLabel), ViewY(_priceLabel), 15, 40) image:[UIImage imageNamed:@"订单明细按钮"]];
    [detailBtn addSubview:imageView];
    
    UIButton *submitBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.frame = CGRectMake(ViewWidth(detailBtn)+ViewX(detailBtn), 0, windowContentWidth/2, 40);
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    submitBtn.titleLabel.font = systemFont(14);
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"gjbd"] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitOrder) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:submitBtn];
    
    _scrollView.contentSize = CGSizeMake(0, ViewHeight(agreeBtn)+ViewY(agreeBtn)+150);
}

#pragma mark------------以下是游学内容------------
//------------以下是游学内容------------//
//选择出发时间
//
-(void)selectTimeView:(LXTimeTableModel *)model index:(NSUInteger)index
{
    DLog(@"-------%@",model.setoff_date);
    UIButton *timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    timeBtn.frame=CGRectMake(0, 40+40*index, windowContentWidth, 40);
    timeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [timeBtn setTitle:[NSString stringWithFormat:@"%@（余位%@）",[self getDateStr:model.setoff_date],model.quota] forState:UIControlStateNormal];
    [timeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    timeBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
    timeBtn.tag=index+1000;
    if (index==0)
    {
        
        timeBtn.selected=YES;
    }
    else
    {
        timeBtn.selected=NO;
    }
    _selectBtnIndex=1000;
    [timeBtn addTarget:self action:@selector(selectTimeClick:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:timeBtn];
    
    UIImageView *selectImag=[[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-30, 10, 20, 20)];
    if (index==0)
    {
        selectImag.image=[UIImage imageNamed:@"选中圆圈"];
        
    }
    else
    {
        selectImag.image=[UIImage imageNamed:@"未选中圆圈"];
    }
    selectImag.tag=99;
    [timeBtn addSubview:selectImag];
    
    UIImageView *line=[[UIImageView alloc] init];
    line.frame=CGRectMake(0, 0, windowContentWidth, 0.5);
    line.backgroundColor=TableLineColor;
    [timeBtn addSubview:line];
    
    
}

-(void)selectTimeClick:(UIButton *)btn
{
    if (_selectBtnIndex!=btn.tag)
    {
        adultNumLabel.text=@"0";
        childNunLabel.text=@"0";
        _priceLabel.text = [NSString stringWithFormat:@"订单总额￥0"];
    }
    //上一个选中的日期
    UIImageView *imageView1=(UIImageView *)[[view1 viewWithTag:_selectBtnIndex] viewWithTag:99];
    imageView1.image=[UIImage imageNamed:@"未选中圆圈"];
    
    UIImageView *imageView=(UIImageView *)[btn viewWithTag:99];
    imageView.image=[UIImage imageNamed:@"选中圆圈"];
    
    _selectBtnIndex=btn.tag;
    
    LXTimeTableModel *model=[_setoffDateArray objectAtIndex:btn.tag-1000];
    self.departureDate=model.setoff_date;
    self.remanentPeople=model.quota;
    [self updatePrice:model];
    //只有选中全额付款时，价格才变
    if (_isSum==YES)
    {
        _childPrice=[model.camper_price floatValue];
        _adultPrice=[model.teacher_price floatValue];
        [self updateTotalPrice];
    }
    
    DLog(@"出发时间----%@",self.departureDate);
}

#pragma mark ---时间戳转换成时间字符串
-(NSString *)getDateStr:(NSString *)date
{
    NSString *str=date;//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    DLog(@"date:%@",detaildate);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    DLog(@"开始时间===%@",currentDateStr);
    return currentDateStr;
}

- (void)loadStudyTourView
{
    
    LXTimeTableModel *model=[_setoffDateArray objectAtIndex:0];
    
    view2 = [[UIView alloc] init];
    if ([_stadyTourModel.pay_type integerValue]==3) {
        view2.frame= CGRectMake(0, ViewHeight(view1)+ViewY(view1)+20, windowContentWidth, 111+100);
    }else{
        view2.frame= CGRectMake(0, ViewHeight(view1)+ViewY(view1)+20, windowContentWidth, 111+60);
    }
    view2.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:view2];
    
    NSArray *addArray = [NSArray arrayWithObjects:@"家长/老师",@"营员", nil];

    for (int i=0; i<addArray.count; i++)
    {
        
        UILabel *adultLabel = [YXTools allocLabel:[addArray objectAtIndex:i] font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, 56*i, 100, 30) textAlignment:0];
        [view2 addSubview:adultLabel];
        
        UILabel *unitLabel1 = [YXTools allocLabel:@"全价" font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(adultLabel),ViewY(adultLabel)+ViewHeight(adultLabel), 30, 20) textAlignment:0];
        [view2 addSubview:unitLabel1];
        
        UILabel *adultPrice = [YXTools allocLabel:@"" font:systemFont(13) textColor:[UIColor redColor] frame:CGRectMake(ViewX(unitLabel1)+ViewWidth(unitLabel1),ViewY(adultLabel)+ViewHeight(adultLabel), 80, 20) textAlignment:0];
        adultPrice.tag=i+100;
        [view2 addSubview:adultPrice];
        
        //定金
        _earnestLab = [YXTools allocLabel:@"定金" font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(adultPrice)+ViewWidth(adultPrice),ViewY(adultLabel)+ViewHeight(adultLabel), 30, 20) textAlignment:0];
        _earnestLab.tag=300+i;
        [view2 addSubview:_earnestLab];
        
        _earnestpriceLab = [YXTools allocLabel:_stadyTourModel.earnest font:systemFont(13) textColor:[UIColor redColor] frame:CGRectMake(ViewX(_earnestLab)+ViewWidth(_earnestLab),ViewY(adultLabel)+ViewHeight(adultLabel), 100, 20) textAlignment:0];
        _earnestpriceLab.tag=300+i;
        [view2 addSubview:_earnestpriceLab];
        if ([_stadyTourModel.pay_type integerValue]==1) {
            _earnestLab.hidden=YES;
            _earnestpriceLab.hidden=YES;
        }
        
        
        UIButton *cutBtn = [YXTools allocButton:@"" textColor:[UIColor whiteColor] nom_bg:[UIImage imageNamed:@"减少不可用"] hei_bg:nil frame:CGRectMake(windowContentWidth -115, (55-25)/2+ViewY(adultLabel), 25, 25)];
        cutBtn.tag=1+i;
        [cutBtn addTarget:self action:@selector(cutOrAdd1:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:cutBtn];
        
        UIButton *addBtn = [YXTools allocButton:@"" textColor:[UIColor whiteColor] nom_bg:[UIImage imageNamed:@"添加"] hei_bg:nil frame:CGRectMake(windowContentWidth -40, ViewY(cutBtn), 25, 25)];
        addBtn.tag=3+i;
        [addBtn addTarget:self action:@selector(cutOrAdd1:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:addBtn];
        
        UIView *lineOrder = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(adultPrice)+ViewY(adultPrice)+5, windowContentWidth, 0.5)];
        lineOrder.backgroundColor = bordColor;
        [view2 addSubview:lineOrder];
        if (i==0)
        {
            adultPrice.text = [NSString stringWithFormat:@"￥%@",model.teacher_price];
        }
        else
        {
            adultPrice.text = [NSString stringWithFormat:@"￥%@",model.camper_price];
        }
        
    }
    
    adultNumLabel = [YXTools allocLabel:@"0" font:systemFont(15) textColor:[UIColor orangeColor] frame:CGRectMake(windowContentWidth -85, 0, 40, 56) textAlignment:1];
    [view2 addSubview:adultNumLabel];
    
    childNunLabel = [YXTools allocLabel:@"0" font:systemFont(15) textColor:[UIColor orangeColor] frame:CGRectMake(ViewX(adultNumLabel), 56, 40, 56) textAlignment:1];
    [view2 addSubview:childNunLabel];
    
    UIView *bgView=[[UIView alloc] init];
    bgView.frame=CGRectMake(0, 111, windowContentWidth, 20);
    bgView.backgroundColor=BgViewColor;
    [view2 addSubview:bgView];
    
    [self earnestOrAllPriceView:[_stadyTourModel.pay_type integerValue]];

}

-(void)earnestOrAllPriceView:(NSUInteger)pay_type
{
    NSArray *nameArr;
    if (pay_type==1)
    {
        //全额
        nameArr=@[@"全额付款"];
        _pay_type=@"1";
        _isSum=YES;
    }
    else if (pay_type==2)
    {
        //定金
        nameArr=@[@"定金占位"];
        _pay_type=@"2";
    }
    else if (pay_type==3)
    {
        //都可(默认定金)
        nameArr=@[@"定金占位",@"全额付款"];
        _pay_type=@"2";
    }
    
    
    for (int i=0; i<nameArr.count; i++)
    {
        UIButton *timeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        timeBtn.frame=CGRectMake(0, 131+40*i, windowContentWidth, 40);
        timeBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [timeBtn setTitle:[nameArr objectAtIndex:i] forState:UIControlStateNormal];
        [timeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        timeBtn.contentEdgeInsets = UIEdgeInsetsMake(0,10, 0, 0);
        timeBtn.tag=i+500;
        if (i==0)
        {
            timeBtn.selected=YES;
        }
        else
        {
            timeBtn.selected=NO;
        }
        _selectBtnIndex1=500;
        if (nameArr.count==2)
        {
            [timeBtn addTarget:self action:@selector(selectPayTypeClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        [view2 addSubview:timeBtn];
        
        UIImageView *selectImag=[[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-30, 10, 20, 20)];
        if (i==0)
        {
            selectImag.image=[UIImage imageNamed:@"选中圆圈"];
            
        }
        else
        {
            selectImag.image=[UIImage imageNamed:@"未选中圆圈"];
        }
        selectImag.tag=99;
        [timeBtn addSubview:selectImag];
        
        if (nameArr.count==2)
        {
            UIImageView *line=[[UIImageView alloc] init];
            line.frame=CGRectMake(0, 131+40, windowContentWidth, 0.5);
            line.backgroundColor=TableLineColor;
            [view2 addSubview:line];
        }
        
    }
}

-(void)selectPayTypeClick:(UIButton *)btn
{
    //上一个付款方式
    UIImageView *imageView1=(UIImageView *)[[view2 viewWithTag:_selectBtnIndex1] viewWithTag:99];
    imageView1.image=[UIImage imageNamed:@"未选中圆圈"];
    
    UIImageView *imageView=(UIImageView *)[btn viewWithTag:99];
    imageView.image=[UIImage imageNamed:@"选中圆圈"];
    
    _selectBtnIndex1=btn.tag;
    
    //修改价格
    if (btn.tag==500)
    {
        //定金
        [self earnest_hidden_No];
        _isSum=NO;
        _adultPrice=[_stadyTourModel.earnest floatValue];
        _childPrice=[_stadyTourModel.earnest floatValue];
        _pay_type=@"2";
    }
    else
    {
        //全款
        [self earnest_hidden_Yes];
        _isSum=YES;
        LXTimeTableModel *model=[_setoffDateArray objectAtIndex:_selectBtnIndex-1000];
        _adultPrice=[model.teacher_price floatValue];
        _childPrice=[model.camper_price floatValue];
        _pay_type=@"1";
    }
    
    [self updateTotalPrice];
    
    
}

-(void)updatePrice:(LXTimeTableModel *)model
{
    UILabel *teacherPriceLab=(UILabel *)[view2 viewWithTag:100];
    UILabel *camperPriceLab=(UILabel *)[view2 viewWithTag:101];
    teacherPriceLab.text = [NSString stringWithFormat:@"￥%@",model.teacher_price];
    camperPriceLab.text = [NSString stringWithFormat:@"￥%@",model.camper_price];
}

#pragma mark  ------修改订单总额
-(void)updateTotalPrice
{
    CGFloat total;
    total= [adultNumLabel.text intValue]*_adultPrice+[childNunLabel.text intValue]*_childPrice;
    self.totalPrice = [NSString stringWithFormat:@"%.2f",total];
    _priceLabel.text = [NSString stringWithFormat:@"订单总额￥%.2f",total];
    
}

-(void)earnest_hidden_Yes
{
    for (UILabel *lab in [view2 subviews])
    {
        if (lab.tag==300 || lab.tag==301)
        {
            lab.hidden=YES;
        }
    }

    UILabel *lab=(UILabel *)[view2 viewWithTag:300];
    UILabel *lab1=(UILabel *)[view2 viewWithTag:301];
    lab.hidden=YES;
    lab1.hidden=YES;

}

-(void)earnest_hidden_No
{
    for (UILabel *lab in [view2 subviews])
    {
        if (lab.tag==300 || lab.tag==301)
        {
            lab.hidden=NO;
        }
    }
}

#pragma mark------------以上是游学内容------------
#pragma mark  ------加载旅游视图
- (void)loadTravelView
{
   
   view2 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(view1)+ViewY(view1)+20, windowContentWidth, 161)];
    view2.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:view2];
    
    NSArray *addArray = [NSArray arrayWithObjects:@"成人",@"儿童", nil];
    if ([YXTools stringReturnNull:self.child_price])
    {
        addArray = [NSArray arrayWithObjects:@"成员", nil];
    }
    for (int i=0; i<addArray.count; i++)
    {
        
        UILabel *adultLabel = [YXTools allocLabel:[addArray objectAtIndex:i] font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, 56*i, 60, 30) textAlignment:0];
        [view2 addSubview:adultLabel];
        
        UILabel *unitLabel1 = [YXTools allocLabel:@"单价" font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(adultLabel),ViewY(adultLabel)+ViewHeight(adultLabel), 30, 20) textAlignment:0];
        [view2 addSubview:unitLabel1];
        
        UILabel *adultPrice = [YXTools allocLabel:@"" font:systemFont(13) textColor:[UIColor redColor] frame:CGRectMake(ViewX(unitLabel1)+ViewWidth(unitLabel1),ViewY(adultLabel)+ViewHeight(adultLabel), 100, 20) textAlignment:0];
        [view2 addSubview:adultPrice];
        
        UIButton *cutBtn = [YXTools allocButton:@"" textColor:[UIColor whiteColor] nom_bg:[UIImage imageNamed:@"减少不可用"] hei_bg:nil frame:CGRectMake(windowContentWidth -125, (55-25)/2+ViewY(adultLabel), 25, 25)];
         cutBtn.tag=1+i;
        [cutBtn addTarget:self action:@selector(cutOrAdd1:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:cutBtn];
        
        UIButton *addBtn = [YXTools allocButton:@"" textColor:[UIColor whiteColor] nom_bg:[UIImage imageNamed:@"添加"] hei_bg:nil frame:CGRectMake(windowContentWidth -50, ViewY(cutBtn), 25, 25)];
        addBtn.tag=3+i;
        [addBtn addTarget:self action:@selector(cutOrAdd1:) forControlEvents:UIControlEventTouchUpInside];
        [view2 addSubview:addBtn];

        UIView *lineOrder = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(adultPrice)+ViewY(adultPrice)+5, windowContentWidth, 0.5)];
        lineOrder.backgroundColor = bordColor;
        [view2 addSubview:lineOrder];
        if (i==0)
        {
            adultPrice.text = [NSString stringWithFormat:@"￥%@",self.adult_price];
        }
        else
        {
            adultPrice.text = [NSString stringWithFormat:@"￥%@",self.child_price];
        }
       
    }
    
    adultNumLabel = [YXTools allocLabel:@"0" font:systemFont(15) textColor:[UIColor orangeColor] frame:CGRectMake(windowContentWidth -95, 0, 40, 56) textAlignment:1];
    [view2 addSubview:adultNumLabel];

    childNunLabel = [YXTools allocLabel:@"0" font:systemFont(15) textColor:[UIColor orangeColor] frame:CGRectMake(ViewX(adultNumLabel), 56, 40, 56) textAlignment:1];
    [view2 addSubview:childNunLabel];
    
    YXAutoEditVIew *biaozhunLable = [[YXAutoEditVIew alloc] initWithFrame:CGRectMake(0,ViewY(childNunLabel)+ViewHeight(childNunLabel)+1,windowContentWidth , 40)];
   // LXTimeTableModel *model=[_setoffDateArray objectAtIndex:0];
    biaozhunLable.line.hidden = YES;
    biaozhunLable.titleLable.text = @"儿童标准:";
    DLog(@"%@",self.childStandard);
    NSString *str=[self filterHTML:self.childStandard];
    [biaozhunLable setContentText:str];
    //[biaozhunLable setContentText:@"1.1米到1.4米儿童仅含车位, 保险, 半餐导服费, 产生其的费用需自理"];
    view2.frame= CGRectMake(0, ViewHeight(view1)+ViewY(view1)+20, windowContentWidth,ViewBelow(biaozhunLable));
    [view2 addSubview:biaozhunLable];
    if ([YXTools stringReturnNull:self.child_price])
    {
        childNunLabel.hidden = YES;
        biaozhunLable.frame = CGRectMake(ViewX(biaozhunLable), ViewY(childNunLabel), ViewWidth(childNunLabel), ViewHeight(biaozhunLable));
        view2.frame = CGRectMake(ViewX(view2), ViewY(view2), ViewWidth(view2), 66+ViewHeight(biaozhunLable));
    }

}
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

#pragma mark  ------加载签证视图
- (void)loadVisaView
{
    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(view1)+ViewY(view1)+20, windowContentWidth, 160)];
    view2.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:view2];
    
    
    _visaPerArray = [[NSMutableArray alloc] init];
    [_visaPerArray addObject:@"2"];
    _visaNumberView = [[YXExitArrayItem alloc] initWithFrame:CGRectMake(0, 10, windowContentWidth , 150)];
    _visaNumberView.backgroundColor = [UIColor whiteColor];
    _visaNumberView.delegate = self;
    [_visaNumberView setIsEdit:YES];
    [view2 addSubview:_visaNumberView];
}

#pragma mark  ------加载门票视图

- (void)loadTicketView
{
    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(view1)+ViewY(view1) + 20, windowContentWidth, 160)];
    view2.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:view2];
    
    
    _visaPerArray = [[NSMutableArray alloc] init];
    [_visaPerArray addObject:@"2"];
    _visaNumberView = [[YXExitArrayItem alloc] initWithFrame:CGRectMake(0, 10, windowContentWidth , 150 + 81 + 40) withCellStyle:TicketCellStyle];

    _visaNumberView.backgroundColor = [UIColor whiteColor];
    _visaNumberView.delegate = self;
    [_visaNumberView setIsEdit:YES];
    [view2 addSubview:_visaNumberView];
    
}

#pragma mark  ------加载邮轮视图
- (void)loadShipView
{
    self.shipArr = [[NSMutableArray alloc] init];
    view2 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(view1)+ViewY(view1)+20, windowContentWidth, 160)];
    view2.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:view2];
    
    NSArray *allData = [[NSArray alloc] init];//所有船舱房间
    NSMutableArray *lowestPrice = [[NSMutableArray alloc] init];
    NSInteger buttonIndex = 0;//表示选中那个类型的仓房
    NSArray *cabinArr = [[NSArray alloc] init];//仓位数组
    
    if (self.shipDataDci)
    {
       allData = [NSArray arrayWithArray:[self bianLiJSON:self.shipDataDci]];
        //遍历出每一种房型的最低价格，存放到_lowestPrice中
        for (int i=0; i<keys.count; i++)
        {
            NSString *key = [keys objectAtIndex:i];
            NSArray *dateArr = [[allData objectAtIndex:i] objectForKey:key];
            if (dateArr.count >0)
            {
                NSMutableArray *moneyArray = [NSMutableArray array];
                for (int i = 0; i<dateArr.count; i++)
                {
                    NSDictionary *dicP = [dateArr objectAtIndex:i];
                    
                    NSString *lastPriceStr = nil;
                    
                    if ([[dicP objectForKey:@"first_price"] intValue] > 0 && [[dicP objectForKey:@"second_price"] intValue ]> 0 && [[dicP objectForKey:@"third_price"] intValue] > 0) {
                        lastPriceStr = [dicP objectForKey:@"third_price"];
                    }
                    else if([[dicP objectForKey:@"first_price"] intValue] > 0 && [[dicP objectForKey:@"second_price"] intValue ]> 0 && [[dicP objectForKey:@"third_price"] intValue] <= 0)
                    {
                        lastPriceStr = [dicP objectForKey:@"second_price"];
                        
                    }
                    else
                    {
                        lastPriceStr = [dicP objectForKey:@"first_price"];
                    }
                    
                    [moneyArray addObject:lastPriceStr];
                }
                NSString *minMoneyStr = [self minWith:moneyArray];
                [lowestPrice addObject:minMoneyStr];
            }
        }
    }
    if (self.shipTypeId !=nil)
    {
        
        for (int j = 0; j < keys.count; j++)
        {
            NSString *shipName = [keys objectAtIndex:j];
            if ([shipName isEqualToString:self.shipTypeName])
            {
                cabinArr = [[allData objectAtIndex:j] objectForKey:shipName];
                buttonIndex = j;
            }
        }

    }
    else
    {
        buttonIndex = 0;
        cabinArr = [[allData objectAtIndex:0] objectForKey:[keys objectAtIndex:0]];
    }
    _shipView = [[YXShipOrderView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 160) initWithKeys:keys lowest:lowestPrice all:allData cabin:cabinArr index:buttonIndex shoreTraveLineArr:self.ShoreTraveLineArr];
    
    _shipView.delegate = self;
    [view2 addSubview:_shipView];
    view2.frame = CGRectMake(0, ViewY(view2), windowContentWidth, ViewHeight(_shipView));
}
#pragma mark -计算每种房间类型的最低价
-(NSString *)minWith:(NSArray *)moenyArray
{
    NSArray *minArray = [moenyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if (obj1 > obj2) {
            return NSOrderedDescending;
        }
        else if (obj1 < obj2){
            return NSOrderedAscending;
        }
        else {
            return NSOrderedSame;
        }
    }];
    
    NSString *minMoney = [minArray firstObject];
    return minMoney;
 }
#pragma mark ----遍历字典，相同的船舱类型归为一类
- (NSMutableArray *)bianLiJSON:(NSDictionary *)roomDic
{
    NSMutableArray *result=[NSMutableArray array];
    keys = [roomDic allKeys];
    
    for (NSString *roomNameStr in keys) {
        NSArray *roomArray = [roomDic objectForKey:roomNameStr];
        NSDictionary *roomDic = [NSDictionary dictionaryWithObjectsAndKeys:roomArray,roomNameStr, nil];
        [result addObject:roomDic];
    }
    
    return result;

}
#pragma mark ---- 遍历字典，存放所有的舱位到数组（此处是用于存放记录用户选中的船舱）
- (NSMutableArray *)bianLiRoom:(NSDictionary *)roomDic
{
    NSMutableArray *result=[NSMutableArray array];
    keys = [roomDic allKeys];
    
    for (NSString *roomNameStr in keys)
    {
        NSArray *roomArray = [roomDic objectForKey:roomNameStr];
        for (NSDictionary *roomDic in roomArray)
        {
            [result addObject:roomDic];
            
        }
        
      
    }
    
    return result;
    
}
#pragma mark ----  增加人数/减少人数
/**
 *   增加人数
 *
 *  @param button
 */
- (void)addTicketNumberBut:(UIButton *)button
{
    NSInteger tickrtSum = [self.sumLabel.text integerValue];
    tickrtSum = tickrtSum + 1;
    self.sumLabel.text = [NSString stringWithFormat:@"%ld", tickrtSum];
    [self.minusBut setImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
}
/**
 *  减少人数
 *
 *  @param button
 */
- (void)minusTicketNumberBut:(UIButton *)button
{
    NSInteger tickrtSum = [self.sumLabel.text integerValue];
    if (tickrtSum == 0)
    {
        
        tickrtSum = 0;
        
    }
    else if (tickrtSum > 0)
    {
        
        tickrtSum = tickrtSum - 1;
        
    }
    if (tickrtSum == 0)
    {
        [self.minusBut setImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
    }
    self.sumLabel.text = [NSString stringWithFormat:@"%ld", tickrtSum];
    
}


#pragma mark -- 订单详细
- (void)orderDetail:(UIButton *)sender
{
     if (_isShip)
    {
        [self loadCellArray];
        self.isShowShipPriceDetail = !self.isShowShipPriceDetail;
        DLog(@"%d",self.isShowShipPriceDetail);
        if (self.isShowShipPriceDetail) {
            
            UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - 40)];
            grayView.backgroundColor = [UIColor blackColor];
            grayView.alpha = 0.5;
            grayView.tag = 350;
            UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteSearchView)];
            [grayView addGestureRecognizer:ges];
            [[YXTools getApp].window addSubview:grayView];
            
            UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight - 200, windowContentWidth, 160)];
            whiteView.backgroundColor = [UIColor whiteColor];
            whiteView.tag = 450;
            [[YXTools getApp].window addSubview:whiteView];
            
            if (self.allPriceHigh == 0) {
                self.allPriceHigh = 160;
            }
            
            whiteView.frame = CGRectMake(0, windowContentHeight-self.allPriceHigh - 40, windowContentWidth, self.allPriceHigh);
            whiteView.layer.borderColor = bordColor.CGColor;
            whiteView.layer.borderWidth = 0.5;
            UILabel *detailLabel = [YXTools allocLabel:@"价格详情" font:systemBoldFont(16) textColor:[UIColor blackColor] frame:CGRectMake(15, 0, windowContentWidth-15, 40) textAlignment:0];
            [whiteView addSubview:detailLabel];
            UIView *lineBottm = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(detailLabel)+ViewHeight(detailLabel), windowContentWidth, 0.5)];
            lineBottm.backgroundColor = bordColor;
            [whiteView addSubview:lineBottm];
            
            _bottomView = [[UITableView alloc] initWithFrame:CGRectMake(0, ViewHeight(lineBottm)+ViewY(lineBottm), windowContentWidth, ViewHeight(whiteView) - 41)];
            _bottomView.bounces = NO;
            _bottomView.delegate = self;
            _bottomView.dataSource = self;
            _bottomView.tableFooterView = [[UIView alloc] init];
            [whiteView addSubview:_bottomView];
            
        }
        else
        {
            UIView *v = (UIView *)[[YXTools getApp].window viewWithTag:350];
            [v removeFromSuperview];
            
            UIView *v1 = (UIView *)[[YXTools getApp].window viewWithTag:450];
            [v1 removeFromSuperview];
        
        }
        
    }else
    {
        UIView *grayView = [[UIView alloc]initWithFrame:[YXTools getApp].window.bounds];
        grayView.backgroundColor = [UIColor blackColor];
        grayView.alpha = 0.5;
        grayView.tag = 350;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteSearchView)];
        [grayView addGestureRecognizer:ges];
        [[YXTools getApp].window addSubview:grayView];
        
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth-60, 160)];
        whiteView.backgroundColor = [UIColor whiteColor];
        whiteView.tag = 450;
        [[YXTools getApp].window addSubview:whiteView];
         whiteView.center = [YXTools getApp].window.center;
         whiteView.layer.cornerRadius = 3.0;
        UILabel *areaLabel =  [YXTools allocLabel:@"费用明细" font:systemFont(15) textColor:[UIColor orangeColor] frame:CGRectMake(0, 10, ViewWidth(whiteView), 30) textAlignment:1];
        [whiteView addSubview:areaLabel];
        
        NSArray *MingArray = [NSArray arrayWithObjects:@"成人",@"儿童",@"总额", nil];
        if (_isVisa)
        {
            MingArray = [NSArray arrayWithObjects:@"成员",@"总额", nil];
        }
        if (_isTrave) {
            if ([YXTools stringReturnNull:self.child_price])      //无儿童价的情况
            {
                MingArray = [NSArray arrayWithObjects:@"成员",@"总额", nil];
            }
  
        }
        
        if (_isTicket)
        {
            MingArray = [NSArray arrayWithObjects:@"门票",@"总额", nil];

        }
        if (_isStudyTour)
        {
            
            MingArray = [NSArray arrayWithObjects:@"家长/老师",@"营员",@"总额", nil];
        }
        
        for (int i=0; i<MingArray.count; i++)
        {
            UILabel *chengLabel =  [YXTools allocLabel:[MingArray objectAtIndex:i] font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, ViewHeight(areaLabel)+ ViewY(areaLabel)+10+35*i, 100, 30) textAlignment:0];
            [whiteView addSubview:chengLabel];
            if (i==MingArray.count-2)
            {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(Begin_X, ViewHeight(chengLabel)+ ViewY(chengLabel), ViewWidth(whiteView)-Begin_X*2, 1)];
                line.backgroundColor = [UIColor orangeColor];
                line.alpha = 0.5;
                [whiteView addSubview:line];
            }
            if (i==MingArray.count-1)
            {
                chengLabel.textColor = [UIColor redColor];
            }
        }
        
        UILabel *chengPrice = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@*%@",self.adult_price,adultNumLabel.text] font:systemFont(14) textColor:[UIColor redColor] frame:CGRectMake(ViewWidth(whiteView)-130, ViewHeight(areaLabel)+ ViewY(areaLabel)+10, 120, 30) textAlignment:2];
        [whiteView addSubview:chengPrice];
        
        UILabel *erPrice = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@*%@",self.child_price,childNunLabel.text] font:systemFont(14) textColor:[UIColor redColor] frame:CGRectMake(ViewX(chengPrice), ViewHeight(chengPrice)+ ViewY(chengPrice)+5, ViewWidth(chengPrice), 30) textAlignment:2];
        [whiteView addSubview:erPrice];
        
        UILabel *totalPrice = [YXTools allocLabel:[NSString stringWithFormat:@"￥%@",self.totalPrice] font:systemFont(14) textColor:[UIColor redColor] frame:CGRectMake(ViewX(chengPrice), ViewHeight(erPrice)+ ViewY(erPrice)+5, ViewWidth(chengPrice), 30) textAlignment:2];
        [whiteView addSubview:totalPrice];
        
        if (_isStudyTour)
        {
            
            chengPrice.text=[NSString stringWithFormat:@"￥%.2f*%@",_adultPrice,adultNumLabel.text];
            erPrice.text=[NSString stringWithFormat:@"￥%.2f*%@",_childPrice,childNunLabel.text];
        }
        else
        {
            if (_isVisa)
            {
                chengPrice.text = [NSString stringWithFormat:@"￥%@*%ld",_visaModel.sell_price,_visaPerArray.count];
                erPrice.hidden = YES;
                totalPrice.frame = erPrice.frame;
            }
            if (_isTicket)
            {
                
                chengPrice.text = [NSString stringWithFormat:@"￥%@*%ld",[self judgeReturnString:_ticketGoodsModel.sell_price withReplaceString:@"0.00"],_visaPerArray.count
                                   ];
                erPrice.hidden = YES;
                totalPrice.frame = erPrice.frame;
                
            }
            if (_isTrave) {
                if ([YXTools stringReturnNull:self.child_price])      //无儿童价的情况
                {
                    erPrice.hidden = YES;
                    totalPrice.frame = erPrice.frame;
                }else{
                   
                }
 
            }
        }
        
    }
}

#pragma mark -加载cell的数组
-(void)loadCellArray
{
    [self.selectRoomCellSelect removeAllObjects];
    for (int i = 0; i < self.shipArr.count; i++) {
        NSString *keyStr = [NSString stringWithFormat:@"%d",i];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"NO",keyStr, nil];
        [self.selectRoomCellSelect addObject:dic];
    }
}
- (void)deleteSearchView
{
    if (_isShip) {
        self.isShowShipPriceDetail = NO;
    }

    UIView *v = (UIView *)[[YXTools getApp].window viewWithTag:350];
    [v removeFromSuperview];
    
    UIView *v1 = (UIView *)[[YXTools getApp].window viewWithTag:450];
    [v1 removeFromSuperview];
}


#pragma mark -- 按钮点击方法都在这
-(void)cutOrAdd1:(UIButton *)btn
{
    UIButton *btnView = (UIButton *)[self.view viewWithTag:btn.tag];
    switch (btn.tag)
    {
        case 1:
        {
            //减少成人数
            if ([adultNumLabel.text intValue]>0)
            {
                adultNumLabel.text=[NSString stringWithFormat:@"%d",[adultNumLabel.text intValue]-1];
                [btnView setBackgroundImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
                if ([adultNumLabel.text intValue]==0)
                {
                     [btnView setBackgroundImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
                }
            }
            
            
        }
            break;
        case 2:
        {
            //减少儿童数
            if ([childNunLabel.text intValue]>0)
            {
                childNunLabel.text=[NSString stringWithFormat:@"%d",[childNunLabel.text intValue]-1];
                [btnView setBackgroundImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
                if ([childNunLabel.text intValue]==0)
                {
                    [btnView setBackgroundImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
                }
            }
            
        }
            break;
        case 3:
        {
            //增加成人数
            btnView = (UIButton *)[self.view viewWithTag:btn.tag-2];
            NSInteger totalPeople1=[adultNumLabel.text integerValue]+[childNunLabel.text integerValue];
            //DLog(@"总人数-----%ld",(long)totalPeople);
            if (self.isRealTrave==YES && totalPeople1>=[self.remanentPeople integerValue])
            {
                [[LXAlterView sharedMyTools] createTishi:@"超过可预订总人数！"];
            }
            else if (_isStudyTour && totalPeople1>=[self.remanentPeople integerValue])
            {
                [[LXAlterView sharedMyTools] createTishi:@"超过可预订总人数！"];
            }
            else
            {
                adultNumLabel.text=[NSString stringWithFormat:@"%d",[adultNumLabel.text intValue]+1];
                [btnView setBackgroundImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
            }
            
            
        }
            break;
        case 4:
        {
            //增加儿童数
            btnView = (UIButton *)[self.view viewWithTag:btn.tag-2];
            NSInteger totalPeople1=[adultNumLabel.text integerValue]+[childNunLabel.text integerValue];
            //DLog(@"总人数-----%ld",(long)totalPeople);
            if (self.isRealTrave==YES && totalPeople1>=[self.remanentPeople integerValue])
            {
                [[LXAlterView sharedMyTools] createTishi:@"超过可预订总人数！"];
            }
            else if (_isStudyTour && totalPeople1>=[self.remanentPeople integerValue])
            {
                [[LXAlterView sharedMyTools] createTishi:@"超过可预订总人数！"];
            }
            else
            {
                childNunLabel.text=[NSString stringWithFormat:@"%d",[childNunLabel.text intValue]+1];
                [btnView setBackgroundImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
            }
        }
        break;
    }
    
    float total;
    if (_isTrave)
    {
        total= [adultNumLabel.text intValue]*[self.adult_price floatValue]+[childNunLabel.text intValue]*[self.child_price floatValue];
    }
    else if (_isStudyTour)
    {
        total= [adultNumLabel.text intValue]*_adultPrice+[childNunLabel.text intValue]*_childPrice;
    }
    
    self.totalPrice = [NSString stringWithFormat:@"%.2f",total];
    _priceLabel.text = [NSString stringWithFormat:@"订单总额￥%.2f",total];
}
- (void)clickAgree:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        UIImageView *leftView = [sender.subviews objectAtIndex:0];
        if (_isAgree)
        {
            leftView.image = [UIImage imageNamed:@"不同意"];
        }else
        {
            leftView.image = [UIImage imageNamed:@"已同意"];
        }
        _isAgree = !_isAgree;

    }else
    {
         YXWebDetailViewController *webVC = [[YXWebDetailViewController alloc] init];
       
        
        
        
        if (_isTicket)
        {
         
            webVC.WebTitle = @"预订条款";
            webVC.webContent=@"<p>1. 中国微旅平台门票产品（以下简称\"微旅\"）各项服务的所有权与运作权归微旅科技有限公司所有。本服务条款具有法律约束力。一旦您点选\"确认下单\"成功提交订单后，即表示您自愿接受本协议之所有条款，并同意通过微旅订购旅游产品。</p><p>2. 服务内容</p><p>2.1微旅服务的具体内容由微旅有限公司根据实际情况提供，微旅对其所提供之服务拥有最终解释权。</p><p>2.2微旅有限公司在平台上向其会员提供相关网络服务。其它与相关网络服务有关的设备（如个人电脑、手机、及其他与接入互联网或移动网有关的装置）及所需的费用（如为接入互联网而支付的电话费及上网费、为使用移动网而支付的手机费等）均由会员自行负担。</p><p>3. 特别提示</p><p>3.1预订提前期与付款期：</p><p>预订提前期与付款期。</p><p>景点门票预订：所有订单请提前2天预订，部分支持手机电子票（二维码）的景点，支持当天预订当天游玩。如需在线支付请在订单生成后1个小时内付清已订产品所有款项。</p><p>4. 订单生效</p><p>订单生效后，您应按订单中约定的时间按时入园。如您未准时出发或未按时入园，视为您主动解约。</p><p>5. 解除已生效订单</p><p>5.1景点订单</p><p>5.1.1如您通过取票时付款的方式预订，解除预订无须支付任何费用。</p><p>5.1.2如您通过预付费的方式预订，订单生效后，若要主动解除已生效订单，您须在行程前一天中午12点前通知微旅解除所做预订，包括放弃整张订单的全部内容和减少出行人数，如未按规定时间内通知解除的情况，视违约处理，您需要按照如下标准支付违约金。</p><p>5.1.3在至景点游玩前一天中午12点以前通知取消的，支付全部费用总额的5%的违约金，逾期则不予退费。</p><p>6. 更改已生效订单</p><p>订单生效后，您主动要求更改该订单内的任何项目，请务必在行程前一天中午12点前通知微旅您的更改需求。微旅会尽量满足您的需求，但您必须全额承担因变更带来的损失及可能增加的费用。</p><p>7. 因微旅原因取消您的已生效订单</p><p>在您按要求付清所有产品费用后，如因微旅原因，致使您的产品取消，微旅应当立即通知您。</p><p>8. 不可抗力</p><p>您和微旅双方因不可抗力(包括但不限于地震、台风、雷击、水灾、火灾等自然原因,以及战争、政府行为、黑客攻击、电信部门技术管制等原因)不能履行或不能继续履行已生效订单约定内容的，双方均不承担违约责任，但法律另有规定的除外。因微旅延迟履行已生效订单约定内容，且在后期提供服务过程中发生不可抗力的，不能免除责任。</p><p>9. 解决争议适用法律法规约定</p><p>在您的预订生效后，如果在本须知或订单约定内容履行过程中，您对相关事宜的履行发生争议，您只同意按照中华人民共和国国家旅游局颁布的相关法律法规来解决争议。</p><p>其它</p><p>本须知未尽的其他事项，在微旅为您确认的订单中另行约定。</p><p>10. 同时合同双方需承担对等的义务。</p><p>祝您旅途愉快! </p><p>如有疑问，请拨打微旅客服电话: 400-619-9619</p>";
            
        }
        else if (_isStudyTour)
        {
            webVC.WebTitle = @"预订条款";
            webVC.webContent=@"<p><strong>1.微旅预订条款的确认</strong></p><p>中国微旅平台产品（以下简称\"微旅\"）各项服务的所有权与运作权归微旅科技有限公司所有。本服务条款具有法律约束力。一旦您点选\"确认下单\"成功提交订单后，即表示您自愿接受本协议之所有条款，并同意通过微旅订购旅游产品。</p> <p><strong>2．服务内容</strong></p><p>2.1 微旅服务的具体内容由微旅有限公司根据实际情况提供，在不违反国家相关法律规定的前提下微旅对其所提供之服务拥有最终解释权。<br>2.2 微旅有限公司在平台上向其会员提供相关网络服务。其它与相关网络服务有关的设备（如个人电脑、手机、及其他与接入互联网或移动网有关的装置）及所需的费用（如为接入互联网而支付的电话费及上网费、为使用移动网而支付的手机费等）均由会员自行负担。</p><p><strong>3. 特别提示</strong></p><p>3.1 预订：所有订单请根据产品介绍的说明，在有效期内预订。<br>3.2 支付：如需在线支付，请在订单生成后1个小时内付清已订产品约定需支付的款项；非在线支付，请根据订单的要求按时缴付。</p><p><strong>4.订单生效</strong></p><p>订单生效后，您应按订单中约定的条款及时履行签约、缴付定金等手续，如您未准时办理相关手续，视为您主动解约。</p><p><strong>5. 解除已生效订单</strong></p><p>5.1 未按规定办理签约、支付定金等手续，视为自动解除订单并无须支付任何费用。<br>5.2 已按规定办理签约或支付定金手续的，请根据与产品供应商签订的相关协议办理退出手续，您的解除订单请求受您与产品供应商签订的相关协议约束并以协议的规定为准。</p><p><strong>6. 更改已生效订单</strong></p><p>订单生效后，您主动要求更改该订单内的任何项目，应该在您与产品供应商签订的相关协议许可之内。微旅会尽量满足 您的需求，但您必须全额承担因变更带来的损失及可能增加的费用。</p><p><strong>7. 因微旅原因取消您的已生效订单</strong></p><p>在您按要求付清所有产品费用后，如因微旅原因，致使您的产品取消，微旅应当立即通知您。</p><p><strong>8. 不可抗力</strong></p><p>您和微旅双方因不可抗力(包括但不限于地震、台风、雷击、水灾、火灾等自然原因,以及战争、政府行为、黑客攻击、电信部门技术管制等原因)不能履行或不能继续履行已生效订单约定内容的，双方均不承担违约责任，但法律另有规定的除外。</p><p>因微旅延迟履行已生效订单约定内容，且在后期提供服务过程中发生不可抗力的，不能免除责任。</p><p><strong>9. 解决争议适用法律法规约定</strong></p><p>在您的预订生效后，如果在本须知或订单约定内容履行过程中，您对相关事宜的履行发生争议，您只同意按照中华人民共和国国家旅游局颁布的相关法律法规来解决争议。</p><p>其它<br>本须知未尽的其他事项，在微旅为您确认的订单中另行约定。</p><p><strong>10.同时合同双方需承担对等的义务。</strong></p><p>祝您旅途愉快!&nbsp;</p><p>如有疑问，请拨打微旅客服电话: 400-619-9619</p> ";
        }
        else
        {
            webVC.WebTitle = @"重要条款";
            webVC.webContent = @"<p> <strong><span style=‘font-size:16px;’>特别提示：</span></strong>微旅平台的产品均由具备资质的产品供应商提供。产品供应商充分借用微旅平台，推出全方位的产品，产品的行程安排以及合同签订都是由合作产品供应商为您提供。 微旅平台作为您获取产品的地点，本协议的签署并不意味着微旅平台成为产品交易的参与者，对前述交易微旅平台仅提供技术支持，不对供应商行为的合法性、有效性及产品的真实性、合法性及有效性作任何明示或暗示的担保。在预订微旅平台的产品前，请您仔细阅读本须知，并注意本须知及产品页面中的其它重要条款也作为双方协议的补充内容。当您开始预订微旅平台产品时，即表明您已经仔细阅读并接受本协议的所有条款。</p><p><strong>第一条 相关概念及注解</strong></p><p> 1、旅游产品：以旅游酒店+交通+景点+餐饮+旅游用车+导游服务+签证（出境游）为核心，行程、交通方式、食宿标准、游览项目均有固定安排，既有专业导游带您游览经典景区，又不含任何强制购物和自费的项目。<br/>2、签证产品：目前只针对持有中国大陆地区因私护照的客人提供服务，主要包含代为预约、签证材料制作整理、翻译或使领馆允许的代送服务。<br/>3、邮轮产品：指海洋上的定线、定期航行的大型客运轮船，它是由包括有形的（如邮轮、邮轮服务设施、游乐项目等）和无形的（邮轮服务、游客感受等）两部分组成。<br/>4、旅游消费者：指通过微旅平台预订由旅游供应商提供的旅游产品的用户，用户在微旅平台上预订旅游产品成功后，用户和旅游供应商之间建立合同关系。</p><p><strong>第二条 旅游产品内容及其标准</strong></p><p>1、旅游产品内容主要包含：目的地接待服务及其他服务。具体产品的最终包含内容以确认的订单约定内容为准。<br />2、微旅平台关于旅游产品的行程推荐仅为友情提示，不能作为约定条款。<br/>3、旅游产品中约定的产品和服务内容，均为经过微旅平台严格考评筛选出的具备相关资质的旅游供应商提供，微旅平台只对其经营资质的合法性承担责任，不对其在您消费过程中可能涉及的具体产品和服务内容承担责任。</p><p><strong>第三条 签证产品内容及其标准</strong></p><p>1、签证产品是以客人提供所需的材料为前提。网上公布的所需材料为使领馆要求每位申请人提供的必备材料。使领馆根据个人的不同情况可能会要求增补其它材料时，申请人应及时提供效真实的材料。一旦增补材料，不能在原受理时间内出签，客人的行程可能会受影响。鉴于，上述情形并非供应商所能控制，客人因此产生的损失，供应商不承担任何赔偿责任。<br/>2、如申请人办签过程中，领馆对申请人进行行政审核导致未能及时出签或拒绝出签的，申请人应及时告知供应商，客人应承担因此产生的全部损失，但供应商将协助申请人减少损失。<br />3、提供所有材料并不意味着使领馆一定颁发签证。如遇使领馆拒签，供应商所收的全部费用不予以退还。</p><p><strong>第四条 产品价格</strong></p><p>微旅平台展示的产品价格均为实际价格，您预订的所有产品价格，均以微旅平台上显示的金额为准。</p><p><strong>第五条 订单生效</strong></p><p>1、您在微旅平台上预订产品，并通过第三方支付完成付款后，您的订单立即生效。但如您未按要求完成支付，而此时微旅平台为您预留的产品价格、内容或标准等有发生变化，微旅平台对此不承担任何责任。 订单生效，即代表您与产品供应商的合作意向已经达成，你的变更、解除产品等的需求，将受到本协议第五条、第六条等相关条款的约束。订购合同成立后，您应按订单中约定的时间和上车地点出发。如您未按约定出发，则视您的这种行为构成违约，您应承担由此导致的损失并按照约定支付违约金。</p><p><strong>第六条 您主动更改已生效订单</strong></p><p> 订单生效后，您若需要更改该订单内的任何项目，请务必在旅游行程开始前通知您的更改需求。我们会尽量满足您的需求，但您必须全额承担因变更带来的损失及可能增加的费用。若您所预订的产品在目的地停留的日期部分或全部处在国家法定节假日或其它部分国际性、国家性、地方性重大节日期间，鉴于资源的特殊状况，已生效订单不可进行任何更改。</p><p><strong>第七条 您主动解除已生效订单</strong></p><p>1、旅游产品订单生效后，您因个人原因不能出行造成违约，须按照下列标准承担违约责任：<br />在行程开始前7日以内提出取消订单的按下列标准扣除必要的费用：<br />国内游订单：<br />1）行程开始前6日至4日，按旅游费用总额的20%；<br />2）行程开始前3日至1日，按旅游费用总额的40%；<br />3）行程开始当日，按旅游费用总额的60%。<br />出境游（含港澳台）订单：<br />在行程开始前30日以内提出解除合同的，按下列标准扣除必要的费用：<br />1）行程开始前29日至15日，按旅游费用总额的5%；<br />2）行程开始前14日至7日，按旅游费用总额的20%；<br />3）行程开始前6日至4日，按旅游费用总额的50%；<br />4）行程开始前3日至1日，按旅游费用总额的60%；<br />5）行程开始当日，按旅游费用总额的70%。</p><p>2、邮轮产品订单生效后，您因个人原因不能出行造成违约，须按照下列标准承担违约责任：<br />1）开航前90天前（含第90天）内通知取消,收2000元/人损失;<br />2）开航前89天至45天前（含第45天）内通知取消,收取团款的50%;<br />3）开航前44天至15天前（含第15天）内通知取消，收取团款的80%;<br />4）开航前14天（含第14天）内通知取消,或没有在开航时准时出现,或在开航后无论以任何理由放弃旅行,其必须支付100%团费。</p><p>3、签证产品订单生效后，您因个人原因不能出行造成违约，须按照下列标准承担违约责任：<br />订单生效后，若要主动解除已生效订单，您必须及时通知供应商解除所做预订，包括放弃整张订单、减少办理人数，同时您还须承担供应商处理该订单已经支出的其它必要费用：<br />已付款的订单，如未产生签证费用的，将全额退款。如已产生签证费用，所有费用将不予退还。</p><p><strong>第八条 因供应商原因取消您的已生效订单</strong></p><p>1、在您按要求付清旅游产品费用后，如因供应商原因，致使您旅游产品不能成行而取消的，供应商应须按照下列标准承担违约责任：<br />国内游订单：<br />在行程开始前7日以内提出解除合同的，或者旅游消费者在行程开始前7日以内收到旅游供应商不能成团通知，不同意转团、延期出行和改签线路的，旅游供应商应向旅游消费者退还已收取的全部旅游费用，并按下列标准向旅游消费者支付违约金： <br />1）行程开始前6日至4日，支付旅游费用总额10%的违约金；<br />2）行程开始前3日至1日，支付旅游费用总额15%的违约金；<br />3）行程开始当日，支付旅游费用总额20%的违约金。<br />出境游（含港澳台）订单：<br />在行程开始前30日以内提出解除合同的，或者旅游消费者在行程开始前30日以内收到旅游供应商不能成团通知，不同意转团、延期出行和改签线路的，旅游供应商应向旅游消费者退还已收取的全部旅游费用（不得扣除签证／签注等费用），并按下列标准向旅游者支付违约金：<br />1）行程开始前29日至15日，支付旅游费用总额2%的违约金；<br />2）行程开始前14日至7日，支付旅游费用总额5%的违约金；<Br />3）行程开始前6日至4日，支付旅游费用总额10%的违约金；<br />4）行程开始前3日至1日，支付旅游费用总额15%的违约金；<br />5）行程开始当日，支付旅游费用总额20%的违约金。<br />如按上述比例支付的违约金不足以赔偿旅游者的实际损失，旅行社应当按实际损失对旅游者予以赔偿；具体参见各省旅游局格式合同条款。</p><p>2、在您按要求付清所有签证费用后，如因供应商原因，致使您的签证无法办理而取消或不能按时出签的，供应商应当立即通知您，无条件退返您已支付的所有费用。  </p><p><strong>第九条 旅游产品使用权的变更</strong></p><p> 在您按要求付清旅游产品费用后，在行程开始前，须经旅游供应商同意，您可以将您预订的当地游产品使用权转让或赠送给具有参加本次旅游产品活动条件的第三人。变更后如有费用增加，须由您全额承担，否则旅游供应商有权拒绝您的变更要求。</p><p><strong>第十条 您的权利和义务</strong></p><p> 1、您应确保出行人身体条件适合本次外出旅游度假，如出行人为孕妇或有心脏病、高血压、呼吸系统疾病等病史，请在征得医院专业医生同意后出行。<br />2、您保证提供给微旅平台的证件、通讯联络方式等相关资料均真实有效。<br />3、度假期间，您应尊重当地的宗教信仰、民族习惯和风土人情，自觉保护当地自然环境。<br />4、您须通过微旅平台预订并通过微旅平台页面支付全部旅游款。但相关款项将直接汇入微旅平台帐户。如您需要退款请直接联系微旅平台为您配置的旅行管家，旅行管家将协助您完成退款事宜。<br />5、您在旅游过程中如对旅游供应商的服务质量有异议，应积极与旅游供应商沟通，争取在旅游过程中解决。<br />6、您可以选择通过微旅平台或旅游供应商电话进行投诉。<br />7、如您不遵守本须知的规定，恶意干扰微旅平台的正常运营，恶意预订、更改或退订旅游产品，微旅平台保留追究您个人责任的权利。</p><p><strong>第十一条 相关责任</strong></p><p> 您在旅游中出现下列情况，微旅平台应协助办理，结果由您承担。<br />1、您在旅游中应注意人身财产安全，妥善保管自己的证件及行李物品， 如果发生人身意外、伤害或随身携带行李物品遗失、被盗、被抢等情况，微旅平台会积极协助办理，但无赔偿之责任；补办证件所产生的费用，由您自行承担。解决的依据应以相关机构的规定为准。您必须保留有关单据和证明文件。<br />2、您违反相关国家或地区的法律、法规而被罚、被拘留及被追究其他刑事、民事责任的，您应依法承担相关责任和费用。</p><p><strong>第十二条 不可抗力</strong></p><p> 1、旅游产品：以旅游酒店+交通+景点+餐饮+旅游用车+导游服务+签证（出境游）为核<br />心，行程、交通方式、食宿标准、游览项目均有固定安排，既有专业导游带您游览经典景区，又不含任何强制购物和自费的项目。<br />2、旅游消费者：指通过微旅平台预订由旅游供应商提供的旅游产品的微信用户，微信用户在微旅平台上预订旅游产品成功后，用户和旅游供应商之间建立合同关系。</p><p><strong>第十一条 不可抗力</strong></p><p> 1、因不可抗力(包括地震、台风、雷击、雪灾、水灾、火灾等自然原因,以及战争、政府行为、黑客攻击、电信部门技术管制等原因)和意外事件等原因不能履行或不能继续履行已生效订单约定内容的，双方均不承担违约责任，但法律另有规定的除外。<br />2、如果由于临时调价而导致的产品价格上涨，对于已成交的订单，不再向您收取涨价费用；对于已确认但未付款和未确认的订单，则以最新发布的价格为准。</p><p><strong>第十三条 关于旅行责任保险</strong></p><p>1、 责任险是对因旅行社责任引起的游客人身伤亡、财产遭受的损失及由此发生的相关费用的赔偿，对于游客，在实际发生意外时，“责任险”保障的主要是旅行社对游客出游期间依法应承担的各种民事赔偿责任，而这种责任由法院或相关仲裁机构裁决。这意味着意外发生后，旅行社是不包揽一切的，它只承担自己的责任。由于游客自身原因或其他方原因出险由游客自行负责，旅行社只提供道义上的协助。为了使游客获得更为全面的保障，我们强烈建议游客出游时根据个人意愿和需要自行投保个人险种。<br />2、 游客参加旅行社组织的旅游活动过程中，因旅行社原因引起的游客人身伤亡和财产损失，旅行社依据《旅行社投保旅行社责任保险的规定》承担责任。 <br />3、 游客参加旅行社组织的旅游活动过程中，由于游客个人过错导致的人身伤亡和财产损失，以及由此导致需支出的各种费用，旅行社不承担赔偿责任。<br />4、 游客在自行终止旅行社安排的旅游行程后，或在不参加双方约定的活动而自行活动的时间内，发生的人身、财产损害，旅行社不承担赔偿责任。</p>";
            
        }
        
        
        
        
        
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
- (void)selectedContact
{
    if ([[LXUserTool alloc] getUid] == nil)
    {
        
        LoginAndRegisterViewController * fastLoginVC = [[LoginAndRegisterViewController alloc] init];
        [self.navigationController pushViewController:fastLoginVC animated:YES];
        return;
        
    }
    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"member"])
    {
        CusInfoViewController *infoVC = [[CusInfoViewController alloc] init];
        infoVC.delegate = self;
        infoVC.isFromeOrder = YES;
        [self.navigationController pushViewController:infoVC animated:YES];
    }
    else
    {
        ZFJMyMemberListVC *myMemberVc=[[ZFJMyMemberListVC alloc] init];
        myMemberVc.backTitle = @"会员";
        myMemberVc.delegate = self;
        [self.navigationController pushViewController:myMemberVc animated:YES];
        
    }
    
}

#pragma mark YXSelectedCusInfoDelegate
- (void)getContact:(NSDictionary *)dic
{
    OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
    v.nameTextField.text = [dic objectForKey:@"to_username"];
    v.phoneTextField.text = [dic objectForKey:@"phone"];
}

#pragma mark ZFJMyMemberListVCDelegate
- (void)getMember:(MyMembersModel *)dic
{
    OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
    if (dic.realname == nil)
    {
       v.nameTextField.text = dic.username;
        
    }
    else
    {
        v.nameTextField.text = dic.realname;
        
    }
    if (dic.email==nil)
    {
        [v.emailTF setPlaceholder:@"邮箱"];
    }
    else
    {
        v.emailTF.text=dic.email;
    }
    v.phoneTextField.text = dic.phone;
}


#pragma mark YXExitArrayItemDelegate
- (void)editArrayChangeFrame:(YXExitArrayItem *)item
{
    view2.frame = CGRectMake(0, ViewY(view2), ViewWidth(view2), item.frame.size.height+10);
    if (_isTicket) {
        bookView.frame = CGRectMake(0, ViewHeight(view2)+ViewY(view2)+20, windowContentWidth, 200);
    } else {
        bookView.frame = CGRectMake(0, ViewHeight(view2)+ViewY(view2)+20, windowContentWidth, 160);
    }
    agreeBtn.frame = CGRectMake(Begin_X,ViewHeight(bookView)+ViewY(bookView)+20,125,30);
    tiaokuangBtn.frame = CGRectMake(ViewWidth(agreeBtn)+ViewX(agreeBtn),ViewY(agreeBtn),175,30);
    _scrollView.contentSize = CGSizeMake(0, ViewHeight(agreeBtn)+ViewY(agreeBtn)+150);
}

- (void)AddArrayForItem:(NSInteger)index
{
    if (_isVisa)
    {
        NSString *objc = @"1";
        [_visaPerArray addObject:objc];
       // _visaNumberView.dataArray = _visaPerArray;
        
        float total = [_visaModel.sell_price floatValue]*(int)(_visaPerArray.count);
        self.totalPrice = [NSString stringWithFormat:@"%.2f",total];
        _priceLabel.text = [NSString stringWithFormat:@"订单总额￥%.2f",total];

    }
    else if (_isTicket)
    {
        NSString *objc = @"1";
        //count;
        [_visaPerArray addObject:objc];
       // _visaNumberView.dataArray = _visaPerArray;
        
        float total = [_ticketGoodsModel.sell_price floatValue]*(int)(_visaPerArray.count);
        self.totalPrice = [NSString stringWithFormat:@"%.2f",total];
        _priceLabel.text = [NSString stringWithFormat:@"订单总额￥%.2f",total];

    }
}
#pragma 删除
- (void)delArrayForItem:(NSInteger)index
{
    if (_visaPerArray.count>0) {
      [_visaPerArray removeObjectAtIndex:0];
    }
//
    //_visaNumberView.dataArray = _visaPerArray;
    
    if (_isVisa)
    {
        float total = [_visaModel.sell_price floatValue]*(int)(_visaPerArray.count);
        self.totalPrice = [NSString stringWithFormat:@"%.2f",total];
        _priceLabel.text = [NSString stringWithFormat:@"订单总额￥%.2f",total];

    }
    else if (_isTicket)
    {
        float total = [_ticketGoodsModel.sell_price floatValue]*(int)(_visaPerArray.count);
        self.totalPrice = [NSString stringWithFormat:@"%.2f",total];
        _priceLabel.text = [NSString stringWithFormat:@"订单总额￥%.2f",total];

    }
}
-(void)chooseTypeView:(UIButton *)button
{
    [self resignFirstResponder];
    if (_isVisa)
    {
        if (self.chooseTypeView == nil)
        {
            self.chooseTypeView = [[UIView alloc] initWithFrame:CGRectMake([[button superview] superview].frame.origin.x + 60, [[button superview] superview].frame.origin.y + [[button superview] superview].frame.size.height+ViewHeight(view1)+ViewY(view1)+30, windowContentWidth - 60- 2 * [[button superview] superview].frame.origin.x, 155)];
            _chooseTypeView.layer.cornerRadius=4.0;
            _chooseTypeView.layer.borderWidth = 1.0;
            _chooseTypeView.layer.borderColor = bordColor.CGColor;
            NSArray * typeTitle = @[@"在职人员", @"自由职业者", @"退休人员", @"在校学生", @"学龄前儿童"];
            
            for (int i = 0; i < typeTitle.count; i++)
            {
                UIButton * typeBut = [UIButton buttonWithType:UIButtonTypeCustom];
                typeBut.frame = CGRectMake(10, 30 * i + 5, windowContentWidth - 60- 2 * [[button superview] superview].frame.origin.x - 20, 25);
//                typeBut.layer.borderWidth = 1.0;
//                typeBut.layer.borderColor = bordColor.CGColor;
                [typeBut setTitle:[typeTitle objectAtIndex:i] forState:UIControlStateNormal];
                [typeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                typeBut.titleLabel.font = [UIFont systemFontOfSize:15];
                [typeBut addTarget:self action:@selector(chooseTypeBut:) forControlEvents:UIControlEventTouchUpInside];
                [_chooseTypeView addSubview:typeBut];
            }
            _chooseTypeView.backgroundColor = [UIColor whiteColor];
            [_scrollView addSubview:_chooseTypeView];
            
        }
        else
        {
            self.chooseTypeView.frame = CGRectMake([[button superview] superview].frame.origin.x + 60, [[button superview] superview].frame.origin.y + [[button superview] superview].frame.size.height+ViewHeight(view1)+ViewY(view1)+30, windowContentWidth - 60- 2 * [[button superview] superview].frame.origin.x, 155);
            if (self.chooseTypeView.hidden == NO)
            {
                self.chooseTypeView.hidden = YES;
            }
            else
            {
                self.chooseTypeView.hidden = NO;
            }
        }
       
        self.tempBut = button;
        
    }
    else if (_isTicket)
    {
        if (self.chooseTypeView == nil)
        {
            self.chooseTypeView = [[UIView alloc] initWithFrame:CGRectMake([[button superview] superview].frame.origin.x + 60, [[button superview] superview].frame.origin.y + [[button superview] superview].frame.size.height+ViewHeight(view1)+ViewY(view1) - 10, ViewWidth([[button superview] superview]) - 80, 125)];
            _chooseTypeView.layer.cornerRadius=4.0;
            _chooseTypeView.layer.borderWidth = 1.0;
            _chooseTypeView.layer.borderColor = bordColor.CGColor;
            NSArray * typeTitle = @[@"身份证", @"护照", @"港澳通行证", @"台胞证"];
            for (int i = 0; i < typeTitle.count; i++)
            {
                UIButton * typeBut = [UIButton buttonWithType:UIButtonTypeCustom];
                typeBut.frame = CGRectMake(10, 30 * i + 5, ViewWidth(self.chooseTypeView) - 20, 25);
//                typeBut.layer.borderWidth = 1.0;
//                typeBut.layer.borderColor = bordColor.CGColor;
                [typeBut setTitle:[typeTitle objectAtIndex:i] forState:UIControlStateNormal];
                [typeBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                typeBut.titleLabel.font = [UIFont systemFontOfSize:15];
                [typeBut addTarget:self action:@selector(chooseTypeBut:) forControlEvents:UIControlEventTouchUpInside];
                [_chooseTypeView addSubview:typeBut];
            }
            _chooseTypeView.backgroundColor = [UIColor whiteColor];
            [_scrollView addSubview:_chooseTypeView];
            
        }
        else
        {
            
            self.chooseTypeView.frame = CGRectMake([[button superview] superview].frame.origin.x + 60, [[button superview] superview].frame.origin.y + [[button superview] superview].frame.size.height+ViewHeight(view1)+ViewY(view1) - 10, windowContentWidth - 60- 2 * [[button superview] superview].frame.origin.x, 125);
            if (self.chooseTypeView.hidden == NO)
            {
                self.chooseTypeView.hidden = YES;
            }
            else
            {
                self.chooseTypeView.hidden = NO;
            }
        }
        self.tempBut = button;
    }
    
}

- (void)chooseTypeBut:(UIButton *)button
{
    self.chooseTypeView.hidden = YES;
    UILabel * label = (UILabel *)[self.tempBut superview];
    [self.tempBut setTitle:@"" forState:UIControlStateNormal];
    label.text = [NSString stringWithFormat:@"  %@", button.titleLabel.text];
}

#pragma mark YXShipOrderViewDelegate
- (void)changeShipViewFrame:(YXShipOrderView *)orderView
{
    view2.frame = CGRectMake(0, ViewY(view2), ViewWidth(view2), orderView.frame.size.height);
    if (_isTicket)
    {
        bookView.frame = CGRectMake(0, ViewHeight(view2)+ViewY(view2)+20, windowContentWidth, 200);
    }
    else
    {
        bookView.frame = CGRectMake(0, ViewHeight(view2)+ViewY(view2)+20, windowContentWidth, 160);
    }
    agreeBtn.frame = CGRectMake(Begin_X,ViewHeight(bookView)+ViewY(bookView)+20,125,30);
    tiaokuangBtn.frame = CGRectMake(ViewWidth(agreeBtn)+ViewX(agreeBtn),ViewY(agreeBtn),175,30);
    _scrollView.contentSize = CGSizeMake(0, ViewHeight(agreeBtn)+ViewY(agreeBtn)+150);

}

////计算总价格
- (void)totalPriceData:(NSMutableArray *)allData price:(float)total num:(int)number
{
    self.totalPrice = [NSString stringWithFormat:@"%.2f",total];
    _priceLabel.text = [NSString stringWithFormat:@"订单总额￥%.2f",total];
    self.adultNumber = [NSString stringWithFormat:@"%d",number];         //总人数
    //self.shipArr = [NSArray arrayWithArray:allData];          //选择后的船舱集合
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//数据加载完成之前显示转动的菊花圈
- (void)setProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"正在提交";
    [self.view addSubview:_hud];
    [_hud show:YES];
}
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(windowContentWidth -20, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

#pragma mark --- 提交订单
//提交订单
- (void)submitOrder
{
    if(_isAgree == NO)
    {
        [[LXAlterView alloc] createTishi:@"是否接受重要条款？"];
        return;
    }
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeNone)
    {
         LoginAndRegisterViewController * loginVC = [[LoginAndRegisterViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    NSMutableArray * orderArr = [NSMutableArray array];
    if (_isStudyTour)
    {
        if ([childNunLabel.text intValue]==0 &&[adultNumLabel.text intValue]==0)
        {
            [[LXAlterView sharedMyTools] createTishi:@"请先选择申请人数"];
            return;
        }
        OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
        if ([YXTools stringIsNotNullTrim:v.nameTextField.text] || [YXTools stringIsNotNullTrim:v.phoneTextField.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请完善联系人信息"];
            return;
        }
        if (![YXTools isValidateMobile:v.phoneTextField.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
            return;
        }
        self.reservePeople = [[ZFJOrderPeopleModel alloc] init];
        self.reservePeople.nameText = v.nameTextField.text;
        self.reservePeople.infoText = v.phoneTextField.text;
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        // manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        // manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //传入的参数
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        LXUserTool * userTool = [[LXUserTool alloc] init];
        
        NSString * email = [userTool getEmail];
        
        NSString * user_id = [userTool getUid];
        
        if (email == nil)
        {
            email = @"0";
        }
 
        
        NSArray * dataMainKey = @[ @"contacts",
                                   @"create_time",
                                   @"email",
                                   @"is_comment",
                                   @"member_id",
                                   @"order_source",
                                   @"order_status",
                                   @"phone",
                                   @"product_category",
                                   @"product_id",
                                   @"product_name",
                                   @"group",
                                   @"belongs"];
        NSArray * dataMainV = @[self.reservePeople.nameText,
                                [NSString stringWithFormat:@"%ld",
                                 (long)[[NSDate date] timeIntervalSince1970]],
                                email, @"0",
                                user_id,
                                @"iOS",
                                @"0",
                                self.reservePeople.infoText,
                                @"-2",
                                _stadyTourModel.yoosure_id,
                                _stadyTourModel.yoosure_name,
                                [[LXUserTool alloc]getuserGroup],_stadyTourModel.belongs];
        
        
        NSMutableDictionary * dataMainDic = [NSMutableDictionary dictionaryWithObjects:dataMainV forKeys:dataMainKey];
        
        if (self.traveModel.child_price == nil)
        {
            self.traveModel.child_price = @"00.00";
        }
        if (self.traveModel.adult_price == nil)
        {
            self.traveModel.adult_price = @"00.00";
        }
        
        LXTimeTableModel *model=[_setoffDateArray objectAtIndex:_selectBtnIndex-1000];
        DLog(@"--[%@]",_pay_type);
        NSDictionary * dataTravel = @{@"camper_num":childNunLabel.text,
                                      @"teacher_num":adultNumLabel.text,
                                      @"pay_type":_pay_type,
                                      @"person_info":@"",
                                      @"time_table_id":model.timetable_id,
                                      @"yoosure_id":_stadyTourModel.yoosure_id,
                                      @"pass_citys":@"",
                                      @"pay_way":_stadyTourModel.pay_way,
                                      };
        
        NSDictionary * orderdata = @{@"cat_id":@"-2", @"dataMain":dataMainDic, @"dataYoosure":dataTravel, @"product_id":_stadyTourModel.yoosure_id};
        
        NSString *token = @"~0;id<zOD.{ll@]JKi(:";
        NSString *token1 = [token stringByAppendingString:user_id];
        NSDictionary *parameters = nil;
        if (self.orderSource == WLOrderSourceStewardShop)
        {
            parameters = @{@"member_id":user_id,
                           @"orderdata":[self dictionaryToJson:orderdata],
                           @"wltoken":[WXUtil md5:token1],
                           @"store_id":self.store_id};

        }
        else
        {
            parameters = @{@"member_id":user_id,
                           @"orderdata":[self dictionaryToJson:orderdata],
                           @"wltoken":[WXUtil md5:token1]};
        }
        [self setProgressHud];
        //发送请求
        DLog(@"%@",parameters);
        [manager POST:M_URL_SHIP_SUBMIT_ORDER parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [_hud hide:YES];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            DLog(@"%@",dic);
            if ([[dic objectForKey:@"state"] integerValue] == -1 || [[dic objectForKey:@"state"] integerValue] == -2 || [[dic objectForKey:@"state"] integerValue] == -3)
            {
                
                [[LXAlterView sharedMyTools] createTishi:[dic objectForKey:@"msg"]];
                
            }
            else
            {
                [[LXAlterView sharedMyTools] createTishi:@"订单提交成功！"];
                YXVisaPayViewController *payVC = [[YXVisaPayViewController alloc] init];
                payVC.orderId = [[dic objectForKey:@"data"] objectForKey:@"order_sn"];
                payVC.place = placeLabel.text;
                if ([[[dic objectForKey:@"data"] objectForKey:@"yoosure_pay_type"] integerValue]==2)
                {
                     payVC.price = [[dic objectForKey:@"data"] objectForKey:@"earnest"];
                }
                else
                {
                    payVC.price = [[dic objectForKey:@"data"] objectForKey:@"order_price"];
                }
                
                payVC.contact = v.nameTextField.text;
                payVC.tel = v.phoneTextField.text;
                payVC.time = [self getDateStr:self.departureDate];
                int totalNum = [childNunLabel.text intValue]+ [adultNumLabel.text intValue];
                payVC.renshu = [NSString stringWithFormat:@"%d",totalNum];
                payVC.dingdanId = [[dic objectForKey:@"data"] objectForKey:@"order_id"];
                payVC.memberId = [[dic objectForKey:@"data"] objectForKey:@"member_id"];
                
                //新增字段用来判断状态
                payVC.order_statu = [[dic objectForKey:@"data"] objectForKey:@"order_status"];
                payVC.adultNum = adultNumLabel.text;
                payVC.childNum = childNunLabel.text;
                payVC.isStudyTour=YES;
                payVC.pay_way=_stadyTourModel.pay_way;
                payVC.pay_type=[[dic objectForKey:@"data"] objectForKey:@"yoosure_pay_type"];
                [self.navigationController pushViewController:payVC animated:YES];
            }
            
        }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             DLog(@"%@",error);
             _hud.labelText = @"订单提交失败！";
            [_hud hide:YES afterDelay:0.2];
            
        }];
        
        
    }
    else if (_isVisa)
    {
        for (int i =0; i<_visaNumberView.dataArray.count; i++)
        {
            NSIndexPath *pathOne = [NSIndexPath indexPathForRow:i inSection:0]; //获取cell的位置
            YXEditArrayCell *cellOne = (YXEditArrayCell *)[_visaNumberView.tableView cellForRowAtIndexPath:pathOne];//获取具体位置的cell
            DLog(@"%@---++%@",cellOne.nameTextField.text,cellOne.phoneTextField.text);
            if ([YXTools stringIsNotNullTrim:cellOne.nameTextField.text] || ![self judgeString:cellOne.phoneTextField.text])
            {
                [[LXAlterView sharedMyTools] createTishi:@"请完善出游人信息"];
                return;
            }
            ZFJOrderPeopleModel * orderModel = [[ZFJOrderPeopleModel alloc] init];
            orderModel.nameText = cellOne.nameTextField.text;
            orderModel.infoText = cellOne.phoneTextField.text;
            [orderArr addObject:orderModel];
        }
        
        OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
        if ([YXTools stringIsNotNullTrim:v.nameTextField.text] || [YXTools stringIsNotNullTrim:v.phoneTextField.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请完善联系人信息"];
            return;
        }
        if (![YXTools isValidateMobile:v.phoneTextField.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
            return;
        }
        self.reservePeople = [[ZFJOrderPeopleModel alloc] init];
        self.reservePeople.nameText = v.nameTextField.text;
        self.reservePeople.infoText = v.phoneTextField.text;
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString * nowTime = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        
        LXUserTool * userTool = [[LXUserTool alloc] init];
        
        NSString * email = [userTool getEmail];
        
        NSString * user_id = [userTool getUid];
        
        NSArray * dataMainKey = @[@"admin_type",
                                  @"contacts",
                                  @"create_time",
                                  @"email",
                                  @"is_comment",
                                  @"is_ticket",
                                  @"member_id",
                                  @"group",
                                  @"order_source",
                                  @"order_status",
                                  @"phone",
                                  @"product_category",
                                  @"product_id",
                                  @"product_name"];
        
        NSString * admin_type = [NSString stringWithFormat:@"%@", self.visaModel.admin_type];
        
        if (email == nil)
        {
            email = @"0";
        }
 
        
        NSArray * dataMainV = @[admin_type,
                                _reservePeople.nameText,
                                nowTime,
                                email,
                                @"0",
                                @"0",
                                user_id,
                                [[LXUserTool alloc]getuserGroup],
                                @"iOS",
                                @"0",
                                _reservePeople.infoText,
                                @"2",
                                _visaModel.product_id,
                                _visaModel.product_name];
        
        NSMutableDictionary * dataMainDic = [NSMutableDictionary dictionaryWithObjects:dataMainV forKeys:dataMainKey];
        
        
        NSMutableArray * peoleArr = [NSMutableArray array];
        for (int i = 0; i < orderArr.count; i++)
        {
            ZFJOrderPeopleModel * model = [orderArr objectAtIndex:i];
            if (model.infoText != nil)
            {
                NSDictionary * people = @{@"name":model.nameText,
                                          @"type": model.infoText};
                [peoleArr addObject:people];
            }
            else
            {
                 [[LXAlterView sharedMyTools] createTishi:@"请选择类型！"];
                return;
            }

        }
        
        NSDictionary * person_info = @{@"fulldir":@"下单后会电话询问，默认邮寄到旅行社",
                                       @"people":peoleArr};
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate * date = [formatter dateFromString:self.departureDate];
        DLog(@"%@",self.departureDate);
        NSString *tour_time = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];//出游时间；
        NSDictionary * dataVisa = @{@"mail_post":@"快递",
                                    @"nums":[NSString stringWithFormat:@"%ld", peoleArr.count],
                                    @"person_info":person_info,
                                    @"tour_time":tour_time};
        
        
        NSDictionary * orderdata = @{@"cat_id":@"2",
                                     @"dataMain":dataMainDic,
                                     @"dataVisa":dataVisa,
                                     @"product_id":self.visaModel.product_id};
        NSString *token = @"~0;id<zOD.{ll@]JKi(:";
        NSString *token1 = [token stringByAppendingString:user_id];
        NSDictionary *parameters =nil;
        
        if (self.orderSource == WLOrderSourceStewardShop)
        {
            parameters = @{@"member_id":user_id,
                           @"orderdata":[self dictionaryToJson:orderdata],
                           @"wltoken":[WXUtil md5:token1],
                           @"store_id":self.store_id};
        }
        else
        {
            parameters = @{@"member_id":user_id,
                           @"orderdata":[self dictionaryToJson:orderdata],
                           @"wltoken":[WXUtil md5:token1]};
        }
        //你的接口地
        NSString *url= orderDetailURL;
        [self setProgressHud];
        DLog(@"邮轮提交订单参数：%@",parameters);
        //发送请求
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            [_hud hide:YES];
           
            self.dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             DLog(@"JSON: %@",  self.dataDic);
            if ([[self.dataDic objectForKey:@"state"] integerValue] == -1 || [[self.dataDic objectForKey:@"state"] integerValue] == -2 || [[self.dataDic objectForKey:@"state"] integerValue] == -3)
            {
                
                [[LXAlterView sharedMyTools] createTishi:[self.dataDic objectForKey:@"msg"]];
 
            }
            else
            {
               [[LXAlterView sharedMyTools] createTishi:@"订单提交成功！"];
               YXVisaPayViewController *payVC = [[YXVisaPayViewController alloc] init];
               payVC.orderId = [[self.dataDic objectForKey:@"data"] objectForKey:@"order_sn"];
                payVC.place = placeLabel.text;
                payVC.price = [[self.dataDic objectForKey:@"data"] objectForKey:@"order_price"];
                payVC.contact = v.nameTextField.text;
                payVC.tel = v.phoneTextField.text;
                payVC.time = _beginDateLabel.text;
                payVC.dingdanId = [[self.dataDic objectForKey:@"data"] objectForKey:@"order_id"];
                payVC.memberId = [[self.dataDic objectForKey:@"data"] objectForKey:@"member_id"];
                payVC.adultNum = [NSString stringWithFormat:@"%ld", peoleArr.count];
                payVC.isVisa=YES;
                payVC.renshu = [NSString stringWithFormat:@"%ld", peoleArr.count];
                [self.navigationController pushViewController:payVC animated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             DLog(@"%@",error);
             _hud.labelText = @"订单提交失败！";
            [_hud hide:YES afterDelay:0.2];

        }];
    }
    else if(_isShip)
    {
        if (_isShip) {
            self.isShowShipPriceDetail = NO;
        }
        UIView *v2 = (UIView *)[[YXTools getApp].window viewWithTag:350];
        [v2 removeFromSuperview];
        
        UIView *v1 = (UIView *)[[YXTools getApp].window viewWithTag:450];
        [v1 removeFromSuperview];
        
        if ([self.adultNumber intValue]==0)
        {
            [[LXAlterView sharedMyTools] createTishi:@"请先选择出游人数"];
            return;
        }
        OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
        if ([YXTools stringIsNotNullTrim:v.nameTextField.text] || [YXTools stringIsNotNullTrim:v.phoneTextField.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请完善联系人信息"];
            return;
        }
        if (![YXTools isValidateMobile:v.phoneTextField.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
            return;
        }
        LXUserTool * userTool = [[LXUserTool alloc] init];
        NSString *email = [userTool getEmail];
        NSString *user_id = [userTool getUid];
        NSString *admin_type = self.shipModel.admin_type;
        NSString *admin_id = self.shipModel.admin_id;
        if (email == nil)
        {
            email = @"0";
        }
         if (admin_type == nil)
        {
            admin_type = @"0";
        }
        self.reservePeople = [[ZFJOrderPeopleModel alloc] init];
        self.reservePeople.nameText = v.nameTextField.text;
        self.reservePeople.infoText = v.phoneTextField.text;
        NSArray * dataMainKey = @[@"admin_type",
                                  @"admin_id",
                                  @"contacts",
                                  @"create_time",
                                  @"email",
                                  @"is_comment",
                                  @"is_ticket",
                                  @"member_id",
                                  @"group",
                                  @"order_price",
                                  @"order_source",
                                  @"order_status",
                                  @"phone",
                                  @"product_category",
                                  @"product_id",
                                  @"product_name"];
        NSArray * dataMainV = @[admin_type,
                                admin_id,
                                self.reservePeople.nameText,
                                [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]],
                                email,
                                @"0",
                                @"0",
                                user_id,
                                [[LXUserTool alloc]getuserGroup],
                                self.allPrice,
                                @"iOS",
                                @"0",
                                self.reservePeople.infoText,
                                @"-5",
                                self.shipModel.product_id,
                                self.shipModel.product_name];
        NSMutableDictionary * dataMainDic = [NSMutableDictionary dictionaryWithObjects:dataMainV forKeys:dataMainKey];
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate * date = [formatter dateFromString:self.departureDate];
        NSString *tour_time = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];//出游时间；
        NSMutableArray * dataShip = [[NSMutableArray alloc] init];
    for (int i=0; i<self.shipArr.count; i++) {
            NSDictionary *youlunDic = [self.shipArr objectAtIndex:i];
            NSDictionary *roomPeopleDic = [self.roomPeopleArray objectAtIndex:i];
        NSString *adultNumber = [roomPeopleDic objectForKey:@"adultNum"];
        NSString *childNumNumber = [roomPeopleDic objectForKey:@"childNum"];
        NSString *numStr = self.selectRoomNum[i];
            ZFJShipRoom *shipRoom = JsonStringTransToObject(youlunDic, @"ZFJShipRoom");
            
            if (shipRoom.room_price2 == nil)
            {
                shipRoom.room_price2 = @"00.00";
            }
            if (shipRoom.room_34_price2 == nil)
            {
                shipRoom.room_34_price2 = @"00.00";
            }
        

    NSDictionary *cruiseDic = @{@"adult_number":adultNumber,@"room_id":shipRoom.c_id,@"cabin_id":shipRoom.cabin_id,@"cabin_num":shipRoom.num,@"depart_date":tour_time,@"first_price":shipRoom.first_price,@"third_price":shipRoom.third_price,@"company_id":self.company_id,@"line_id":self.line_id,@"room_num":[NSString stringWithFormat:@"%@",numStr],@"second_price":shipRoom.second_price,@"tour_id":self.tourId,@"children":childNumNumber};
            DLog(@"订单房间参数%@",cruiseDic);
            [dataShip addObject:cruiseDic];
        }
          NSDictionary * orderdata = @{@"cat_id":@"-5",
                                     @"dataMain":dataMainDic,
                                     @"dataCruise":dataShip,
                                     @"product_id":self.shipModel.product_id,@"pay_way":_pay_way};
         NSString *token = @"~0;id<zOD.{ll@]JKi(:";
         NSString *token1 = [token stringByAppendingString:user_id];
        NSDictionary *parameters = nil;
         if (self.orderSource == WLOrderSourceStewardShop)
        {
            parameters = @{@"member_id":user_id,
                           @"orderdata":[self dictionaryToJson:orderdata],
                           @"wltoken":[WXUtil md5:token1],
                           @"store_id":self.store_id};
        }
        else
        {
            parameters = @{@"member_id":user_id,
                           @"orderdata":[self dictionaryToJson:orderdata],
                           @"wltoken":[WXUtil md5:token1]};
        }
        DLog(@"邮轮提交订单请求参数：%@",parameters);
          //发送请求
        [self setProgressHud];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager POST:orderDetailURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            [_hud hide:YES];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             if ([[dic objectForKey:@"state"] integerValue] == -1 || [[dic objectForKey:@"state"] integerValue] == -2 || [[dic objectForKey:@"state"] integerValue] == -3 || [[dic objectForKey:@"state"] integerValue] == 0)
            {
                 [[LXAlterView sharedMyTools] createTishi:[dic objectForKey:@"msg"]];
            }
            else
            {
                [[LXAlterView sharedMyTools] createTishi:@"订单提交成功！"];
                YXVisaPayViewController *payVC = [[YXVisaPayViewController alloc] init];
                payVC.orderId = [[dic objectForKey:@"data"] objectForKey:@"order_sn"];
                payVC.place = placeLabel.text;
                payVC.price = [[dic objectForKey:@"data"] objectForKey:@"order_price"];
                payVC.contact = v.nameTextField.text;
                payVC.tel = v.phoneTextField.text;
                payVC.time = _beginDateLabel.text;
                payVC.renshu = self.adultNumber;
                payVC.childNum = self.childrenNumber;
                payVC.adultNum = self.adultNumber;
                payVC.order_statu = [[dic objectForKey:@"data"] objectForKey:@"order_status"];
                payVC.dingdanId = [[dic objectForKey:@"data"] objectForKey:@"order_id"];
                payVC.memberId = [[dic objectForKey:@"data"] objectForKey:@"member_id"];
                payVC.pay_way=[[dic objectForKey:@"data"] objectForKey:@"pay_way"];
                payVC.isShip = YES;
                [self.navigationController pushViewController:payVC animated:YES];
            }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            DLog(@"%@",error);
            _hud.labelText = @"订单提交失败！";
            [_hud hide:YES afterDelay:0.2];
        }];
     }
    else if(_isTicket)
    {
        
        for (int i =0; i<_visaNumberView.dataArray.count; i++)
        {
            NSIndexPath *pathOne = [NSIndexPath indexPathForRow:i inSection:0]; //获取cell的位置
            YXEditArrayCell *cellOne = (YXEditArrayCell *)[_visaNumberView.tableView cellForRowAtIndexPath:pathOne];//获取具体位置的cell
            if ([YXTools stringIsNotNullTrim:cellOne.nameTextField.text] || [YXTools stringIsNotNullTrim:cellOne.phoneTextField.text]) {
                [[LXAlterView sharedMyTools] createTishi:@"请完善申请人信息"];
                return;
            }
            
            if (![YXTools isValidateMobile:cellOne.phoneTextField.text]) {
                [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
                return;
            }
            
            if (![self judgeEmail:cellOne.emailTF.text]) {
                [[LXAlterView sharedMyTools] createTishi:@"请输入正确的邮箱"];
                return;
            }
            if ([cellOne.voucherTypeTF.text isEqualToString:@"  身份证"] && [[CheckIDNumber sharedMyTools] validateIDCardNumber:cellOne.voucherNumberTF.text] == false)
            {
                [[LXAlterView sharedMyTools] createTishi:@"请输入正确的身份证号"];
                return;
            }
            if (![self judgeString:cellOne.voucherTypeTF.text])
            {
                [[LXAlterView sharedMyTools] createTishi:@"请选择证件类型"];
                return;
            }
            else if (![self judgeString:cellOne.voucherNumberTF.text] )
            {
                [[LXAlterView sharedMyTools] createTishi:@"请输入证件号"];
                return;
                
            }
             ZFJOrderPeopleModel * orderModel = [[ZFJOrderPeopleModel alloc] init];
            orderModel.nameText = cellOne.nameTextField.text;
            orderModel.phoneText = cellOne.phoneTextField.text;
            orderModel.credentialsText = cellOne.voucherNumberTF.text;
            orderModel.credentialsTypeText = cellOne.voucherTypeTF.text;
            orderModel.emailText = cellOne.emailTF.text;
            [orderArr addObject:orderModel];
        }
        
        OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
        if ([YXTools stringIsNotNullTrim:v.nameTextField.text] || [YXTools stringIsNotNullTrim:v.phoneTextField.text]||[YXTools stringIsNotNullTrim:v.emailTF.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请完善联系人信息"];
            return;
        }
        if (![YXTools isValidateMobile:v.phoneTextField.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
            return;
        }
        if (![self judgeEmail:v.emailTF.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请输入正确的邮箱"];
            return;
        }
        
        self.reservePeople = [[ZFJOrderPeopleModel alloc] init];
        self.reservePeople.nameText = v.nameTextField.text;
        self.reservePeople.infoText = v.phoneTextField.text;
        self.reservePeople.emailText = v.emailTF.text;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        NSString * nowTime = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        
        LXUserTool * userTool = [[LXUserTool alloc] init];
        
        NSString * email = [userTool getEmail];
        
        NSString * user_id = [userTool getUid];
        
        NSArray * dataMainKey = @[@"product_id",
                                  @"contacts",
                                  @"phone",
                                  @"product_category",
                                  @"order_status",
                                  @"create_time",
                                  @"is_comment",
                                  @"order_source",
                                  @"is_ticket",
                                  @"email",
                                  @"admin_type",
                                  @"product_name",
                                  @"member_id",
                                  @"group"
                                  ];
         if (email == nil)
        {
            email = @"0";
        }
        
        NSString *goods_name=[NSString stringWithString:self.product_name];
        goods_name=[goods_name stringByAppendingString:@"/"];
        goods_name=[goods_name stringByAppendingString:self.ticketGoodsModel.goods_name];
        
        NSArray * dataMainV = @[self.ticketGoodsModel.goods_id,
                                self.reservePeople.nameText,
                                self.reservePeople.infoText,
                                @"-1",
                                @"0",
                                nowTime,
                                @"0",
                                @"iOS",
                                @"0",
                                self.reservePeople.emailText,
                                @"-1",
                                goods_name,
                                user_id,
                                [[LXUserTool alloc]getuserGroup]];
        NSMutableDictionary * dataMainDic = [NSMutableDictionary dictionaryWithObjects:dataMainV forKeys:dataMainKey];
        NSMutableArray * travellerArr = [NSMutableArray array];
        for (int i = 0; i < orderArr.count; i++)
        {
            ZFJOrderPeopleModel * model = [orderArr objectAtIndex:i];
            if (model.credentialsTypeText != nil)
            {
                NSString * credentialsTypeStr = @"";
                if ([model.credentialsTypeText isEqualToString:@"  身份证"])
                {
                    credentialsTypeStr = @"ID_CARD";
                }
                else if ([model.credentialsTypeText isEqualToString:@"  护照"])
                {
                    credentialsTypeStr = @"HUZHAO";
                }
                else if ([model.credentialsTypeText isEqualToString:@"  港澳通行证"])
                {
                    credentialsTypeStr = @"GANGAO";
                }
                else if ([model.credentialsTypeText isEqualToString:@"  台胞证"])
                {
                    credentialsTypeStr = @"TAIBAO";
                }
                
                NSDictionary * travellerDic = @{@"name":model.nameText,
                                                @"mobile": model.phoneText,
                                                @"email": model.emailText,
                                                @"credentials": model.credentialsText,
                                                @"credentialsType": credentialsTypeStr};
                [travellerArr addObject:travellerDic];
            }
            else
            {
                [[LXAlterView sharedMyTools] createTishi:@"请选择类型！"];
                return;
            }
        }
        
        NSDictionary * dataTicket = @{@"goods_id": _ticketGoodsModel.goods_id,
                                      @"traveller":travellerArr,
                                      @"num":[NSString stringWithFormat:@"%ld", travellerArr.count],
                                      @"date":self.departureDate};
        
        
        NSDictionary * orderdata = @{@"cat_id":@"-1",
                                     @"product_id":self.ticketGoodsModel.goods_id,
                                     @"dataMain":dataMainDic,
                                     @"dataTicket":dataTicket};
        
        DLog(@"***\n%@\n****", orderdata);
        NSString *token = @"~0;id<zOD.{ll@]JKi(:";
        NSString *token1 = [token stringByAppendingString:user_id];
 
        
        NSDictionary *parameters = nil;
        
        if (self.orderSource == WLOrderSourceStewardShop)
        {
            parameters = @{@"member_id":user_id,
                           @"orderdata":[self dictionaryToJson:orderdata],
                           @"wltoken":[WXUtil md5:token1],
                           @"store_id":self.store_id};
        }
        else
        {
            parameters = @{@"member_id":user_id,
                           @"orderdata":[self dictionaryToJson:orderdata],
                           @"wltoken":[WXUtil md5:token1]};
        }

        
        
        //接口
        NSString *url= orderDetailURL;
        [self setProgressHud];
        //发送请求
        [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
            [_hud hide:YES];
            
            self.dataDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            DLog(@"Parameters:%@,JSON: %@",parameters, self.dataDic);
            if ([[self.dataDic objectForKey:@"state"] integerValue] == -1 || [[self.dataDic objectForKey:@"state"] integerValue] == -2 || [[self.dataDic objectForKey:@"state"] integerValue] == -3 || [[self.dataDic objectForKey:@"state"] integerValue] == 0)
            {
                [[LXAlterView sharedMyTools] createTishi:[self.dataDic objectForKey:@"msg"]];
                
            }
            else
            {
                [[LXAlterView sharedMyTools] createTishi:@"订单提交成功！"];
                YXVisaPayViewController *payVC = [[YXVisaPayViewController alloc] init];
                payVC.orderId = [[self.dataDic objectForKey:@"data"] objectForKey:@"order_sn"];
                payVC.place =goods_name;//placeLabel.text;
                payVC.price = [[self.dataDic objectForKey:@"data"] objectForKey:@"order_price"];
                payVC.contact = v.nameTextField.text;
                payVC.tel = v.phoneTextField.text;
                payVC.time = _beginDateLabel.text;
                payVC.isTicket = YES;
                payVC.dingdanId = [[self.dataDic objectForKey:@"data"] objectForKey:@"order_id"];
                payVC.memberId = [[self.dataDic objectForKey:@"data"] objectForKey:@"member_id"];
                DLog(@"%@",self.ticketGoodsModel.ticket_type);
                if ([self.ticketGoodsModel.ticket_type isEqualToString:@"儿童票"])
                {
                    payVC.childNum=[NSString stringWithFormat:@"%ld", travellerArr.count];
                }
                else if ([self.ticketGoodsModel.ticket_type isEqualToString:@"成人票"])
                {
                    payVC.adultNum = [NSString stringWithFormat:@"%ld", travellerArr.count];
                }
                payVC.renshu = [NSString stringWithFormat:@"%ld", travellerArr.count];
                
                [self.navigationController pushViewController:payVC animated:YES];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            _hud.labelText = @"订单提交失败！";
            [_hud hide:YES afterDelay:0.2];
            
        }];

    }
    else if(_isTrave==YES)
    {
        
        if ([childNunLabel.text intValue]==0 &&[adultNumLabel.text intValue]==0)
        {
            [[LXAlterView sharedMyTools] createTishi:@"请先选择出游人数"];
            return;
        }
        OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
        if ([YXTools stringIsNotNullTrim:v.nameTextField.text] || [YXTools stringIsNotNullTrim:v.phoneTextField.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请完善联系人信息"];
            return;
        }
        if (![YXTools isValidateMobile:v.phoneTextField.text])
        {
            [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
            return;
        }
        self.reservePeople = [[ZFJOrderPeopleModel alloc] init];
        self.reservePeople.nameText = v.nameTextField.text;
        self.reservePeople.infoText = v.phoneTextField.text;

        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //申明返回的结果是json类型
        // manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        // manager.requestSerializer=[AFJSONRequestSerializer serializer];
        //如果报接受类型不一致请替换一致text/html或别的
        //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //传入的参数
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        LXUserTool * userTool = [[LXUserTool alloc] init];

        NSString * email = [userTool getEmail];
        
        NSString * user_id = [userTool getUid];
        
        if (email == nil)
        {
            email = @"0";
        }
 
        NSArray * dataMainKey = @[@"admin_type",
                                  @"contacts",
                                  @"create_time",
                                  @"email",
                                  @"is_comment",
                                  @"is_ticket",
                                  @"member_id",
                                  @"group",
                                  @"order_source",
                                  @"order_status",
                                  @"phone",
                                  @"product_category",
                                  @"product_id",
                                  @"product_name"];
        NSArray * dataMainV = @[self.traveModel.admin_type,
                                self.reservePeople.nameText,
                                [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]],
                                email,
                                @"0",
                                @"0",
                                user_id,
                                [[LXUserTool alloc]getuserGroup],
                                @"iOS",
                                @"0",
                                self.reservePeople.infoText,
                                @"1",
                                self.traveModel.product_id,
                                self.traveModel.product_name];
        
        
        NSMutableDictionary * dataMainDic = [NSMutableDictionary dictionaryWithObjects:dataMainV forKeys:dataMainKey];
        

        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate * date = [formatter dateFromString:self.departureDate];
        DLog(@"%@",self.departureDate);
        NSString *tour_time = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];//出游时间；
        DLog(@"%@",tour_time);
        if (self.traveModel.child_price == nil)
        {
            self.traveModel.child_price = @"00.00";
        }
        if (self.traveModel.adult_price == nil)
        {
            self.traveModel.adult_price = @"00.00";
        }
     
        NSDictionary * dataTravel = @{@"child":childNunLabel.text,
                                      @"insurance":@"1",
                                      @"person_info":@"",
                                      @"is_oldman":@"0",
                                      @"f_time":tour_time,
                                      @"is_adult":@"0",
                                      @"is_foreign":@"0",
                                      @"adule_price":adultNumLabel.text,
                                      @"adule":adultNumLabel.text,
                                      @"order_id":@"99",
                                      @"f_city":self.traveModel.f_city,
                                      @"child_price":childNunLabel.text};
        
        NSDictionary * orderdata = @{@"group": [[LXUserTool alloc]getuserGroup],
                                     @"cat_id":@"1",
                                     @"dataMain":dataMainDic,
                                     @"dataTravel":dataTravel,
                                     @"product_id":self.traveModel.product_id};
        
        NSString *token = @"~0;id<zOD.{ll@]JKi(:";
        NSString *token1 = [token stringByAppendingString:user_id];
        NSDictionary *parameters = nil;
        if (self.orderSource == WLOrderSourceStewardShop)
        {
            parameters = @{@"member_id":user_id,
                           @"orderdata":[self dictionaryToJson:orderdata],
                           @"wltoken":[WXUtil md5:token1],
                           @"store_id":self.store_id};
        } else
        {
            parameters = @{@"member_id":user_id,
                           @"orderdata":[self dictionaryToJson:orderdata],
                           @"wltoken":[WXUtil md5:token1]};
        }

        [self setProgressHud];
        
        DLog(@"提交订单：%@",parameters);
        
        //发送请求
        [manager POST:orderDetailURL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            [_hud hide:YES];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            DLog(@"JSON: %@",  dic);
            if ([[dic objectForKey:@"state"] integerValue] == -1 || [[dic objectForKey:@"state"] integerValue] == -2 || [[dic objectForKey:@"state"] integerValue] == -3)
            {
                
                [[LXAlterView sharedMyTools] createTishi:[dic objectForKey:@"msg"]];
                
                
            }else
            {
                [[LXAlterView sharedMyTools] createTishi:@"订单提交成功！"];
                YXVisaPayViewController *payVC = [[YXVisaPayViewController alloc] init];
                payVC.orderId = [[dic objectForKey:@"data"] objectForKey:@"order_sn"];
                payVC.place = placeLabel.text;
                payVC.price = [[dic objectForKey:@"data"] objectForKey:@"order_price"];
                DLog(@"%@",payVC.price);
                payVC.contact = v.nameTextField.text;
                payVC.tel = v.phoneTextField.text;
                payVC.time = _beginDateLabel.text;
                int totalNum = [childNunLabel.text intValue]+ [adultNumLabel.text intValue];
                payVC.renshu = [NSString stringWithFormat:@"%d",totalNum];
                payVC.dingdanId = [[dic objectForKey:@"data"] objectForKey:@"order_id"];
                payVC.memberId = [[dic objectForKey:@"data"] objectForKey:@"member_id"];
                 payVC.adultNum = [[dic objectForKey:@"data"] objectForKey:@"adule"];
                payVC.childNum = [[dic objectForKey:@"data"] objectForKey:@"child"];
                payVC.pay_way=[[dic objectForKey:@"data"] objectForKey:@"pay_way"];
                [self.navigationController pushViewController:payVC animated:YES];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            _hud.labelText = @"订单提交失败！";
            [_hud hide:YES afterDelay:0.2];
        }];
    }
}

#pragma mark ----tableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.shipArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableDictionary *cellCountDic = self.selectRoomCellSelect[section];
    NSString *sectionStr = [NSString stringWithFormat:@"%ld",section];
    NSString *cellState = cellCountDic[sectionStr];
    return [cellState isEqualToString:@"YES"]?1:0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *cellCountDic = self.selectRoomCellSelect[indexPath.section];
    NSString *sectionStr = [NSString stringWithFormat:@"%ld",indexPath.section];
    NSString *cellState = cellCountDic[sectionStr];
    return [cellState isEqualToString:@"YES"]?40:0;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
return 40;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndent10 = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndent10];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndent10];
        //左价格详情界面
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, windowContentWidth - 20, 20)];
        //titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.tag = 1000;
        [cell.contentView addSubview:titleLabel];
 
        
    }
    NSDictionary *dic = self.selectRoomPriceAndNum[indexPath.section];
    NSString *numStr = self.selectRoomNum[indexPath.section];
    UILabel *titleLabel = [cell.contentView viewWithTag:1000];
    //titleLabel.backgroundColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    cell.backgroundColor = [UIColor grayColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = [NSString stringWithFormat:@"成人*%@人    儿童*%@人    房间*%@间",dic[@"adultNum"],dic[@"childNum"],numStr];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
      return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDictionary *dic = self.shipArr[section];
    NSDictionary *priceAndNumdic = self.selectRoomPriceAndNum[section];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 40)];
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, windowContentWidth/2 , 20)];
    detailLabel.text = [NSString stringWithFormat:@"%@:",dic[@"cabin_name"]];
    [headView addSubview:detailLabel];
    headView.tag = section;
    
    UIView *priceAndIamgeView = [[UIView alloc] initWithFrame:CGRectMake(windowContentWidth/2, 10, windowContentWidth/2 , 20)];

    [headView addSubview:priceAndIamgeView];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth/2  - 30, 20)];
    priceLabel.text = [NSString stringWithFormat:@"¥%@",priceAndNumdic[@"sumPrice"]];
    priceLabel.textAlignment = NSTextAlignmentRight;
    [priceAndIamgeView addSubview:priceLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth/2  - 30, 2.5, 20, 15)];
    imageView.image = [UIImage imageNamed:@"订单明细按钮down"];
    [priceAndIamgeView addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(priceClick:)];
    [headView addGestureRecognizer:tap];

    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, windowContentWidth, 0.5)];
    lineLabel.backgroundColor = [UIColor grayColor];
    [headView addSubview:lineLabel];
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if ([self.traveLineModel.fee_status isEqualToString:@"0"]) {
        CGFloat viewHigh = 0;
        if ( section ==  self.shipArr.count - 1) {
            viewHigh = 40;
        }
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, viewHigh)];

        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80 , 20)];
        detailLabel.text = @"岸上观光";
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, windowContentWidth - 110 , 20)];
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.text = [NSString stringWithFormat:@"¥%@*%d人",self.traveLineModel.tour_price,([self.adultNumber  intValue]+[self.childrenNumber intValue])];
        
        [footerView addSubview:priceLabel];
        [footerView addSubview:detailLabel];
        return footerView;
    }
    
    return nil;
 
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.traveLineModel.fee_status isEqualToString:@"0"])
    {
        if ( section ==  self.shipArr.count - 1) {
            return 40;
        }

    
    
    }
    
   
        return 0;
  
    
}

#pragma mark -tableView的headview的点击事件
-(void)priceClick:(UITapGestureRecognizer *)tap
{
    UIView *headView = tap.view;
    DLog(@"%ld",headView.tag);
    NSMutableDictionary *cellCountDic = self.selectRoomCellSelect[headView.tag];
    NSString *sectionStr = [NSString stringWithFormat:@"%ld",headView.tag];
    NSString *cellState = cellCountDic[sectionStr];
    for (int i = 0; i < self.selectRoomCellSelect.count; i++) {
        NSMutableDictionary *cellSelectDic = self.selectRoomCellSelect[i];
        if (i == headView.tag) {
            if ([cellState isEqualToString:@"YES"]) {
                [cellSelectDic setValue:@"NO" forKey:sectionStr];
            }
            else
            {
            [cellSelectDic setValue:@"YES" forKey:sectionStr];
            }
            
        }
    }
    [_bottomView reloadData];
    
    

}
#pragma mark ---- dictionaryToJson

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
- (NSString*)arrayToJson:(NSArray *)arr

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

#pragma mark - textField协议方法
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    return YES;
}

//当键盘出现或改变时调用
- (void)keyboardShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    bottomView.frame = CGRectMake(0, windowContentHeight-40-64-height, windowContentWidth, 40);
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    bottomView.frame = CGRectMake(0, windowContentHeight-40-64, windowContentWidth, 40);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
   
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.origin.x, [textField superview].frame.origin.y - 30);
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    OrderTextFieldView *v = (OrderTextFieldView *)[self.view viewWithTag:201];
    if (textField == v.phoneTextField)
    {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11)
        {
            return NO;
        }
    }
    
    return YES;
}


- (void)totalPriceData:(NSMutableArray *)allData price:(float)total adultNum:(int)adultNum childNum:(int)childNum
{
    DLog(@"%f-----",total);
    
}
#pragma mark  ----计算用户的订单总和跟选择的舱位及人数
- (void)totalChooseDataDic:(NSMutableDictionary *)dataDic shoreTraveLine:(ZFJShoreTraveModel *)shoreTraveModel
{
    
    self.traveLineModel = shoreTraveModel;
    [self.selectRoomPriceAndNum removeAllObjects];
    NSArray *allkeys = [dataDic allKeys];
    for (NSString *key in allkeys) {
        NSDictionary *dic = dataDic[key];
         [self.selectRoomPriceAndNum addObject:dic];
    }
   
    if (shoreTraveModel == nil) {
       self.tourId = @"-1";
    }
    else
    {
  self.tourId = shoreTraveModel.tour_id;
    }
    
    NSString *linePriceStr = nil;
    
    linePriceStr = (shoreTraveModel == nil || [shoreTraveModel.fee_status isEqualToString:@"1"])?@"0":shoreTraveModel.tour_price;
    
    [self.shipArr removeAllObjects];
    [self.roomPeopleArray removeAllObjects];
    [self.selectRoomNum removeAllObjects];
    NSArray *allRoomDataArray = [NSArray arrayWithArray:[self bianLiRoom:self.shipDataDci]];
    
    NSString *allPrice = @"0";
    NSString *adultNumberStr = @"0";
    NSString *childrenNumberStr = @"0";
    
    NSArray *keysArray = [dataDic allKeys];
    
     //便利数组取出用户选中的邮轮舱位
    for (int i = 0; i < keysArray.count; i++) {
         NSString *moneyKeyStr = [keysArray objectAtIndex:i];
        NSDictionary *moneyDic = [dataDic objectForKey:moneyKeyStr];
        NSString *sumPriceStr = [moneyDic objectForKey:@"sumPrice"];
        
        for (NSDictionary *roomDic in allRoomDataArray) {
            NSString *c_id = roomDic[@"c_id"];
            if ([moneyKeyStr isEqualToString:c_id]) {
                NSString *adultNum = [moneyDic objectForKey:@"adultNum"];
                NSString *childNum = [moneyDic objectForKey:@"childNum"];
                NSString *room_num = roomDic[@"num"] ;
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:adultNum,@"adultNum",childNum,@"childNum",nil];
                NSString *numStr = nil;
                if (([adultNum intValue] + [childNum intValue])%[room_num intValue] == 0) {
                    numStr = [NSString stringWithFormat:@"%d",([adultNum intValue] + [childNum intValue])/[room_num intValue]];
                } else {
                     numStr = [NSString stringWithFormat:@"%d",([adultNum intValue] + [childNum intValue])/[room_num intValue] + 1];
                }
                
                [self.roomPeopleArray addObject:dic];
                [self.shipArr addObject:roomDic];
                [self.selectRoomNum addObject:numStr];
            }
            
        }
        
        NSString *adultNumber = [NSString stringWithFormat:@"%@",[moneyDic objectForKey:@"adultNum"]];
        NSString *childrenNumber = [NSString stringWithFormat:@"%@",[moneyDic objectForKey:@"childNum"]];
        adultNumberStr = [NSString stringWithFormat:@"%d",([adultNumberStr intValue] + [adultNumber intValue])];
        
        childrenNumberStr = [NSString stringWithFormat:@"%d",([childrenNumberStr intValue] + [childrenNumber intValue])];
        
        allPrice = [NSString stringWithFormat:@"%0.2f",([sumPriceStr floatValue] + [allPrice floatValue])];
        
        
    }
    //计算价格详情高度
    self.allPriceHigh = 60;
    for (NSDictionary *roomDic in self.shipArr) {
     self.allPriceHigh = [[roomDic objectForKey:@"num"] intValue] > 2?(self.allPriceHigh + 100):(self.allPriceHigh + 40);
    }
    self.allPriceHigh = self.allPriceHigh + 80;
    
    
    if (self.allPriceHigh > windowContentHeight - 60) {
        self.allPriceHigh = windowContentHeight - 100;
    }
    
    DLog(@"%ld",self.shipArr.count);
    self.adultNumber = adultNumberStr;
    self.childrenNumber = childrenNumberStr;
    allPrice = [NSString stringWithFormat:@"%0.2f",([allPrice floatValue] + ([adultNumberStr intValue] + [childrenNumberStr intValue])*[linePriceStr floatValue])];
    _priceLabel.text = [NSString stringWithFormat:@"订单总额￥%@",allPrice];
    self.allPrice = allPrice;

}

- (void)totalPriceDataDic:(NSMutableDictionary *)dataDic totalPrice:(float)totalPrice adultNum:(int)adultNum childNum:(int)childNum{
    DLog(@"%f---++++++++--",totalPrice);
    
}

- (void)totalChooseDataDic:(NSMutableDictionary *)dataDic{
    DLog(@"%@",dataDic);
}

@end


@implementation OrderTextFieldView

@synthesize nameTextField = _nameTextField,phoneTextField = _phoneTextField;
@synthesize contactImagV = _contactImagV,phoneImagV = _phoneImagV;
- (id)initWithFrame:(CGRect)frame placderName:(NSString *)name placderPhone:(NSString *)phone
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _contactImagV = [YXTools allocImageView:CGRectMake(0, 15, 40, 20) image:nil];
        [self addSubview:_contactImagV];
    
        UILabel *nameLable = [YXTools allocLabel:@"联系人" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(_contactImagV)+ViewWidth(_contactImagV), 10, 50, 30) textAlignment:0];
        [self addSubview:nameLable];
        
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(nameLable)+ViewX(nameLable), ViewY(nameLable), ViewWidth(self)-(ViewWidth(nameLable)+ViewX(nameLable)), 30)];
        _nameTextField.placeholder = name;
        _nameTextField.font = systemFont(14);
        [self addSubview:_nameTextField];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(_nameTextField)+ViewY(_nameTextField)+5, windowContentWidth, 0.5)];
        line.backgroundColor = bordColor;
        [self addSubview:line];
        
        _phoneImagV = [YXTools allocImageView:CGRectMake(0, ViewY(line)+ViewHeight(line)+15, ViewWidth(_contactImagV), ViewHeight(_contactImagV)) image:nil];
        [self addSubview:_phoneImagV];
        
        UILabel *phoneLable = [YXTools allocLabel:@"手机号" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(_phoneImagV)+ViewWidth(_phoneImagV),ViewY(line)+ViewHeight(line)+10, 50, 30) textAlignment:0];
        [self addSubview:phoneLable];
        
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(phoneLable)+ViewX(phoneLable), ViewY(phoneLable), ViewWidth(self)-(ViewWidth(phoneLable)+ViewX(phoneLable)), 30)];
        _phoneTextField.placeholder = phone;
        _phoneTextField.font = systemFont(14);
        [self addSubview:_phoneTextField];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame placderName:(NSString *)name placderPhone:(NSString *)phone emial:(NSString *)emailStr
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        _contactImagV = [YXTools allocImageView:CGRectMake(0, 15, 40, 20) image:nil];
        [self addSubview:_contactImagV];
        
        UILabel *nameLable = [YXTools allocLabel:@"联系人" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(_contactImagV)+ViewWidth(_contactImagV), 10, 50, 30) textAlignment:0];
        [self addSubview:nameLable];
        
        _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(nameLable)+ViewX(nameLable), ViewY(nameLable), ViewWidth(self)-(ViewWidth(nameLable)+ViewX(nameLable)), 30)];
        _nameTextField.placeholder = name;
        _nameTextField.font = systemFont(14);
        [self addSubview:_nameTextField];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(_nameTextField)+ViewY(_nameTextField)+5, windowContentWidth, 0.5)];
        line.backgroundColor = bordColor;
        [self addSubview:line];
        
        _phoneImagV = [YXTools allocImageView:CGRectMake(0, ViewY(line)+ViewHeight(line)+15, ViewWidth(_contactImagV), ViewHeight(_contactImagV)) image:nil];
        [self addSubview:_phoneImagV];
        
        UILabel *phoneLable = [YXTools allocLabel:@"手机号" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(_phoneImagV)+ViewWidth(_phoneImagV),ViewY(line)+ViewHeight(line)+10, 50, 30) textAlignment:0];
        [self addSubview:phoneLable];
        
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(phoneLable)+ViewX(phoneLable), ViewY(phoneLable), ViewWidth(self)-(ViewWidth(phoneLable)+ViewX(phoneLable)), 30)];
        _phoneTextField.placeholder = phone;
        _phoneTextField.font = systemFont(14);
        [self addSubview:_phoneTextField];
        
        
        UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(_phoneTextField)+ViewY(_phoneTextField)+5, windowContentWidth, 0.5)];
        lineOne.backgroundColor = bordColor;
        [self addSubview:lineOne];
        
        self.emailImageView = [YXTools allocImageView:CGRectMake(0, ViewY(lineOne)+ViewHeight(lineOne)+15, ViewWidth(_contactImagV) - 2.5, ViewHeight(_contactImagV) - 2.5) image:nil];
        [self addSubview:_emailImageView];
        
        UILabel *emailLable = [YXTools allocLabel:@"邮箱" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(_emailImageView)+ViewWidth(_emailImageView),ViewY(lineOne)+ViewHeight(lineOne)+10, 50, 30) textAlignment:0];
        [self addSubview:emailLable];
        
        self.emailTF = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(emailLable)+ViewX(emailLable), ViewY(emailLable), ViewWidth(self)-(ViewWidth(emailLable)+ViewX(emailLable)), 30)];
        _emailTF.placeholder = emailStr;
        _emailTF.font = systemFont(14);
        [self addSubview:_emailTF];

        
    }
    return self;
}



@end
