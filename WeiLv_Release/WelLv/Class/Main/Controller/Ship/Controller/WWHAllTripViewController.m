//
//  WWHAllTrip.m
//  WelLv
//
//  Created by 吴伟华 on 15/12/29.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WWHAllTripViewController.h"
#import "UIImageView+WebCache.h"
#import "ShipLineWebView.h"
#define BLACKCOLOR [UIColor colorWithRed:222/255.0 green:229/255.0 blue:235/255.0 alpha:1]



@interface WWHAllTripViewController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,UIWebViewDelegate>
@property(nonatomic,strong) UITableView *leftTableView;
@property(nonatomic,strong) UITableView *rightTableView;
@property(nonatomic,strong) NSMutableArray *leftDaySarray;
@property(nonatomic,strong) NSMutableArray *rightDaySarray;
@property(nonatomic,strong) NSIndexPath *lastLeftSelectIndexPath;
@property(nonatomic,strong) NSMutableArray *detailHightArray;
@property(nonatomic,assign) NSInteger detailCellCount;
@property(nonatomic,assign) BOOL isLeftTableClick;
@property(nonatomic,strong) NSMutableArray *leftTableDaySarray;
@property(nonatomic,strong) NSMutableArray *seleCellArray;
@property(nonatomic,strong) NSMutableArray *cellHighArray;
@property(nonatomic,strong) NSMutableArray *dayCellHighArray;
@property(nonatomic,strong) NSMutableArray *dayCellDetailHighArray;
@property(nonatomic,strong) NSMutableDictionary *dayCellDetailHighDic;
@property(nonatomic,assign) int allDetailCount;
@property(nonatomic,weak) UILabel *topLabel;
@property(nonatomic,weak) UIView *topView;
@end

@implementation WWHAllTripViewController

#pragma mark -懒加载
-(NSMutableDictionary *)dayCellDetailHighDic
{

    if (_dayCellDetailHighDic == nil) {
        _dayCellDetailHighDic = [NSMutableDictionary dictionary];
    }
    return _dayCellDetailHighDic;

}
-(NSMutableArray *)leftTableDaySarray
{

    if (_leftTableDaySarray == nil) {
        _leftTableDaySarray = [NSMutableArray array];
    }
    return _leftTableDaySarray;

}
-(NSMutableArray *)dayCellDetailHighArray
{

    if (_dayCellDetailHighArray == nil) {
        _dayCellDetailHighArray = [NSMutableArray array];
    }
    return _dayCellDetailHighArray;

}
-(NSMutableArray *)dayCellHighArray
{
    if (_dayCellHighArray == nil) {
        _dayCellHighArray = [NSMutableArray array];
    }
    return _dayCellHighArray;

}
-(NSMutableArray *)cellHighArray
{
    if (_cellHighArray == nil) {
        _cellHighArray = [NSMutableArray array];
    }
    return _cellHighArray;
}
-(NSMutableArray *)seleCellArray
{
    if (_seleCellArray == nil) {
        _seleCellArray = [NSMutableArray array];
    }
    return _seleCellArray;
}
-(NSMutableArray *)detailHightArray
{

    if (_detailHightArray == nil) {
        _detailHightArray = [NSMutableArray array];
    }
    return _detailHightArray;

}
-(NSMutableArray *)leftDaySarray
{
    if (_leftDaySarray == nil) {
        _leftDaySarray = [NSMutableArray array];
    }
    return _leftDaySarray;
}

-(NSMutableArray *)rightDaySarray
{

    if (_rightDaySarray == nil) {
        _rightDaySarray = [NSMutableArray array];
    }
    return _rightDaySarray;
}
-(UITableView *)leftTableView
{
    if (_leftTableView == nil) {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 50, 100) style:UITableViewStylePlain];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_leftTableView];
        
    }
    return _leftTableView;
}
-(UITableView *)rightTableView
{
    if (_rightTableView == nil) {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 50, 100) style:UITableViewStylePlain];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_rightTableView];
    }
    return _rightTableView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"^^^%@", self.allTripDic);
    _allDetailCount = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.detailCellCount = 0;
    [self creatButtomView];//创建底边的删除视图
    [self loaWebView];
}
-(void)loaWebView
{
    
    for (int i = 0; i < self.allTripDic.count; i++) {
        if (i == 0) {
            NSMutableDictionary *selectDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"YES",@"0", nil];
            [self.seleCellArray addObject:selectDic];
        }
        else
        {
            NSMutableDictionary *selectDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"NO",[NSString stringWithFormat:@"%d",i], nil];
            [self.seleCellArray addObject:selectDic];
        }
    }
    [self writeFileArray:self.seleCellArray];
   [self cellHigh];//计算cell的高度

}
#pragma mark -计算右边tableview的cell高度
-(void)cellHigh
{
    
    NSArray *compareAfterAry = [self arrySort];
    [self.leftTableDaySarray removeAllObjects];
    [self.leftTableDaySarray addObjectsFromArray:compareAfterAry];
    
    [self.dayCellHighArray removeAllObjects];
    [self.dayCellDetailHighArray removeAllObjects];
    
    //先计算出所有的detail个数
    _allDetailCount = (int)compareAfterAry.count;
    for (int i = 0; i < compareAfterAry.count; i++) {
        
        NSString *lineStr = compareAfterAry[i];
        NSDictionary *lineDic = self.allTripDic[lineStr];
        if ([lineDic[@"schedule_type"] isEqualToString:@"2"]) {
            NSArray *lineArray = lineDic[@"tour_list"];
            
             //if (!([lineArray isEqual:[NSNull null]] ||lineArray == nil||lineArray.count == 0) ){
                _allDetailCount = _allDetailCount + (int)lineArray.count;
           // }
         }
    }
    
    
    //初始化天数cell的高度
    for (int k = 0; k < compareAfterAry.count; k++) {
        NSString *dayStr = [NSString stringWithFormat:@"%d",k];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"0",dayStr, nil];
        [self.dayCellHighArray addObject:dic];
    }
    //初始化某一天数航线所有cell的高度
    for (int b = 0; b < self.dayCellHighArray.count; b++) {
        NSString *numStr = [NSString stringWithFormat:@"%d",b];
        NSMutableArray *daysArray = [NSMutableArray arrayWithCapacity:0];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:daysArray,numStr, nil];
        [self.dayCellDetailHighArray addObject:dic];
    }
    
    //计算内容高度
    for (int i = 0; i < compareAfterAry.count; i++) {
        
        NSString *htmlstr = self.allTripDic[self.leftTableDaySarray[i]][@"detail"];
        NSString * formatString = @"<span style=\"font-size:14px;color:#808080\">%@</span>";
        NSString * htmlString = [NSString stringWithFormat:formatString,htmlstr];
        ShipLineWebView *detail = [[ShipLineWebView alloc] initWithFrame:CGRectMake(0, -1000, windowContentWidth - 90, 100)];
        detail.tag = 100 + i;
        detail.webViewType = webViewTypeDay;
        [detail loadHTMLString:htmlString baseURL:nil];
        detail.delegate = self;
        [self.view addSubview:detail];

        /*计算cell中的webview高度*/
        NSDictionary *dic = self.allTripDic[self.leftTableDaySarray[i]];
        
         if ([dic[@"schedule_type"] isEqualToString:@"2"])
         {
              if ([dic[@"tour_list"] isKindOfClass:[NSArray class]]) {
                 NSArray *tourListArray = dic[@"tour_list"];
                 for (int a = 0; a < tourListArray.count; a++)
                 {
                     NSDictionary *dic = tourListArray[a];
                     NSString *html = dic[@"detail"];
                     NSString * formatString = @"<span style=\"font-size:14px;color:#808080\">%@</span>";
                     NSString * htmlString = [NSString stringWithFormat:formatString,html];
                     ShipLineWebView *detailWebView = [[ShipLineWebView alloc] initWithFrame:CGRectMake(0, -1000, windowContentWidth - 90, 100)];
                     detailWebView.tag = 1000 + a;
                     detailWebView.webViewType = webViewTypeLine;
                     detailWebView.day = i;
                     [detailWebView loadHTMLString:htmlString baseURL:nil];
                     detailWebView.delegate = self;
                     [self.view addSubview:detailWebView];
                 }
             }
             
             
        }

    }
}
#pragma mark  -时间排序
-(NSArray *)arrySort
{
    NSArray *daysArray = [self.allTripDic allKeys];
    
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
    
    return compareAfterAry;

}
#pragma mark -webView代理
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    static int count = 0;
    count++;
    
    ShipLineWebView *shipLineWebView = (ShipLineWebView *)webView;
    
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    NSString *sizeHeight = [NSString stringWithFormat:@"%f", frame.size.height];
    
    if([sizeHeight floatValue] <= 8){
          sizeHeight = @"20";
    }
    
    if (shipLineWebView.webViewType == webViewTypeDay) {
       NSString *dayStr = [NSString stringWithFormat:@"%ld",shipLineWebView.tag - 100];
        NSDictionary *dayCellHight = [NSDictionary dictionaryWithObjectsAndKeys:sizeHeight,dayStr, nil ];
        [self.dayCellHighArray replaceObjectAtIndex:shipLineWebView.tag - 100 withObject:dayCellHight];

    }
    else
    {
        NSDictionary *cellDic = self.dayCellDetailHighArray[shipLineWebView.day];
        NSMutableArray *arry = cellDic[[NSString stringWithFormat:@"%d",shipLineWebView.day]];
        NSDictionary *cellHighDic = [NSDictionary dictionaryWithObjectsAndKeys:sizeHeight,[NSString stringWithFormat:@"%ld",shipLineWebView.tag - 1000], nil];
        
        [arry insertObject:cellHighDic atIndex:shipLineWebView.tag - 1000];
    }
    
    if (_allDetailCount == count) {
        
        [self calculationAllCellHight];
        count = 0;
    }
    
   // DLog(@"内容高度%f  第%ld个webView %ld",sizeHeight,webView.tag,shipLineWebView.webViewType);
}

//计算天数和观光线路的cell高度
-(void)calculationAllCellHight
{
    
    NSArray *daysArray = [self arrySort];
    
     for (int i = 0; i < daysArray.count; i++) {
      NSDictionary *cellHighDic =  self.dayCellHighArray[i];
      NSString *cellHigh = cellHighDic[[NSString stringWithFormat:@"%d",i]];
        
        //计算cell中的webview高度
        NSDictionary *dic = self.allTripDic[self.leftTableDaySarray[i]];
        NSString *cellHight = nil;
        
        if ([dic[@"schedule_type"] isEqualToString:@"1"]) {
            
            int imageHigh = 0;
            
            id schedule = dic[@"album"];
            
            if (![schedule isEqual:[NSNull null]]) {
                NSArray *imageArray = (NSArray *)schedule;
                imageHigh = imageArray.count > 2?220:110;
            }
            else
            {
                imageHigh = 0;
            }
            cellHight = [NSString stringWithFormat:@"%d",110 + imageHigh + [cellHigh intValue]];
            
        }
        else
        {
            
            int imageHigh = 0;
            id schedule = dic[@"album"];
            if (![schedule isEqual:[NSNull null]]) {
                NSArray *imageArray = (NSArray *)schedule;
                imageHigh = imageArray.count > 2?220:110;
            }
            else
            {
                imageHigh = 0;
            }
            
            
            if ([dic[@"tour_list"] isKindOfClass:[NSArray class]]) {
                int cellLineHigh = 0;
                 NSArray *tourListArray = dic[@"tour_list"];
                for (int a = 0; a < tourListArray.count; a++) {
                    NSDictionary *dic = tourListArray[a];
                    NSMutableDictionary *dayAllCellDic =  self.dayCellDetailHighArray[i];
                    NSMutableArray *cellHighArrat = dayAllCellDic[[NSString stringWithFormat:@"%d",i]];
                    NSDictionary *cellHighDic = cellHighArrat[a];
                    NSString *cellHigh = cellHighDic[[NSString stringWithFormat:@"%d",a]];
                    
                    id schedule = dic[@"album"];
                    
                    if (![schedule isEqual:[NSNull null]]) {
                        NSArray *imageArray = (NSArray *)schedule;
                        imageHigh = imageHigh + (imageArray.count > 2?260:110);
                    }
                    else
                    {
                        imageHigh = imageHigh +  10;
                    }
                    cellLineHigh = cellLineHigh + [cellHigh intValue] + 60;
                }
                cellHight = [NSString stringWithFormat:@"%d",110 + imageHigh + [cellHigh intValue] + cellLineHigh];
            }
            
        }
        [self.cellHighArray addObject:cellHight];
    }
    [self creatLeftTableView];//创建左边tableview
    [self creatRightTableView];//创建右边tableview
}
#pragma mark -定义成方法方便多个label调用 增加代码的复用性
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font andMaxSize:(CGSize)maxSize
{
    CGRect rect = [string boundingRectWithSize:maxSize//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}
#pragma mark -创建底部视图
-(void)creatButtomView
{

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,windowContentHeight - 80 , windowContentWidth, 80)];
    backView.backgroundColor = BLACKCOLOR;
    [self.view addSubview:backView];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.center = CGPointMake(backView.frame.size.width/2.0, backView.frame.size.height/2.0);
    [cancelBtn setImage:[UIImage imageNamed:@"游轮取消"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.bounds = CGRectMake(0, 0, 40, 40);
    [backView addSubview:cancelBtn];


}
#pragma mark -取消按钮
-(void)cancelBtnClick
{
    [self dismissViewControllerAnimated:NO completion:nil];

}
#pragma mark -创建左边视图
-(void)creatLeftTableView
{
    
    self.leftTableView.frame = CGRectMake(0, 60, 80, windowContentHeight - 170);
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.backgroundColor = [UIColor whiteColor];
    [self.leftTableView reloadData];
    
}
#pragma mark -创建右边视图
-(void)creatRightTableView
{
    self.rightTableView.frame = CGRectMake(60, 20, windowContentWidth - 80, windowContentHeight - 80 - 20);
    self.rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rightTableView.backgroundColor = [UIColor whiteColor];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(59, 20, windowContentWidth - 59, 30)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    self.topView = topView;
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, windowContentWidth - 80 - 30, 20)];
    topLabel.numberOfLines = 0;
    [topView addSubview:topLabel];
    
    NSDictionary *dic = self.allTripDic[@"1"];
    NSString *titleStr =  dic[@"title"];
    NSString *dayStr = [NSString stringWithFormat:@"第%@天  %@",self.leftTableDaySarray[0],titleStr];
    topLabel.text = dayStr;
     self.topLabel = topLabel;
    
    UIImageView *dayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 18, 25)];
    dayImageView.image = [UIImage imageNamed:@"天数图片"];
    [topView addSubview:dayImageView];
    
    
}
#pragma mark -tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftTableDaySarray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.leftTableView) {
        static NSString *reusStr = @"leftCell";
        UITableViewCell *leftCell = [tableView dequeueReusableCellWithIdentifier:reusStr];
         if (leftCell == nil) {
            leftCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusStr];
            
            leftCell.separatorInset = UIEdgeInsetsZero;
            leftCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIView *daysView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            daysView.tag = 1000;
            daysView.backgroundColor = BLACKCOLOR;
            [leftCell.contentView addSubview:daysView];
            
            UILabel *daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, 40, 20)];
            daysLabel.textColor = [UIColor colorWithRed:179/255.0 green:190/255.0 blue:199/255.0 alpha:1];
            daysLabel.textAlignment = NSTextAlignmentCenter;
            daysLabel.font = [UIFont systemFontOfSize:16];
            daysLabel.tag = 1001;
            [leftCell.contentView addSubview:daysLabel];
         
           }
        UILabel *daysLabel = (UILabel *)[leftCell viewWithTag:1001];
        UIView *daysView = (UIView *)[leftCell viewWithTag:1000];

        NSArray *selectCellArray = [self getSelectDic];
        NSMutableDictionary *selectCellDic = selectCellArray[indexPath.row];
        NSString *selectCellStr = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        NSString *selectState = selectCellDic[selectCellStr];
        
        if ([selectState isEqualToString:@"YES"]) {
            daysView.backgroundColor = BLACKCOLOR;
            daysLabel.textColor = [UIColor whiteColor];
            _lastLeftSelectIndexPath = indexPath;
        }
        else
        {
            daysView.backgroundColor = BLACKCOLOR;
            daysLabel.textColor = [UIColor colorWithRed:179/255.0 green:190/255.0 blue:199/255.0 alpha:1];
        }
        leftCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *dayStr = [NSString stringWithFormat:@"D%@",self.leftTableDaySarray[indexPath.row]];
        daysLabel.text = dayStr;
        cell = leftCell;
    }
    else
    {
        static NSString *rightStr = @"rightCell";
        UITableViewCell *rightCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightStr];
        
        //没有岸上观光的View
        UIView *noShoreSeeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth - 80, 150)];
        noShoreSeeView.tag = 10;
        [rightCell addSubview:noShoreSeeView];
        
        // NSString *cellHigh = self.cellHighArray[indexPath.row];
        
        NSDictionary *daysDic =self.allTripDic[self.leftTableDaySarray[indexPath.row]];
        
        for (UIView *subView in noShoreSeeView.subviews) {
            [subView removeFromSuperview];
        }
        [noShoreSeeView addSubview:[self loadDaysView:daysDic andFrame:CGRectMake(0, 0, windowContentWidth - 100, 0) andDay:[NSString stringWithFormat:@"%ld",(long)indexPath.row + 1]]];
        
         cell = rightCell;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        return 70;
    }
    else
    {
        NSDictionary *daysDic =self.allTripDic[self.leftTableDaySarray[indexPath.row]];
        if ([daysDic[@"schedule_type"] isEqualToString:@"2"]) {
            return [self.cellHighArray[indexPath.row] intValue] + 50;
        } else {
            return [self.cellHighArray[indexPath.row] intValue];
        }
        
        
    }
    
}
#pragma mark -加载天数view
-(UIView *)loadDaysView:(NSDictionary *)lineDic andFrame:(CGRect)frame andDay:(NSString *)day
{
    UIView *daysView = [[UIView alloc] initWithFrame:frame];
    //显示左边的图片
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 10, 8, 8)];
  
    backImageView.image = [UIImage imageNamed:@"椭圆-26-副本"];

    [daysView addSubview:backImageView];
    //显示第几天
    UILabel *daysLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, windowContentWidth - 80, 20)];
    daysLabel.font = [UIFont systemFontOfSize:16];
    daysLabel.backgroundColor = [UIColor clearColor];
    [daysView addSubview:daysLabel];
    daysLabel.numberOfLines = 0;
    daysLabel.textColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    NSString *detailStr = [NSString stringWithFormat:@"第%@天   %@",day,lineDic[@"title"]];
    
    CGSize labelSize = [self sizeWithString:detailStr font:[UIFont systemFontOfSize:16] andMaxSize:CGSizeMake(windowContentWidth - 95, 1000)];
     daysLabel.frame = CGRectMake(20, 5, windowContentWidth - 95, labelSize.height);
    daysLabel.text = detailStr;
    
     //显示左边的线
    int days = [day intValue];
    int lineH = [self.cellHighArray[days -1] intValue] + 40;

    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(7.5, 0, 0.5, lineH + 40)];
    if ([day isEqualToString:@"1"]) {
        lineLabel.frame = CGRectMake(7.5, 15, 0.5, lineH + 20);
    }
    else
    {
    lineLabel.frame = CGRectMake(7.5, 0, 0.5, lineH + 40);
    }
   
    lineLabel.backgroundColor = TimeGreenColor;
    [daysView addSubview:lineLabel];
    //显示航海时间
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, ViewBelow(daysLabel) + 10, windowContentWidth - 80, 20)];
    timeLabel.font = [UIFont systemFontOfSize:15];
    [daysView addSubview:timeLabel];
    timeLabel.textColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    CGFloat timaeLableHight= 0;
    
    NSString *arrival_timeStr =lineDic[@"arrival_time"];
    NSString *sail_timeStr = lineDic[@"sail_time"];
    
    NSString *lastArrival_timeStr = [arrival_timeStr isEqualToString:@""]?@"":[NSString stringWithFormat:@"%@抵港",arrival_timeStr];
    NSString *lastSail_timeStr = [sail_timeStr isEqualToString:@""]?@"":[NSString stringWithFormat:@"%@启航",sail_timeStr];
    
    if (!([arrival_timeStr isEqualToString:@""] && [sail_timeStr isEqualToString:@""])) {
        timaeLableHight = 12;
        timeLabel.frame = CGRectMake(20, ViewBelow(daysLabel) + 5, windowContentWidth - 80, 20);
        timeLabel.text = [NSString stringWithFormat:@"航海时间: %@   %@",lastArrival_timeStr,lastSail_timeStr];
    }
    else
    {
        timeLabel.text = @"";
        timeLabel.frame = CGRectMake(20, ViewBelow(daysLabel), windowContentWidth - 80, 0);
    }
    
    UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, ViewBelow(timeLabel), windowContentWidth - 95, 35)];
    footLabel.font = [UIFont systemFontOfSize:14];
    footLabel.backgroundColor = [UIColor clearColor];
    footLabel.textColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    [daysView addSubview:footLabel];
    
    footLabel.numberOfLines = 0;
    //显示自助餐
    NSString *breakfastStr = [lineDic[@"breakfast"] isEqualToString:@"1"]?@"含邮轮餐":@"敬请自理";
    NSString *lunchStr = [lineDic[@"lunch"] isEqualToString:@"1"]?@"含邮轮餐":@"敬请自理";
    NSString *dinnerStr = [lineDic[@"dinner"] isEqualToString:@"1"]?@"含邮轮餐":@"敬请自理";
    footLabel.text = [NSString stringWithFormat:@"早餐:%@    午餐:%@    晚餐:%@",breakfastStr,lunchStr,dinnerStr];
    NSDictionary *dayCellDic = self.dayCellHighArray[[day integerValue] - 1];
    
    NSString *cellHighStr = [NSString stringWithFormat:@"%ld",[day integerValue] - 1];
    NSString *cellHigh = dayCellDic[cellHighStr];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, ViewBelow(footLabel), frame.size.width + 15, [cellHigh intValue]+5)];

    webView.scrollView.scrollEnabled = NO;
    [daysView addSubview:webView];
    
    webView.backgroundColor = [UIColor whiteColor];
    NSString *detail = lineDic[@"detail"];
    DLog(@"%@",detail);
    if (detail == nil || [detail isEqualToString:@""]) {
        detail = @"<p>暂无岸上观光详情介绍</p>";
    }
    
    NSString * formatString = @"<span style=\"font-size:14px;color:#808080\">%@</span>";
    
    NSString * htmlString = [NSString stringWithFormat:formatString,detail];
    DLog(@"%@",htmlString);
    [webView loadHTMLString:htmlString baseURL:nil];

    for (UIView *subView in [webView subviews])
    {
        if ([[[subView class] description] isEqualToString:@"UIImageView"])
            subView.hidden = YES;
    }
    webView.opaque=NO;

    id scroller=[webView.subviews objectAtIndex:0];
    for (UIView *subView in [scroller subviews]) {
        if ([[[subView class] description] isEqualToString:@"UIImageView"])
        {
            subView.hidden = YES;
        }
    }
    
    [(UIScrollView *)[[webView subviews] objectAtIndex:0] setBounces:NO];
    
    UIView *imagesView = [[UIView alloc] initWithFrame:CGRectMake(20,ViewBelow(webView) - 5, windowContentWidth - 80, 20)];
    [daysView addSubview:imagesView];
    
            CGFloat imagsViewH  = 0;
            id images = lineDic[@"album"];
            if ([images isEqual:[NSNull null]]) {
                imagsViewH = 0;
                imagesView.hidden = YES;
            }
            else
            {
            imagesView.hidden = NO;
            NSArray *imagesArray = (NSArray *)images;
            if (imagesArray.count > 2) {
                imagsViewH = 220;
            }
            else if (imagesArray.count == 0)
            {
                 imagsViewH = 0;
            }
            else
            {
            imagsViewH = 110;
            }
    
     imagesView.frame = CGRectMake(0,ViewBelow(webView) - 5, windowContentWidth - 80, imagsViewH);
    int cellImgeH = (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)?70:100;
    if (imagesArray) {
                  for (int i = 0; i < imagesArray.count; i++) {
                    if (i == 0) {
                        CGFloat imagewith = (windowContentWidth - 120) /2;
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0 , imagewith, cellImgeH) ];
                        NSString *imageUrl =[NSString stringWithFormat:@"%@%@",WLHTTP,[imagesArray[i] objectForKey:@"picture"]];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];
                        [imagesView addSubview:imageView];
                    }
                    else if (i == 1)
                    {
                        CGFloat imagewith = (windowContentWidth - 120) /2;
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imagewith + 35, 0 , imagewith, cellImgeH) ];
                        NSString *imageUrl =[NSString stringWithFormat:@"%@%@",WLHTTP,[imagesArray[i] objectForKey:@"picture"]];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];
                        [imagesView addSubview:imageView];
                    }
                    else if (i == 2)
                    {
                        CGFloat imagewith = (windowContentWidth - 120) /2;
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, cellImgeH + 10 , imagewith, cellImgeH) ];
                        NSString *imageUrl =[NSString stringWithFormat:@"%@%@",WLHTTP,[imagesArray[i] objectForKey:@"picture"]];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];
                        [imagesView addSubview:imageView];
                    }
                    else
                    {
                        CGFloat imagewith = (windowContentWidth - 120) /2;
                        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imagewith + 35, cellImgeH + 10 , imagewith, cellImgeH) ];
                        NSString *imageUrl =[NSString stringWithFormat:@"%@%@",WLHTTP,[imagesArray[i] objectForKey:@"picture"]];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];
                        [imagesView addSubview:imageView];
                    }
                }
                
            }
     }
    int publick_Y = ViewBelow(imagesView);//记录行程天数某一个View的Y值
    int default_line_high = 0;//表示岸上观光某一个view的高度
    if ([lineDic[@"schedule_type"] isEqualToString:@"2"]) {
        
        NSArray *tourListArray = lineDic[@"tour_list"];
        for (int i = 0; i < tourListArray.count; i++) {
            
            NSDictionary *dic = tourListArray[i];
            
            NSMutableDictionary *dayAllCellDic =  self.dayCellDetailHighArray[[day integerValue] - 1];
            
            NSMutableArray *cellHighArrat = dayAllCellDic[[NSString stringWithFormat:@"%ld",[day integerValue] - 1]];
            
            NSDictionary *cellHighDic = cellHighArrat[i];
            NSString *cellHigh = cellHighDic[[NSString stringWithFormat:@"%d",i]];
            
            id imagesArray = dic[@"album"];
            CGFloat imagsViewH  = 0;

            if (![imagesArray isEqual:[NSNull null]]) {
                NSArray *imagesArrays = (NSArray *)imagesArray;
                if (imagesArrays.count == 2 || imagesArrays.count == 1) {
                    imagsViewH = 110;
                }
                else if (imagesArrays.count == 0)
                {
                    imagsViewH = 0;
                 
                }
                else
                {
                    imagsViewH = 220;
                  
                }
            }
            default_line_high = imagsViewH + [cellHigh intValue] + 60;
            float sectionY = i == 0?0:30;
            
            UIView *view = [self loadLineView:dic andFrame:CGRectMake(0,publick_Y + sectionY, frame.size.width, default_line_high) day:day andCell:i];
            
            publick_Y = ViewBelow(view);
            
            [daysView addSubview:view];
        }
    }
    
    return daysView;
}

#pragma mark -加载观光路线view
-(UIView *)loadLineView:(NSDictionary *)lineDic andFrame:(CGRect)frame day:(NSString *)day andCell:(int)cell
{
    
    UIView *lineView = [[UIView alloc] initWithFrame:frame];

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 18, 6, 6)];
    imageView.image = [UIImage imageNamed:@"椭圆-26-副本"];
    
    [lineView addSubview:imageView];
    
    NSString *titleAndMoneyStr = nil;
    if ([lineDic[@"fee_status"]  isEqualToString:@"1"]) {
        titleAndMoneyStr = [NSString stringWithFormat:@"%@        免费",lineDic[@"tour_name"]];
    }
    else
    {
        titleAndMoneyStr = [NSString stringWithFormat:@"%@        ￥%@",lineDic[@"tour_name"],lineDic[@"tour_price"]];
        
    }
    
    CGSize labelSize = [self sizeWithString:titleAndMoneyStr font:[UIFont systemFontOfSize:16] andMaxSize:CGSizeMake(frame.size.width + 5, 1000)];
    
    UILabel *lineLable = [YXTools allocLabel:titleAndMoneyStr font:[UIFont systemFontOfSize:14] textColor:[UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1] frame:CGRectMake(30,0,frame.size.width - 8, labelSize.height) textAlignment:NSTextAlignmentLeft];
    
    [lineView addSubview:lineLable];
    
    UILabel *footLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, ViewBelow(lineLable), frame.size.width - 20, 35)];
    
    //显示自助餐
    NSString *breakfastStr = [lineDic[@"breakfast"] isEqualToString:@"1"]?@"含邮轮餐":@"敬请自理";
    NSString *lunchStr = [lineDic[@"lunch"] isEqualToString:@"1"]?@"含邮轮餐":@"敬请自理";
    NSString *dinnerStr = [lineDic[@"dinner"] isEqualToString:@"1"]?@"含邮轮餐":@"敬请自理";
    footLabel.backgroundColor = [UIColor clearColor];
    footLabel.font = [UIFont systemFontOfSize:14];
    footLabel.textColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    footLabel.numberOfLines = 0;
//    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
//        footLabel.frame = CGRectMake(20, 35, frame.size.width - 20, 40);
//    }
    footLabel.text = [NSString stringWithFormat:@"早餐:%@    午餐:%@    晚餐:%@",breakfastStr,lunchStr,dinnerStr];
     [lineView addSubview:footLabel];
    
     NSMutableDictionary *dayAllCellDic =  self.dayCellDetailHighArray[[day integerValue] - 1];
    
    NSMutableArray *cellHighArrat = dayAllCellDic[[NSString stringWithFormat:@"%ld",[day integerValue] - 1]];
    
    NSDictionary *cellHighDic = cellHighArrat[cell];
    NSString *cellHigh = cellHighDic[[NSString stringWithFormat:@"%d",cell]];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, ViewBelow(footLabel), frame.size.width + 15, [cellHigh intValue] + 5)];
    webView.backgroundColor = [UIColor clearColor];
    webView.scrollView.scrollEnabled = NO;
    [lineView addSubview:webView];
    NSString *detail = lineDic[@"detail"];
    if (detail == nil || [detail isEqualToString:@""]) {
        detail = @"<p>暂无岸上观光详情介绍</p>";
    }
    
    NSString * formatString = @"<span style=\"font-size:14px;color:#808080\">%@</span>";
    
    NSString * htmlString = [NSString stringWithFormat:formatString,detail];
    [webView loadHTMLString:htmlString baseURL:nil];
    
    
    
     UIView *imagesView = [[UIView alloc] initWithFrame:CGRectMake(20, ViewBelow(webView), windowContentWidth - 100, 20)];
    [lineView addSubview:imagesView];
    
    CGFloat imagsViewH  = 0;
    
    
    id images = lineDic[@"album"];
    
    if ([images isEqual:[NSNull null]]) {
        imagsViewH = 0;
        imagesView.hidden = YES;
    }
    else
    {
        imagesView.hidden = NO;
        NSArray *imagesArray = (NSArray *)images;
        
        
        if (imagesArray.count > 2 ) {
            imagsViewH =  (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)?140:220;
        }
        else if (imagesArray.count == 0)
        {
            
            imagsViewH = 0;
        }
        else
        {
            imagsViewH =  (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)?70:110;
        }
        
        imagesView.frame = CGRectMake(0,ViewBelow(webView) , windowContentWidth - 100, imagsViewH);
        
       int  cellImage = (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)?70:100;
        if (imagesArray) {
            for (int i = 0; i < imagesArray.count; i++) {
                if (i == 0) {
                    CGFloat imagewith = (windowContentWidth - 120) /2;
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0 , imagewith, cellImage) ];
                    NSString *imageUrl =[NSString stringWithFormat:@"%@%@",WLHTTP,[imagesArray[i] objectForKey:@"picture"]];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];
                    [imagesView addSubview:imageView];
                }
                else if (i == 1)
                {
                CGFloat imagewith = (windowContentWidth - 120) /2;
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imagewith + 35, 0 , imagewith, cellImage) ];
                NSString *imageUrl =[NSString stringWithFormat:@"%@%@",WLHTTP,[imagesArray[i] objectForKey:@"picture"]];
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];
                [imagesView addSubview:imageView];
                }
                else if (i == 2)
                {
                    CGFloat imagewith = (windowContentWidth - 120) /2;
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, cellImage + 10 , imagewith, cellImage) ];
                    NSString *imageUrl =[NSString stringWithFormat:@"%@%@",WLHTTP,[imagesArray[i] objectForKey:@"picture"]];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];
                    [imagesView addSubview:imageView];
                }
                else
                {
                    CGFloat imagewith = (windowContentWidth - 120) /2;
                    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imagewith + 35, cellImage + 10 , imagewith, cellImage) ];
                    NSString *imageUrl =[NSString stringWithFormat:@"%@%@",WLHTTP,[imagesArray[i] objectForKey:@"picture"]];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];
                    [imagesView addSubview:imageView];
                }
            }
            
        }
    }
    
    
    return lineView;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        self.isLeftTableClick = YES;
        UITableViewCell *lastSelectCell = [tableView cellForRowAtIndexPath:_lastLeftSelectIndexPath];
        UIView *lastDaysView = (UIView *)[lastSelectCell.contentView viewWithTag:1000];
        UILabel *lastDaysLabel = (UILabel *)[lastSelectCell.contentView viewWithTag:1001];
        lastDaysView.backgroundColor = BLACKCOLOR;
        lastDaysLabel.textColor = [UIColor colorWithRed:179/255.0 green:190/255.0 blue:199/255.0 alpha:1];
        
        
        UITableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
        UIView *daysView = (UIView *)[selectCell.contentView viewWithTag:1000];
        UILabel *daysLabel = (UILabel *)[selectCell.contentView viewWithTag:1001];
        daysView.backgroundColor = [UIColor colorWithRed:112/255.0 green:212/255.0 blue:128/255.0 alpha:1];
        daysLabel.textColor = [UIColor whiteColor];
        
        _lastLeftSelectIndexPath = indexPath;
        
        for (int i = 0; i < self.seleCellArray.count; i++) {
            NSMutableDictionary *selectDic = self.seleCellArray[i];
            NSString *cellStr = [NSString stringWithFormat:@"%d",i];
            if (i == indexPath.row) {
                [selectDic setValue:@"YES" forKey:cellStr];
            }
            else
            {
            [selectDic setValue:@"NO" forKey:cellStr];
            }
        }
        [self writeFileArray:self.seleCellArray];
        [self.rightTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
     }
    else
    {
    
    }

}
#pragma mark -过滤html标签
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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (self.isLeftTableClick) {
        UITableViewCell *lastSelectCell = [(UITableView *)scrollView cellForRowAtIndexPath:_lastLeftSelectIndexPath];
        UIView *lastDaysView = (UIView *)[lastSelectCell.contentView viewWithTag:1000];
        UILabel *lastDaysLabel = (UILabel *)[lastSelectCell.contentView viewWithTag:1001];
        lastDaysView.backgroundColor = BLACKCOLOR;
        lastDaysLabel.textColor = [UIColor colorWithRed:179/255.0 green:190/255.0 blue:199/255.0 alpha:1];
        self.isLeftTableClick = NO;
    }

    else
    {
        NSArray *arr=[self.rightTableView indexPathsForVisibleRows];
        NSIndexPath *index=arr[0];
        UITableViewCell *lastSelectCell = [self.leftTableView cellForRowAtIndexPath:_lastLeftSelectIndexPath];
        UIView *lastDaysView = (UIView *)[lastSelectCell.contentView viewWithTag:1000];
        UILabel *lastDaysLabel = (UILabel *)[lastSelectCell.contentView viewWithTag:1001];
        lastDaysView.backgroundColor = BLACKCOLOR;
        lastDaysLabel.textColor = [UIColor colorWithRed:179/255.0 green:190/255.0 blue:199/255.0 alpha:1];
        
        
        UITableViewCell *selectCell = [self.leftTableView cellForRowAtIndexPath:index];
        UIView *daysView = (UIView *)[selectCell.contentView viewWithTag:1000];
        UILabel *daysLabel = (UILabel *)[selectCell.contentView viewWithTag:1001];
        daysView.backgroundColor = [UIColor colorWithRed:112/255.0 green:212/255.0 blue:128/255.0 alpha:1];
        daysLabel.textColor = [UIColor whiteColor];
        
        _lastLeftSelectIndexPath = index;
        
        if (!(self.leftTableView == (UITableView *)scrollView)) {
            if (index.row > 0) {
                NSIndexPath *netIndex = [NSIndexPath indexPathForRow:index.row - 1 inSection:0];
                [self.leftTableView scrollToRowAtIndexPath:netIndex atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
            }
        }
        

    }
    
    NSString *day  = [NSString stringWithFormat:@"%d",(int)_lastLeftSelectIndexPath.row + 1];
    NSDictionary *dic = self.allTripDic[day];
    NSString *titleStr = [NSString stringWithFormat:@"第%@天  %@",day,dic[@"title"]];
    
    CGSize labelSize = [self sizeWithString:titleStr font:[UIFont systemFontOfSize:18] andMaxSize:CGSizeMake(windowContentWidth - 80 - 30, 1000)];
    self.topLabel.frame = CGRectMake(30, 5, windowContentWidth - 80 - 30, labelSize.height);
    self.topView.frame = CGRectMake(59, 20, windowContentWidth - 59, labelSize.height + 5);
    NSString *dayStr = titleStr;

    self.topLabel.text = dayStr;
 }
#pragma mark -读取tableviewcell的选中状态
-(NSArray *)getSelectDic
{
    NSArray *resultArray = [NSArray arrayWithContentsOfFile:[self pathFileFileDic]];
    return resultArray;
}
#pragma mark -写入tableviewcell的选中状态
- (void)writeFileArray:(NSMutableArray *)resultArray
{
    NSString *filePath = [self pathFileFileDic];
    [resultArray writeToFile:filePath atomically:YES];
}

- (NSAttributedString *)priceStr:(NSString *)str {
    return [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<span style=\"font-size:14px;color:#808080\">%@</span>", [self judgeReturnString:str withReplaceString:@"0.00"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
}

#pragma mark -获取路径
-(NSString *)pathFileFileDic
{
    
    NSString *documentFile = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    documentFile =  [documentFile stringByAppendingString:@"cellState"];
    return documentFile;
}


@end
