//
//  HotelDteailSelectionViewController.m
//  WelLv
//
//  Created by mac for csh on 15/10/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "HotelDteailSelectionViewController.h"
#import "HotelDetailSelectSecondCell.h"

@interface HotelDteailSelectionViewController ()
{
    UITableView *_tab1;
    UITableView *_tab2;
    NSArray *tab1Arr;
    NSArray *tab2Arr;
    NSDictionary *titleDic;
    
    NSMutableArray * choiceArray;
    
    UIView *titView;
}
@end

@implementation HotelDteailSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"筛选";
    self.view.backgroundColor = [UIColor whiteColor];
    
    tab1Arr = [[NSArray alloc] initWithObjects:@"早餐",@"床型",@"支付方式", nil];
    NSArray *arr1 = @[@"不限",@"单早",@"双早",@"三早及以上"];
    NSArray *arr2 = @[@"不限",@"大床",@"双床"];
    NSArray *arr3 = @[@"不限",@"到店付",@"预付"];
    NSArray *arr = @[arr1,arr2,arr3];
    titleDic = [[NSDictionary alloc] initWithObjects:arr forKeys:tab1Arr];
    tab2Arr =[titleDic valueForKey:[tab1Arr objectAtIndex:0]];
    choiceArray = [[NSMutableArray alloc] init];
    
    [self initTab];
    
}

-(void)initTab{
    _tab1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth/3, windowContentHeight-50-64)];
    _tab1.tag = 1;
    _tab1.delegate = self;
    _tab1.dataSource = self;
    _tab1.backgroundColor = kColor(221, 221, 221);
    _tab1.tableFooterView = [[UIView alloc] init];
     _tab1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tab1];
    NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_tab1 selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionTop];//默认选中第一行
    
    _tab2 = [[UITableView alloc] initWithFrame:CGRectMake(windowContentWidth/3, 0, windowContentWidth/3*2, windowContentHeight-50-64)];
    _tab2.tag = 2;
    _tab2.delegate = self;
    _tab2.dataSource = self;
    _tab2.backgroundColor = [UIColor clearColor];
    _tab2.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tab2];

    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight - 64-50-0.7,windowContentWidth,0.7)];
    line.backgroundColor = kColor(252, 146, 65);
    [self.view addSubview:line];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, ViewHeight(line)+ViewY(line), windowContentWidth, 50);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:kColor(252, 146, 65) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    [btn addTarget:self action:@selector(GetChoiceArray) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

-(void)GetChoiceArray{
    if (self.delegate && [self.delegate respondsToSelector:@selector(getCArray:)]) {
        [self.delegate getCArray:choiceArray];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - tableview delegate/datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float cellheighe = 45.0;
    /*if (tableView.tag == 1) {
        cellheighe = 45;
    }*/
    return cellheighe;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger secions = tab1Arr.count;
    if (tableView.tag == 2) {
        secions = tab2Arr.count;//[[titleDic objectForKey:[tab1Arr objectAtIndex:section]] count];
    }
    return secions; // 分组数
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 1) {
        static NSString *CellIdentifier1 = @"Cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier1] ;
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.text = [tab1Arr objectAtIndex:indexPath.row];
            UIView *aView = [[UIView alloc] initWithFrame:cell.contentView.frame];
            aView.backgroundColor = [UIColor whiteColor];
        }
        return cell;
        
    }else if (tableView.tag == 2){
        static NSString *CellIdentifier2 = @"Cell2";
        HotelDetailSelectSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil)
        {
            cell = [[HotelDetailSelectSecondCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier2] ;
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //cell.textLabel.text = [tab2Arr objectAtIndex:indexPath.row];
            cell.igv.image = [UIImage imageNamed:@"酒店详情筛选未选中"];
            if(indexPath.row == 0){
                cell.igv.image = [UIImage imageNamed:@"酒店详情筛选选中"];            
            }
        }
        cell.textLabel.text = [tab2Arr objectAtIndex:indexPath.row];
        return cell;
    
    }
    
    return nil;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        
        tab2Arr = [[NSArray alloc] init];
        tab2Arr =[titleDic valueForKey:[tab1Arr objectAtIndex:indexPath.row]];
        [_tab2 reloadData];
    }else if (tableView.tag == 2){
        
       // HotelDetailSelectSecondCell *cell = (HotelDetailSelectSecondCell *)[tableView cellForRowAtIndexPath:indexPath];
       // cell.igv.image = [UIImage imageNamed:@"酒店详情筛选选中"];
        for(int i = 0;i< tab2Arr.count ; i ++){
            NSIndexPath *firstPath = [NSIndexPath indexPathForRow:i  inSection:0];
            HotelDetailSelectSecondCell *cell = (HotelDetailSelectSecondCell *)[tableView cellForRowAtIndexPath:firstPath];
            if (indexPath == firstPath ) {
                cell.igv.image = [UIImage imageNamed:@"酒店详情筛选选中"];
            }else{
                cell.igv.image = [UIImage imageNamed:@"酒店详情筛选未选中"];
            }
        }
        
        
        //添加
        if (indexPath.row != 0) {
            int i;
            for( i=0  ; i < tab2Arr.count ; i++){
                //代替同类添加
                if([choiceArray indexOfObject:[tab2Arr objectAtIndex:i]] != NSNotFound){
                    [choiceArray replaceObjectAtIndex:[choiceArray indexOfObject:[tab2Arr objectAtIndex:i]] withObject:[tab2Arr objectAtIndex:indexPath.row]];
                    [self changeTabFrame];
                    break;
                }
                if (i == tab2Arr.count-1) {
                    //新类添加
                    [choiceArray addObject:[tab2Arr objectAtIndex:indexPath.row]];
                    [self changeTabFrame];
                }
            }
        }else if (indexPath.row ==0){
          //移除  点击不限 移除所有同类（单选只有一个）
            for( int j =0  ; j < tab2Arr.count ; j++){
                if([choiceArray indexOfObject:[tab2Arr objectAtIndex:j]] != NSNotFound){
                    [choiceArray removeObject:[tab2Arr objectAtIndex:j]];
                    [self changeTabFrame];
                    break;
                }
               
            }

        }
    }
  NSLog(@"%ld-%ld",tableView.tag,indexPath.row);
}

-(void)changeTabFrame{
    if (choiceArray.count == 0) {
        if (titView) {
            [titView removeFromSuperview];
        }
        _tab1.frame = CGRectMake(0, 0, windowContentWidth/3, windowContentHeight-50-64);
        _tab2.frame = CGRectMake(windowContentWidth/3, 0, windowContentWidth/3*2, windowContentHeight-50-64);
    }else if (choiceArray.count>0 && choiceArray.count<4){
        if (titView) {
            [titView removeFromSuperview];
        }
        titView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 45)];
        titView.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(titView)+ViewHeight(titView)-0.7,windowContentWidth,0.7)];
        line.backgroundColor = bordColor;
        [titView addSubview:line];
        [self.view addSubview:titView];
        for (int i = 0; i<choiceArray.count; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(windowContentWidth/4*i, 0, windowContentWidth/4, 45);
            [button setTitle:[choiceArray objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.tag = i;
            [button addTarget:self action:@selector(deleteTit:) forControlEvents:UIControlEventTouchUpInside];
            [titView addSubview:button];
            
            UIImageView *igv = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(button)-15-5, ViewHeight(button)/2- 15/2 ,15 , 15)];
            igv.image = [UIImage imageNamed:@"酒店详情筛选删除"];
            [button addSubview:igv];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(ViewWidth(button)-0.7, 10 ,0.7 , ViewHeight(button)-10*2)];
            line.backgroundColor = bordColor;
            line.alpha = 0.8;
            [button addSubview:line];
        }
        _tab1.frame = CGRectMake(0, 45, windowContentWidth/3,windowContentHeight-50-64-45);
        _tab2.frame = CGRectMake(windowContentWidth/3, 45, windowContentWidth/3*2, windowContentHeight-50-64-45);
    }
}

-(void)deleteTit:(UIButton *)sender{
    [choiceArray removeObjectAtIndex:sender.tag];
    [self changeTabFrame];
}

@end
