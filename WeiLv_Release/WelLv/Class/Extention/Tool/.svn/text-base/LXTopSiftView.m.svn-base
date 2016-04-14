//
//  LXTopSiftView.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/21.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define cellHeight 40
#define CustomGray [UIColor colorWithRed:240/255.0 green:246/255.0 blue:251/255.0 alpha:1]
#import "LXTopSiftView.h"
#import "LXGetCityIDTool.h"
#import "LXTopSiftViewCell.h"
@implementation LXTopSiftView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)dealloc
{
    [self btnHidden_Yes];
    [_daysTable removeFromSuperview];
    [_priceTable removeFromSuperview];
    [_maskView removeFromSuperview];
    [_contentTable removeFromSuperview];
    [_mudidiLeftTable removeFromSuperview];
}



-(id)initWithFrame:(CGRect)frame nameArray:(NSMutableArray *)siftNameArray InfoArray:(NSMutableArray *)siftInfoArray mudidiType:(NSInteger)mudidiType
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor=[UIColor whiteColor];
        _siftNameArray = siftNameArray;
        _siftInfoArray = siftInfoArray;
        _maskIsShow=NO;
        _selectBtnID=0;
        _mudidiType=mudidiType;
        DLog(@"%ld",_mudidiType);
        _selectDays=-1;
        _selectPrice=-1;
        _selectPriceAndDay=1;
        if (mudidiType==2)
        {
            _priceAndDaysLeftArray=@[@"价格",@"天数"];
            //出境，境外参团
            _mudidiLeftArray=@[@"热门",@"东南亚",@"海岛",@"日韩",@"欧洲",@"美洲",@"中东非",@"大洋洲"];
            NSArray* hotArray=@[@"日本",@"韩国",@"泰国",@"普吉岛",@"澳大利亚",@"巴厘岛"];
            NSArray* dongnanyaArray=@[@"菲律宾",@"柬埔寨",@"马来西亚",@"文莱",@"新加坡",@"越南",@"印尼",@"泰国",@"缅甸"];
            NSArray* haidaoArray=@[@"巴厘岛",@"普吉岛",@"沙巴",@"苏梅岛",@"沙美岛",@"塞班岛",@"马尔代夫",@"夏威夷",@"斯里兰卡",@"斐济",@"大溪地",@"毛里求斯",@"塞舌尔",@"薄荷岛"];
            NSArray* rihanArray=@[@"日本",@"韩国",@"朝鲜"];
            NSArray* ouzhouArray=@[@"法国",@"瑞士",@"意大利",@"德国",@"英国",@"北欧",@"俄罗斯",@"希腊",@"奥地利",@"冰岛"];
            NSArray* meizhouArray=@[@"美国",@"加拿大",@"墨西哥"];
            NSArray* zhongdongfeiArray=@[@"迪拜",@"土耳其",@"埃及",@"南非",@"肯尼亚",@"坦桑尼亚"];
            NSArray* dayangzhouArray=@[@"澳大利亚",@"新西兰"];
            
            
            _contentMudidiArray=[[NSMutableArray alloc] initWithObjects:hotArray,dongnanyaArray,haidaoArray,rihanArray,ouzhouArray,meizhouArray,zhongdongfeiArray,dayangzhouArray, nil];
            
            
        }
        else if (mudidiType==3)
        {
            _priceAndDaysLeftArray=@[@"价格",@"天数"];
            //国内游
            _mudidiLeftArray=@[@"热门",@"东北",@"华北",@"华中",@"华东",@"华南",@"西南",@"西北"];
            NSArray *hotArray=@[@"云南",@"三亚",@"厦门",@"桂林",@"北京",@"西安",@"哈尔滨",@"海口"];
            NSArray *dongbeiArray=@[@"黑龙江",@"吉林",@"辽宁"];
            NSArray *huabeiArray=@[@"北京",@"内蒙古",@"天津",@"河北",@"山西",@"山东"];
            NSArray *huazhogArray=@[@"湖南",@"湖北",@"河南",@"江西"];
            NSArray *huadongArray=@[@"江苏",@"上海",@"浙江",@"安徽"];
            NSArray *huananArray=@[@"广东",@"广西",@"福建"];
            NSArray *xinanArray=@[@"云南",@"贵州",@"四川",@"重庆",@"西藏"];
            NSArray *xibeiArray=@[@"陕西",@"甘肃",@"青海",@"新疆",@"宁夏"];
            
            
            _contentMudidiArray=[[NSMutableArray alloc] initWithObjects:hotArray,dongbeiArray,huabeiArray,huazhogArray,huadongArray,huananArray,xinanArray,xibeiArray, nil];
        }
        else if(mudidiType == 4)
        {
            //一日游
            _priceAndDaysLeftArray=@[@"价格"];
        }
        else if(mudidiType==1 || mudidiType==5)
        {
            //周边港澳
            _priceAndDaysLeftArray=@[@"价格",@"天数"];
        }
        
        NSArray *priceArray=@[@"0-500",@"501-2000",@"2001-5000",@"5000-10000",@"10000-20000",@"2万以上"];
        NSArray *daysArray=@[@"1-2天",@"3-5天",@"6-8天",@"8-15天"];
        
        _priceAndDaysArray=[[NSMutableArray alloc] initWithObjects:priceArray,daysArray, nil];
        
        [self initView];
    }
    return self;


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
    _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self)+64, windowContentWidth, 0)];
    _maskView.backgroundColor=[UIColor colorWithWhite:0.1 alpha:0.8];
    _maskView.userInteractionEnabled=YES;
    [_window addSubview:_maskView];
    _resetView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+240+ViewHeight(self), windowContentWidth, 50)];
    _resetView.backgroundColor=[UIColor whiteColor];
    _resetView.hidden=YES;
    [_window addSubview:_resetView];

    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMask)];
    [_maskView addGestureRecognizer:tap];
    
    _contentTable=[[UITableView alloc] initWithFrame:CGRectMake(0, ViewHeight(self)+64, windowContentWidth, 0) style:UITableViewStylePlain];
    _contentTable.delegate=self;
    _contentTable.dataSource=self;
    [_window addSubview:_contentTable];
    
    if ([_contentTable respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_contentTable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_contentTable respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [_contentTable setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
    _mudidiLeftTable=[[UITableView alloc] initWithFrame:CGRectMake(0, ViewHeight(self)+64, windowContentWidth/4, 0)];
    _mudidiLeftTable.delegate=self;
    _mudidiLeftTable.dataSource=self;
    _mudidiLeftTable.tableFooterView=[[UIView alloc] init];
    _mudidiLeftTable.backgroundColor=CustomGray;
    _mudidiLeftTable.separatorStyle = UITableViewCellSeparatorStyleNone;//不显示分割线
    if ([_mudidiLeftTable respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_mudidiLeftTable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_mudidiLeftTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [_mudidiLeftTable setLayoutMargins:UIEdgeInsetsZero];
    }

    [_window addSubview:_mudidiLeftTable];
        
    
    [self createPriceView];
    
}

-(void)btnClick:(UIButton *)btn
{
    switch (btn.tag)
    {
        case 1:
        {
            
            _siftInfoArray=[[NSMutableArray alloc] initWithObjects:@"销量",@"价格由高到低",@"价格由低到高", nil];
            //销量
            if (_maskIsShow==NO)
            {
                //展开
                _selectBtnID=1;
                [self tableState:isShow];
            }else if(_maskIsShow == YES && _selectBtnID==1)
            {
                [self tableState:isCloose];
            }
            else
            {
                
                _selectBtnID=1;
                [self tableState:Reload];
            }
            
        }
            break;
            
        case 2:
        {
            if (_siftNameArray.count==2)
            {
            _siftInfoArray=[[NSMutableArray alloc] initWithArray:[_priceAndDaysArray objectAtIndex:0]];
                //筛选
                if (_maskIsShow==NO)
                {
                    //[self createPriceView];
                    //展开
                    _selectBtnID=2;
                    [self tableState:isShow];
                }else if(_maskIsShow == YES && _selectBtnID==2)
                {
                    [self tableState:isCloose];
                    _lastIndexPath=nil;
                }
                else
                {
                    _selectBtnID=2;
                    [self tableState:Reload];
                }
            }
            else
            {
                if (_mudidiType==2)
                {
                    //出境，境外参团
                    _siftInfoArray=[_contentMudidiArray objectAtIndex:0];
                }else if (_mudidiType==3)
                {
                    //国内游
                    _siftInfoArray=[_contentMudidiArray objectAtIndex:0];
                }
                else if (_mudidiType==5)
                {
                    _siftInfoArray=[[NSMutableArray alloc] initWithObjects:@"香港",@"澳门",@"台湾", nil];
                }
                
                //目的地
                if (_maskIsShow==NO)
                {
                    //展开
                    _selectBtnID=2;
                    [self tableState:isShow];
                }else if(_maskIsShow == YES && _selectBtnID==2)
                {
                    [self tableState:isCloose];
                }
                else
                {
                    _selectBtnID=2;
                    [self tableState:Reload];
                }

                
            }
        }
            break;
            
        case 3:
        {
            _siftInfoArray=[[NSMutableArray alloc] initWithArray:[_priceAndDaysArray objectAtIndex:0]];
            
            //筛选
            if (_maskIsShow==NO)
            {
                //[self createPriceView];
                //展开
                _selectBtnID=3;
                [self tableState:isShow];
            }else if(_maskIsShow == YES && _selectBtnID==3)
            {
                [self tableState:isCloose];
            }
            else
            {
                _selectBtnID=3;
                [self tableState:Reload];
            }
            
        }
            break;
            
        case 4:
        {
            
            _siftInfoArray=[[NSMutableArray alloc] initWithArray:[_priceAndDaysArray objectAtIndex:0]];
            
            //筛选
            if (_maskIsShow==NO)
            {
                //[self createPriceView];
                //展开
                _selectBtnID=4;
                [self tableState:isShow];
            }else if(_maskIsShow == YES && _selectBtnID==4)
            {
                [self tableState:isCloose];
            }
            else
            {
                _selectBtnID=4;
                [self tableState:Reload];
            }
            
        }
            break;
            
            case 5:
        {
         //重置
            UITableViewCell *priceCell=[_priceTable cellForRowAtIndexPath:_priceIndexPath];
            priceCell.textLabel.textColor=[UIColor blackColor];
            priceCell.backgroundColor=[UIColor whiteColor];
            
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            
            priceCell.accessoryView=rigthImage;
           
            
            UITableViewCell *dayCell=[_daysTable cellForRowAtIndexPath:_dayIndexPath];
            dayCell.textLabel.textColor=[UIColor blackColor];
            dayCell.backgroundColor=[UIColor whiteColor];
            UIImageView *rigthImage1=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            rigthImage1.image=[UIImage imageNamed:@"未选中圆圈"];
            dayCell.accessoryView=rigthImage1;
            
            _selectPrice=-1;
            _selectDays=-1;
            //[_priceTable reloadData];
            //[_daysTable reloadData];
        }
            break;
            
        case 6:
        {
            //确定
            [self tapMask];
            DLog(@"%ld",_selectPrice);
            DLog(@"%ld",_selectDays);
            DLog(@"%ld",_priceIndexPath.row);
            DLog(@"%ld",_dayIndexPath.row);
            if (_selectPrice>-1&&_selectDays>-1)
            {
                DLog(@"选择的价格==%@",[[_priceAndDaysArray objectAtIndex:0] objectAtIndex:_selectPrice]);
                if (self.infoBlock)
                {
                    self.infoBlock([[_priceAndDaysArray objectAtIndex:0] objectAtIndex:_selectPrice],[[_priceAndDaysArray objectAtIndex:1] objectAtIndex:_selectDays]);
                }
                
            }else  if(_selectPrice>-1&&_selectDays==-1){
                self.infoBlock([[_priceAndDaysArray objectAtIndex:0] objectAtIndex:_selectPrice],@"1");
            }else if(_selectPrice==-1&&_selectDays>-1)
            {
                self.infoBlock(@"1",[[_priceAndDaysArray objectAtIndex:1] objectAtIndex:_selectDays]);
            }else{
                return;
            }
//            if (_selectDays>-1) {
//                DLog(@"选择的天数==%@",[[_priceAndDaysArray objectAtIndex:1] objectAtIndex:_selectDays]);
//                if (self.dayBlock!=nil)
//                {
//                    self.dayBlock([[_priceAndDaysArray objectAtIndex:1] objectAtIndex:_selectDays]);
//                }
//            }else{
//                return;
//            }
//            
            
        }
            break;
            
        default:
            break;
    }
    _lastBtnID=_selectBtnID;
    
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
    [_mudidiLeftTable selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark 处理表的状态
-(void)tableState:(TableState)tableState
{
    switch (tableState)
    {
        case isShow:
        {
            UIButton *btn=(UIButton *)[self viewWithTag:_selectBtnID];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            _maskIsShow=YES;
            [UIView animateWithDuration:0.0 animations:^{
                _maskView.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth, windowContentHeight);
                if ((_mudidiType==2 || _mudidiType==3) && _selectBtnID==2)
                {
                    //出境，境外参团，国内
                    _mudidiLeftTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth/4, _mudidiLeftArray.count*cellHeight);
                    _contentTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable)-2, ViewHeight(self)+64, windowContentWidth-ViewWidth(_mudidiLeftTable), ViewHeight(_mudidiLeftTable));
                    //[_mudidiLeftTable reloadData];
                    [self selectFirstCell];
                    
                }
                else if ((_selectBtnID==2 && _siftNameArray.count==2) || (_selectBtnID==3 && _siftNameArray.count==3))
                {

                    _mudidiLeftTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth/4, _siftInfoArray.count*cellHeight);
                   
                    _daysTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable)-2, ViewHeight(self)+64, windowContentWidth-ViewWidth(_mudidiLeftTable), _siftInfoArray.count*cellHeight);
                    _daysTable.hidden=YES;
                    _priceTable.hidden=NO;
                    _priceTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable)-2, ViewHeight(self)+64, windowContentWidth-ViewWidth(_mudidiLeftTable), _siftInfoArray.count*cellHeight);
                    DLog(@"%@",[_priceTable subviews]);
                    _resetBtn.frame=CGRectMake(10, 5, (windowContentWidth-30)*0.4, 40);
                    _affirmBtn.frame=CGRectMake(ViewRight(_resetBtn)+10, 5, (windowContentWidth-30)*0.6, 40);
                    
                    [self btnHidden_No];
                    [_daysTable reloadData];
                    [_priceTable reloadData];
                    
                    [_mudidiLeftTable reloadData];
                }
                else
                {
                    _contentTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth, _siftInfoArray.count*cellHeight);
                }
                
            } completion:^(BOOL finished) {
                
            }];
        }
            break;
            
        case isCloose:
        {
            UIButton *btn=(UIButton *)[self viewWithTag:_selectBtnID];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            _maskIsShow=NO;
            [UIView animateWithDuration:0.0 animations:^{
                _maskView.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth, 0);
                if ((_mudidiType==2 || _mudidiType==3) && _selectBtnID==2)
                {
                    _mudidiLeftTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth/4, 0);
                    _contentTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth, 0);
                }
                else if ((_selectBtnID==2 && _siftNameArray.count==2) || (_selectBtnID==3 && _siftNameArray.count==3))
                {

                    _mudidiLeftTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth/4,0);
                    _priceTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth, 0);
                    _daysTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth, 0);
                    _resetBtn.frame=CGRectMake(10, 5, (windowContentWidth-30)*0.4, 40);
                    _affirmBtn.frame=CGRectMake(ViewRight(_resetBtn)+10, 5, (windowContentWidth-30)*0.6, 40);
                    [self btnHidden_Yes];
                }
                else
                {
                    _contentTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth, 0);
                }
                
            } completion:^(BOOL finished) {
            
                
            }];
        }
            break;
            
        case Reload:
        {
            UIButton *btn=(UIButton *)[self viewWithTag:_selectBtnID];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            
            UIButton *lastBtn=(UIButton *)[self viewWithTag:_lastBtnID];
            [lastBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            if ((_mudidiType==2 || _mudidiType==3) && _selectBtnID==2)
            {
                

                _mudidiLeftTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth/4, _mudidiLeftArray.count*cellHeight);
                _contentTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth, ViewHeight(_mudidiLeftTable));
                _priceTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth, 0);
                _daysTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth, 0);
                _resetBtn.frame=CGRectMake(10, 5, (windowContentWidth-30)*0.4, 40);
                _affirmBtn.frame=CGRectMake(ViewRight(_resetBtn)+10,5, (windowContentWidth-30)*0.6, 40);
                [self btnHidden_Yes];
                
            }
            else if ((_selectBtnID==2 && _siftNameArray.count==2) || (_selectBtnID==3 && _siftNameArray.count==3))
            {

                _mudidiLeftTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth/4, _siftInfoArray.count*cellHeight);
                _priceTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth-ViewWidth(_mudidiLeftTable), ViewHeight(_mudidiLeftTable));
                _daysTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth-ViewWidth(_mudidiLeftTable), ViewHeight(_mudidiLeftTable));
                _resetBtn.frame=CGRectMake(10, 5, (windowContentWidth-30)*0.4, 40);
                _affirmBtn.frame=CGRectMake(ViewRight(_resetBtn)+10, 5, (windowContentWidth-30)*0.6, 40);
                _contentTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth, 0);
                [self btnHidden_No];
                [_daysTable reloadData];
                [_priceTable reloadData];
                
                [_mudidiLeftTable reloadData];
            }
            else
            {
                //没有左边
                _mudidiLeftTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth/4, 0);
                _contentTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth, _siftInfoArray.count*cellHeight);
                _priceTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth, 0);
                _daysTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth, 0);
                [self btnHidden_Yes];
            
            }
            
            
            
        }
            break;
            
        default:
            break;
    }
    
    [_mudidiLeftTable reloadData];
    [_contentTable reloadData];
}

-(void)btnHidden_Yes
{
    _resetBtn.hidden=YES;
    _affirmBtn.hidden=YES;
    _resetView.hidden=YES;
    _leftLastIndexPath=nil;
}

-(void)btnHidden_No
{
    _resetBtn.hidden=NO;
    _affirmBtn.hidden=NO;
    _resetView.hidden=NO;
    [self selectFirstCell];
}


-(void)createPriceView
{
    
    _daysTable=[[UITableView alloc] init];
    _daysTable.frame=CGRectMake(windowContentWidth/4, ViewHeight(self)+64, 3*windowContentWidth/4, 0);
    _daysTable.delegate=self;
    _daysTable.dataSource=self;
    
    if ([_daysTable respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_daysTable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_daysTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [_daysTable setLayoutMargins:UIEdgeInsetsZero];
    }
    _daysTable.tableFooterView=[[UIView alloc] init];
    [_window addSubview:_daysTable];
    
    _priceTable=[[UITableView alloc] init];
    _priceTable.frame=CGRectMake(windowContentWidth/4, ViewHeight(self)+64, 3*windowContentWidth/4, 0);
    _priceTable.delegate=self;
    _priceTable.dataSource=self;
    _priceTable.tableFooterView=[[UIView alloc] init];
    if ([_priceTable respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [_priceTable setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([_priceTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [_priceTable setLayoutMargins:UIEdgeInsetsZero];
    }

    [_window addSubview:_priceTable];
    

    _resetBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _resetBtn.frame=CGRectMake(10, 5, (windowContentWidth-30)*0.4, 40);
    [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [_resetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _resetBtn.backgroundColor=kColor(132, 146, 155);
    _resetBtn.tag=5;
    _resetBtn.layer.cornerRadius=3;
    [_resetBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_resetView addSubview:_resetBtn];
    
    _affirmBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    _affirmBtn.frame=CGRectMake(ViewRight(_resetBtn)+10, 5, (windowContentWidth-30)*0.6, 40);
    [_affirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_affirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _affirmBtn.backgroundColor=kColor(54, 152, 254);
    _affirmBtn.tag=6;
    _affirmBtn.layer.cornerRadius=3;
    [_affirmBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_resetView addSubview:_affirmBtn];
    [self btnHidden_Yes];


    
}



-(void)tapMask
{
    if (_selectBtnID!=0)
    {
        UIButton *btn=(UIButton *)[self viewWithTag:_selectBtnID];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    
    _maskIsShow=NO;
    [UIView animateWithDuration:0.0 animations:^{
        _maskView.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth, 0);
        if ((_mudidiType==2 || _mudidiType==3) && _selectBtnID==2)
        {
            _mudidiLeftTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth/4, 0);
            _contentTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth, 0);
        }
        else if ((_selectBtnID==2 && _siftNameArray.count==2) || (_selectBtnID==3 && _siftNameArray.count==3))
        {
            
            _mudidiLeftTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth/4,0);
            _priceTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth, 0);
            _daysTable.frame=CGRectMake(ViewWidth(_mudidiLeftTable), ViewHeight(self)+64, windowContentWidth, 0);
            _resetBtn.frame=CGRectMake(10, ViewY(_mudidiLeftTable)+ViewHeight(_mudidiLeftTable), windowContentWidth/4, 40);
            _affirmBtn.frame=CGRectMake(ViewRight(_resetBtn)+10, ViewY(_mudidiLeftTable)+ViewHeight(_mudidiLeftTable), windowContentWidth-ViewRight(_resetBtn)-10, 40);
            [self btnHidden_Yes];
        }
        else
        {
            _contentTable.frame=CGRectMake(0, ViewHeight(self)+64, windowContentWidth, 0);
        }
        
    } completion:^(BOOL finished) {
        
        
    }];

}


-(void)returnSifyIDBlock:(siftTypeBlock)typeBlock infoBlock:(siftInfoBlock)infoBlock
{
    self.typeBlock=typeBlock;
    self.infoBlock=infoBlock;
    //self.dayBlock=dayBlock;
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_contentTable)
    {
        return _siftInfoArray.count;
    }
    else if (tableView==_priceTable || tableView==_daysTable)
    {
        return _siftInfoArray.count;
    }
    else
    {
        if (_siftNameArray.count==2)
        {
            //筛选
            return _priceAndDaysLeftArray.count;
            

        }
        else
        {
            //目的地
            if (_selectBtnID==2)
            {
                return _mudidiLeftArray.count;
            }
            else
            {
                return _priceAndDaysLeftArray.count;
            }
        }
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_contentTable)
    {
        static NSString *CellIdentifier0 = @"cellIdentifier0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier0];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.text=[_siftInfoArray objectAtIndex:indexPath.row];
        
        return cell;
    }
    else if(tableView == _mudidiLeftTable)
    {
        static NSString *CellIdentifier1 = @"cellIdentifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.backgroundColor= CustomGray;
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.textLabel.textColor=[UIColor blackColor];
        if (_selectBtnID==2 && _siftNameArray.count==3)
        {
            cell.textLabel.text=[_mudidiLeftArray objectAtIndex:indexPath.row];
           cell.textLabel.textColor=[UIColor blackColor];
                //当前单元格
                //UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
                //cell.textLabel.textColor=[UIColor orangeColor];
            
                //cell.backgroundColor=[UIColor whiteColor];
                
                //_leftLastIndexPath=indexPath;
            
            
        }
        if ((_selectBtnID==2 && _siftNameArray.count==2) || (_selectBtnID==3 && _siftNameArray.count==3))
        {
            cell.textLabel.text=[_priceAndDaysLeftArray objectAtIndex:indexPath.row];
            cell.textLabel.textColor=[UIColor blackColor];
//            if (indexPath.row==0) {
//                //当前单元格
//                //UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
//                cell.textLabel.textColor=[UIColor orangeColor];
//                cell.backgroundColor=[UIColor whiteColor];
//                
//                _leftLastIndexPath=indexPath;
//            }
            
        }
        
        return cell;
        
    }
    else if(tableView == _priceTable)
    {
        //价格筛选列表
        static NSString *CellIdentifier2 = @"cellIdentifier2";
        LXTopSiftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil)
        {
           
            
            cell = [[LXTopSiftViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
            
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
            if (_priceIndexPath==indexPath) {
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"选中圆圈"];
            cell.accessoryView=rigthImage;
          
            
        }else{
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            cell.accessoryView=rigthImage;
        }
        cell.backgroundColor=[UIColor whiteColor];
        //cell.textLabel.font=[UIFont systemFontOfSize:14];
        cell.leftLabel.text=[_siftInfoArray objectAtIndex:indexPath.row];
        //cell.detailTextLabel.backgroundColor=[UIColor greenColor];
        return cell;
        
    }
    else if(tableView == _daysTable)
    {
        //天数筛选列表
        static NSString *CellIdentifier3 = @"cellIdentifier3";
        LXTopSiftViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell2 == nil)
        {
            cell2 = [[LXTopSiftViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.accessoryType=UITableViewCellAccessoryNone;

        }
        if (_dayIndexPath==indexPath) {
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"选中圆圈"];
            cell2.accessoryView=rigthImage;
        }else{
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            cell2.accessoryView=rigthImage;
        }

        cell2.backgroundColor=[UIColor whiteColor];
        cell2.leftLabel.font=[UIFont systemFontOfSize:14];
        
        cell2.leftLabel.text=[_siftInfoArray objectAtIndex:indexPath.row];
        
        return cell2;
        
    }
   return nil;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView==_contentTable) {
        if ((_selectBtnID!=2 && _siftNameArray.count==2) || (_selectBtnID!=3 && _siftNameArray.count==3))
        {
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:indexPath];
            lastCell.textLabel.textColor=[UIColor blackColor];
            lastCell.backgroundColor=[UIColor grayColor];
            
            UIButton *btn=(UIButton *)[self viewWithTag:_selectBtnID];
            [btn setTitle:[_siftInfoArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            [self tableState:isCloose];
            
//            //获取目的地id
//            if (_mudidiType==2)
//            {
//                //出境，境外参团
//                [[LXGetCityIDTool sharedMyTools] getT_cityID:[_siftInfoArray objectAtIndex:indexPath.row] region_type:@"1"];
//                
//            }else if (_mudidiType==3)
//            {
//                //国内游
//                [[LXGetCityIDTool sharedMyTools] getT_cityID:[_siftInfoArray objectAtIndex:indexPath.row] region_type:@"2"];
//            }
//            else if (_mudidiType==5)
//            {
//                //港澳台
//                [[LXGetCityIDTool sharedMyTools] getT_cityID:[_siftInfoArray objectAtIndex:indexPath.row] region_type:@"2"];
//            }
            
            //利用block返回筛选内容
            if (self.typeBlock!=nil)
            {
                self.typeBlock([_siftInfoArray objectAtIndex:indexPath.row]);
            }
            
            
            
        }else
        {
            if (_lastIndexPath!=indexPath)
            {
                DLog(@"选择新的单元格");
                //当前单元格
                UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
                cell.textLabel.textColor=[UIColor orangeColor];
                cell.backgroundColor=[UIColor whiteColor];
//                UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//                rigthImage.image=[UIImage imageNamed:@"选中圆圈"];
//                cell.accessoryView=rigthImage;

                
                
                //上一次点击的单元格
                UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_lastIndexPath];
                lastCell.textLabel.textColor=[UIColor blackColor];
                lastCell.backgroundColor=[UIColor whiteColor];
//                UIImageView *rigthImage1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//                rigthImage1.image=[UIImage imageNamed:@"未选中圆圈"];
//                cell.accessoryView=rigthImage1;

                
                _lastIndexPath=indexPath;
//                if (_selectPriceAndDay==1)
//                {
//                    _selectPrice=indexPath.row;
//                }else
//                {
//                    _selectDays=indexPath.row;
//                }
                
            }
            else
            {
                DLog(@"选择当前单元格");
            }
            
        }
        
    }
    else if (tableView==_mudidiLeftTable)
    {
        
        if (_leftLastIndexPath!=indexPath)
        {
            //选择左边列表。右边列表刷新
            if (_selectBtnID==2 && _siftNameArray.count==3)
            {
                _siftInfoArray=[_contentMudidiArray objectAtIndex:indexPath.row];
                [_contentTable reloadData];
                
            }
             if ((_selectBtnID==2 && _siftNameArray.count==2) || (_selectBtnID==3 && _siftNameArray.count==3))
            {
                _siftInfoArray=[_priceAndDaysArray objectAtIndex:indexPath.row];
                if (indexPath.row==0)
                {
                    
//                    _priceTable.alpha=1;
//                    _daysTable.alpha=1;
                    _priceTable.hidden=NO;
                    [_priceTable reloadData];
                    
                }
                else
                {
                    DLog(@"1123");
                    _priceTable.hidden=YES;
                     _daysTable.hidden=NO;
                    [_daysTable reloadData];
                }
                
            }
            else
            {
                [_contentTable reloadData];
            }
            
            
            //当前单元格
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            cell.textLabel.textColor=[UIColor orangeColor];
            cell.backgroundColor=[UIColor whiteColor];
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_leftLastIndexPath];
            lastCell.textLabel.textColor=[UIColor blackColor];
            lastCell.backgroundColor=CustomGray;
            _leftLastIndexPath=indexPath;
            
            _selectPriceAndDay=indexPath.row+1;

        }
        else
        {
            
            
        }
        
        
    }
    else if(tableView==_priceTable)
    {
        
        if (_priceIndexPath==indexPath) {
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_priceIndexPath];
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            //rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            lastCell.accessoryView=rigthImage;
            
            _selectPrice=-1;
            _priceIndexPath=nil;
            
            
        }else{
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_priceIndexPath];
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            //rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            lastCell.accessoryView=rigthImage;
            
            //当前单元格
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            UIImageView *rigthImage1=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            //rigthImage1.image=[UIImage imageNamed:@"选中圆圈"];
            cell.accessoryView=rigthImage1;
            
            _priceIndexPath=indexPath;
            _selectPrice=indexPath.row;
            DLog(@"%ld",_selectPrice);
            _selectPriceAndDay=1;
            
//            if (self.infoBlock!=nil)
//            {
//            self.infoBlock([[_priceAndDaysArray objectAtIndex:0] objectAtIndex:indexPath.row]);
      //  }

            //_selectPrice=[_priceArray objectAtIndex:indexPath.row];
            
            
        }
        [_priceTable reloadData];

        
        
        //价格和天数筛选列表
//        if (_priceIndexPath!=indexPath)
//        {
//            DLog(@"选择新的单元格%@",_priceIndexPath);
//            //当前单元格
//            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
//            cell.textLabel.textColor=[UIColor orangeColor];
//            cell.backgroundColor=[UIColor whiteColor];
//            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//            rigthImage.image=[UIImage imageNamed:@"选中圆圈"];
//            cell.accessoryView=rigthImage;
//
//            
//            //上一次点击的单元格
//            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_priceIndexPath];
//            lastCell.textLabel.textColor=[UIColor blackColor];
//            lastCell.backgroundColor=[UIColor whiteColor];
//            UIImageView *rigthImage1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
//            rigthImage1.image=[UIImage imageNamed:@"未选中圆圈"];
//            cell.accessoryView=rigthImage1;
//            [_priceTable reloadData];
//            
//            _priceIndexPath=indexPath;
//            
//            
//            
//        }
//        else
//        {
//            DLog(@"选择当前单元格");
//        }
        
    }
    else if(tableView==_daysTable)
    {
        if (_dayIndexPath==indexPath) {
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_dayIndexPath];
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            lastCell.accessoryView=rigthImage;
            
            _selectPrice=-1;
            _dayIndexPath=nil;
            
            
        }else{
            //上一次点击的单元格
            UITableViewCell *lastCell=[tableView cellForRowAtIndexPath:_dayIndexPath];
            UIImageView *rigthImage=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            rigthImage.image=[UIImage imageNamed:@"未选中圆圈"];
            lastCell.accessoryView=rigthImage;
            
            //当前单元格
            UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
            UIImageView *rigthImage1=[[UIImageView alloc] initWithFrame:CGRectMake(-2, 0, 20, 20)];
            rigthImage1.image=[UIImage imageNamed:@"选中圆圈"];
            cell.accessoryView=rigthImage1;
            
            _dayIndexPath=indexPath;
            _selectDays=indexPath.row;
            _selectPriceAndDay=2;

        }
        [_daysTable reloadData];
       
        
        
    }
    
    
}

#pragma mark 分割线左边对齐
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}



@end
