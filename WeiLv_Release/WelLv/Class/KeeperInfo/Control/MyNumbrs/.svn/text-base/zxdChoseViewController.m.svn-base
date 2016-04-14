//
//  zxdChoseViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdChoseViewController.h"

@interface zxdChoseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *zxdTableView;

@property(strong,nonatomic)NSArray *zhiyeArr; //职业
@property(strong,nonatomic)NSArray *incomeArr;//收入
@property(strong,nonatomic)NSArray *fellingArr;//感情
@property(strong,nonatomic)NSArray *educationArr;//教育
@property(strong,nonatomic)NSArray *BoolArr;//血型
@end

@implementation zxdChoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatArr];
    [self creatTableView];
    // Do any additional setup after loading the view.
}
-(void)creatTitle
{
    self.view.backgroundColor = BgViewColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
}
-(void)creatArr
{
    //职业
    self.zhiyeArr = @[@"学生",@"教师",@"公务员",@"人事/行政/前台/秘书",@"金融/银行/保险",@"销售/采购",@"老板",@"自由职业者",@"其他"];
    //收入
    self.incomeArr = @[@"0-3000",@"3000-6000",@"6000-10000",@"10000以上"];
    //感情
    self.fellingArr = @[@"单身",@"求交往",@"暗恋中",@"暧昧中",@"恋爱中",@"订婚",@"已婚"];
    //教育
    self.educationArr = @[@"初中",@"高中",@"大专",@"本科",@"硕士",@"博士",@"博士后"];
    //血型
    self.BoolArr = @[@"A型",@"B型",@"AB型",@"O型"];
  
}

-(void)creatTableView
{
    
    [self.zxdTableView removeFromSuperview];
    self.zxdTableView = [[UITableView alloc] init];
    self.zxdTableView.delegate = self;
    self.zxdTableView.dataSource = self;
    self.zxdTableView.backgroundColor = [YXTools stringToColor:@"#dee5eb"];;
    self.zxdTableView.tableFooterView = [[UIView alloc] init];
    self.zxdTableView.frame = CGRectMake(0, 15, windowContentWidth, windowContentHeight-15);
    if ([self.zxdTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.zxdTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.zxdTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.zxdTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:self.zxdTableView];
//    if (0 == self.type) {
//        //9个
//        //职业
//        self.zxdTableView.frame = CGRectMake(0, 15, windowContentWidth, 405);
//    }
//    else if (2 == self.type)
//    {
//        //4个
//        //收入
//        self.zxdTableView.frame = CGRectMake(0, 15, windowContentWidth, 180);
//    }
//    else if (3 == self.type)
//    {
//        //7个
//         //感情
//        self.zxdTableView.frame = CGRectMake(0, 15, windowContentWidth, 315);
//    }
//    else if (4 == self.type)
//    {
//        //7个
//         //教育
//        self.zxdTableView.frame = CGRectMake(0, 15, windowContentWidth, 315);
//    }
//    else if (6 == self.type)
//    {
//        //4个
//        //血型
//        self.zxdTableView.frame = CGRectMake(0, 15, windowContentWidth, 180);
//    }
}

#pragma mark---tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 1;
    switch (self.type) {
        case 0:
        {
            return self.zhiyeArr.count;
        }
            break;
        case 2:
        {
            return self.incomeArr.count;
        }
            break;
        case 3:
        {
            return  self.fellingArr.count;
        }
            break;
        case 4:
        {
            return self.educationArr.count;
        }
            break;
        case 6:
        {
            return self.BoolArr.count;
        }
            break;
            
        default:
        {
            return 0;
        }
            break;
    }

}
#pragma mark 分割线左边对齐
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    //UITableViewCell *cell = [[UITableViewCell alloc] init];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        UILabel *zxdDetail = [[UILabel alloc] init];
        zxdDetail.textAlignment = NSTextAlignmentLeft;
        zxdDetail.frame = CGRectMake(10, 7, windowContentWidth-100, 30);
        zxdDetail.font = [UIFont systemFontOfSize:15];
        zxdDetail.tag = 551;
        [cell addSubview:zxdDetail];
        
    }
    UILabel *zxdLabel = (UILabel *)[cell viewWithTag:551];
    zxdLabel.textColor = [YXTools stringToColor:@"#6f7378"];
    UIImageView *zxdImageView = [[UIImageView alloc] init];
    zxdImageView.image = [UIImage imageNamed:@"zxdA对号"];
    zxdImageView.frame = CGRectMake(windowContentWidth-50, 15, 21, 14);
    [cell addSubview:zxdImageView];
    zxdImageView.hidden = YES;
    if (indexPath.row == self.didSelect) {
        zxdImageView.hidden = NO;
    }
    switch (self.type) {
        case 0:
        {
            zxdLabel.text = [self.zhiyeArr objectAtIndex:indexPath.row];
            
        }
            break;
        case 2:
        {
            zxdLabel.text = [self.incomeArr objectAtIndex:indexPath.row];
            
        }
            break;
        case 3:
        {
            zxdLabel.text = [self.fellingArr objectAtIndex:indexPath.row];
           
        }
            break;
        case 4:
        {
            zxdLabel.text = [self.educationArr objectAtIndex:indexPath.row];
           
        }
            break;
        case 6:
        {
            zxdLabel.text = [self.BoolArr objectAtIndex:indexPath.row];
                    }
            break;
            
        default:
        {
            
        }
            break;
    }
   zxdLabel.tintColor = [YXTools stringToColor:@"#2f2f2f"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.didSelect = indexPath.row;
    [self creatTableView];
   // DLog(@"============%ld================",self.didSelect);
    // DLog(@"============%ld================",indexPath.row);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)close
{
    [self zxdDelegate];
    
    [self zxdUpDate];
   
    [super close];
}
-(void)zxdDelegate
{
    /*//职业
     self.zhiyeArr = @[@"学生",@"教师",@"公务员",@"人事/行政/前台/秘书",@"金融/银行/保险",@"销售/采购",@"老板",@"自由职业者",@"其他"];
     //收入
     self.incomeArr = @[@"0-3000",@"3001-6000",@"6001-10000",@"10000以上"];
     //感情
     self.fellingArr = @[@"单身",@"求交往",@"暗恋中",@"暧昧中",@"恋爱中",@"订婚",@"已婚"];
     //教育
     self.educationArr = @[@"初中",@"高中",@"大专",@"本科",@"硕士",@"博士",@"博士后"];
     //血型
     self.BoolArr = @[@"A型",@"B型",@"AB型",@"O型"];
*/
    NSMutableArray *arr = nil;
    switch (self.type) {
        case 0:
        {
            
            arr = [[NSMutableArray alloc] initWithArray:self.zhiyeArr];
        }
            break;
        case 2:
        {
           
            arr = [[NSMutableArray alloc] initWithArray:self.incomeArr];
        }
            break;
        case 3:
        {
           arr = [[NSMutableArray alloc] initWithArray:self.fellingArr];
            
        }
            break;
        case 4:
        {
            arr = [[NSMutableArray alloc] initWithArray:self.educationArr];
        }
            break;
        case 6:
        {
            arr = [[NSMutableArray alloc] initWithArray:self.BoolArr];
        }
            break;
            
        default:
        {
            arr = [[NSMutableArray alloc] initWithArray:self.zhiyeArr];
        }
            break;
    }

    if ([self.delegate respondsToSelector:@selector(zxdViewController:text:number:)]) {
        [self.delegate zxdViewController:self text:[arr objectAtIndex:self.didSelect] number:self.type];
        
    }
}
-(void)zxdUpDate
{
     NSDictionary *dic = nil;
    switch (self.type) {
        case 0:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"occupation":[self.zhiyeArr objectAtIndex:self.didSelect]};
        }
            break;
        case 2:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"income":[self.incomeArr objectAtIndex:self.didSelect]};
        }
            break;
        case 3:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"marital_status":[self.fellingArr objectAtIndex:self.didSelect]};
        }
            break;
        case 4:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"educational_background":[self.educationArr objectAtIndex:self.didSelect]};
        }
            break;
        case 6:
        {
            dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                    @"blood_type":[self.BoolArr objectAtIndex:self.didSelect]};
        }
            break;

        default:
            break;
    }
    NSString *url = [NSString stringWithFormat:@"%@%@",WLHTTP,@"/api/assistant/edit_member_info"];
    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict count]==0) {
            [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
            
        }
        else if ([[dict objectForKey:@"status"] integerValue]!=1)
        {
            [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
        }
        else
        {
           // [self zxdDelegate];
           // [super close];
            //NSDictionary *zxdDict = dict[@"msg"];
            // self.zxdDateDict = dict[@"data"];
            //                       [self.DateModel setValuesForKeysWithDictionary:<#(nonnull NSDictionary<NSString *,id> *)#>]
            //
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[LXAlterView sharedMyTools] createTishi:@"保存失败"];
    }];
    

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
