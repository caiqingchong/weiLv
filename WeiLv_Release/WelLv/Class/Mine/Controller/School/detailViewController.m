//
//  detailViewController.m
//  WelLv
//
//  Created by mac for csh on 15/9/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "detailViewController.h"
#import "detailTableViewCell.h"
#import "TextWebViewViewController.h"
#import "VideoViewController.h"

@interface detailViewController ()
{
    NSArray *secondArray;
}

@end

@implementation detailViewController
@synthesize idd;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = BgViewColor;
    NSLog(@"idd = %@",idd);
    [self initData];
}

-(void)initData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters =  @{@"id":idd};
   // NSLog(@"uir :%@  \n  paramers is %@",detailSchoolSources,parameters);
    NSString *url = [detailSchoolSources stringByAppendingString:[NSString stringWithFormat:@"/%@",idd]];
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              
              id arr = [dict objectForKeyedSubscript:@"results"];
              if (  [arr isKindOfClass:[NSArray class]]) {
                  secondArray = [NSArray arrayWithArray:arr];
                  if (secondArray.count>0) {
                      [self initView];
                  }
              }else{
                  //[[LXAlterView sharedMyTools]createTishi:@"暂无数据"];
              }
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];

}

-(void)initView{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.backgroundColor = BgViewColor;
    _tableView.delegate = self;_tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.tableFooterView = [[UIView alloc] init];
}

#define cellHeight 40.0

#pragma mark -
#pragma mark Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [secondArray count]; // 分组数
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // return [[[secondArray objectAtIndex:section] objectForKey:@"title"] count];
    NSArray *array = [[secondArray objectAtIndex:section] objectForKey:@"title"];
    
    if (flag[section]) {
        return [array count];
    }
    else{
        return 0;
    }
   
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, 45)];
    vv.backgroundColor = [UIColor whiteColor];
    vv.tag = section;
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 12.5, 20, 20)];
    leftImageView.image = [UIImage imageNamed:@"分类图标1"];
    [vv addSubview:leftImageView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(35+10, 0,ViewWidth(_tableView) , 45)];
    lab.text = [[secondArray objectAtIndex:section] valueForKey:@"name"];
    [vv addSubview:lab];

    UILabel *labb = [[UILabel alloc] initWithFrame:CGRectMake(0, 45- 0.7, self.tableView.bounds.size.width, 0.7)];
    labb.backgroundColor = bordColor;
    [vv addSubview:labb];
    UILabel *labbb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 0.7)];
    labbb.backgroundColor = bordColor;
    [vv addSubview:labbb];
    
    UIButton *butn = [UIButton buttonWithType:UIButtonTypeCustom];
    butn.frame = vv.frame;
    butn.backgroundColor = [UIColor clearColor];
    butn.tag = section;
    [butn addTarget: self action:@selector(changeSubView:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:butn];
    
    return vv;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    detailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[detailTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell titleLab].text =[[[[secondArray objectAtIndex:indexPath.section] objectForKey:@"title"] objectAtIndex:indexPath.row] objectForKey:@"stitle"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *boolstr = [[[[secondArray objectAtIndex:indexPath.section] objectForKey:@"title"] objectAtIndex:indexPath.row] objectForKey:@"content"];
    if ([boolstr containsString:@".html"]) {
        VideoViewController *videoVC = [[VideoViewController alloc] init];
        videoVC.title = [[[[secondArray objectAtIndex:indexPath.section] objectForKey:@"title"] objectAtIndex:indexPath.row] objectForKey:@"stitle"];
        videoVC.urlString = [[[[secondArray objectAtIndex:indexPath.section] objectForKey:@"title"] objectAtIndex:indexPath.row] objectForKey:@"content"];
        [self.navigationController pushViewController:videoVC animated:YES];
        
    }else{
        TextWebViewViewController *textWebVC = [[TextWebViewViewController alloc] init];
        NSString *content = [NSString stringWithFormat:@"<span style=color:#99BB00;></span>\n%@",[[[[secondArray objectAtIndex:indexPath.section] objectForKey:@"title"] objectAtIndex:indexPath.row] objectForKey:@"content"]];
        textWebVC.webContent = content;
        textWebVC.WebTitle = [[[[secondArray objectAtIndex:indexPath.section] objectForKey:@"title"] objectAtIndex:indexPath.row] objectForKey:@"stitle"];
        [self.navigationController pushViewController:textWebVC animated:YES];
    }
}

-(void)changeSubView:(UIButton *)button{
    
    NSInteger section = button.tag;
    // 取反
    flag[section] = !flag[section];
    
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    
    //  效率略高于reloadData
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];

}

@end
