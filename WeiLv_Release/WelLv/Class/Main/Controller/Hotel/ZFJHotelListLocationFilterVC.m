//
//  ZFJHotelListLocationFilterVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/8.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJHotelListLocationFilterVC.h"
#import <objc/runtime.h>
#import "ConvertEncodeHelper.h"
#import "JsonHelper.h"
static NSString *JsonStr;
@implementation ZFJHotelListLocationFilterVC

#pragma mark - 初始化
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //设置当前视图背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航标题
    self.navigationItem.title=@"位置区域";
    
    //初始化网络数据
    [self initData];
    
    //初始化公共遍历
    self.pubDict=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"",@"tab1",@"",@"tab2",@"",@"tab3", nil];
    self.firstSelectValue=@"";
    self.secondSelectValue=@"";
    self.thirdSelectValue=@"";
}

#pragma mark - 初始化网络数据
-(void)initData{
    UIView *lineView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth,0.5)];
    lineView.backgroundColor=[UIColor lightGrayColor];
    lineView.alpha=0.5;
    [self.view addSubview:lineView];
    //请求参数
    NSDictionary *parameters=@{@"citycode":@"149"};
    //加载等待
    MBProgressHUD *HUD=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText=@"正在加载";
    [HUD  show:YES];

    //区域位置-网络请求
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:HotelFilterArea parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        [HUD hide:YES];
        
        //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        
        
        //获取网络请求成功后的数据
        JsonStr=[NSString stringWithFormat:@"%@",operation.responseString];
        
        //json字符串转码
        JsonStr=[ConvertEncodeHelper replaceUnicode:JsonStr];
        
        //json字符串转换成实体类
        jsonModel=[self GetEntityFromJson:JsonStr];
        
        //获取第一个tableview的行数
        firstRowCount=(int)jsonModel.Data.count;
        
        //表示是一级tableView页面
        if (firstRowCount>0) {
            
            
            self.firstTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,ViewBelow(lineView),80, ControllerViewHeight)];
            self.firstTableView.tag=1;
            self.firstTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            self.firstTableView.dataSource = self;
            self.firstTableView.delegate = self;
            self.firstTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.view addSubview:_firstTableView];
            
            
            
            //把第一个tableView的第一个节点数据转换成数据字典
            secondDict=(NSMutableDictionary *)jsonModel.Data[0];
            
            //把第一个tableViewd的第一个节点的数据字典的children转换成动态数组
            childrenArray=(NSMutableArray *)secondDict[@"children"];
            
            //获取第一个tableViewd的第一个节点的数据字典的children转换成动态数组的节点数
            secondRowCount=(int)[childrenArray count];
            
            //表示是二级tableView页面
            if (secondRowCount>0) {
                //把第二个tableView的第一个节点数据转换成数据字典
                thirdDict=(NSMutableDictionary *)childrenArray[0];
                
                //判断第二个tableView的children节点是否为空，如果为空，表示只有二级tableView页面,否则有三级tableView页面
                if (thirdDict[@"children"]!=nil) {
                    
                    //把第二个tableViewd的第一个节点的数据字典的children转换成动态数组
                    subChildrenArray=(NSMutableArray *)thirdDict[@"children"];
                    
                    //获取第二个tableViewd的第一个节点的数据字典的children转换成动态数组的节点数
                    thirdRowCount=(int)[subChildrenArray count];
                    
                    //表示是三级tableView页面
                    if (thirdRowCount>0) {
                        
                        //创建第二个tableView视图
                        self.secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewRight(_firstTableView), ViewY(_firstTableView),80, ControllerViewHeight)];
                        self.secondTableView.tag=2;
                        self.secondTableView.dataSource = self;
                        self.secondTableView.delegate = self;
                        self.secondTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
                        self.secondTableView.backgroundColor=[UIColor whiteColor];
                        [self.view addSubview:_secondTableView];
                        
                        
                        //创建竖线视图
                        UIView *vertLine=[[UIView alloc] initWithFrame:CGRectMake(160,0,0.5,ControllerViewHeight)];
                        vertLine.backgroundColor=[UIColor lightGrayColor];
                        vertLine.alpha=0.5;
                        [self.view addSubview:vertLine];
                        
                        
                        //创建第三个tableView视图
                        self.thirdTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewRight(vertLine), ViewY(vertLine), windowContentWidth-160, ControllerViewHeight)];
                        self.thirdTableView.tag=3;
                        self.thirdTableView.dataSource = self;
                        self.thirdTableView.delegate = self;
                        self.thirdTableView.backgroundColor=[UIColor whiteColor];
                        [self.view addSubview:_thirdTableView];
                        
                    }else{
                        thirdRowCount=0;
                    }
                    
                }else{
                    
                    //创建第二个tableView视图
                    self.secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewRight(_firstTableView), ViewY(_firstTableView), windowContentWidth-80, ControllerViewHeight)];
                    self.secondTableView.tag=2;
                    self.secondTableView.dataSource = self;
                    self.secondTableView.delegate = self;
                    self.secondTableView.backgroundColor=[UIColor whiteColor];
                    [self.view addSubview:_secondTableView];
                    
                }
                
            }else{
                secondRowCount=0;
            }
        }else{
            firstRowCount=0;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [HUD hide:YES];

        NSLog(@"网络请求失败");
        
    }];
    
 
}

#pragma - mark  Json字符串转换成实体类
-(JsonModel *)GetEntityFromJson:(NSString *)json{
    JsonModel *model=[[JsonModel alloc] init];
    
    NSMutableDictionary *theObject=[[JsonHelper shareSerializer] DeserializeJson:JsonStr];
    
    //通过反射获取指定类中的属性列表
    NSString *ClassName=NSStringFromClass([model class]);
    const char *cClassName=[ClassName UTF8String];
    id theClass=objc_getClass(cClassName);
    
    unsigned int outCount;
    objc_property_t *properties=class_copyPropertyList( theClass, &outCount);
    NSMutableArray *propertyNames=[[NSMutableArray alloc]initWithCapacity:1];
    //获取person类中的所有属性的名称，并存入字典
    for (unsigned int i=0; i<outCount; i++) {
        //objc_property_t property=properties[i];
        NSString *propertyNameString=[[NSString alloc]initWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding];
        [propertyNames addObject:propertyNameString];
    }
    
    for (NSString *key in propertyNames) {
        [model setValue:(theObject[key]) forKey:(key)];
    }
    
    return model;
}

#pragma mark - TableView的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

#pragma mark - TableView的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag==1) {
        return firstRowCount;
    }else if (tableView.tag==2){
        return secondRowCount;
        
    }else if (tableView.tag==3){
        return thirdRowCount;
    }
    return 0;
}

#pragma mark - TabelView的单元格cell设置
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag==1) {
        //创建cell
        static NSString * cellIdentifier = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            cell.separatorInset = UIEdgeInsetsZero;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }else{
            //为了重构时出现层叠
            for (UIView *viewToRemove in [cell.contentView subviews]){
                [viewToRemove removeFromSuperview];
            }
            
        }
     
        
        if (firstRowCount>0) {
            firstDict=(NSMutableDictionary *)jsonModel.Data[indexPath.row];
            cell.textLabel.font=[UIFont systemFontOfSize:12];
            cell.textLabel.text =firstDict[@"name"];
            
            if (indexPath.row==0) {
                if (tableView.dragging==NO&&tableView.decelerating==NO) {
                    cell.backgroundColor = [UIColor whiteColor];
                    self.firstTableViewSelectRow = indexPath.row;
                }
               
                self.firstSelectValue=firstDict[@"name"];
                [self.pubDict setValue:self.firstSelectValue forKey:@"tab1"];
            }
 
            if (![self.pubLocArray[0] isEqual:@""]) {
                if ([self.pubLocArray[0]  isEqualToString:cell.textLabel.text]) {
                    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame=CGRectMake(10,cell.frame.size.height/2+5,4,4);
                    [btn setBackgroundImage:[UIImage imageNamed:@"价格区间圆点"] forState:UIControlStateNormal];
                    cell.backgroundColor = [UIColor whiteColor];
                    [cell addSubview:btn];
                    
                    self.firstTableViewSelectRow = indexPath.row;
                    self.firstSelectValue=firstDict[@"name"];
                    [self.pubDict setValue:self.firstSelectValue forKey:@"tab1"];
                    
                    //触发当前tableview的代理delegate
                    if ([_firstTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
                        [_firstTableView.delegate tableView:_firstTableView didSelectRowAtIndexPath:indexPath];
                    }

                }
            }
            
        }
        
        return cell;

    } else if (tableView.tag==2){
        //创建cell
        static NSString * cellSecndIdentifier = @"secondCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellSecndIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSecndIdentifier];
            cell.separatorInset = UIEdgeInsetsZero;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            for (UIView *viewToRemove in [cell.contentView subviews]){
                [viewToRemove removeFromSuperview];
            }
            cell.accessoryView=nil;
        }
        if (secondRowCount>0) {
            thirdDict=(NSMutableDictionary *)childrenArray[indexPath.row];
            cell.textLabel.font=[UIFont systemFontOfSize:12];
            cell.textLabel.text =thirdDict[@"name"];
            
            if (indexPath.row==0) {
                if (tableView.dragging==NO&&tableView.decelerating==NO) {
                    cell.backgroundColor = [UIColor whiteColor];
                    self.secondTableViewSelectRow = indexPath.row;
                }
                self.secondSelectValue=thirdDict[@"name"];
                [self.pubDict setValue:self.secondSelectValue forKey:@"tab2"];
            }
            if(![self.pubLocArray[1] isEqual:@""]){
                if ([self.pubLocArray[1] isEqualToString:cell.textLabel.text]) {
                    self.secondTableViewSelectRow = indexPath.row;
                    self.secondSelectValue=thirdDict[@"name"];
                    [self.pubDict setValue:self.secondSelectValue forKey:@"tab2"];
                    
                    if (thirdRowCount>0) {
                        cell.textLabel.textColor=[UIColor orangeColor];
                        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                        btn.frame=CGRectMake(10,cell.frame.size.height/2+5,4,4);
                        [btn setBackgroundImage:[UIImage imageNamed:@"价格区间圆点"] forState:UIControlStateNormal];
                        cell.backgroundColor = [UIColor whiteColor];
                        [cell addSubview:btn];

                    }else{
                        UIImage *image=[UIImage imageNamed:@"筛选条件选中"];
                        iconSecond=[UIButton buttonWithType:UIButtonTypeCustom];
                        iconSecond.frame=CGRectMake(0, 0,17,17);
                        [iconSecond setBackgroundImage:image forState:UIControlStateNormal];
                        cell.accessoryView=iconSecond;
                    }
                }
            }else{
             
                if (indexPath.row==0) {
                    if (thirdRowCount>0) {
                        if (tableView.dragging==NO&&tableView.decelerating==NO) {
                           cell.textLabel.textColor=[UIColor orangeColor];
                        }
                    }else{
                        cell.textLabel.textColor=[UIColor blackColor];
                        UIImage *image=[UIImage imageNamed:@"筛选条件选中"];
                        iconSecond=[UIButton buttonWithType:UIButtonTypeCustom];
                        iconSecond.frame=CGRectMake(0, 0,15,15);
                        [iconSecond setBackgroundImage:image forState:UIControlStateNormal];
                        cell.accessoryView=iconSecond;
                    }
                }
            
            }
        }


      return cell;
        
    } else if (tableView.tag==3){
        //创建cell
        static NSString * cellSecndIdentifier = @"thirdCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellSecndIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSecndIdentifier];
            cell.separatorInset = UIEdgeInsetsZero;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            for (UIView *viewToRemove in [cell.contentView subviews]){
                [viewToRemove removeFromSuperview];
            }
            cell.accessoryView=nil;
        }
        if (thirdRowCount>0) {
            fourthDict=(NSMutableDictionary *)subChildrenArray[indexPath.row];
            cell.textLabel.font=[UIFont systemFontOfSize:12];
            cell.textLabel.text =fourthDict[@"name"];
            
            if (indexPath.row==0) {
                cell.backgroundColor = [UIColor whiteColor];
                self.thirdTableViewSelectRow = indexPath.row;
                self.thirdSelectValue=fourthDict[@"name"];
                [self.pubDict setValue:self.thirdSelectValue forKey:@"tab3"];
            }
            
            if (![self.pubLocArray[2] isEqual:@""]) {
                if ([self.pubLocArray[2] isEqualToString:cell.textLabel.text]) {
                    self.thirdTableViewSelectRow = indexPath.row;
                    self.thirdSelectValue=fourthDict[@"name"];
                    [self.pubDict setValue:self.thirdSelectValue forKey:@"tab3"];
                    
                    UIImage *image=[UIImage imageNamed:@"筛选条件选中"];
                    iconSecond=[UIButton buttonWithType:UIButtonTypeCustom];
                    iconSecond.frame=CGRectMake(0, 0,15,15);
                    [iconSecond setBackgroundImage:image forState:UIControlStateNormal];
                    cell.accessoryView=iconSecond;
                }
                
            }else{
                if (indexPath.row == 0) {
                    UIImage *image=[UIImage imageNamed:@"筛选条件选中"];
                    iconSecond=[UIButton buttonWithType:UIButtonTypeCustom];
                    iconSecond.frame=CGRectMake(0, 0,17,17);
                    [iconSecond setBackgroundImage:image forState:UIControlStateNormal];
                    cell.accessoryView=iconSecond;
                }
            }
        }

        return cell;

    }
    return nil;
}

#pragma mark - TableView的选中选中行事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag==1) {
        secondRowCount=0;
        thirdRowCount=0;
        
     
        NSIndexPath * lastIndex = [NSIndexPath indexPathForRow:self.firstTableViewSelectRow inSection:indexPath.section];
        UITableViewCell * lastCell = [tableView cellForRowAtIndexPath:lastIndex];
        lastCell.backgroundColor = [UIColor groupTableViewBackgroundColor];

        
        self.firstTableViewSelectRow = indexPath.row;
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [self.pubDict setValue:cell.textLabel.text forKey:@"tab1"];
 
        
       
        
        //把第一个tableView的第一个节点数据转换成数据字典
        secondDict=(NSMutableDictionary *)jsonModel.Data[indexPath.row];
        
        //把第一个tableViewd的第一个节点的数据字典的children转换成动态数组
        childrenArray=(NSMutableArray *)secondDict[@"children"];
        
        //获取第一个tableViewd的第一个节点的数据字典的children转换成动态数组的节点数
        secondRowCount=(int)[childrenArray count];
        
        //表示是二级tableView页面
        if (secondRowCount>0) {
            //把第二个tableView的第一个节点数据转换成数据字典
            thirdDict=(NSMutableDictionary *)childrenArray[0];
            //判断第二个tableView的children节点是否为空，如果为空，表示只有二级tableView页面,否则有三级tableView页面
            if (thirdDict[@"children"]!=nil) {
                
                //把第二个tableViewd的第一个节点的数据字典的children转换成动态数组
                subChildrenArray=(NSMutableArray *)thirdDict[@"children"];
                
                //获取第二个tableViewd的第一个节点的数据字典的children转换成动态数组的节点数
                thirdRowCount=(int)[subChildrenArray count];
                
                //表示是三级tableView页面
                if (thirdRowCount>0) {
                    
                    //创建第二个tableView视图
                    self.secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewRight(_firstTableView), ViewY(_firstTableView),80, ControllerViewHeight)];
                    self.secondTableView.tag=2;
                    self.secondTableView.dataSource = self;
                    self.secondTableView.delegate = self;
                    self.secondTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
                    self.secondTableView.backgroundColor=[UIColor whiteColor];
                    [self.view addSubview:_secondTableView];
                    
                    //创建竖线视图
                    UIView *vertLine=[[UIView alloc] initWithFrame:CGRectMake(160,0,0.5,ControllerViewHeight)];
                    vertLine.backgroundColor=[UIColor lightGrayColor];
                    vertLine.alpha=0.5;
                    [self.view addSubview:vertLine];
                    
                    
                    //创建第三个tableView视图
                    self.thirdTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewRight(vertLine), ViewY(vertLine), windowContentWidth-160, ControllerViewHeight)];
                    self.thirdTableView.tag=3;
                    self.thirdTableView.dataSource = self;
                    self.thirdTableView.delegate = self;
                    self.thirdTableView.backgroundColor=[UIColor whiteColor];
                    [self.view addSubview:_thirdTableView];
                    
                  
                    
                }else{
                    thirdRowCount=0;
                }
                
            }else{
                //创建第二个tableView视图
                self.secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewRight(_firstTableView), ViewY(_firstTableView), windowContentWidth-80, ControllerViewHeight)];
                self.secondTableView.tag=2;
                self.secondTableView.dataSource = self;
                self.secondTableView.delegate = self;
                self.secondTableView.backgroundColor=[UIColor whiteColor];
                [self.view addSubview:_secondTableView];
            }
        }else{
            //创建第二个tableView视图
            self.secondTableView = [[UITableView alloc] initWithFrame:CGRectMake(ViewRight(_firstTableView), ViewY(_firstTableView), windowContentWidth-80, ControllerViewHeight)];
            self.secondTableView.tag=2;
            self.secondTableView.dataSource = self;
            self.secondTableView.delegate = self;
            self.secondTableView.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:_secondTableView];
        }
    }else if(tableView.tag==2){
        thirdRowCount=0;

        //把第二个tableView的第一个节点数据转换成数据字典
        secondDict=(NSMutableDictionary *)childrenArray[indexPath.row];
        
        //把第二个tableViewd的第一个节点的数据字典的children转换成动态数组
        subChildrenArray=(NSMutableArray *)secondDict[@"children"];
        
        //获取第二个tableViewd的第一个节点的数据字典的children转换成动态数组的节点数
        thirdRowCount=(int)[subChildrenArray count];
        if (thirdRowCount>0) {
            //当前选中的cell
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor=[UIColor orangeColor];
            [self.pubDict setValue:cell.textLabel.text forKey:@"tab2"];
 
            //上一次的cell
            NSIndexPath * lastIndex = [NSIndexPath indexPathForRow:self.secondTableViewSelectRow inSection:indexPath.section];
            UITableViewCell * lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            lastCell.backgroundColor = [UIColor whiteColor];
            lastCell.textLabel.textColor=[UIColor blackColor];
          
            //重新赋值
            self.secondTableViewSelectRow = indexPath.row;

        }else{

            //当前选中的cell
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textColor=[UIColor blackColor];
            UIImage *image=[UIImage imageNamed:@"筛选条件选中"];
            iconSecond=[UIButton buttonWithType:UIButtonTypeCustom];
            iconSecond.frame=CGRectMake(0, 0,15,15);
            [iconSecond setBackgroundImage:image forState:UIControlStateNormal];
            cell.accessoryView=iconSecond;
            [self.pubDict setValue:cell.textLabel.text forKey:@"tab2"];

            //上一次的cell
            NSIndexPath * lastIndex = [NSIndexPath indexPathForRow:self.secondTableViewSelectRow inSection:indexPath.section];
            UITableViewCell * lastCell = [tableView cellForRowAtIndexPath:lastIndex];
            lastCell.backgroundColor = [UIColor whiteColor];
            lastCell.textLabel.textColor=[UIColor blackColor];
            lastCell.accessoryView=nil;
            
            //重新赋值
            self.secondTableViewSelectRow = indexPath.row;
            NSString *str=[[NSString alloc] init];
            str=[str stringByAppendingString:self.pubDict[@"tab1"]];
            str=[str stringByAppendingString:@","];
            str=[str stringByAppendingString:self.pubDict[@"tab2"]];
            str=[str stringByAppendingString:@","];
            str=[str stringByAppendingString:self.pubDict[@"tab3"]];
            
           
            
            [self.delegate resultLocationValue:str];
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
     
    }else if(tableView.tag==3){
    
        //当前选中的cell
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor=[UIColor blackColor];
        UIImage *image=[UIImage imageNamed:@"筛选条件选中"];
        iconSecond=[UIButton buttonWithType:UIButtonTypeCustom];
        iconSecond.frame=CGRectMake(0, 0,15,15);
        [iconSecond setBackgroundImage:image forState:UIControlStateNormal];
        cell.accessoryView=iconSecond;
        [self.pubDict setValue:cell.textLabel.text forKey:@"tab3"];

        //上一次的cell
        NSIndexPath * lastIndex = [NSIndexPath indexPathForRow:self.thirdTableViewSelectRow inSection:indexPath.section];
        UITableViewCell * lastCell = [tableView cellForRowAtIndexPath:lastIndex];
       
        lastCell.backgroundColor = [UIColor whiteColor];
        lastCell.textLabel.textColor=[UIColor blackColor];
        lastCell.accessoryView=nil;
        
        //重新赋值
        self.thirdTableViewSelectRow = indexPath.row;
        NSString *str=[[NSString alloc] init];
        str=[str stringByAppendingString:self.pubDict[@"tab1"]];
        str=[str stringByAppendingString:@","];
        str=[str stringByAppendingString:self.pubDict[@"tab2"]];
        str=[str stringByAppendingString:@","];
        str=[str stringByAppendingString:self.pubDict[@"tab3"]];
        [self.delegate resultLocationValue:str];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
}

#pragma mark - 初始化赋值
-(void)initLocation:(NSString *)value{
    if (![value isEqual:@""]) {
        self.pubLocArray=[value componentsSeparatedByString:@","];
    }else{
        self.pubLocArray=@[@"",@"",@""];
    }
}

@end
