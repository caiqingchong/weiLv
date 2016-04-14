//
//  zxdExternViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdExternViewController.h"
#import "zxdChoseViewController.h"
#import "zxdChoseLoveViewController.h"
#import "zxdChoseOtherViewController.h"
#import "WritreMessageViewController.h"
#import "MBProgressHUD.h"

#import "zxdLockFourViewController.h"
#import "zxdLockTwoViewController.h"
@interface zxdExternViewController ()<zxdLockFourViewControllerDelegate,zxdLockTwoViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,zxdChoseViewControllerDelegate,zxdChoseLoveViewControllerDelegate,zxdChoseOtherViewControllerDelegate>
@property(nonatomic,strong)UITableView *zxdTableView;
@property(nonatomic,strong)NSArray *zxdArr;
@property(nonatomic,strong)NSMutableArray *zxdArr2;
@property(nonatomic,strong) MBProgressHUD *zxdHud;
@property(nonatomic,assign) BOOL zxdIsSued;


@end

@implementation zxdExternViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatTableView];
    [self downDate];
    // Do any additional setup after loading the view.
}
-(void)creatTitle
{
    self.navigationItem.title = @"扩展信息";
    //[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#6f7378"]}];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
    self.view.backgroundColor = BgViewColor;
}
-(void)creatTableView
{
    self.zxdArr = @[@"职业",@"职位",@"月收入",@"感情状况",@"教育",@"毕业学校",@"血型",@"民族",@"宗教信仰",@"家庭成员",@"出境记录",@"护照",@"忌口"];
    //self.zxdArr2 = [[NSMutableArray alloc] initWithArray:@[@"公务员",@"职位",@"0-3000",@"单身",@"本科",@"毕业学校",@"A型",@"民族",@"宗教信仰",@"家庭成员",@"是否有出境记录",@"是否有护照",@"是否忌口"]];
    self.zxdArr2 = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    self.zxdTableView = [[UITableView alloc] init];
    self.zxdTableView.frame = CGRectMake(0, 15, windowContentWidth, windowContentHeight-64-15);
    self.zxdTableView.backgroundColor = BgViewColor;
    self.zxdTableView.delegate = self;
    self.zxdTableView.dataSource = self;
    self.zxdTableView.showsVerticalScrollIndicator = NO;
    self.zxdTableView.tableFooterView = [[UIView alloc] init];
    if ([self.zxdTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.zxdTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.zxdTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.zxdTableView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self.view addSubview:self.zxdTableView];
}
#pragma mark---tableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.zxdArr.count;
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
        UIImageView *zxdView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-23, ViewHeight(cell)/2-9, 10, 17)];
        [zxdView setImage:[UIImage imageNamed:@"zxdf"]];
        [cell addSubview:zxdView];
        UILabel *zxdLabeHead = [[UILabel alloc] init];
        zxdLabeHead.frame = CGRectMake(10, 7, windowContentWidth-100, 30);
        zxdLabeHead.font = [UIFont systemFontOfSize:15];
        zxdLabeHead.tag = 502;
        zxdLabeHead.tintColor = kColor(89, 90, 92);//[YXTools stringToColor:@"#6f7378"];
        [cell addSubview:zxdLabeHead];
        //cell.textLabel.text = [self.zxdArr objectAtIndex:indexPath.row];
        UILabel *label = [[UILabel alloc] init];
        
        label.frame = CGRectMake(windowContentWidth/2-30, 13, windowContentWidth/2, 20);
        
        label.tag = 501;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [YXTools stringToColor:@"#2f2f2f"];
        [cell addSubview:label];
    }
    UILabel *zxdLabelH = (UILabel *)[cell viewWithTag:502];
    zxdLabelH.text = [self.zxdArr objectAtIndex:indexPath.row];
    zxdLabelH.textColor = [YXTools stringToColor:@"#6f7378"];
    UILabel *label = (UILabel *)[cell viewWithTag:501];
    label.text = [self.zxdArr2 objectAtIndex:indexPath.row];
    return cell;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.zxdIsSued) {
         [[LXAlterView sharedMyTools] createTishi:@"网络出现故障,请先检查网络"];
        return;
    }
    if (indexPath.row == 0||indexPath.row == 2||indexPath.row == 3||indexPath.row == 4||indexPath.row == 6) {
        zxdChoseViewController *zxdVc = [[zxdChoseViewController alloc] init];
        zxdVc.type = indexPath.row;
        zxdVc.didSelect = [self zxdNsstring:[self.zxdArr2 objectAtIndex:indexPath.row] zxdDidSelect:indexPath.row];
        zxdVc.delegate = self;
        zxdVc.uid = self.uid;
        zxdVc.navigationItem.title = [self.zxdArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:zxdVc animated:YES];
    }
    else if (indexPath.row == 1||indexPath.row == 7||indexPath.row == 8||indexPath.row == 11)
    {
        zxdLockTwoViewController *zxdVc2 = [[zxdLockTwoViewController alloc] init];
        //zxdChoseLoveViewController *zxdVc2 = [[zxdChoseLoveViewController alloc] init];
        zxdVc2.type = indexPath.row;
        zxdVc2.uid = self.uid;
        zxdVc2.delegate = self;
        zxdVc2.strtext = [self.zxdArr2 objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:zxdVc2 animated:YES];
    }
    else
    {
        zxdLockFourViewController *zxdVc3 = [[zxdLockFourViewController alloc] init];
        //zxdChoseOtherViewController *zxdVc3 = [[zxdChoseOtherViewController alloc] init];
        zxdVc3.type = indexPath.row;
        //zxdVc3.navigationItem.title = [self.zxdArr objectAtIndex:indexPath.row];
        zxdVc3.starString = [self.zxdArr2 objectAtIndex:indexPath.row];
        zxdVc3.delegate = self;
        zxdVc3.uid = self.uid;
        [self.navigationController pushViewController:zxdVc3 animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark------下载数据
-(void)downDate
{
    NSString *url = [NSString stringWithFormat:@"%@%@",WLHTTP,@"/api/assistant/edit_member_info"];
    
    //    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
    //                          @"select":@"*"};
    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                          @"select":@"*"};

        // NSArray *arr = [[NSArray alloc] initWithObjects:dic, nil];
    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    //data={"token":"7a6bd7af36e5db226281a037909fbdfd","select":"*"}&member_id=31040
    [self setHud:@"正在下载"];
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.zxdHud.hidden = YES;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict count]==0) {
            [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
            weakSelf.zxdIsSued = NO;
        }
        else if ([[dict objectForKey:@"status"] integerValue]!=1)
        {
            [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
            weakSelf.zxdIsSued = NO;
        }
        else if ([[dict objectForKey:@"status"] integerValue]==1&&[[dict objectForKey:@"data"] count]==0)
        {
           
            weakSelf.zxdIsSued = YES;
        }
        else
        {
            NSDictionary *zxdDict = dict[@"data"];
            weakSelf.zxdIsSued = YES;
            [weakSelf fillData:zxdDict];
            //self.zxdDateDict = dict[@"data"];
            //                       [self.DateModel
       // weakSelf.zxdHud.labelText = dict[@"msg"];//setValuesForKeysWithDictionary:<#(nonnull NSDictionary<NSString *,id> *)#>]
            //
        }
        //weakSelf.zxdHud.labelText = dict[@"msg"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.zxdHud.hidden = YES;
        [[LXAlterView sharedMyTools] createTishi:@"网络出现故障"];
        self.zxdIsSued = NO;
    }];
}
-(void)setHud:(NSString *)str
{
    
    self.zxdHud = [[MBProgressHUD alloc] initWithView:self.view];
    self.zxdHud.frame = self.view.bounds;
    self.zxdHud.minSize = CGSizeMake(100, 100);
    self.zxdHud.mode = MBProgressHUDModeIndeterminate;
    self.zxdHud.labelText = str;
    [self.view addSubview:self.zxdHud];
    // [_zxdTableView bringSubviewToFront:self.zxdHud];
    [self.zxdHud show:YES];
}
-(void)fillData:(NSDictionary *)zxdDict
{
    //职业
    NSString *occupation = [self judgeString:zxdDict[@"occupation"]]?zxdDict[@"occupation"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:0 withObject:occupation];
    //职位
    NSString * position = [self judgeString:zxdDict[@"position"]]?zxdDict[@"position"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:1 withObject:position];
    //月收入
    NSString * incom= [self judgeString:zxdDict[@"income"]]?zxdDict[@"income"]:@"0-3000";
    [self.zxdArr2 replaceObjectAtIndex:2 withObject:incom];
    //感情状况
    NSString * marital_status= [self judgeString:zxdDict[@"marital_status"]]?zxdDict[@"marital_status"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:3 withObject:marital_status];
    //教育状况
    NSString * educational_background= [self judgeString:zxdDict[@"educational_background"]]?zxdDict[@"educational_background"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:4 withObject:educational_background];
    //毕业学校
    NSString * info_school= [self judgeString:zxdDict[@"info_school"]]?zxdDict[@"info_school"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:5 withObject:info_school];
    //血型
    NSString * blood_type= [self judgeString:zxdDict[@"blood_type"]]?zxdDict[@"blood_type"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:6 withObject:blood_type];
    //民族
    NSString * nation=[self judgeString:zxdDict[@"nation"]]?zxdDict[@"nation"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:7 withObject:nation];
    //宗教信仰
    NSString * religiou= [self judgeString:zxdDict[@"religiou"]]?zxdDict[@"religiou"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:8 withObject:religiou];
    //家庭成员
    NSString * family= [self judgeString:zxdDict[@"family"]]?zxdDict[@"family"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:9 withObject:family];
    //是否有出境记录
    NSString * exit_log= [self judgeString:zxdDict[@"exit_log"]]?zxdDict[@"exit_log"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:10 withObject:exit_log];
    ///是否有护照
    NSString * passport= [self judgeString:zxdDict[@"passport"]]?zxdDict[@"passport"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:11 withObject:passport];
    //是否忌口
    NSString * diet_taboo= [self judgeString:zxdDict[@"diet_taboo"]]?zxdDict[@"diet_taboo"]:@"";
    [self.zxdArr2 replaceObjectAtIndex:12 withObject:diet_taboo];
    //刷新
    [self.zxdTableView reloadData];
    //
    //
    
}
-(NSInteger)zxdNsstring:(NSString *)string zxdDidSelect:(NSInteger)row
{
    // 职位0 2月收入 3感情 4教育 6血型
    ///
   // self.zhiyeArr = @[@"学生",@"教师",@"公务员",@"人事/行政/前台/秘书",@"金融/银行/保险",@"销售/采购",@"老板",@"自由职业者",@"其他"];
    //收入
    //self.incomeArr = @[@"0-3000",@"3001-6000",@"6001-10000",@"10000以上"];
    //感情
    //self.fellingArr = @[@"单身",@"求交往",@"暗恋中",@"暧昧中",@"恋爱中",@"订婚",@"已婚"];
    //教育
    //self.educationArr = @[@"初中",@"高中",@"大专",@"本科",@"硕士",@"博士",@"博士后"];
    //血型
   // self.BoolArr = @[@"A型",@"B型",@"AB型",@"O型"];

    switch (row) {
        case 0:
        {
            if ([string isEqualToString:@"学生"]) {
                return 0;
            }
            else if ([string isEqualToString:@"教师"])
            {
                return 1;
            }
            else if ([string isEqualToString:@"公务员"])
            {
                return 2;
            }
            else if ([string isEqualToString:@"人事/行政/前台/秘书"])
            {
                return 3;
            }
            else if ([string isEqualToString:@"金融/银行/保险"])
            {
                return 4;
            }

            else if ([string isEqualToString:@"销售/采购"])
            {
                return 5;
            }
            else if ([string isEqualToString:@"老板"])
            {
                return 6;
            }

            else if ([string isEqualToString:@"自由职业者"])
            {
                return 7;
            }
            else if ([string isEqualToString:@"其他"])
            {
                return 8;
            }
            else
            {
                return 0;
            }

        }
            break;
        case 2:
        {
            if ([string isEqualToString:@"0-3000"]) {
                return 0;
            }
            else if ([string isEqualToString:@"3000-6000"])
            {
                return 1;
            }
            else if ([string isEqualToString:@"6000-10000"])
            {
                return 2;
            }
            else if ([string isEqualToString:@"10000以上"])
            {
                return 3;
            }
            else{
                return 0;
            }
        }
            break;
        case 3:
        {
            if ([string isEqualToString:@"单身"]) {
                return 0;
            }
            else if ([string isEqualToString:@"求交往"])
            {
                return 1;
            }
            else if ([string isEqualToString:@"暗恋中"])
            {
                return 2;
            }
            else if ([string isEqualToString:@"暧昧中"])
            {
                return 3;
            }
            else if ([string isEqualToString:@"恋爱中"])
            {
                return 4;
            }
            else if ([string isEqualToString:@"订婚"])
            {
                return 5;
            }
            
            else if ([string isEqualToString:@"已婚"])
            {
                return 6;
            }
            else{
                return 0;
            }
            
        }
            break;
        case 4:
        {
            if ([string isEqualToString:@"初中"]) {
                return 0;
            }
            else if ([string isEqualToString:@"高中"])
            {
                return 1;
            }
            else if ([string isEqualToString:@"大专"])
            {
                return 2;
            }
            else if ([string isEqualToString:@"本科"])
            {
                return 3;
            }
            else if ([string isEqualToString:@"硕士"])
            {
                return 4;
            }
            
            else if ([string isEqualToString:@"博士"])
            {
                return 5;
            }
            else if ([string isEqualToString:@"博士后"])
            {
                return 6;
            }
            
            else
            {
                return 0;
            }
            

        }
            break;
        case 6:
        {
            if ([string isEqualToString:@"A型"]) {
                return 0;
            }
            else if ([string isEqualToString:@"B型"])
            {
                return 1;
            }
            else if ([string isEqualToString:@"AB型"])
            {
                return 2;
            }
            else if ([string isEqualToString:@"O型"])
            {
                return 3;
            }
            else
            {
                return 0;
            }
            
            
        }
            break;
        default:
            return 0;
            break;
    }
    return 1;
}
#pragma mark----- 实现职业等代理回调
-(void)zxdViewController:(zxdChoseViewController *)zxdVC text:(NSString *)string number:(NSInteger)number
{
    [self.zxdArr2 replaceObjectAtIndex:number withObject:string];
    [self.zxdTableView reloadData];
}
#pragma mark------实现毕业学校等代理回调
-(void)zxdViewController:(zxdChoseLoveViewController *)zxdVC text:(NSString *)string Number:(NSInteger)number
{
    [self.zxdArr2 replaceObjectAtIndex:number withObject:string];
    [self.zxdTableView reloadData];
}
#pragma mark-----民族宗教信仰代理回调
-(void)zxdViewController3:(zxdChoseOtherViewController *)zxdVC text:(NSString *)string number:(NSInteger)number
{
    
    [self.zxdArr2 replaceObjectAtIndex:number withObject:string];
    [self.zxdTableView reloadData];
}

//修改后的代理回调
-(void)zxdViewController4:(zxdLockTwoViewController *)zxdVC text:(NSString *)string Number:(NSInteger)number
{
    [self.zxdArr2 replaceObjectAtIndex:number withObject:string];
    [self.zxdTableView reloadData];

}
-(void)zxdViewController5:(zxdLockFourViewController *)zxdVC text:(NSString *)string number:(NSInteger)number
{
    [self.zxdArr2 replaceObjectAtIndex:number withObject:string];
    [self.zxdTableView reloadData];

}

#pragma mark------实现数据修改
-(void)zxdChangedownDate
{
    NSString *url = [NSString stringWithFormat:@"%@%@",WLHTTP,@"/api/assistant/edit_member_info"];
    
    //    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
    //                          @"select":@"*"};
      // NSArray *arr = [[NSArray alloc] initWithObjects:dic, nil];
    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                          @"occupation":[self.zxdArr2 objectAtIndex:0],
                          @"position":[self.zxdArr2 objectAtIndex:1],
                          @"incom":[self.zxdArr2 objectAtIndex:2],
                          @"marital_status":[self.zxdArr2 objectAtIndex:3],
                          @"educational_background":[self.zxdArr2 objectAtIndex:4],
                          @"info_school":[self.zxdArr2 objectAtIndex:5],
                          @"blood_type":[self.zxdArr2 objectAtIndex:6],
                          @"nation":[self.zxdArr2 objectAtIndex:7],
                          @"religiou":[self.zxdArr2 objectAtIndex:8],
                          @"family":[self.zxdArr2 objectAtIndex:9],
                          };

    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    //data={"token":"7a6bd7af36e5db226281a037909fbdfd","select":"*"}&member_id=31040
    [self setHud:@"正在保存"];
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.zxdHud.hidden = YES;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dict count]==0) {
            [[LXAlterView sharedMyTools] createTishi:@"数据修改失败"];
            
        }
        else if ([[dict objectForKey:@"status"] integerValue]!=1)
        {
            [[LXAlterView sharedMyTools] createTishi:@"数据修改失败"];
        }
        else
        {
           // NSDictionary *zxdDict = dict[@"data"];
            [self.navigationController popViewControllerAnimated:YES];
            
            //self.zxdDateDict = dict[@"data"];
            //                       [self.DateModel
            // weakSelf.zxdHud.labelText = dict[@"msg"];//setValuesForKeysWithDictionary:]
            //
        }
        //weakSelf.zxdHud.labelText = dict[@"msg"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.zxdHud.hidden = NO;
    }];
}
-(void)close
{
    //[self zxdChangedownDate];
    [super close];
    
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
