//
//  JYCCustomerTicket.m
//  WelLv
//
//  Created by lyx on 15/11/20.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCCustomerTicket.h"
#import "JYCcustomerCell.h"
#import "WXUtil.h"
#import "DishModel.h"
#define kScreenBounds [[UIScreen mainScreen] bounds]


@interface JYCCustomerTicket ()<UITableViewDataSource,UITableViewDelegate>
{
    AFHTTPRequestOperationManager *manager;
    UIView *backgroundView;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *baseArr;
@end

@implementation JYCCustomerTicket

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=BgViewColor;
    self.title=@"活动设置";
    _baseArr=[[NSMutableArray alloc]init];
    [self initData];
    [self createUI];
}
-(void)initData
{

    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString * memberId = @"446";
    NSString *token1 = [token stringByAppendingString:memberId];
    
    NSDictionary *parameters = @{@"wltoken":[WXUtil md5:token1],@"member_id":memberId};
    
    NSLog(@"%@",parameters);
    NSString *url2=[EatCustomerTicketUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self sendWith:url2 dict:parameters];

    }
-(void) sendWith:(NSString *)str dict:(NSDictionary *)dict
{
    //__weak typeof(self)weakSelf =self;
    
    //[self setProgressHud];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:str parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"----+++++%@",dict);
        if ([dict[@"state"]integerValue]==1) {
       
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            arr=dict[@"data"];
            
            for (NSDictionary *dic in arr) {
                customerTicketModel *model=[[customerTicketModel alloc]init];
                [model setValuesForKeysWithDictionary:dic];
                [self.baseArr addObject:model];
            }
            
        }
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
      
    }];
    

}
-(void)createUI
{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, windowContentHeight-64-10)];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    self.tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.baseArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    
    static NSString *cellID = @"cellID";
    JYCcustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
   // cell.cellSeparateStyle = UITableViewCellSeparateStyleNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    if (cell == nil) {
        cell = [[JYCcustomerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.row==0) {
        cell.bgImageView.image=[UIImage imageNamed:@"底色1"];
    }else if(indexPath.row==1)
    {
        cell.bgImageView.image=[UIImage imageNamed:@"底色2"];
    }else if(indexPath.row==2)
    {
        cell.bgImageView.image=[UIImage imageNamed:@"底色3"];
    }
    
    customerTicketModel *model=[[customerTicketModel alloc]init];
    model=self.baseArr[indexPath.row];
    NSString *str=[NSString stringWithFormat:@"%@?tiket_pwd=%@",Quickmark,model.ticket_pwd];
    [cell.igView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    cell.timeLabel2.text=[NSString stringWithFormat:@"%@",model.come_time];
    cell.nameLabel.text=[NSString stringWithFormat:@"%@",model.describe];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)btnClick:(UIButton *)button
{
    
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
