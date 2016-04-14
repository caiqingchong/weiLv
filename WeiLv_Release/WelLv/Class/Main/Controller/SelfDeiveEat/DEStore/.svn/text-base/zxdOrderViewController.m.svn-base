//
//  zxdOrderViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/25.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "zxdOrderViewController.h"

@interface zxdOrderViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_zxdTableView;
    NSMutableArray *_arrImage;
    UISwitch *_sw;
}
@property(nonatomic,strong)UISwitch *sw;
@property(nonatomic,strong)UITableView *zxdTableView;
@property(nonatomic,strong)NSMutableArray *arrImage;
@end

@implementation zxdOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    // Do any additional setup after loading the view.
}
-(void)creatTableView
{
    
    NSArray *arr1 = @[@"合计"];
    NSArray *arr2 = @[@"就餐时间",@"就餐人数",@"是否包间",@"备注"];
    NSArray *arr3 = @[@"联系人",@"手机号"];
    self.view.backgroundColor = BgViewColor;
    self.arrImage = [[NSMutableArray alloc] initWithObjects:arr1,arr2,arr3, nil];

    self.zxdTableView = [[UITableView alloc] init];
    self.zxdTableView.frame = CGRectMake(0, 0, windowContentWidth, windowContentHeight);
    self.zxdTableView.tableFooterView = [[UIView alloc] init];//多余的cell
    self.zxdTableView.backgroundColor = [UIColor clearColor];
    self.zxdTableView.delegate = self;
    self.zxdTableView.dataSource = self;
    [self.zxdTableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.zxdTableView];
    
}
#pragma mark-UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrImage.count;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:self.zxdTableView.tableHeaderView.frame];
    header.backgroundColor = [UIColor clearColor];
    return header;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.arrImage objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdtifier = @"CellIdtifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdtifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdtifier];
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [[self.arrImage objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    }
    if (indexPath.section==1&&indexPath.row ==2) {
        self.sw = [[UISwitch alloc] initWithFrame:CGRectMake(windowContentWidth-80, 5, 45, 30)];
        
        [self.sw setOn:NO];
        [self.sw addTarget:self action:@selector(zxdSWAction:) forControlEvents:UIControlEventEditingChanged];
        [cell addSubview:self.sw];
    }
    else
    {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(windowContentWidth-60, 5, 45, 30);
        label.text = @"123";
        label.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label];
    }
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld----%ld",indexPath.section,indexPath.row);
}
-(void)zxdSWAction:(id)sender
{
    
    if ([self.sw isOn]) {
        [self.sw setOn:NO animated:YES];
        NSLog(@"是");
    }
    else
    {
         [self.sw setOn:YES animated:YES];
        NSLog(@"否");
    }
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
