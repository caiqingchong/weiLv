//
//  likeOfSelfViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "likeOfSelfViewController.h"
#import "zxdLoveViewController.h"
#import "MBProgressHUD.h"
@interface likeOfSelfViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *zxdTableView;
@property(strong,nonatomic)NSArray *zxdArr;
@property(strong,nonatomic)NSMutableArray *zxdImageArr;
@property(strong,nonatomic)NSMutableArray *zxdArrtheme;
@property(strong,nonatomic)NSMutableArray *zxdArrtype;
@property(strong,nonatomic)NSMutableArray *zxdArrseason;
@property(strong,nonatomic)NSMutableArray *zxdArrregion;
@property(nonatomic,strong) MBProgressHUD *zxdHud;
@property(nonatomic,assign)BOOL zxdIsSued;
@end

@implementation likeOfSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatTableView];
    [self zxdDownDate];
    // Do any additional setup after loading the view.
}
-(void)creatTitle
{
    
    self.navigationItem.title = @"个人偏好";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
       self.view.backgroundColor =  BgViewColor;
}
-(void)creatTableView
{
    self.zxdArr = @[@"出游偏好主题",@"出游偏好类型",@"出游偏好时节",@"出游偏好地域"];
    self.zxdTableView = [[UITableView alloc] init];
    self.zxdTableView.frame = CGRectMake(0, 15, windowContentWidth, 180-5);
    self.zxdTableView.dataSource = self;
    self.zxdTableView.delegate= self;
    self.zxdTableView.tableFooterView = [[UIView alloc] init];
    self.zxdTableView.scrollEnabled = NO;
    [self.zxdTableView setShowsVerticalScrollIndicator:NO];
    if ([self.zxdTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.zxdTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.zxdTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.zxdTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.view addSubview:self.zxdTableView];
    
}
#pragma mark----tableViewDelegate
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    //UITableViewCell *cell = [[UITableViewCell alloc] init];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;//去掉点击时候灰色
        UIImageView *zxdView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-23, ViewHeight(cell)/2-9, 10, 17)];
        [zxdView setImage:[UIImage imageNamed:@"zxdf"]];
        [cell addSubview:zxdView];
        UILabel *zxdDetail  = [[UILabel alloc] init];
        zxdDetail.frame = CGRectMake(10, 7, windowContentWidth/2, 30);
        zxdDetail.tag = 606;
        [cell addSubview:zxdDetail];
        //cell.textLabel.tintColor = [YXTools stringToColor:@"#6f7378"];
        //cell.textLabel.font = [UIFont systemFontOfSize:15];
        //cell.textLabel.text = [self.zxdArr objectAtIndex:indexPath.row];
        }
    UILabel *zxdHead = (UILabel *)[cell viewWithTag:606];
    zxdHead.textColor = [YXTools stringToColor:@"#6f7378"];
    zxdHead.font = [UIFont systemFontOfSize:15];
    zxdHead.text = [self.zxdArr objectAtIndex:indexPath.row];
    return cell;

}
#pragma mark----点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (!self.zxdIsSued) {
         [[LXAlterView sharedMyTools] createTishi:@"网络出现故障,请先检查网络"];
        return;
    }
    zxdLoveViewController *zxdVC = [[zxdLoveViewController alloc] init];
    zxdVC.Type = indexPath.row;
    zxdVC.arrAddImage = [[NSMutableArray alloc] init];
    zxdVC.uid = self.uid;
    zxdVC.zxdDownArr = [self.zxdImageArr objectAtIndex:indexPath.row];
    zxdVC.arrAddImage = [self.zxdImageArr objectAtIndex:indexPath.row];
    zxdVC.navigationItem.title = [self.zxdArr objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:zxdVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)zxdDownDate
{
 NSString *url = [NSString stringWithFormat:@"%@%@",WLHTTP,@"/api/assistant/edit_member_info"];
    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                          @"select":@"theme,type,season,region"};
    //@"theme,type,season,region"
    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    [self setHud:@"正在下载"];
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.zxdHud.hidden = YES;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([dict count]==0) {
            [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
            [self zxdCreatArr];
            //self.zxdIsSued = NO;
            
        }
        else if ([[dict objectForKey:@"status"] integerValue]!=1)
        {
            [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
            [self zxdCreatArr];
             //self.zxdIsSued = NO;
        }
        else
        {
            NSDictionary *zxd = dict[@"data"];
             self.zxdIsSued = YES;
            //主题类型
            if ([self judgeString:zxd[@"type"]]) {
                [self.zxdArrtype removeAllObjects];
                self.zxdArrtype = zxd[@"type"];
                
                
          //  DLog(@"=========%@",str);
            }
            else
            {
                self.zxdArrtype =[[NSMutableArray alloc] initWithArray:@[@"城市古镇"]];
            }
            //偏好主题
            if ([self judgeString:zxd[@"theme"]]) {
                [self.zxdArrtheme removeAllObjects];
                self.zxdArrtheme = zxd[@"theme"];
                
                //  DLog(@"=========%@",str);
            }
            else
            {
                self.zxdArrtheme =[[NSMutableArray alloc] initWithArray:@[@"自驾摄影"]];
            }
            //偏好时节
            if ([self judgeString:zxd[@"season"]]) {
                [self.zxdArrseason removeAllObjects];
                self.zxdArrseason = zxd[@"season"];
                //  DLog(@"=========%@",str);
            }
            else
            {
                self.zxdArrseason =[[NSMutableArray alloc] initWithArray:@[@"七夕"]];
            }
            //偏好地域
            if ([self judgeString:zxd[@"region"]]) {
                [self.zxdArrregion removeAllObjects];
                self.zxdArrregion = zxd[@"region"];
                //  DLog(@"=========%@",str);
            }
            else
            {
                self.zxdArrregion =[[NSMutableArray alloc] initWithArray:@[@"海南"]];
            }
            self.zxdImageArr =[[NSMutableArray alloc] initWithObjects:self.zxdArrtheme,self.zxdArrtype,self.zxdArrseason,self.zxdArrregion, nil] ;
        }
       
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           weakSelf.zxdHud.hidden = YES;
          [[LXAlterView sharedMyTools] createTishi:@"网络出现故障"];
         self.zxdIsSued = NO;
        [self zxdCreatArr];
    }];
    
}
-(void)zxdCreatArr
{
   self.zxdArrtype =[[NSMutableArray alloc] initWithArray:@[@"城市古镇"]];
    self.zxdArrtheme =[[NSMutableArray alloc] initWithArray:@[@"自驾摄影"]];
    self.zxdArrseason =[[NSMutableArray alloc] initWithArray:@[@"七夕"]];
    self.zxdArrregion =[[NSMutableArray alloc] initWithArray:@[@"海南"]];
    self.zxdImageArr =[[NSMutableArray alloc] initWithObjects:self.zxdArrtheme,self.zxdArrtype,self.zxdArrseason,self.zxdArrregion, nil] ;

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
