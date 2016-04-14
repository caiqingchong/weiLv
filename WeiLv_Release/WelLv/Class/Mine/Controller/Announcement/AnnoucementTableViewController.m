//
//  AnnoucementTableViewController.m
//  WelLv
//
//  Created by mac for csh on 15/9/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "AnnoucementTableViewController.h"
#import "AnnounceTableViewCell.h"
#import "LXCommonTools.h"
#import "TextWebViewViewController.h"

@interface AnnoucementTableViewController ()
{
    int _currentPage;
    int _offset;
    
    UITableView *_tableView;
    NSMutableArray *annouceArray;
}
@end

@implementation AnnoucementTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"系统公告";
   
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.tableFooterView=[[UIView alloc] init];//去掉多余的cell
    _tableView.delegate = self; _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self initData];
}

-(void)initData{
    _currentPage=2;
    _offset=1;
    if (annouceArray) {
        [annouceArray removeAllObjects];
    }
    annouceArray = [[NSMutableArray alloc] init];
    NSString *offset1=[NSString stringWithFormat:@"%d",0];
    NSDictionary *dic=@{@"offset":offset1,@"limit":@"10"};
    [self sendRequest:dic];
    
    //----------上拉加载更多
    [_tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)loadLastData
{
    _offset=_currentPage;
    NSString *offset1=[NSString stringWithFormat:@"%ld",(long)_offset];
    NSDictionary *dic=@{@"offset":offset1,@"limit":@"10"};
    [self sendRequest:dic];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [_tableView.footer endRefreshing];
        _currentPage++;
    });
}


-(void)sendRequest:(NSDictionary *)parameters
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:AnnoucementList parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              
              id dd = [dict objectForKey:@"announce_list"];
              if ([dd isKindOfClass:[NSArray class]] && [dd count]>0) {
                  for (int i = 0; i < [dd count]; i++) {
                      NSDictionary *detailDic = [[NSDictionary alloc] initWithDictionary:[dd objectAtIndex:i]];
                      [annouceArray addObject:detailDic];
                  }
                 
                  [_tableView reloadData];
                 [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              }
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return annouceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier10000 = @"cellIdentifier10000";
    AnnounceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier10000];
    
    if (cell == nil)
    {
        cell = [[AnnounceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier10000];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = [annouceArray objectAtIndex:indexPath.row];
    cell.timeLab.text = [dic objectForKey:@"senddate"];
    cell.contentLab.text = [dic objectForKey:@"title"];
   /* CGFloat hgt = [[LXCommonTools sharedMyTools] textHeight:cell.contentLab.text Afont:15 width:ViewWidth(cell.contentLab)];
   // NSLog(@"str = %@\nhgt = %f",cell.contentLab.text,hgt);
    if (hgt>28) {
       cell.contentLab.numberOfLines = 2;
        cell.contentLab.frame = CGRectMake(15, 20+5, windowContentWidth -15*2, 40);
    }else{
        cell.contentLab.numberOfLines = 1;
        cell.contentLab.frame = CGRectMake(15, 20+5, windowContentWidth -15*2, 20);
    }*/
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TextWebViewViewController *textWebVC = [[TextWebViewViewController alloc] init];
    NSString *content = [[annouceArray objectAtIndex:indexPath.row] objectForKey:@"content"];
    textWebVC.webContent = content;
    textWebVC.WebTitle = [[annouceArray objectAtIndex:indexPath.row] objectForKey:@"title"];;
    [self.navigationController pushViewController:textWebVC animated:YES];
}







@end
