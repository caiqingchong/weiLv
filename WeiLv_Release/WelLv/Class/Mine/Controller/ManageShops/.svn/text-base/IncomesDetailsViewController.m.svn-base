
//
//  IncomesDetailsViewController.m
//  WelLv
//
//  Created by mac for csh on 15/10/28.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "IncomesDetailsViewController.h"
#import "ButtonWithImage.h"
#import "WXUtil.h"

@interface IncomesDetailsViewController ()
{
    UIButton *chooseBtn;
    UIView *chooseView;
    UIView* chooseView1;
    UITableView *_tableView;
    NSMutableArray *array;
    NSMutableArray *titleArray;
    
    NSInteger _page;
}
@property(nonatomic,strong)UILabel *total;
@property(nonatomic,strong)UILabel *totalSort;

@end

@implementation IncomesDetailsViewController
@synthesize conditionStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    BackBtn *_backBtn = [[BackBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    _backBtn.leftView.image = [UIImage imageNamed:@"back"];
    [_backBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    

    array = [[NSMutableArray alloc] init];
    titleArray = [[NSMutableArray alloc] init];
    
   //
    [self initView];
    _page = 1;
    [self loadDataWithParameters];
}


-(void)loadDataWithParameters{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    NSString *str = @"";
    if ([self.conditionStr isEqualToString:@"累计收益"]) {
        str = @"all";
    }else if([self.conditionStr isEqualToString:@"最近一周收入"]){
        str = @"week";
    }else if([self.conditionStr isEqualToString:@"最近一月收入"]){
        str = @"month";
    }else if([self.conditionStr isEqualToString:@"今日收入"]){
        str = @"day";
    }
    NSString *pageStr = [NSString stringWithFormat:@"%ld",_page];
    NSDictionary *parameters=@{@"assistant_id":[[LXUserTool alloc] getUid],@"wltoken":md5str,@"type":str,@"":pageStr,@"nums":@"20"};
    [manager POST:KeeperDriveDetail parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
            //   NSLog(@"xxxxxxx = %@",dict);
              if ([[dict objectForKey:@"state"] integerValue] ==1) {
                  NSDictionary *dict1 = [dict objectForKey:@"data"];
                  if ([dict1 objectForKey:@"accounts"]) {
                      self.total.text = [NSString stringWithFormat:@"%@",[dict1 objectForKey:@"accounts"] ];
                      if ([self.total.text isEqualToString:@""] || [self.total.text isEqualToString:@"(null)"] || [self.total.text isEqual:NULL]) {
                          self.total.text = @"0.00";
                      }
                     
                  }
                  if ([dict1 objectForKey:@"list"] && [[dict1 objectForKey:@"list"] isKindOfClass:[NSArray class]]) {
                      NSArray *totalArr = [dict1 objectForKey:@"list"];
                      if ([totalArr isKindOfClass:[NSArray class]] && totalArr.count >0) {
        /*begin------调整数组和二维数组的数据--------*/
                          for (int i = 0; i < totalArr.count ; i ++) {
                              NSDictionary *dayModel = [totalArr objectAtIndex:totalArr.count -i-1];
                              if ([titleArray indexOfObject:[dayModel objectForKey:@"year_day"]] == NSNotFound) {
                                  [titleArray addObject:[dayModel objectForKey:@"year_day"]];
                              }
                          }

                          
                          for (int j = 0; j < titleArray.count ;j ++) {
                              NSString *keyStr =[titleArray objectAtIndex:j];
                              NSMutableArray *monthArr = [NSMutableArray array];
                              [monthArr removeAllObjects];
                              for (int i = 0; i < totalArr.count ; i ++) {
                                   NSDictionary *daycellModel = [totalArr objectAtIndex:i];
                                  if ([[daycellModel objectForKey:@"year_day"] isEqualToString:keyStr]) {
                                      [monthArr addObject:daycellModel];
                                  }
                              }
                              [array addObject:monthArr];
                          }
                         
                        //  NSLog(@"%@",array);
        /*end---------------------------------*/
                      }
                  }
                  _page ++;
                  [_tableView reloadData];
                  
            }else{
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
              }
             
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
}

-(void)initView{
    
    chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [chooseBtn setBackgroundColor:[UIColor clearColor]];
    [chooseBtn setBackgroundImage:[UIImage imageNamed:@"订单1-自驾吃"] forState:UIControlStateNormal];
    chooseBtn.frame = CGRectMake(ViewWidth(self.navigationController.navigationBar)/2+25, ViewHeight(self.navigationController.navigationBar)/2-32/2, 40, 32);
    [chooseBtn addTarget:self action:@selector(loadChooseView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:chooseBtn];
   
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth , 100)];
    bgView.backgroundColor = kColor(250, 121, 11);
    [self.view addSubview:bgView];
    
    self.totalSort = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 30)];
    self.totalSort.backgroundColor = [UIColor clearColor];
    self.totalSort.text = self.conditionStr;
    self.totalSort.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.totalSort.textColor = [UIColor whiteColor];
    self.totalSort.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:self.totalSort];
    
    self.total = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, windowContentWidth, 50)];
    self.total.backgroundColor = [UIColor clearColor];
    self.total.text = @"￥0.00";
    self.total.font = [UIFont systemFontOfSize:27];
    self.total.textColor = [UIColor whiteColor];
    self.total.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:self.total];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, windowContentWidth, windowContentHeight - NavHeight -100)];
    _tableView.tableFooterView=[[UIView alloc] init];//去掉多余的cell
    _tableView.delegate = self; _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor ];
   // _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_tableView];

}

-(void)loadChooseView{
    NSArray *arr =[[NSArray alloc] initWithObjects:@"累计收益",@"最近一周收入",@"最近一月收入",@"今日收入", nil];
    if (!chooseView) {
         chooseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
        chooseView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        [self.view addSubview:chooseView];
        chooseView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 45*arr.count)];
        chooseView1.backgroundColor = [UIColor whiteColor];
        [chooseView addSubview:chooseView1];
        for (int i = 0; i<arr.count; i++) {
            ButtonWithImage *btn = [[ButtonWithImage alloc] initWithFrame:CGRectMake(0, 45*i, windowContentWidth, 45)];
            btn.textLabel.text = [arr objectAtIndex:i];
            if( [btn.textLabel.text isEqualToString:self.totalSort.text]){
                btn.imageV.hidden =NO;
            }
            
            btn.tag = i;
            [btn addTarget:self action:@selector(Clicked:) forControlEvents:UIControlEventTouchUpInside];
            [chooseView1 addSubview:btn];
          /*  if (i != arr.count -1) {
                UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45*i+45-0.5, windowContentWidth, 0.5)];
                line.backgroundColor = bordColor;
                [chooseView1 addSubview:line];
            }*/
        }
        [chooseBtn setBackgroundImage:[UIImage imageNamed:@"订单2-自驾吃"] forState:UIControlStateNormal];
    }else if(chooseView && chooseView.hidden == YES){
        chooseView.hidden = NO;
        [chooseBtn setBackgroundImage:[UIImage imageNamed:@"订单2-自驾吃"] forState:UIControlStateNormal];
    }else if(chooseView && chooseView.hidden == NO){
        chooseView.hidden = YES;
        [chooseBtn setBackgroundImage:[UIImage imageNamed:@"订单1-自驾吃"] forState:UIControlStateNormal];
    }
}

-(void)Clicked:(ButtonWithImage *)butn{
    //ButtonWithImage *butn = (ButtonWithImage *)sender;
    NSLog(@"%ld",butn.tag);
    for (ButtonWithImage * btn in [chooseView1 subviews]) {
        if (btn == butn) {
            btn.imageV.hidden = NO;
        }else{
            btn.imageV.hidden = YES;
        }
    }

    self.totalSort.text = butn.textLabel.text;
    self.navigationItem.title = butn.textLabel.text;
    chooseView.hidden = YES;
    [chooseBtn setBackgroundImage:[UIImage imageNamed:@"订单1-自驾吃"] forState:UIControlStateNormal];
    if (butn.tag == 1 || butn.tag == 2) {
        [chooseBtn setFrame:CGRectMake(ViewWidth(self.navigationController.navigationBar)/2+25 +15, ViewHeight(self.navigationController.navigationBar)/2-32/2, 40, 32)];
    }else {
        [chooseBtn setFrame:CGRectMake(ViewWidth(self.navigationController.navigationBar)/2+25, ViewHeight(self.navigationController.navigationBar)/2-32/2, 40, 32)];
    }
    
    self.conditionStr = butn.textLabel.text;
    self.total.text = @"0.00";
    _page =1;
    [titleArray removeAllObjects];titleArray = [[NSMutableArray alloc] init];;
    [array removeAllObjects];array = [[NSMutableArray alloc] init];
    [self loadDataWithParameters];
}

//添加收入逗号格式
-(NSString *)countNumAndChangeformat:(NSString *)num{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {   count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

-(void)close{
    [self.navigationController popViewControllerAnimated:YES];
    [chooseBtn removeFromSuperview];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[array objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v =[[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 35)];
    v.backgroundColor = [UIColor whiteColor];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 1)];
    line1.backgroundColor = bordColor;
    [v addSubview:line1];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, windowContentWidth-15, 35)];
    lab.backgroundColor =[UIColor clearColor];
    lab.textColor = [UIColor orangeColor];
    lab.font = [UIFont systemFontOfSize:15];
    lab.text = [titleArray objectAtIndex:section];
    [v addSubview:lab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 35-1, windowContentWidth, 1)];
    line.backgroundColor = bordColor;
    [v addSubview:line];
    
    return v;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier10000 = @"cellIdentifier10000";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier10000];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier10000];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, windowContentWidth);
        
        
    }
    NSString *str1 = [NSString stringWithFormat:@"%@",[[[array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"log_day"]];
    NSString *str2 = [NSString stringWithFormat:@"%@",[[[array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"log_week"]];
    cell.textLabel.text = [[str1 stringByAppendingString:@"-"] stringByAppendingString:str2];
    cell.detailTextLabel.text = [[[array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] valueForKey:@"daily_income"];
    cell.textLabel.font =cell.detailTextLabel.font=[UIFont systemFontOfSize:14];
    
  
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
