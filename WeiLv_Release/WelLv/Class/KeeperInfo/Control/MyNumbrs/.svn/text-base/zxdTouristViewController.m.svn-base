//
//  zxdTouristViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/20.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdTouristViewController.h"
#import "addViewController.h"
#import "zxdMemberCell.h"
#import "zxdMemberModel.h"
#import "MBProgressHUD.h"

@interface zxdTouristViewController ()<UITableViewDelegate,UITableViewDataSource,addViewControllerDelegate>
@property(nonatomic,strong)UITableView *zxdTableView;
@property(nonatomic,strong) MBProgressHUD *zxdHud;
@property(nonatomic,strong)UIView *view1;
@end

@implementation zxdTouristViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTitle];
    [self creatAddbtn];
    [self creatArr];
    [self creatTableView];
    [self zxdDownDate];
 
    // Do any additional setup after loading the view.
}
-(void)creatArr
{
    self.zxdArr = [[NSMutableArray alloc] init];
    zxdMemberModel *model = [[zxdMemberModel alloc] init];
    model.name = @"邹向东";
    model.cID = @"身份证号";
    model.IDnumber = @"412728198906153273";
    model.phoneNumber = @"13949038485";
    for (int i=0; i<3; i++) {
        //[self.zxdArr addObject:model];
    }
}
-(void)creatAddbtn
{
    _view1 = [[UIView alloc] init];
    _view1.frame = CGRectMake(0, 15, windowContentWidth, 45);
    _view1.backgroundColor = [UIColor whiteColor];
    _view1.userInteractionEnabled = YES;
    UIImageView *zxdImage = [[UIImageView alloc] init];
    zxdImage.frame = CGRectMake(windowContentWidth-23, ViewHeight(_view1)/2-9, 10, 17);
    [zxdImage setImage:[UIImage imageNamed:@"zxdf"]];//@"zxdf"@"常用游客资料-添加"
    [_view1 addSubview:zxdImage];
    UIImageView *zxdAddImage = [[UIImageView alloc] init];
    zxdAddImage.frame = CGRectMake(15, ViewHeight(_view1)/2-11, 20, 20);
    [zxdAddImage setImage:[UIImage imageNamed:@"常用游客资料-添加"]];//@"zxdf"@"常用游客资料-添加"
    [_view1 addSubview:zxdAddImage];
    UILabel *addlabel = [[UILabel alloc] init];
    addlabel.text = @"添加游客资料";
    addlabel.font = [UIFont systemFontOfSize:18];
    addlabel.frame = CGRectMake(45, 0, windowContentWidth, 45);
    addlabel.textColor = [UIColor orangeColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBtnClick)];
    tap.cancelsTouchesInView = NO;
    //设置为NO表示当前控件响应后会传播到其他控件上,默认为yes
    [_view1 addGestureRecognizer:tap];

    [_view1 addSubview:addlabel];
    [self.view addSubview:_view1];
}
-(void)addBtnClick
{
    if (self.zxdArr.count<4) {
        addViewController *zxdAdvc = [[addViewController alloc] init];
        zxdAdvc.strd = self.uid;
        zxdAdvc.delegate = self;
        zxdAdvc.navigationItem.title = @"添加常用游客";
        [self.navigationController pushViewController:zxdAdvc animated:YES];
    }
    else
    {
      [[LXAlterView sharedMyTools] createTishi:@"亲,只能添加4条哦"];
    }
}
-(void)creatTitle
{
    self.navigationItem.title = @"常用游客资料";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];
    self.view.backgroundColor = BgViewColor;
}
-(void)creatTableView
{
    
    [self.zxdTableView removeFromSuperview];
    self.zxdTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 75, windowContentWidth, windowContentHeight-15-64)];
    self.zxdTableView.delegate =self;
    self.zxdTableView.dataSource = self;
    self.zxdTableView.scrollEnabled = NO;
    self.zxdTableView.tableFooterView = [[UIView alloc] init];
  //  self.zxdTableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.zxdTableView setShowsVerticalScrollIndicator:NO];
    if ([self.zxdTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.zxdTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.zxdTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.zxdTableView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self.view addSubview:self.zxdTableView];
}
- (void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
    
}
#pragma mark-------UItableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.zxdArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"Cell";
    zxdMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[zxdMemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    zxdMemberModel *model = [self.zxdArr objectAtIndex:indexPath.row];
    cell.NameLabel.text = [NSString stringWithFormat:@"%@",[self judgeString:model.visitor]?model.visitor:@""];
    cell.PhoneLabel.text = [NSString stringWithFormat:@"手机 %@",[self judgeString:model.phone]?model.phone:@""];
    cell.IDLabel.text = [NSString stringWithFormat:@"QQ  %@",[self judgeString:model.qq]?model.qq:@""];
    //cell.zxdModel = model;
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 95;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    addViewController *zxdAdvc = [[addViewController alloc] init];
    zxdMemberModel *model = [self.zxdArr objectAtIndex:indexPath.row];
    zxdAdvc.delegate = self;
    zxdAdvc.strName = model.visitor;
    zxdAdvc.strPhone = model.phone;
    zxdAdvc.strQQ = model.qq;
    zxdAdvc.navigationItem.title = @"编辑常用游客";
    zxdAdvc.strUid = model.visitor_id;
    zxdAdvc.strd = self.uid;
    [self.navigationController pushViewController:zxdAdvc animated:YES];
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

#pragma mark---定制cell删除按钮
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //[self.arrImage removeObjectAtIndex:indexPath.row];
    // [self.zxdTableView reloadData ];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [self deleletData:indexPath.row];
       
    }];
    deleteRowAction.backgroundColor = [UIColor orangeColor];
        // 将设置好的按钮放到数组中返回
    return @[deleteRowAction];
}

-(void)zxdDownDate
{
    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                        @"select":@"*",
                          };
    //测试
//    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
//                          @"visitor":@"姓名1",
//                          @"phone":@"123",
//                          @"qq":@"123456",
//                          };
    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    __weak typeof (self)weakSelf = self;
     [self setHud:@"正在下载"];
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:zxdTourUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict count]==0) {
            [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
        }
        else if ([dict[@"status"] integerValue]==1)
        {
            if ([dict[@"data"] count]==0) {
               // [[LXAlterView sharedMyTools] createTishi:@"常用游客联系人为空"];
                self.zxdTableView.hidden = YES;
             }
            else
            {
                [weakSelf.zxdArr removeAllObjects];
                NSArray *itemArr = dict[@"data"];
                
                for (NSDictionary *item in itemArr) {
                    zxdMemberModel *model = [[zxdMemberModel alloc] init];
                    [model setValuesForKeysWithDictionary:item];
                    [weakSelf.zxdArr addObject:model];
                }
                 self.zxdTableView.frame =CGRectMake(0, 75, windowContentWidth, 95*self.zxdArr.count);
                [weakSelf.zxdTableView reloadData];
            }
        }
        else
        {
             [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
            
        }
        weakSelf.zxdHud.hidden = YES;
        //NSDictionary *zxdDict = dict;

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
        weakSelf.zxdHud.hidden = YES;
          [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)deleletData:(NSInteger)zxdInt
{
    zxdMemberModel *model = [self.zxdArr objectAtIndex:zxdInt];
    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                                 };
   
    NSDictionary *parameters = @{@"member_id":self.uid,
                                 @"visitor_id":model.visitor_id,
                                @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    __weak typeof (self)weakSelf = self;
    [self setHud:@"正在删除"];
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:zxdTourdelectUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict[@"status"] integerValue]!=1) {
            [[LXAlterView sharedMyTools] createTishi:@"删除失败"];
        }
        else
        {
        weakSelf.zxdHud.hidden = YES;
        [weakSelf.zxdArr removeObjectAtIndex:zxdInt];
         weakSelf.zxdTableView.frame =CGRectMake(0, 75, windowContentWidth, 95*weakSelf.zxdArr.count);
        [weakSelf.zxdTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.zxdHud.hidden = YES;
        [[LXAlterView sharedMyTools] createTishi:@"删除失败"];
    }];
}
#pragma mark---回调刷新数据代理
-(void)tourViewController:(addViewController *)vc zxdArr:(NSMutableArray *)zxdDataArr
{
    [self.zxdArr removeAllObjects];
    self.zxdArr = zxdDataArr;
    self.zxdTableView.hidden = NO;
    self.zxdTableView.frame =CGRectMake(0, 75, windowContentWidth, 95*self.zxdArr.count);
    [self.zxdTableView reloadData];
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
