//
//  YXChoosCabinViewController.m
//  WelLv
//
//  Created by lyx on 15/5/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXChoosCabinViewController.h"
#define ButtonWith windowContentWidth/4
#define BottomVieHight 50

@interface YXChoosCabinViewController ()
{
    UITableView *_tableView;
    NSMutableArray *_buttonArr;       //仓房标题button数组
    NSArray *_cabinArr;       //仓位数组
    
    UITableView *_bottomView;        //底部详细视图
    UIButton *_upDownBtn;       //控制底部视图隐藏收缩按钮
    UIImageView *_upDownImageView;
    
    UILabel *_totalPrice;        //底部总金额
}

@property (nonatomic,strong)UIButton *selectBtn;
@end

@implementation YXChoosCabinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"选择舱房";
    _buttonArr = [[NSMutableArray alloc] init];
    _lowestPrice = [[NSMutableArray alloc] init];
    _cabinArr = [[NSArray alloc] init];
    selectedCabin = [[NSMutableArray alloc] init];
    allData = [[NSMutableArray alloc] init];
    [self loadData];
    _isShow = NO;
}

- (void)loadData
{
    if (self.dataArray) {
        _AllData = [NSArray arrayWithArray:[self bianLiJSON:self.dataArray]];
        //遍历出每一种房型的最低价格，存放到_lowestPrice中
        for (int i=0; i<keys.count; i++) {
            NSString *key = [keys objectAtIndex:i];
            NSArray *dateArr = [[_AllData objectAtIndex:i] objectForKey:key];
            if (dateArr.count >0) {
                float minPrice = 0.0;
                for (int i = 0; i<dateArr.count; i++) {
                    NSDictionary *dicP = [dateArr objectAtIndex:i];
                    NSString *str12 = [dicP objectForKey:@"room_price2"];
                    NSString *str34 = [dicP objectForKey:@"room_34_price2"];
                    if ([str34 floatValue] !=0 && [str12 floatValue] > [str34 floatValue]) {
                        minPrice = [str34 floatValue];
                    }else if(minPrice !=0 && [str12 floatValue]>minPrice)
                    {
                        minPrice = minPrice;
                    }else
                    {
                        minPrice = [str12 floatValue];
                    }
                }
                [_lowestPrice addObject:[NSString stringWithFormat:@"%.0f",minPrice]];
            }
        }
    }
    if (self.typeId !=nil) {
        buttonIndex = [keys indexOfObject:self.typeId];
    }else
    {
        buttonIndex = 0;
    }
    _cabinArr = [[_AllData objectAtIndex:buttonIndex] objectForKey:[keys objectAtIndex:buttonIndex]];
    [self initView];
}

//把json数据归类，相同的typeId归为一类
- (NSMutableArray *)bianLiJSON:(NSArray *)arr
{
    NSMutableDictionary *tmpDict=[NSMutableDictionary dictionary];
    for(NSDictionary *dict in arr)
    {
        NSString *key = dict[@"type_id"];
        if(tmpDict[key] == nil)
        {
            tmpDict[key]=[[NSMutableArray alloc] init];
        }
        [tmpDict[key] addObject:dict];
    }
    
    NSMutableArray *result=[NSMutableArray array];
    NSArray *sortkeys=[tmpDict.allKeys sortedArrayUsingSelector:@selector(compare:)];
    keys = [NSArray arrayWithArray:sortkeys];
    for (NSString *key in sortkeys)
    {
        NSDictionary *dict=@{key:tmpDict[key]};
        [result addObject:dict];
    }
    return result;
}

- (void) initView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-170)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    [self initHeaderView:_tableView];
    [self showBottomView];
    [self orderMoneyView];
    
}
- (void)initHeaderView:(UITableView *)tableView
{
    UIView *topVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth,160)];
    topVIew.backgroundColor = kColor(237, 238, 239);
    tableView.tableHeaderView = topVIew;
    //产品名称
    UILabel *productLable = [YXTools allocLabel:self.shipModel.product_name font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(10, 0, windowContentWidth-20, 50) textAlignment:0];
    productLable.numberOfLines = 0;
    productLable.backgroundColor = [UIColor clearColor];
    [topVIew addSubview:productLable];
    
    UIImageView *leftImageView = [YXTools allocImageView:CGRectMake(ViewX(productLable), ViewY(productLable)+ViewHeight(productLable), 35, 20) image:[UIImage imageNamed:@"选择时间"]];
    [topVIew addSubview:leftImageView];
    NSString *date = [YXTools getDate:self.shipModel.setoff_date];
    UILabel *timeLable = [YXTools allocLabel:[NSString stringWithFormat:@"出发时间：%@",date] font:systemFont(13) textColor:[UIColor grayColor] frame:CGRectMake(ViewX(leftImageView)+ViewWidth(leftImageView), ViewY(leftImageView), windowContentWidth-ViewX(leftImageView)-ViewWidth(leftImageView), 20) textAlignment:0];
    timeLable.backgroundColor = [UIColor clearColor];
    [topVIew addSubview:timeLable];
    
    UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ViewY(timeLable)+ViewHeight(timeLable)+10, windowContentWidth, 80)];
    titleScrollView.layer.borderColor = bordColor.CGColor;
    titleScrollView.backgroundColor = [UIColor whiteColor];
    titleScrollView.layer.borderWidth = 0.5;
    [topVIew addSubview:titleScrollView];
    
    
    for (int i=0; i<keys.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0+i*ButtonWith, 0, ButtonWith, ViewHeight(titleScrollView));
        button.tag = i;
        [button addTarget:self action:@selector(changeCabin:) forControlEvents:UIControlEventTouchUpInside];
        [titleScrollView addSubview:button];
        [_buttonArr addObject:button];
        
        NSString *typeName = [keys objectAtIndex:i];
        
        UILabel *typeLable = [YXTools allocLabel:typeName font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(0, 10, ViewWidth(button), 30) textAlignment:1];
        [button addSubview:typeLable];
        
        UILabel *priceLable = [YXTools allocLabel:[NSString stringWithFormat:@"%@起",[_lowestPrice objectAtIndex:i]] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(0, ViewHeight(typeLable)+ViewY(typeLable), ViewWidth(button), 30) textAlignment:1];
        [button addSubview:priceLable];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth(button)+ViewX(button), 10, 0.5, ViewHeight(button) -20)];
        line.alpha = 0.6;
        line.backgroundColor = [UIColor orangeColor];
        [titleScrollView addSubview:line];
        if (i== buttonIndex) {
            typeLable.textColor = [UIColor orangeColor];
            priceLable.textColor = [UIColor orangeColor];
        }
        
    }
    titleScrollView.contentSize = CGSizeMake(ButtonWith*keys.count, 0);
    
}

//可收缩详细视图
- (void)showBottomView
{
    _upDownBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _upDownBtn.frame = CGRectMake(windowContentWidth-55, windowContentHeight-250-30-BottomVieHight, 60, 30);
    _upDownBtn.layer.cornerRadius = 2.0;
    _upDownImageView = [YXTools allocImageView:CGRectMake(20, 0, 20, 30) image:[UIImage imageNamed:@"icon_calendar_down.png"]];
    [_upDownBtn addSubview:_upDownImageView];
    _upDownBtn.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.8];
    [_upDownBtn addTarget:self action:@selector(hideBottomView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_upDownBtn];
    
    _bottomView = [[UITableView alloc] initWithFrame:CGRectMake(0, ViewHeight(_upDownBtn)+ViewY(_upDownBtn), windowContentWidth, 190)];
    _bottomView.bounces = NO;
    _bottomView.delegate = self;
    _bottomView.dataSource = self;
    _bottomView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _bottomView.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.8];
    [self.view addSubview:_bottomView];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 41)];
    UILabel *detailLabel = [YXTools allocLabel:@"价格详情:(未住满的房间按整个房间价格计算)" font:systemFont(15) textColor:[UIColor whiteColor] frame:CGRectMake(15, 0, windowContentWidth-15, 40) textAlignment:0];
    [headerView addSubview:detailLabel];
    UIView *lineBottm = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(detailLabel)+ViewHeight(detailLabel), windowContentWidth, 0.5)];
    lineBottm.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:lineBottm];
    _bottomView.tableHeaderView = headerView;
    
}

//最底部订单视图
- (void)orderMoneyView
{
    UIView *orderView = [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight-60-BottomVieHight, windowContentWidth*2/3, BottomVieHight)];
    orderView.backgroundColor = kColor(254, 204, 65);
    [self.view addSubview:orderView];
    
    UILabel *orderLabel = [YXTools allocLabel:@"订单金额:" font:systemFont(13) textColor:[UIColor whiteColor] frame:CGRectMake(15, 0, 70, ViewHeight(orderView)) textAlignment:0];
    orderLabel.backgroundColor = [UIColor clearColor];
    [orderView addSubview:orderLabel];
    
    float with = ViewWidth(orderLabel)+ViewX(orderLabel);
    _totalPrice = [YXTools allocLabel:@"￥0" font:systemFont(13) textColor:[UIColor redColor] frame:CGRectMake(with, 0,ViewWidth(orderView)-with , ViewHeight(orderView)) textAlignment:0];
    _totalPrice.backgroundColor = [UIColor clearColor];
    [orderView addSubview:_totalPrice];
    
    UIButton *nextBtn = [YXTools allocButton:@"下一步" textColor:[UIColor whiteColor] nom_bg:[UIImage imageNamed:@"qzddBtn"] hei_bg:nil frame:CGRectMake(ViewWidth(orderView)+ViewX(orderView), ViewY(orderView),windowContentWidth*1/3, ViewHeight(orderView))];
    [nextBtn addTarget:self action:@selector(submitOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}

//点击按钮收起和展示视图
- (void)hideBottomView
{
    if (_isShow) {
        
        [self popUpDisplay];
    }else
    {
        [YXTools cATransitionAnimation:self.view typeIndex:0 subTypeIndex:1 duration:0.25 animation:^{
            _isShow = YES;
            _upDownImageView.image = [UIImage imageNamed:@"icon_calendar_up.png"];
            _upDownBtn.frame = CGRectMake(windowContentWidth-55, windowContentHeight-135-BottomVieHight, 60, 30);
            _bottomView.frame = CGRectMake(0, ViewHeight(_upDownBtn)+ViewY(_upDownBtn), windowContentWidth, 210);
        }];
        
    }
    
}
#pragma mark 更换海景房类型
- (void)changeCabin:(UIButton *)sender
{
    for (int i = 0; i<_buttonArr.count; i++)
    {
        UIButton *button = (UIButton *)[_buttonArr objectAtIndex:i];
        UILabel *label1 = (UILabel*)button.subviews[0];
        UILabel *label2 = (UILabel*)button.subviews[1];
        if (sender.tag == button.tag)
        {
            label1.textColor = [UIColor orangeColor];
            label2.textColor = [UIColor orangeColor];
        }
        else
        {
            label1.textColor = [UIColor blackColor];
            label2.textColor = [UIColor blackColor];
        }
    }
    buttonIndex = sender.tag;
    _cabinArr = [[_AllData objectAtIndex:sender.tag] objectForKey:[keys objectAtIndex:sender.tag]];
    [_tableView reloadData];
    [_bottomView reloadData];
}


//弹出视图展示
- (void)popUpDisplay
{
    _isShow = NO;
    _upDownImageView.image = [UIImage imageNamed:@"icon_calendar_down.png"];
    _upDownBtn.frame = CGRectMake(windowContentWidth-55,  windowContentHeight-250-30-BottomVieHight, 60, 30);
    _bottomView.frame = CGRectMake(0, ViewHeight(_upDownBtn)+ViewY(_upDownBtn), windowContentWidth, 190);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击下一步，提交订单
- (void)submitOrder:(UIButton *)sender
{
    if ([totalNumber intValue] == 0) {
        [[LXAlterView sharedMyTools] createTishi:@"请选择人数"];
        return;
    }
    
    YXOrderViewController *orderVC = [[YXOrderViewController alloc] init];
    orderVC.visaRegion = self.shipModel.product_name;
    orderVC.departureDate = [YXTools getDate:self.shipModel.setoff_date];
    orderVC.isTrave = YES;
    orderVC.isShip = YES;
    orderVC.adultNumber = totalNumber;      //总人数
    orderVC.shipArr = allData;
    orderVC.totalPrice = [_totalPrice.text substringFromIndex:1];
    orderVC.shipModel = self.shipModel;
    [self.navigationController pushViewController:orderVC animated:YES];
}
#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cabinArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _bottomView) {
        return 70;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _bottomView) {
        static NSString *CellIndent10 = @"cell";
        CabinPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIndent10];
        if (cell == nil) {
            cell = [[CabinPriceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndent10 frame:CGRectMake(0, 0, windowContentWidth, 70)];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
        }
        NSDictionary *dicDisy= [_cabinArr objectAtIndex:indexPath.row];
        cell.bottomCabinName.text = [dicDisy objectForKey:@"cabin_name"];
        cell.price12.text = [NSString stringWithFormat:@"第1/2人：￥%@/人",[dicDisy objectForKey:@"first_price"]];
        cell.price34.text = [NSString stringWithFormat:@"第3/4人：￥%@/人",[dicDisy objectForKey:@"first_price"]];
        return cell;
    }
    if (tableView == _tableView) {
        NSString *CellIdentifier0 = [NSString stringWithFormat:@"cellIdentifier%ld",buttonIndex];
        YXShipCabinCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
        if (cell == nil) {
            cell = [[YXShipCabinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier0 frame:CGRectMake(0, 0, windowContentWidth, 100)];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        NSDictionary *cabinDic = [_cabinArr objectAtIndex:indexPath.row];
        cell.indexRow = indexPath.row;
        cell.liveInNumber = [cabinDic objectForKey:@"num"];
        cell.cabinFourName.text = [cabinDic objectForKey:@"cabin_name"];
        NSString *detail = [NSString stringWithFormat:@"%@㎡, %@层, 入住%@人",[cabinDic objectForKey:@"size"],[cabinDic objectForKey:@"floor"],[cabinDic objectForKey:@"num"]];
        cell.fRoomDetail.text = detail;
        cell.kucunLabel.text = [NSString stringWithFormat:@"剩余舱房：%@间",[cabinDic objectForKey:@"stock"]];
        cell.price12 = [cabinDic objectForKey:@"first_price"];
        cell.price34 = [cabinDic objectForKey:@"first_price"];
        cell.cabinDic = cabinDic;
        return cell;
        
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        [self popUpDisplay];
        
        [self showDetailCabinView:[_cabinArr objectAtIndex:indexPath.row]];
    }
    
}

- (void)showDetailCabinView:(NSDictionary *)dic
{
    UIView *grayView = [[UIView alloc]initWithFrame:[YXTools getApp].window.bounds];
    grayView.backgroundColor = [UIColor blackColor];
    grayView.alpha = 0.5;
    grayView.tag = 300;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteSearchView)];
    [grayView addGestureRecognizer:ges];
    [[YXTools getApp].window addSubview:grayView];
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth-60, 300)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 5.0;
    whiteView.center = [YXTools getApp].window.center;
    whiteView.tag = 400;
    [[YXTools getApp].window addSubview:whiteView];
    
    UILabel *titleLable = [YXTools allocLabel:[dic objectForKey:@"cabin_name"] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(10, 0,150, 40) textAlignment:0];
    [whiteView addSubview:titleLable];
    
    UIImageView *introductImageView = [YXTools allocImageView:CGRectMake(0, ViewY(titleLable)+ViewHeight(titleLable), ViewWidth(whiteView), 200) image:nil];
    introductImageView.contentMode = UIViewContentModeScaleToFill;
    NSString *imageUrl = [dic objectForKey:@"thumb"];
    NSString *imageP = @"";
    if ([imageUrl hasPrefix:@"https://"] || [imageUrl hasPrefix:@"http://"]) {
        imageP = imageUrl;
    }else
    {
        imageP = [WLHTTP stringByAppendingString:imageUrl];
    }
    [introductImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageP]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    [whiteView addSubview:introductImageView];
    
    
    NSArray *arr = [NSArray arrayWithObjects:@"面积",@"入住人数" ,@"楼层",nil];
    float with = ViewWidth(whiteView)/arr.count;
    for (int i = 0; i<arr.count; i++) {
        UILabel *lable = [YXTools allocLabel:[arr objectAtIndex:i] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(with*i, ViewY(introductImageView)+ViewHeight(introductImageView)+10, with, 20) textAlignment:1];
        [whiteView addSubview:lable];
        if (i != arr.count -1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ViewX(lable) + ViewWidth(lable), ViewY(lable), 0.5, 40)];
            line.backgroundColor = [UIColor grayColor];
            line.alpha = 0.5;
            [whiteView addSubview:line];
        }
    }
    UILabel *areaLabel =  [YXTools allocLabel:[NSString stringWithFormat:@"%@㎡",[dic objectForKey:@"size"]] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(0, 270, with, 20) textAlignment:1];
    [whiteView addSubview:areaLabel];
    UILabel *numberLabel =  [YXTools allocLabel:[NSString stringWithFormat:@"%@",[dic objectForKey:@"num"]] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(areaLabel)+ViewWidth(areaLabel), ViewY(areaLabel), with, 20) textAlignment:1];
    [whiteView addSubview:numberLabel];
    
    UILabel *floorLabel =  [YXTools allocLabel:[NSString stringWithFormat:@"%@",[dic objectForKey:@"floor"]] font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(numberLabel)+ViewWidth(numberLabel), ViewY(areaLabel), with, 20) textAlignment:1];
    [whiteView addSubview:floorLabel];
    
    //    UILabel *windowLabel =  [YXTools allocLabel:@"2" font:systemFont(13) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(floorLabel)+ViewWidth(floorLabel), ViewY(areaLabel), with, 20) textAlignment:1];
    //    [whiteView addSubview:windowLabel];
}
- (void)deleteSearchView
{
    UIView *v = (UIView *)[[YXTools getApp].window viewWithTag:300];
    [v removeFromSuperview];
    
    UIView *v1 = (UIView *)[[YXTools getApp].window viewWithTag:400];
    [v1 removeFromSuperview];
}

#define mark YXShipCabinCellDelegate
/*实现思路
 1、创建两个数组，一个存放可变的对象，一个存放不可变的对象；存可变得数组用于存放选中的对象、人数和总价格，不可变数组用于做判断对象是否在数组里
 2、增加：先判断对象是否在不可变数组中，如果不在，加入数组，如果已经存在，在可变数组里遍历到该对象，修改对象中人数和价格的值；
 3、减少：先判读如果对象不在可不变数组中并且房间数为0，可变数组中删除改对象，不可变数组中遍历到该条对象，再删除；否则，遍历到该条对象，修改人数和价格
 4、遍历存放所有数据的数组（allData），取出每一条字典里的价格和人数累加起来，算出总数
 
 ps:为什么不用一个数组、一个字典？
 因为，如果用一个可变的字典，那么每次修改完之后都会作为一条新数据添加到数组里
 */

//计算总金额
- (void)calculateTotalAmount:(NSInteger)index number:(NSString *)number roomNum:(int)number1 totalPrice:(NSString *)price andTag:(int)tag cabinDic:(NSDictionary *)dic
{
    NSDictionary *dicDisy = [_cabinArr objectAtIndex:index];
    NSMutableDictionary *alldic = [[NSMutableDictionary alloc] initWithDictionary:dicDisy];
    //减少
    if (tag == 1) {
        if([selectedCabin indexOfObject:dicDisy] != NSNotFound && number1 ==0){
            [selectedCabin removeObjectIdenticalTo:dicDisy];
            
            [allData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
                NSString *typeId = [obj objectForKey:@"cabin_id"];
                if ([typeId isEqualToString:[alldic objectForKey:@"cabin_id"]]){
                    *stop = YES;
                }
                if (*stop == YES) {
                    [allData removeObject:obj];
                }
                
            }];
            
        }else
        {
            for (NSDictionary *typeDic in allData) {
                NSString *typeId = [typeDic objectForKey:@"cabin_id"];
                if ([typeId isEqualToString:[alldic objectForKey:@"cabin_id"]]) {
                    [typeDic setValue:number forKey:@"adult_number"];
                    [typeDic setValue:price forKey:@"totalMoney"];
                }
            }
        }
    }else //增加
    {
        if([selectedCabin indexOfObject:dicDisy] == NSNotFound)
        {
            [selectedCabin addObject:dicDisy];
            
            [alldic setValue:number forKey:@"adult_number"];
            [alldic setValue:price forKey:@"totalMoney"];
            [allData addObject:alldic];
        }else
        {
            for (NSDictionary *typeDic in allData) {
                NSString *typeId = [typeDic objectForKey:@"cabin_id"];
                if ([typeId isEqualToString:[alldic objectForKey:@"cabin_id"]]) {
                    [typeDic setValue:number forKey:@"adult_number"];
                    [typeDic setValue:price forKey:@"totalMoney"];
                }
            }
            
        }
        
    }
    int totalMoney = 0;
    int renshu = 0;
    for (int i = 0; i<allData.count; i++) {
        NSDictionary *dic = [allData objectAtIndex:i];
        NSString *money = [dic objectForKey:@"totalMoney"];
        NSString *ManNum = [dic objectForKey:@"adult_number"];
        totalMoney = [money intValue]+totalMoney;
        renshu = renshu +[ManNum intValue];
    }
    
    totalNumber = [NSString stringWithFormat:@"%d",renshu];
    _totalPrice.text = [NSString stringWithFormat:@"￥%d",totalMoney];
    
    //    selectDic = dic;
    //    totalNumber = number;
    //    _totalPrice.text = [NSString stringWithFormat:@"￥%@",price];
}
@end

@implementation CabinPriceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = frame;
        [self initView];
    }
    return self;
}

- (void)initView
{
    _bottomCabinName = [YXTools allocLabel:@"内舱房" font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(15, 10, (windowContentWidth - 30) / 3.0, 80) textAlignment:0];
    _bottomCabinName.numberOfLines = 0;
    [self addSubview:_bottomCabinName];
    
    _price12 = [YXTools allocLabel:@"第1/2人：￥0.0/人" font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(ViewRight(_bottomCabinName) + 5, ViewY(_bottomCabinName), (windowContentWidth - 30) * 2 / 3.0 - 5, 30) textAlignment:0];
    [self addSubview:_price12];
    
    _price34 = [YXTools allocLabel:@"第3/4成人：￥0.0/人" font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(_price12), ViewY(_price12)+ViewHeight(_price12), ViewWidth(_price12), 30) textAlignment:0];
    [self addSubview:_price12];
    
    self.childPrice34 = [YXTools allocLabel:@"第3/4儿童：￥0.0/人" font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(_price12), ViewBelow(_price34), ViewWidth(_price12), 30) textAlignment:0];
    [self addSubview:_childPrice34];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 100-0.5, windowContentWidth, 0.5)];
    line.backgroundColor = bordColor;
    [self addSubview:line];
    
    //    UILabel *baox = [YXTools allocLabel:@"保险" font:systemFont(15) textColor:[UIColor whiteColor] frame:CGRectMake(ViewX(_bottomCabinName), ViewY(_price34)+ViewHeight(_price34), 100, 30) textAlignment:0];
    //    [_bottomView addSubview:baox];
    //
    //    _baoXian = [YXTools allocLabel:@"￥80*1人" font:systemFont(15) textColor:[UIColor whiteColor] frame:CGRectMake(ViewX(_price12), ViewY(baox), ViewWidth(_price12), 30) textAlignment:2];
    //    [_bottomView addSubview:_baoXian];
    
}
@end
