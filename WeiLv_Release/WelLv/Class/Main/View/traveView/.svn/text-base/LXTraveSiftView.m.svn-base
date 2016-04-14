//
//  LXTraveSiftView.m
//  WelLv
//
//  Created by lx on 15/8/4.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#define CustomGray [UIColor colorWithRed:240/255.0 green:246/255.0 blue:251/255.0 alpha:1]

#import "LXTraveSiftView.h"

@implementation LXTraveSiftView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void)dealloc{
//    _maskView.hidden=YES;
//    _compositeTable.hidden=YES;
//    _leftSiftTable.hidden=YES;
//}

-(id)initWithFrame:(CGRect)frame traveType:(NSInteger)traveTpye
{
    self= [super initWithFrame:frame];
    if (self) {
        _traveType=traveTpye;
       // NSLog(@"%ld",(long)_traveType);
        [self initData];
        [self initView];
    }
    return self;
}

-(void)initData
{
    _destinationTableLastPath=nil;
    
    _selectSiftType=1;
    _siftNameArray=[[NSMutableArray alloc] initWithObjects:@"综合",@"筛选", nil];
    _compositeInfoArray=[[NSMutableArray alloc] initWithObjects:@"综合",@"销量",@"价格从低到高",@"价格从高到低", nil];
    _compositeImageArray=[[NSMutableArray alloc] initWithObjects:@"综合",@"销量",@"从低到高",@"从高到低", nil];
    _leftSiftImageArray=[[NSMutableArray alloc] initWithObjects:@"价格选中",@"出行天数",@"目的地", nil];
    if (_traveType==5) {
        _leftSiftTableArray = [[NSMutableArray alloc] initWithObjects:@"价格区间", nil];
    }else if (_traveType==6){
        _leftSiftTableArray = [[NSMutableArray alloc] initWithObjects:@"价格区间",@"行程天数", nil];
    }else if (_traveType==7){
        _leftSiftTableArray = [[NSMutableArray alloc] initWithObjects:@"价格区间",@"行程天数",@"目的省份", nil];
    }else if (_traveType==8){
        _leftSiftTableArray = [[NSMutableArray alloc] initWithObjects:@"价格区间",@"行程天数",@"目的国家", nil];
    }else if (_traveType==9){
        _leftSiftTableArray = [[NSMutableArray alloc] initWithObjects:@"价格区间",@"行程天数",@"目的城市", nil];
    }else if (_traveType==10){
        _leftSiftTableArray = [[NSMutableArray alloc] initWithObjects:@"价格区间",@"行程天数",@"目的国家", nil];
    }else if (_traveType==0)
    {
       _leftSiftTableArray = [[NSMutableArray alloc] initWithObjects:@"价格区间",@"行程天数",@"目的国家", nil];
    }
    

    _priceArray=[[NSMutableArray alloc] initWithObjects:@"0-500",@"501-2000",@"2001-5000",@"5000-10000",@"10000-20000",@"2万以上", nil];
}

-(void)initView
{
    for (int i=0; i<_siftNameArray.count; i++)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame=CGRectMake(windowContentWidth/_siftNameArray.count*i, 0, windowContentWidth/_siftNameArray.count, ViewHeight(self));
        [btn setTitle:[_siftNameArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:13];
        btn.titleLabel.textAlignment=1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i+1;
        [self addSubview:btn];
    }
    UIView *lineView1=[[UIView alloc] initWithFrame:CGRectMake(windowContentWidth/2, 10, 0.5, 30)];
    lineView1.backgroundColor=[UIColor orangeColor];
    [self addSubview:lineView1];
    
    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self)-0.5, windowContentWidth, 0.5)];
    lineView.backgroundColor=TableLineColor;
    [self addSubview:lineView];
    
    _window=[UIApplication sharedApplication].keyWindow;
    _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self)+64, windowContentWidth, windowContentHeight)];
    _maskView.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.8];
    _maskView.userInteractionEnabled=YES;
    _maskView.hidden=YES;
    [_window addSubview:_maskView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMask)];
    [_maskView addGestureRecognizer:tap];
    
    //综合table
    _compositeTable=[[UITableView alloc] initWithFrame:CGRectMake(0, ViewHeight(self)+64, windowContentWidth, _compositeInfoArray.count*40) style:UITableViewStylePlain];
    _compositeTable.delegate=self;
    _compositeTable.dataSource=self;
    _compositeTable.hidden=YES;
    [_window addSubview:_compositeTable];
    
    //左边筛选table
    _leftSiftTable=[[UITableView alloc] initWithFrame:CGRectMake(0, ViewHeight(self)+64, windowContentWidth/3, windowContentHeight/2) style:UITableViewStylePlain];
    _leftSiftTable.delegate=self;
    _leftSiftTable.dataSource=self;
    _leftSiftTable.hidden=YES;
    _leftSiftTable.backgroundColor=CustomGray;
    _leftSiftTable.separatorStyle = UITableViewCellSeparatorStyleNone;//不显示分割线
    [_window addSubview:_leftSiftTable];
    //默认选中第一个cell
    [self selectFirstCell];
    
    
    //价格
    _priceTable=[[UITableView alloc] initWithFrame:CGRectMake(ViewWidth(_leftSiftTable)+ViewX(_leftSiftTable), ViewHeight(self)+64, windowContentWidth*2/3, ViewHeight(_leftSiftTable)) style:UITableViewStylePlain];
    _priceTable.delegate=self;
    _priceTable.dataSource=self;
    _priceTable.hidden=YES;
    _priceTable.backgroundColor=[UIColor whiteColor];
    //_rightSiftTable.separatorStyle = UITableViewCellSeparatorStyleNone;//不显示分割线
    [_window addSubview:_priceTable];
    
    //日程
    _daysTable=[[UITableView alloc] initWithFrame:CGRectMake(ViewWidth(_leftSiftTable)+ViewX(_leftSiftTable), ViewHeight(self)+64, windowContentWidth*2/3, ViewHeight(_leftSiftTable)) style:UITableViewStylePlain];
    _daysTable.delegate=self;
    _daysTable.dataSource=self;
    _daysTable.hidden=YES;
    _daysTable.backgroundColor=[UIColor whiteColor];
    //_rightSiftTable.separatorStyle = UITableViewCellSeparatorStyleNone;//不显示分割线
    [_window addSubview:_daysTable];
    
    //目的地
    _destinationTable=[[UITableView alloc] initWithFrame:CGRectMake(ViewWidth(_leftSiftTable)+ViewX(_leftSiftTable), ViewHeight(self)+64, windowContentWidth*2/3, ViewHeight(_leftSiftTable)) style:UITableViewStylePlain];
    _destinationTable.delegate=self;
    _destinationTable.dataSource=self;
    _destinationTable.hidden=YES;
    _destinationTable.backgroundColor=[UIColor whiteColor];
    //_rightSiftTable.separatorStyle = UITableViewCellSeparatorStyleNone;//不显示分割线
    [_window addSubview:_destinationTable];
    
    
    [self createResetBtn];
    
    if ([_compositeTable respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_compositeTable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_compositeTable respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_compositeTable setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
}
/**
 *  默认选中第一个cell
 */
-(void)selectFirstCell
{
//    _priceTable.dataSource=self;
//    _priceTable.delegate=self;
   
    NSInteger selectedIndex = 0;
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    [_leftSiftTable selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

-(void)createResetBtn
{
    _resetView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(_leftSiftTable)+ViewHeight(_leftSiftTable), windowContentWidth, 50)];
    _resetView.backgroundColor=CustomGray;
    _resetView.hidden=YES;
    [_window addSubview:_resetView];
    
    UIButton *resetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    resetBtn.frame=CGRectMake(10, 5, (windowContentWidth-30)*0.4, 40);
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    resetBtn.backgroundColor=kColor(132, 146, 155);
    [resetBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    resetBtn.tag=3;
    resetBtn.layer.cornerRadius=3;
    [_resetView addSubview:resetBtn];
    
    UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame=CGRectMake(ViewX(resetBtn)+ViewWidth(resetBtn)+10, 5, (windowContentWidth-30)*0.6, 40);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.backgroundColor=kColor(54, 152, 254);
    [sureBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    sureBtn.tag=4;
    sureBtn.layer.cornerRadius=3;
    [_resetView addSubview:sureBtn];
}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag==1) {
        if (_compositeTable.hidden==YES) {
            _maskView.hidden=NO;
            _compositeTable.hidden=NO;
            _leftSiftTable.hidden=YES;
            _resetView.hidden=YES;
            //_rightSiftTable.hidden=YES;
            _priceTable.hidden=YES;
            _daysTable.hidden=YES;
            _destinationTable.hidden=YES;
        }else{
            
            [self All_Hidden_Yes];
        }
    }else if (btn.tag==2){
        
        if (_leftSiftTable.hidden==YES) {
            _maskView.hidden=NO;
            _leftSiftTable.hidden=NO;
            _compositeTable.hidden=YES;
            _resetView.hidden=NO;
            //_rightSiftTable.hidden=NO;
            _priceTable.hidden=NO;
            _daysTable.hidden=YES;
            _destinationTable.hidden=YES;
            [_leftSiftTable reloadData];
            _priceArray=[[NSMutableArray alloc] initWithObjects:@"0-500",@"501-2000",@"2001-5000",@"5000-10000",@"10000-20000",@"2万以上", nil];
            [_priceTable reloadData];
        }else{

            [self All_Hidden_Yes];
        }
    }else if (btn.tag==3)
    {
        _priceTabLastPath=nil;
        _dayTabLastPath=nil;
        _destinationTableLastPath=nil;
        
        //重置按钮
        [_priceTable reloadData];
        [_daysTable reloadData];
        [_destinationTable reloadData];
        _selectPrice=nil;
        _selectDays=nil;
        _selectDestination=nil;
        
    }else if (btn.tag==4)
    {
        //确定按钮
        DLog(@"价格--%@，天数-%@，目的地-%@",_selectPrice,_selectDays,_selectDestination);
        [self All_Hidden_Yes];
        if (self.siftccInfoBlock) {
            self.siftccInfoBlock(_selectPrice,_selectDays,_selectDestination);
        }
    }
}

-(void)tapMask
{
    [self All_Hidden_Yes];
}

-(void)All_Hidden_Yes
{
    _maskView.hidden=YES;
    _compositeTable.hidden=YES;
    _leftSiftTable.hidden=YES;
    _resetView.hidden=YES;
    //_rightSiftTable.hidden=YES;
    _priceTable.hidden=YES;
    _daysTable.hidden=YES;
    _destinationTable.hidden=YES;
    
    //默认选中第一个cell
    [self selectFirstCell];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_compositeTable) {
        return _compositeInfoArray.count;
    }if (tableView==_leftSiftTable)
    {
        return _leftSiftTableArray.count;
    }if (tableView== _priceTable)
    {
        return _priceArray.count;
       
    }if (tableView==_daysTable) {
        return _daysArray.count;
    }if (tableView==_destinationTable) {
        return _destinationArray.count;
    }
    
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_compositeTable) {
        static NSString *CellIdentifier1 = @"cellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        cell.imageView.image=[UIImage imageNamed:[_compositeImageArray objectAtIndex:indexPath.row]];
        cell.textLabel.text=[_compositeInfoArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:13];
        return cell;
    }else if (tableView==_leftSiftTable){
        static NSString *CellIdentifier1 = @"cellIdentifier2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            //cell.selectionStyle=UITableViewCellSelectionStyleNone;
           
            //cell未选中时背景色
            cell.backgroundColor=CustomGray;
            cell.textLabel.textColor=kColor(137, 146, 158);
            cell.textLabel.highlightedTextColor=[UIColor orangeColor];
            cell.textLabel.font=[UIFont systemFontOfSize:13];
            
            //选中状态是白色
            cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
            
            //cell.imageView.image=[UIImage imageNamed:[_leftSiftImageArray objectAtIndex:indexPath.row]];
            
        }
        cell.textLabel.text=[_leftSiftTableArray objectAtIndex:indexPath.row];
        return cell;
    }else if (tableView==_priceTable || _daysTable || _destinationTable) {
        static NSString *CellIdentifier1 = @"cellIdentifier3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            cell.accessoryView=rigthImage;
            cell.textLabel.font=[UIFont systemFontOfSize:13];
        }
        
        if ((tableView==_priceTable &&_priceTabLastPath==indexPath) ||
            (tableView==_daysTable &&_dayTabLastPath==indexPath) ||
            (tableView==_destinationTable &&_destinationTableLastPath==indexPath)) {
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"选中圆圈"];
            cell.accessoryView=rigthImage;
        }else
        {
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            cell.accessoryView=rigthImage;
        }
        
        if (tableView==_priceTable) {
            cell.textLabel.text=[_priceArray objectAtIndex:indexPath.row];
        }
        if (tableView==_daysTable) {
            cell.textLabel.text=[_daysArray objectAtIndex:indexPath.row];
        }
        if (tableView==_destinationTable) {
            cell.textLabel.text=[_destinationArray objectAtIndex:indexPath.row];
        }
        
        
       
        return cell;
    }else{
        static NSString *CellIdentifier1 = @"cellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_compositeTable) {
        UIButton *btn=(UIButton *)[self viewWithTag:1];
        [btn setTitle:[_compositeInfoArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        if (self.compositeInfo) {
            self.compositeInfo([_compositeInfoArray objectAtIndex:indexPath.row]);
        }
        
        [self tapMask];
    }else if (tableView == _leftSiftTable)
    {
        _selectSiftType=indexPath.row+1;
        if (indexPath.row==0) {
            //_rightSiftTableArray=[[NSMutableArray alloc] initWithObjects:@"0-500",@"501-2000",@"2001-5000",@"5000-10000",@"10000-20000",@"2万以上", nil];
            _priceArray=[[NSMutableArray alloc] initWithObjects:@"0-500",@"501-2000",@"2001-5000",@"5000-10000",@"10000-20000",@"2万以上", nil];
            _daysTable.hidden=YES;
            _destinationTable.hidden=YES;
            _priceTable.hidden=NO;
            
            //避免table滚动时切换到别的类型崩溃
//            _priceTable.dataSource=self;
//            _priceTable.delegate=self;
//            _daysTable.dataSource=nil;
//            _daysTable.delegate=nil;
//            _destinationTable.dataSource=nil;
//            _destinationTable.delegate=nil;
            
             [_priceTable reloadData];
            
        }
        if (indexPath.row==1) {
            //_rightSiftTableArray=[[NSMutableArray alloc] initWithObjects:@"1-2天",@"3-5天",@"6-8天",@"8-15天", nil];
            _daysArray=[[NSMutableArray alloc] initWithObjects:@"1-2天",@"3-5天",@"6-8天",@"8-15天", nil];
            _priceTable.hidden=YES;
            _destinationTable.hidden=YES;
            _daysTable.hidden=NO;
            
            
            
//            _daysTable.dataSource=self;
//            _daysTable.delegate=self;
//            _priceTable.dataSource=nil;
//            _priceTable.delegate=nil;
//            _destinationTable.dataSource=nil;
//            _destinationTable.delegate=nil;
            
            [_daysTable reloadData];
        }
        if (indexPath.row==2) {
            //目的地
            if (_traveType==7) {
//                _rightSiftTableArray=[[NSMutableArray alloc] initWithObjects:@"北京",@"上海",@"天津",@"重庆",@"河北",@"山西",@"山东",@"内蒙古",@"黑龙江",@"吉林",@"辽宁",@"湖南",@"湖北",@"河南",@"江西",@"江苏",@"浙江",@"安徽",@"广东",@"广西",@"福建",@"云南",@"贵州",@"四川",@"西藏",@"陕西",@"甘肃",@"青海",@"新疆",@"宁夏", nil];
                _destinationArray=[[NSMutableArray alloc] initWithObjects:@"北京",@"上海",@"天津",@"重庆",@"河北",@"山西",@"山东",@"内蒙古",@"黑龙江",@"吉林",@"辽宁",@"湖南",@"湖北",@"河南",@"江西",@"江苏",@"浙江",@"安徽",@"广东",@"广西",@"福建",@"云南",@"贵州",@"四川",@"西藏",@"陕西",@"甘肃",@"青海",@"新疆",@"宁夏", nil];
            }
            if (_traveType==8) {
                //_rightSiftTableArray=[[NSMutableArray alloc] initWithObjects:@"日本",@"韩国",@"泰国",@"普吉岛",@"澳大利亚",@"巴厘岛",@"菲律宾",@"柬埔寨",@"马来西亚",@"文莱",@"新加坡",@"越南",@"印尼",@"泰国",@"缅甸",@"巴厘岛",@"普吉岛",@"沙巴",@"苏梅岛",@"沙美岛",@"塞班岛",@"马尔代夫",@"夏威夷",@"斯里兰卡",@"斐济",@"大溪地",@"毛里求斯",@"塞舌尔",@"薄荷岛",@"日本",@"韩国",@"朝鲜",@"法国",@"瑞士",@"意大利",@"德国",@"英国",@"北欧",@"俄罗斯",@"希腊",@"奥地利",@"冰岛",@"美国",@"加拿大",@"墨西哥",@"迪拜",@"土耳其",@"埃及",@"南非",@"肯尼亚",@"坦桑尼亚",@"澳大利亚",@"新西兰", nil];
                _destinationArray=[[NSMutableArray alloc] initWithObjects:@"菲律宾",@"柬埔寨",@"马来西亚",@"文莱",@"新加坡",@"越南",@"印尼",@"泰国",@"缅甸",@"巴厘岛",@"普吉岛",@"沙巴",@"苏梅岛",@"沙美岛",@"塞班岛",@"马尔代夫",@"夏威夷",@"斯里兰卡",@"斐济",@"大溪地",@"毛里求斯",@"塞舌尔",@"薄荷岛",@"日本",@"韩国",@"朝鲜",@"法国",@"瑞士",@"意大利",@"德国",@"英国",@"北欧",@"俄罗斯",@"希腊",@"奥地利",@"冰岛",@"美国",@"加拿大",@"墨西哥",@"迪拜",@"土耳其",@"埃及",@"南非",@"肯尼亚",@"坦桑尼亚",@"澳大利亚",@"新西兰", nil];
               
            }
            if (_traveType==9) {
                //_rightSiftTableArray=[[NSMutableArray alloc] initWithObjects:@"香港",@"澳门",@"台湾", nil];
                _destinationArray=[[NSMutableArray alloc] initWithObjects:@"香港",@"澳门",@"台湾", nil];
            }
            if (_traveType==10) {
                //_rightSiftTableArray=[[NSMutableArray alloc] initWithObjects:@"日本",@"韩国",@"泰国",@"普吉岛",@"澳大利亚",@"巴厘岛",@"菲律宾",@"柬埔寨",@"马来西亚",@"文莱",@"新加坡",@"越南",@"印尼",@"泰国",@"缅甸",@"巴厘岛",@"普吉岛",@"沙巴",@"苏梅岛",@"沙美岛",@"塞班岛",@"马尔代夫",@"夏威夷",@"斯里兰卡",@"斐济",@"大溪地",@"毛里求斯",@"塞舌尔",@"薄荷岛",@"日本",@"韩国",@"朝鲜",@"法国",@"瑞士",@"意大利",@"德国",@"英国",@"北欧",@"俄罗斯",@"希腊",@"奥地利",@"冰岛",@"美国",@"加拿大",@"墨西哥",@"迪拜",@"土耳其",@"埃及",@"南非",@"肯尼亚",@"坦桑尼亚",@"澳大利亚",@"新西兰", nil];
                _destinationArray=[[NSMutableArray alloc] initWithObjects:@"菲律宾",@"柬埔寨",@"马来西亚",@"文莱",@"新加坡",@"越南",@"印尼",@"泰国",@"缅甸",@"巴厘岛",@"普吉岛",@"沙巴",@"苏梅岛",@"沙美岛",@"塞班岛",@"马尔代夫",@"夏威夷",@"斯里兰卡",@"斐济",@"大溪地",@"毛里求斯",@"塞舌尔",@"薄荷岛",@"日本",@"韩国",@"朝鲜",@"法国",@"瑞士",@"意大利",@"德国",@"英国",@"北欧",@"俄罗斯",@"希腊",@"奥地利",@"冰岛",@"美国",@"加拿大",@"墨西哥",@"迪拜",@"土耳其",@"埃及",@"南非",@"肯尼亚",@"坦桑尼亚",@"澳大利亚",@"新西兰", nil];
            }if (_traveType==0) {
                _destinationArray=[[NSMutableArray alloc] initWithObjects:@"菲律宾",@"柬埔寨",@"马来西亚",@"文莱",@"新加坡",@"越南",@"印尼",@"泰国",@"缅甸",@"巴厘岛",@"普吉岛",@"沙巴",@"苏梅岛",@"沙美岛",@"塞班岛",@"马尔代夫",@"夏威夷",@"斯里兰卡",@"斐济",@"大溪地",@"毛里求斯",@"塞舌尔",@"薄荷岛",@"日本",@"韩国",@"朝鲜",@"法国",@"瑞士",@"意大利",@"德国",@"英国",@"北欧",@"俄罗斯",@"希腊",@"奥地利",@"冰岛",@"美国",@"加拿大",@"墨西哥",@"迪拜",@"土耳其",@"埃及",@"南非",@"肯尼亚",@"坦桑尼亚",@"澳大利亚",@"新西兰", nil]; 
            }
            
            _priceTable.hidden=YES;
            _daysTable.hidden=YES;
            _destinationTable.hidden=NO;
            
            
//            _destinationTable.dataSource=self;
//            _destinationTable.delegate=self;
//            _priceTable.dataSource=nil;
//            _priceTable.delegate=nil;
//            _daysTable.dataSource=nil;
//            _daysTable.delegate=nil;
            [_destinationTable reloadData];
        }
        
        //[_rightSiftTable reloadData];
        
    }
    else if (tableView == _priceTable )
    {
        
        if (_priceTabLastPath==indexPath) {
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_priceTabLastPath];
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            lastCell.accessoryView=rigthImage;
            
            _selectPrice=nil;
            _priceTabLastPath=nil;
           
            
        }else{
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_priceTabLastPath];
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            lastCell.accessoryView=rigthImage;
            
            //当前单元格
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            UIImageView *rigthImage1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage1.image=[UIImage imageNamed:@"选中圆圈"];
            cell.accessoryView=rigthImage1;
            
            _priceTabLastPath=indexPath;
            
            
            _selectPrice=[_priceArray objectAtIndex:indexPath.row];
            
           
        }
        [_priceTable reloadData];
        
    }
    else if (tableView == _daysTable )
    {
        
        if (_dayTabLastPath==indexPath) {
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_dayTabLastPath];
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            lastCell.accessoryView=rigthImage;
            
            _selectDays=nil;
            _dayTabLastPath=nil;
            
            
        }else{
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_dayTabLastPath];
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            lastCell.accessoryView=rigthImage;
            
            //当前单元格
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            UIImageView *rigthImage1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage1.image=[UIImage imageNamed:@"选中圆圈"];
            cell.accessoryView=rigthImage1;
            
            _dayTabLastPath=indexPath;
            
            
            _selectDays=[_daysArray objectAtIndex:indexPath.row];
            
            
        }
        [_daysTable reloadData];
        
    }
    else if (tableView == _destinationTable)
    {
        
        if (_destinationTableLastPath==indexPath) {
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_destinationTableLastPath];
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            lastCell.accessoryView=rigthImage;
            
            _selectDestination=nil;
            _destinationTableLastPath=nil;
            
            
        }else{
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_destinationTableLastPath];
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            lastCell.accessoryView=rigthImage;
            
            //当前单元格
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            UIImageView *rigthImage1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            rigthImage1.image=[UIImage imageNamed:@"选中圆圈"];
            cell.accessoryView=rigthImage1;
            
            _destinationTableLastPath=indexPath;
            
            
            _selectDestination=[_destinationArray objectAtIndex:indexPath.row];
            
            
        }
        
        [_destinationTable reloadData];
       
    }
    
}

-(void)returnCompositeBlock:(compositeBlock)CompositeBlock infoBlock:(siftInfoBlock)infoBlock
{
    self.compositeInfo=CompositeBlock;
    self.siftccInfoBlock=infoBlock;
}

@end
