//
//  HotelSortControl.m
//  CreateControl
//
//  Created by James on 15/11/25.
//  Copyright © 2015年 James. All rights reserved.
//

#import "HotelSortControl.h"

@implementation HotelSortControl

#pragma mark - 初始化
-(instancetype)init{
    if (self=[super init]) {
        //初始化当前视图
        self.frame=CGRectMake(0, 0,windowContentWidth, windowContentHeight);
        self.backgroundColor=[UIColor colorWithWhite:0.5 alpha:0.5];
        
       
        int sortY=104;
        int sortH=64;
        switch ((int)windowContentHeight) {
            case 480:
                //设置“圆点”辅助Y->3.5吋
                sortY=326;
                sortH=104;
                break;
            case 568:
                //设置“圆点”辅助Y->4吋
                sortY=244;
                sortH=84;
                break;
            case 667:
                //设置“圆点”辅助Y->4.7存
                sortY=124;
                break;
            case 736:
                //设置“圆点”辅助Y->5.5吋
                
                break;
            default:
                break;
        }

        
        
        //创建背景视图
        self.backgroundView=[[UIView alloc] initWithFrame:CGRectMake(0,(windowContentHeight-sortY)/2, windowContentWidth, windowContentHeight/2+sortH)];
        
        
        
        
        
        
        self.backgroundView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.backgroundView];
        
        //給当前父视图添加手势
        UITapGestureRecognizer *tapGeRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewHide:)];
        tapGeRecognizer.cancelsTouchesInView=NO;
        [self addGestureRecognizer:tapGeRecognizer];
        //给当前子视图添加手势
        UITapGestureRecognizer *subTapGecognize=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subViewHide:)];
        subTapGecognize.cancelsTouchesInView=NO;
        [self.backgroundView addGestureRecognizer:subTapGecognize];

        //创建自定义视图
        [self customView];
    }
    return self;
}

#pragma mark - 自定义视图
-(void)customView{
    
    int sortH=64;
    switch ((int)windowContentHeight) {
        case 480:
            //设置“圆点”辅助Y->3.5吋
            sortH=104;
            break;
        case 568:
            //设置“圆点”辅助Y->4吋
            sortH=84;
            break;
        case 667:
            //设置“圆点”辅助Y->4.7存
            
            break;
        case 736:
            //设置“圆点”辅助Y->5.5吋
            
            break;
        default:
            break;
    }

    
    //创建一个表格视图
    sortTableView=[[UITableView alloc] initWithFrame:CGRectMake(0,0,windowContentWidth,windowContentHeight/2+sortH) style:UITableViewCellStyleValue1];
    sortTableView.delegate=self;
    sortTableView.dataSource=self;
    sortTableView.scrollEnabled=false;
    
    //创建一个数据字典
    Dict=@{@"0":@"默认排序/",@"1":@"价格/低到高",@"2":@"价格/高到低",@"3":@"星级/低到高",@"4":@"星级/高到低",@"5":@"距离/近到远"};
    
    //未选中图片
    filterUnSelect=[UIImage imageNamed:@"filterUnSelect"];
    //选中图片
    filterSelect=[UIImage imageNamed:@"filterSelect"];
    
    //把表格视图添加至背景视图
    [self.backgroundView addSubview:sortTableView];
}

#pragma mark - tableView 代理方法实现

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    NSString *cellIdentifier=@"sortIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    UILabel *lowperToUpper=[[UILabel alloc] initWithFrame:CGRectMake(0, 0,windowContentWidth,45)];
    lowperToUpper.font=[UIFont systemFontOfSize:14];
    lowperToUpper.text=@"低到高";
    lowperToUpper.textAlignment=UITextAlignmentCenter;
    
    UILabel *upperToLower=[[UILabel alloc] initWithFrame:CGRectMake(0,0,windowContentWidth,45)];
    upperToLower.font=[UIFont systemFontOfSize:14];
    upperToLower.text=@"高到低";
    upperToLower.textAlignment=UITextAlignmentCenter;
    
    UILabel *nearToFar=[[UILabel alloc] initWithFrame:CGRectMake(0,0,windowContentWidth,45)];
    nearToFar.font=[UIFont systemFontOfSize:14];
    nearToFar.text=@"近到远";
    nearToFar.textAlignment=UITextAlignmentCenter;
    
 
    btnSelect1=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSelect1.frame=CGRectMake(cell.frame.size.width-40,ViewY(cell)+10, filterSelect.size.width, filterSelect.size.height);
    btnSelect1.userInteractionEnabled=false;
    btnSelect1.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    btnSelect1.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [btnSelect1 setImage:filterUnSelect forState:UIControlStateNormal];
    
    
   UIButton *selectButton=[UIButton buttonWithType:UIButtonTypeCustom];
    selectButton.frame=CGRectMake(cell.frame.size.width-40,ViewY(cell)+10, filterSelect.size.width, filterSelect.size.height);
    selectButton.userInteractionEnabled=false;
    selectButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    selectButton.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [selectButton setImage:filterSelect forState:UIControlStateNormal];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text=@"默认排序";
            cell.textLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:16];
            if (indexValue==0) {
                btnSelect1=selectButton;
            }
            btnSelect1.tag=indexPath.row+100;
            [cell addSubview:btnSelect1];
            break;
        case 1:
            cell.textLabel.text=@"价格";
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            [cell addSubview:lowperToUpper];
            if (indexValue==1) {
                btnSelect1=selectButton;
            }
            btnSelect1.tag=indexPath.row+100;
            [cell addSubview:btnSelect1];
            break;
        case 2:
            cell.textLabel.text=@"价格";
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            [cell addSubview:upperToLower];
            if (indexValue==2) {
                btnSelect1=selectButton;
            }
            btnSelect1.tag=indexPath.row+100;
            [cell addSubview:btnSelect1];
            break;
        case 3:
            cell.textLabel.text=@"星级";
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            [cell addSubview:lowperToUpper];
            if (indexValue==3) {
                btnSelect1=selectButton;
            }
            btnSelect1.tag=indexPath.row+100;
            [cell addSubview:btnSelect1];
            break;
        case 4:
            cell.textLabel.text=@"星级";
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            [cell addSubview:upperToLower];
            if (indexValue==4) {
                btnSelect1=selectButton;
            }
            btnSelect1.tag=indexPath.row+100;
            [cell addSubview:btnSelect1];
            break;
        case 5:
            cell.textLabel.text=@"距离";
            cell.textLabel.font=[UIFont systemFontOfSize:14];
            [cell addSubview:nearToFar];
            if (indexValue==5) {
                btnSelect1=selectButton;
            }
            btnSelect1.tag=indexPath.row+100;
            [cell addSubview:btnSelect1];
            break;
        default:
            break;
    }
    
    
    return  cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,windowContentWidth,45)];
    label1.text=@"排序";
    label1.textAlignment=UITextAlignmentCenter;
    label1.backgroundColor=[UIColor whiteColor];
    label1.font=[UIFont systemFontOfSize:18];
    return label1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    NSString *sortValue=[Dict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    for (int i=0; i<6; i++) {
        UIButton *btn=(UIButton *)[tableView viewWithTag:(i+100)];
        if (i!=indexPath.row) {
             [btn setImage:filterUnSelect forState:UIControlStateNormal];
        }else
        {
            [btn setImage:filterSelect forState:UIControlStateNormal];
        }
       
    }
    
    [self.delegate resultSortDelegate:sortValue];
    [tableView setNeedsDisplay];
    
    double delayInsSecondes=0.1;
    __block HotelSortControl *bself=self;
    dispatch_time_t popTime=dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInsSecondes * NSEC_PER_SEC));
    
    dispatch_after(popTime,dispatch_get_main_queue(), ^(void){
         self.hidden=true;
    });
    
}

#pragma mark - 回调函赋值
-(void)initWithSortValue:(NSString *)value
{
    self.pubString=value;
    
    if ([self.pubString isEqual:@"默认排序/"]) {
        indexValue=0;
    }else if ([self.pubString isEqual:@"价格/低到高"]){
        indexValue=1;
    }else if ([self.pubString isEqual:@"价格/高到低"]){
        indexValue=2;
    }else if ([self.pubString isEqual:@"星级/低到高"]){
        indexValue=3;
    }else if ([self.pubString isEqual:@"星级/高到低"]){
        indexValue=4;
    }else if ([self.pubString isEqual:@"距离/近到远"]){
        indexValue=5;
    }else{
        indexValue=0;
    }
 
}

#pragma mark - 隐藏父视图层
-(void)viewHide:(UITapGestureRecognizer*)tap{
    if(self.hidden == NO){
        self.hidden = YES;
        self.backgroundView.hidden = YES;
    }
}
#pragma mark - 点击子视图，不做任何处理，为了覆盖父视图手势
-(void)subViewHide:(UITapGestureRecognizer *)tap{
    
}

@end
