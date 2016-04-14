//
//  zxdRemarksViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdRemarksViewController.h"
#import "zxdWriteRemarksViewController.h"
#import "zxdMemberModel.h"
#import "MBProgressHUD.h"
@interface zxdRemarksViewController ()<UITableViewDataSource,UITableViewDelegate,zxdWriteRemarksViewControllerDelegate>
@property(nonatomic,strong)UITableView *zxdTableView;
@property(nonatomic,strong)NSMutableArray *zxdArrImage;
@property(nonatomic,strong)zxdMemberModel *model1;
@property(nonatomic,strong) MBProgressHUD *zxdHud;
@property(nonatomic,strong)NSMutableArray *zxdArr1;
@property(nonatomic,strong)NSMutableArray *zxdArr2;
@property(nonatomic,strong)NSMutableArray *zxdArr3;
@property(nonatomic,strong)NSMutableArray *zxdArr4;
@property(nonatomic,strong)NSMutableArray *zxdArr5;
@end

@implementation zxdRemarksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
   [self creatTableView];
    [self downData];
    // Do any additional setup after loading the view.
}
-(void)creatTableView
{
    //NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //[self.zxdArrImage addObject:arr];
    [self.zxdTableView removeFromSuperview];
    self.zxdTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, windowContentWidth, windowContentHeight-64)];
    self.zxdTableView.backgroundColor = BgViewColor;
    self.zxdTableView.delegate = self;
    self.zxdTableView.dataSource = self;
    self.zxdTableView.tableFooterView = [[UIView alloc] init];
    self.zxdTableView.showsVerticalScrollIndicator = NO;
    if ([self.zxdTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.zxdTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.zxdTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.zxdTableView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self.view addSubview:self.zxdTableView];
}
-(void)creatTitle
{
    self.view.backgroundColor = BgViewColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
    self.zxdArrImage = [[NSMutableArray alloc] init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"zxd添加按钮"] style:UIBarButtonItemStyleDone target:self action:@selector(zxdConserveright)];
    
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
#pragma mark ----TableViewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // return 1;
    return self.zxdArrImage.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.zxdArrImage.count;
    return [[self.zxdArrImage objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    zxdMemberModel *model = [[self.zxdArrImage objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    CGSize zxdSize = [self sizeWithString:model.tag font:[UIFont systemFontOfSize:15]];
    return zxdSize.height + 55;
    //return 60;
}
#pragma mark----头视图
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:_zxdTableView.tableHeaderView.frame];
    header.backgroundColor = BgViewColor;
    return header;
}
#pragma mark---定制cell删除按钮
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        
        [self zxdDeletData:indexPath];
        
    }];
    deleteRowAction.backgroundColor = [UIColor orangeColor];
       return @[deleteRowAction];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
       cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        UILabel *dataLabel = [[UILabel alloc] init];
        dataLabel.tag = 500;
        dataLabel.font = [UIFont systemFontOfSize:14];
        UILabel *label = [[UILabel alloc] init];
        label.tag = 550;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentLeft;
    //cell.textLabel.text = self.model1.tag;//[self.arrImage objectAtIndex:indexPath.row];
        //cell.textLabel.numberOfLines=0;
                //[self.arrDate objectAtIndex:indexPath.row];
        //dataLabel.textAlignment = NSTextAlignmentCenter;
         [cell addSubview:label];
         [cell addSubview:dataLabel];
           }
     zxdMemberModel *model = [[self.zxdArrImage objectAtIndex:indexPath.section ] objectAtIndex:indexPath.row];
         // cell.textLabel.text = model.tag;
          UILabel *dataLabel = [cell viewWithTag:500];
           UILabel *label = [cell viewWithTag:550];
          CGSize zxdSize = [self sizeWithString:model.tag font:[UIFont systemFontOfSize:15]];
           label.frame = CGRectMake(15, 5, windowContentWidth-30, zxdSize.height+15);
          label.text = model.tag;
//         cell.textLabel.textAlignment = NSTextAlignmentLeft;
//         [cell.textLabel setFrame:CGRectMake(15, 0, windowContentWidth-30, zxdSize.height)];//动态计算行高
           dataLabel.frame = CGRectMake(windowContentWidth-120, zxdSize.height+30, 120, 20);
         NSDateFormatter *zxdFormatter = [[NSDateFormatter alloc] init];
         [zxdFormatter setDateFormat:@"YYYY-MM-dd"];
    /*zxdMemberModel *model = [[self.zxdArrImage objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    CGSize zxdSize = [self sizeWithString:model.tag font:[UIFont systemFontOfSize:15]];*/
        long long int zxdDate1 = (long long int)[model.create_time integerValue];
       NSDate *zxdDate = [NSDate dateWithTimeIntervalSince1970:zxdDate1] ;
        
       dataLabel.text = [zxdFormatter stringFromDate:zxdDate];
      return cell;
  
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
}

-(void)zxdConserveright
{
    zxdWriteRemarksViewController *zxdVc = [[zxdWriteRemarksViewController alloc] init];
    zxdVc.delegate = self;
    zxdVc.uid = self.uid;
    zxdVc.assId = self.assId;
    [self.navigationController pushViewController:zxdVc animated:YES];
}
#pragma mark---zxdWriteRemarksViewControllerDelegate
//反向传值
-(void)viewController:(zxdWriteRemarksViewController *)vc text:(NSString *)string zxddate:(NSMutableArray *)zxdDate isChange:(NSInteger)isChange;
{
    [self.zxdArrImage removeAllObjects];
    self.zxdArrImage = zxdDate;
    [self.zxdTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
// 定义成方法方便多个label调用 增加代码的复用性
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(windowContentWidth - 30, windowContentHeight)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}
-(void)downData
{
    //获取tag备注信息
   
    NSString *stringg = self.uid;
    NSString *urll = [memberTagUrl(stringg) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url = %@",urll);
    //[self setHud:@"正在下载"];
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *managerr = [AFHTTPRequestOperationManager manager];
    managerr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [managerr GET:urll parameters:nil success:^(AFHTTPRequestOperation *operationn,id responseObject){
       // NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        weakSelf.zxdHud.hidden = YES;
        NSString *htmll = operationn.responseString;
        NSData* dataa=[htmll dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dictionary=[NSJSONSerialization  JSONObjectWithData:dataa options:0 error:nil];
        if ([[dictionary objectForKey:@"status"] integerValue] == 1 && [dictionary objectForKey:@"data"] && [[dictionary objectForKey:@"data"] isKindOfClass:[NSArray class]] && [[dictionary objectForKey:@"data"] count] != 0) {
            NSArray  *zxdArr= [NSArray arrayWithArray:[dictionary objectForKey:@"data"]];
            [self.zxdArrImage removeAllObjects];
            
            for (NSDictionary *itemDict in zxdArr) {
                zxdMemberModel *model = [[zxdMemberModel alloc] init];
                [model setValuesForKeysWithDictionary:itemDict];
                NSMutableArray *arrSection = [[NSMutableArray alloc] init];
                [arrSection addObject:model];
                [self.zxdArrImage addObject:arrSection];
            }
         
            [self.zxdTableView reloadData];
        }
        else
        {
             //[[LXAlterView sharedMyTools] createTishi:@"下载失败"];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        NSLog(@"error = %@",error);
       // weakSelf.zxdHud.hidden = YES;
         [[LXAlterView sharedMyTools] createTishi:@"网络出现故障"];
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
-(void)zxdDeletData:(NSIndexPath *)zxdInt
{
    zxdMemberModel *model = [[self.zxdArrImage objectAtIndex:zxdInt.section ] objectAtIndex:zxdInt.row];
    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                                                 };
        NSDictionary *parameters = @{@"member_id":self.uid,
                                     @"tag_id":model.ZXDid,
                                     @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    __weak typeof (self)weakSelf = self;
    [self setHud:@"正在删除备注信息"];
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:zxddelectMemberUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.zxdHud.hidden = YES;
         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] integerValue]==1) {
           
            [weakSelf.zxdArrImage removeObject:[weakSelf.zxdArrImage objectAtIndex:zxdInt.section]];
            [weakSelf.zxdTableView reloadData];
        }
        else
        {
            [[LXAlterView sharedMyTools] createTishi:@"删除失败"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.zxdHud.hidden = YES;
        [[LXAlterView sharedMyTools] createTishi:@"删除失败"];
    }];
}
-(void)close
{
    if ([self.delegate respondsToSelector:@selector(zxdCountViewController:number:)]) {
        [self.delegate zxdCountViewController:self number:self.zxdArrImage.count];
    }
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
