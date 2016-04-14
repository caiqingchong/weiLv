//
//  ChoseBankViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/4.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ChoseBankViewController.h"
#import "BankCell.h"

@interface ChoseBankViewController ()
{
    UITableView *_tableView;
    NSMutableArray *firstArr;
    NSMutableArray *bankArr;
}

@end

@implementation ChoseBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    

    [self initData];
}

-(void)initData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    [manager POST:GetBankList parameters:nil
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              if ([[dict objectForKey:@"state"] integerValue] ==1 ) {
                  
                  [bankArr removeAllObjects];
                  bankArr = [[NSMutableArray alloc] init];
                  NSArray *hotArray = [[dict objectForKey:@"data"] objectForKey:@"hot"];
                  [bankArr addObject:hotArray];
                  
                  [self arraysort:[[dict objectForKey:@"data"] objectForKey:@"other"]];
                  NSLog(@"%@",firstArr);
                  for (int i = 1; i < firstArr.count; i++) {
                      NSString *keyString = [firstArr objectAtIndex:i];
                      
                      NSMutableArray *arr = [[NSMutableArray alloc] init];
                      NSArray *otheraddarr = [[dict objectForKey:@"data"] objectForKey:@"other"];
                      for (id dic in  otheraddarr ) {
                          if ([[(NSDictionary *)dic objectForKey:@"first"] isEqualToString:keyString]) {
                              [arr addObject:dic];
                          }
                      }
                      [bankArr addObject:arr];
                      NSLog(@"bankarr %@",bankArr);
                  }
                  
                  [self inittableView];
                //  NSLog(@"first:%@\nbank:%@",firstArr,bankArr);
                 
              }else{
                  [[LXAlterView alloc]createTishi:[dict objectForKey:@"msg"]];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];

}

-(void)inittableView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.tableFooterView=[[UIView alloc] init];//去掉多余的cell
    _tableView.delegate = self; _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


-(void )arraysort:(NSMutableArray *)array{
    NSMutableArray *firstCodeArr = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (int i = 0; i< array.count; i++) {
        NSString *string1 = [[array objectAtIndex:i] objectForKey:@"first"];
        if ([firstCodeArr indexOfObject:string1] == NSNotFound) {
            [firstCodeArr addObject:string1];
        }
    }
    
    NSArray *arr = [firstCodeArr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    [firstArr removeAllObjects];
    firstArr = [[NSMutableArray alloc] init];
    [firstArr addObject:@"热门"];
    for (int x=0; x<arr.count; x++) {
        [firstArr addObject:[arr objectAtIndex:x]];
    }
    
    //NSLog(@"%@",firstArr);
}

#pragma mark ---- UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return firstArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[bankArr objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

//设置区头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [firstArr objectAtIndex:section];
}
//索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return firstArr;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentifier = @"listCell";
    BankCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell) {
        cell = [[BankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
        
    }
    NSString * str = [[[bankArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.nameLabel.text = str;
    
    NSString *strr = [WLHTTP stringByAppendingString:[[[bankArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"image"]];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:strr] placeholderImage:[UIImage imageNamed:@"默认图2"]];

    
    return cell;
    
}

#pragma mark - UITableViewDelegate
//给区头设置背景色。
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    view.tintColor =  BgViewColor;//[UIColor colorWithRed:131 /255.0 green:146/255.0 blue:156/255.0 alpha:1.0];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [[[bankArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"name"];
    //创建通知
    NSDictionary *dic = @{@"text":str};
    NSNotification *notification =[NSNotification notificationWithName:@"ChooseBankTZ" object:nil userInfo:dic];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
