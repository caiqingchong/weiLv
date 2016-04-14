//
//  JYCInfomationVC.m
//  WelLv
//
//  Created by lyx on 15/9/12.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCInfomationVC.h"
#import "JYCTicketCell.h"
#import "JYCInfomationWebview.h"
@interface JYCInfomationVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIView *_footView;
}

@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *arr;;
@end

@implementation JYCInfomationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"机票服务信息";
    self.view.backgroundColor=[UIColor whiteColor];
    _footView=[[UIView alloc]init];
    _footView.backgroundColor=[UIColor clearColor];
    [self initData];
    [self initView];
}
-(void)initData
{
   self.arr=[NSArray arrayWithObjects:@"网上购票须知",@"电子机票等机说明",@"电子机票退改签说明",@"航空保险说明", nil];
}
-(void)initView
{
    
    if (!self.tableView) {
        //如果没有再创建  懒加载
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,windowContentWidth,windowContentHeight) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    
        self.tableView.tableFooterView=_footView;
        [self.view addSubview:self.tableView];
       
    }

}
#pragma mark - <UITableViewDataSource, UITableViewDelegate>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    JYCTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[JYCTicketCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID height:60];
    }
    cell.leftImageView.image=[UIImage imageNamed:@"Grid"];
    cell.infoLabel.text=self.arr[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"111");
    JYCInfomationWebview *JYCWebView=[[JYCInfomationWebview alloc]init];
    JYCWebView.WebTitle=self.arr[indexPath.row];
    [self.navigationController pushViewController:JYCWebView animated:YES];
    
    
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
