//
//  JYCLeftView.m
//  WelLv
//
//  Created by lyx on 15/11/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCLeftView.h"
#import "RestauantModel.h"

#import "backGroundCell.h"
#import "JYCDishDetailVC.h"
#import <objc/message.h>
@interface JYCLeftView()

{
    AFHTTPRequestOperationManager *manager;
    BOOL isClick;
    UIView *backgroundView;
    float totalTitle;
    UIButton *totalBtn;
    UIButton *orderBtn;
    NSInteger indexleft;
}
@property(nonatomic,strong)NSMutableArray *type1Arr;

@property(nonatomic,strong)NSMutableArray *type2Arr;

@property(nonatomic,strong)NSMutableArray *type3Arr;
@property (nonatomic, strong) MBProgressHUD * hud;
@property(nonatomic,strong)NSMutableArray *type4Arr;
@property(nonatomic,strong)NSMutableArray *baseArry;
@property(nonatomic,copy)NSString *str1;
@property(nonatomic,copy)NSString *str2;
@property(nonatomic,copy)NSString *str3;
@property(nonatomic,copy)NSString *str4;

@property(nonatomic,strong)UITableView *backGroundTableview;
@property(nonatomic,assign) BOOL isLeft;
@property(nonatomic,assign) NSInteger leftCellSelect;
@end


@implementation JYCLeftView
- (id)initWithFrame:(CGRect)frame with:(NSString *)shopId
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       // self.backgroundColor=[UIColor blueColor];
        _leftArr=[[NSMutableArray alloc]init];
        _shopId=shopId;
        
        [self initData];
        [self initUI];
        totalTitle=0;
        _baseArry=[[NSMutableArray alloc]init];
        _type1Arr=[[NSMutableArray alloc]init];
        _type2Arr=[[NSMutableArray alloc]init];
        _type3Arr=[[NSMutableArray alloc]init];
        _type4Arr=[[NSMutableArray alloc]init];
        _chuArr=[[NSMutableArray alloc]init];
    }
    return self;
}
-(void)initData
{
    NSDictionary *dict=nil;
    dict=@{@"shop_id":self.shopId};
    [self sendWith:RestauantUrl dict:dict];
    self.leftCellSelect = 0;
    
    
}
-(void)sendWith:(NSString *)url dict:(NSDictionary *)dict
{
    [self setProgressHud];
    __weak typeof(self)weakSelf =self;
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject){
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        if ([dict[@"state"]intValue]==1) {
            [_hud hide:YES];
            
            NSMutableArray *arr=dict[@"data"];
            for (int i=0;i<arr.count;i++) {
                NSDictionary *dict=arr[i];
                RestauantModel *model=[[RestauantModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                
                if ([model.type intValue]==1) {
                    
                    [weakSelf.type1Arr addObject:model];
                    weakSelf.str1=@"菜品";
                }
                
                else if([model.type intValue]==2)
                {
                    [weakSelf.type2Arr addObject:model];
                    weakSelf.str2=@"套餐";
                }else if([model.type intValue]==3){
                    [weakSelf.type3Arr addObject:model];
                    weakSelf.str3=@"抵用券";
                }else if([model.type intValue]==4)
                {
                    [weakSelf.type4Arr addObject:model];
                    weakSelf.str4=@"特产";
                }
                
            }
          
            
            if (weakSelf.str1) {
                [_leftArr addObject:weakSelf.str1];
                
            }if (weakSelf.str2) {
                [_leftArr addObject:weakSelf.str2];
            }if (weakSelf.str3) {
                [_leftArr addObject:weakSelf.str3];
            }if (weakSelf.str4) {
                [_leftArr addObject:weakSelf.str4];
            }
            if (weakSelf.type1Arr.count!=0) {
               [weakSelf.baseArry addObject:weakSelf.type1Arr];
            } if (weakSelf.type2Arr.count!=0) {
                [weakSelf.baseArry addObject:weakSelf.type2Arr];
            } if (weakSelf.type3Arr.count!=0) {
                [weakSelf.baseArry addObject:weakSelf.type3Arr];
            } if (weakSelf.type4Arr.count!=0) {
                [weakSelf.baseArry addObject:weakSelf.type4Arr];
            }
 
            [self.leftTableView reloadData];
            [self.rightTableView reloadData];
        }else {
            [[LXAlterView sharedMyTools]createTishi:@"刷新失败"];
            [_hud hide:YES];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [_hud hide:YES];
    }];
    
}
- (void)setProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithWindow:[[UIApplication sharedApplication].delegate window]];
    _hud.frame = self.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"加载中...";
    
    [[[UIApplication sharedApplication].delegate window] addSubview:_hud];
    [_hud show:YES];
}


-(void)initUI
{
    
   // _leftArr=[NSMutableArray arrayWithObjects:@"招牌菜",@"热销菜",@"套餐",@"抵用券",@"特产", nil];
    
    self.leftTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth/3, self.frame.size.height-40)];
    self.leftTableView.delegate=self;
    self.leftTableView.dataSource=self;
    //self.leftTableView.backgroundColor=[UIColor redColor];
    self.leftTableView.bounces=NO;
    UIView *view=[[UIView alloc]init];
    self.leftTableView.backgroundColor=[UIColor colorWithRed:221/255.0 green:230/255.0 blue:236/255.0 alpha:1];
    
    view.backgroundColor=[UIColor clearColor];
    self.leftTableView.tableFooterView=view;
    
    if ([self.leftTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.leftTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.leftTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.leftTableView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self addSubview:self.leftTableView];
   // [self.leftTableView reloadData];
    
    self.rightTableView=[[UITableView alloc]initWithFrame:CGRectMake(ViewRight(self.leftTableView), 0, windowContentWidth/3*2, self.frame.size.height-40)];
    self.rightTableView.delegate=self;
    self.rightTableView.dataSource=self;
    if ([self.rightTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.rightTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.rightTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.rightTableView setLayoutMargins:UIEdgeInsetsZero];
    }

    self.rightTableView.backgroundColor=[UIColor whiteColor];
    self.rightTableView.bounces=NO;
    [self addSubview:self.rightTableView];
   // [self.rightTableView reloadData];
    
    UIView *botomView=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
    botomView.backgroundColor=[UIColor whiteColor];
    [self addSubview:botomView];
    totalBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth/2, 40)];
    [totalBtn setTitle:[NSString stringWithFormat:@"总金额:0"] forState:UIControlStateNormal];
    [totalBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [totalBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    totalBtn.tag=101;
    [botomView addSubview:totalBtn];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth(totalBtn)-23, 16.5, 13, 7)];
    image.image=[UIImage imageNamed:@"订单明细按钮"];
    [totalBtn addSubview:image];
    orderBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth/2, 0, windowContentWidth/2, 40)];
    orderBtn.backgroundColor=[UIColor orangeColor];
    [orderBtn setTitle:@"下单" forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    orderBtn.tag=102;
    [botomView addSubview:orderBtn];
    backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, self.frame.size.height-40)];
    backgroundView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:0.5];
    [self addSubview:backgroundView];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [backgroundView addGestureRecognizer:tap];

    backgroundView.hidden=YES;
    

    self.backGroundTableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.backGroundTableview.delegate=self;
    self.backGroundTableview.dataSource=self;
    self.backGroundTableview.bounces=NO;
    [self addSubview:self.backGroundTableview];
    self.backGroundTableview.hidden=YES;
    //self.backGroundTableview.userInteractionEnabled=NO;
   // [backgroundView addSubview:self.backGroundTableview];
    
    
}
-(void)tap:(UITapGestureRecognizer *)tap

{
    isClick=!isClick;
        
    backgroundView.hidden=isClick ?NO:YES;
    self.backGroundTableview.hidden=isClick ?NO:YES;
   
}
-(void)btnClick:(UIButton *)button
{
    if (button.tag==101) {
    isClick=!isClick;
    backgroundView.hidden=isClick ?NO:YES;
    self.backGroundTableview.hidden=isClick ?NO:YES;    
        if (self.chuArr.count*40<=backgroundView.frame.size.height) {
            self.backGroundTableview.frame=CGRectMake(0, backgroundView.frame.size.height-self.chuArr.count*40, windowContentWidth, self.chuArr.count*40);
            
            self.backGroundTableview.backgroundColor=[UIColor redColor];
           
 
        }else {
            self.backGroundTableview.frame=CGRectMake(0,0, windowContentWidth, backgroundView.frame.size.height);
            
            self.backGroundTableview.backgroundColor=[UIColor blueColor];
            //[backgroundView addSubview:self.backGroundTableview];
        }
        
       
    }else if(button.tag==102)
    {
        
        if (self.chuArr.count==0) {
            [[LXAlterView sharedMyTools]createTishi:@"您还没有选择订单"];
            return;
        }
        if ([self.delegate respondsToSelector:@selector(clickToPush:)]) {
            [self.delegate performSelector:@selector(clickToPush:)withObject:self.chuArr];
        }
             
   }
}

#pragma mark ---- TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.leftTableView) {
        return 1;
    }else if (tableView==self.backGroundTableview)
    {
        return 1;
    }
    
    return self.baseArry.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==self.leftTableView) {
        return self.baseArry.count;
    }else if(tableView==self.backGroundTableview)
    {
        return self.chuArr.count;
    }
    NSMutableArray *arr=[self.baseArry objectAtIndex:section];
    return arr.count;
   
    
    
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView==self.leftTableView) {
        return nil;
    }else if(tableView==self.backGroundTableview)
    {
        return nil;
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 20)];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, windowContentWidth, 20)];
    titleLabel.textColor = [UIColor whiteColor];
    headerView.backgroundColor =  [UIColor colorWithRed:253 /255.0 green:203/255.0 blue:130/255.0 alpha:1.0];
    NSMutableArray *arr=[self.baseArry objectAtIndex:section];
    RestauantModel *moel=[[RestauantModel alloc]init];
    moel=arr[0];
    if ([moel.type intValue]==1) {
      titleLabel.text=@"菜品";
    }else if([moel.type intValue]==2) {
        titleLabel.text=@"套餐";
    }else if([moel.type intValue]==3) {
        titleLabel.text=@"抵用券";
    }else if([moel.type intValue]==4) {
        titleLabel.text=@"特产";
    }

    [headerView addSubview:titleLabel];
    return headerView;
    
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==self.leftTableView) {
        return 0;
    }
    else if(tableView==self.backGroundTableview)
    {
        return 0;
    }
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.leftTableView) {
        static NSString *cellID1=@"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];

            NSInteger selectedIndex = 0;
            
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
            [self.leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        cell.backgroundColor=[UIColor colorWithRed:221/255.0 green:230/255.0 blue:236/255.0 alpha:1];
        UIView *view=[[UIView alloc]init];
        view.backgroundColor=[UIColor whiteColor];
        cell.selectedBackgroundView=view;
        
        NSString *str=self.leftArr[indexPath.row];
        cell.textLabel.text=str;
        
       
        return cell;
        
    }
    
    else if(tableView==self.rightTableView)
    {
        NSString *cellID2= [NSString stringWithFormat:@"CellS%ldC%ld", (long)indexPath.section, (long)indexPath.row];
        JYCorderDishesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID2];
        if (cell == nil) {
            cell = [[JYCorderDishesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        NSMutableArray *arr=self.baseArry[indexPath.section];
        RestauantModel *model1=[[RestauantModel alloc]init];
        model1=arr[indexPath.row];
        cell.index=indexPath;
        cell.model=model1;
        __weak typeof (cell)weakCell=cell;
        cell.cellBlock=^(int totolNumeBer,RestauantModel *model,NSIndexPath *indexPath2){
            
            weakCell.totaleNumebr.text=[NSString stringWithFormat:@"%d",totolNumeBer];
    
           

            if (totolNumeBer>0) {
                if (![self.chuArr containsObject:model]) {
                    [self.chuArr addObject:model];
                }
                totalTitle=0;
                for (RestauantModel *model1 in self.chuArr) {
                    totalTitle=totalTitle+[model1.price floatValue]*model1.total;
                }
                [totalBtn setTitle:[NSString stringWithFormat:@"总金额:￥%0.2f",totalTitle] forState:UIControlStateNormal];
               [weakCell.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
                [self.backGroundTableview reloadData];
              
            }
            else if(totolNumeBer==0)
            {
            if (self.chuArr.count>0) {
            [self.chuArr removeObject:model];
            }
            [weakCell.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
                [self.backGroundTableview reloadData];
                totalTitle=0;
                for (RestauantModel *model1 in self.chuArr) {
                    totalTitle=totalTitle+[model1.price floatValue]*model1.total;
                }
                [totalBtn setTitle:[NSString stringWithFormat:@"总金额:￥%0.2f",totalTitle] forState:UIControlStateNormal];
               }
         };
        
        return cell;
    }else if(tableView==self.backGroundTableview)
    {
        NSString *cellID3= [NSString stringWithFormat:@"CellS%ld",(long)indexPath.row];
        backGroundCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID3];
        if (cell == nil) {
            cell = [[backGroundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
        }
        
        RestauantModel *model2=[[RestauantModel alloc]init];
        model2=self.chuArr[indexPath.row];
        cell.model=model2;
        cell.cellBlock2=^(NSIndexPath *indexPath3,int tota,RestauantModel *model){
            
            JYCorderDishesCell *ceell=(JYCorderDishesCell *)[self.rightTableView cellForRowAtIndexPath:indexPath3];
            ceell.totaleNumebr.text=[NSString stringWithFormat:@"%d",tota];
            
            totalTitle=0;
            for (RestauantModel *model1 in self.chuArr) {
                totalTitle=totalTitle+[model1.price floatValue]*model1.total;
            }
            [totalBtn setTitle:[NSString stringWithFormat:@"总金额:￥%0.2f",totalTitle] forState:UIControlStateNormal];
            if (tota==0) {
                
                [ceell.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
                [self.chuArr removeObject:model];
                totalTitle=0;
                for (RestauantModel *model1 in self.chuArr) {
                    totalTitle=totalTitle+[model1.price floatValue]*model1.total;
                }
                [totalBtn setTitle:[NSString stringWithFormat:@"总金额:￥%0.2f",totalTitle] forState:UIControlStateNormal];
                [self.backGroundTableview reloadData];
            }
            
            if (self.chuArr.count*40<=backgroundView.frame.size.height) {
                self.backGroundTableview.frame=CGRectMake(0, backgroundView.frame.size.height-self.chuArr.count*40, windowContentWidth, self.chuArr.count*40);
                
                self.backGroundTableview.backgroundColor=[UIColor redColor];
                [backgroundView addSubview:self.backGroundTableview];
                
            }else {
                self.backGroundTableview.frame=CGRectMake(0,0, windowContentWidth, backgroundView.frame.size.height);
                
                self.backGroundTableview.backgroundColor=[UIColor blueColor];
                [backgroundView addSubview:self.backGroundTableview];
            }
         };
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leftTableView) {
        return 60;
    }else if(tableView==self.backGroundTableview)
    {
        return 40;
    }
    return 85;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.leftTableView) {
        self.isLeft = YES;
        self.leftCellSelect = indexPath.row;
        UITableViewCell *selectCell = [self.leftTableView cellForRowAtIndexPath:indexPath];
        selectCell.selected = YES;
        selectCell.contentView.backgroundColor = [UIColor whiteColor];
        
    [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row]
                                   atScrollPosition:UITableViewScrollPositionTop animated:NO];
   
    }else if(tableView==self.rightTableView)
    {
       
        NSMutableArray *arr=self.baseArry[indexPath.section];
        RestauantModel *model=arr[indexPath.row];
       
        JYCorderDishesCell *ceell=(JYCorderDishesCell *)[self.rightTableView cellForRowAtIndexPath:model.indexPath1];
        NSMutableDictionary *dict=nil;
       [dict removeAllObjects];
       dict=[NSMutableDictionary dictionaryWithObjectsAndKeys:model,@(1),ceell,@(2),self.chuArr,@(3),nil];
        if ([self.delegate respondsToSelector:@selector(didSelectToPresent:)]) {
           [self.delegate performSelector:@selector(didSelectToPresent:) withObject:dict];
            
//           // [self.delegate performSelector:@selector(didSelectToPresent::)withObject:model withObject:ceell];
//        
        }
    }else if(tableView==self.backGroundTableview)
    {
       

    }
   

}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.isLeft) {
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:self.leftCellSelect];
        UITableViewCell *selectCell = [self.leftTableView cellForRowAtIndexPath:selectedIndexPath];
        selectCell.selected = YES;
        self.isLeft = NO;
    }
    else
    {
        NSArray *arr=[self.rightTableView indexPathsForVisibleRows];
        NSIndexPath *index=arr[0];
         NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:index.section inSection:0];
        [self.leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
    
}
@end
