//
//  ZFJSteShopPartnerVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJSteShopPartnerVC.h"
#import "ZFJMyMemberCell.h"
#import "MyMembersModel.h"
#import "ManageMemberInfoViewController.h"


@interface ZFJSteShopPartnerVC ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{

    NSInteger  BtnTag;
}
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, strong) UILabel * partnerLab;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, assign) NSInteger offsetNum;
@property (nonatomic, copy) NSString * keywordStr;
@property(nonatomic,strong)UIView * searchView;
@property(nonatomic,strong)UIView *topView;
@end

@implementation ZFJSteShopPartnerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"合伙人";
    self.keywordStr = @"";
    self.offsetNum = 1;
    
    [self customTableView];
    [self loadData];
    [self addRefreshing];
}
/**
 *   加载搜索视图。
 */
- (void)loadSearchView {
    
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, -45, windowContentWidth, 45)];
    self.searchView.backgroundColor = kColor(154, 165, 175);
    [self.tableView addSubview:self.searchView];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
    leftView.frame = CGRectMake(5, 0,30, 15);
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITextField * searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 7.5, ViewWidth(self.searchView) - 30, 30)];
    searchTF.borderStyle = UITextBorderStyleRoundedRect;
    searchTF.placeholder = @"搜索";
    searchTF.tintColor = [UIColor orangeColor];
    searchTF.layer.cornerRadius = 5.0;
    searchTF.clearButtonMode = UITextFieldViewModeAlways;
    searchTF.leftViewMode = UITextFieldViewModeAlways;
    searchTF.leftView = leftView;
    searchTF.font = [UIFont systemFontOfSize:15];
    searchTF.delegate = self;
    searchTF.returnKeyType = UIReturnKeySearch;
    [self.searchView addSubview:searchTF];
    
}
- (void)customTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight-70)];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    self.tableView.rowHeight  = 80;
    self.tableView.contentInset=UIEdgeInsetsMake(45, 0, 0, 0);
    //self.tableView.bounces=NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self loadSearchView];
    [self addPartnerCountView];
    [self.view addSubview:_tableView];
   // [self.tableView scrollRectToVisible:CGRectMake(0, -45, windowContentWidth, ControllerViewHeight) animated:NO];
}

- (void)addPartnerCountView {
    self.partnerLab = [[UILabel alloc] initWithFrame:CGRectMake(0,0, windowContentWidth, 25)];
    NSLog(@"%@", self.partnerCountStr);
    self.partnerLab.attributedText = [self partnerCountLabAttStr:self.partnerCountStr];
    [self.view addSubview:self.partnerLab];
    self.tableView.tableHeaderView = self.partnerLab;
}

- (NSAttributedString *)partnerCountLabAttStr:(NSString *)str {
    return  [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<p><span style=color:#000000;font-size:15px;>&nbsp;&nbsp;&nbsp;&nbsp;合伙人:&nbsp;<span style=color:#FF9600;font-size:15px;>%@人</span></p>", str] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
}

//加载刷新
- (void)addRefreshing {
    __weak ZFJSteShopPartnerVC * weakSelf = self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.offsetNum = weakSelf.offsetNum + 1;
            [weakSelf loadData];
        });
    }];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark --- UITextFiledDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (textField.text.length > 0) {
        self.keywordStr = textField.text;
        [self.dataArr removeAllObjects];
        [self loadData];
    }
    return YES;
}
#pragma mark --- UITabelViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //   self.partnerLab.attributedText = [self partnerCountLabAttStr:[NSString stringWithFormat:@"%ld", self.dataArr.count]];
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"Cell";
    ZFJMyMemberCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ZFJMyMemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.editMemderInforBut setImage:[UIImage imageNamed:@"修改资料"] forState:UIControlStateNormal];
        [cell.editMemderInforBut setImage:[UIImage imageNamed:@"修改资料按下"] forState:UIControlStateHighlighted];
        
        [cell.sendMessagesBut setImage:[UIImage imageNamed:@"电话1"] forState:UIControlStateNormal];
        [cell.sendMessagesBut setImage:[UIImage imageNamed:@"电话按下"] forState:UIControlStateHighlighted];
    }
    cell.memberModel = [self.dataArr objectAtIndex:indexPath.row];
    [cell.sendMessagesBut addTarget:self action:@selector(sendMessages:) forControlEvents:UIControlEventTouchUpInside];
    cell.sendMessagesBut.tag = 10000 + indexPath.row;
    [cell.editMemderInforBut addTarget:self action:@selector(editMemderInfor:) forControlEvents:UIControlEventTouchUpInside];
    cell.editMemderInforBut.tag = 20000 + indexPath.row;
    return cell;
}
#pragma mark - cell侧滑删除
//设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
//要求委托方的编辑风格在表视图的一个特定的位置。
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //  NSLog(@"touchIIddddd");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deteleCusInfo:indexPath.row];
    }
    
}
//删除
-(void)deteleCusInfo:(NSInteger)index{
    // UIButton *btn=(UIButton *)sender;
    //把btn.tag转化成整型
    BtnTag = index;
    
    UIAlertView *vv = [[UIAlertView alloc] initWithTitle:nil message:@"确定要删除联系人？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    vv.delegate = self;
    [vv show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex == 1){
        
        NSString *postStr =kGuanjiaDeleteHehuo;
        //上传服务器
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        MyMembersModel *model=[self.dataArr objectAtIndex:BtnTag];
        //管家删除合伙人 提交字段 type 类型4 位管家取消合伙人
        NSDictionary *parameters = @{@"assistant_id":[[LXUserTool sharedUserTool]getKeeper],@"type":@"4",@"member_id":model.uid};
        [manager POST:postStr parameters:parameters
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                  DLog(@"%@",dict);
                  if ([dict[@"status"]intValue]==1) {
                      
                      [self.dataArr removeObject:model];
                      [self.tableView reloadData];
                      
                  }
                  //shua刷新列表
                  //[cusInfoArray removeObjectAtIndex:buttonTag];
                  //NSUserDefaults *set=[NSUserDefaults  standardUserDefaults];
                  //[set setObject:cusInfoArray forKey:@"custom"];
                  //[self.myMemberListTableView reloadData];
                  
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  
              }];
    }
    
}
#pragma mark --- 按钮点击方法
- (void)sendMessages:(UIButton *)button
{
    MyMembersModel *model=[self.dataArr objectAtIndex:button.tag - 10000];
    if ([self judgeString:model.phone]) {
        NSString * telString = [NSString stringWithFormat:@"tel:%@", model.phone];
        NSURL * telUrl = [NSURL URLWithString:telString];
        [[UIApplication sharedApplication] openURL:telUrl];
    } else {
        [[LXAlterView sharedMyTools] createTishi:@"失败,请重试!"];
    }
    
}

- (void)editMemderInfor:(UIButton *)button
{
    MyMembersModel *model=[self.dataArr objectAtIndex:button.tag - 20000];
    ManageMemberInfoViewController * editMemderInforVC = [[ManageMemberInfoViewController alloc] init];
    editMemderInforVC.memberModel=model;
    [self.navigationController pushViewController:editMemderInforVC animated:YES];
    
}

#pragma mark --- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //[[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    if (scrollView.contentOffset.y <= -45) {
        [UIView animateWithDuration:0.8 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
            
        }];
        self.isOpen = YES;
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, -45);
        
    }
    
    if (self.isOpen && scrollView.contentOffset.y >= 0){
        [UIView animateWithDuration:0.8 animations:^{
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }];
        self.isOpen = NO;
        
    }
}
#pragma mark --- loadData
/**
 *  请求数据
 */
- (void)loadData {
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //[self setProgressHud];
    
    NSDictionary *parameters = nil;
    if ([self judgeString:self.keywordStr]) {
        parameters = @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                       @"keyword":self.keywordStr,
                       @"offset":[NSString stringWithFormat:@"%ld", self.offsetNum],
                       @"limit":@"10"};
    } else {
        parameters = @{@"assistant_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                       @"offset":[NSString stringWithFormat:@"%ld", self.offsetNum],
                       @"limit":@"10"};
    }
    //接口
    NSString *url= M_SS_URL_PARTNER_LIST;
    //发送请求
    NSLog(@" URL == %@  parameters = %@", url, parameters);
    
    __weak ZFJSteShopPartnerVC * weakSelf = self;
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"JSON: %@",  dic);
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
        if ([dic isKindOfClass:[NSDictionary class]]&& [[dic objectForKey:@"status"] integerValue] == 1 && [[[dic objectForKey:@"data"] objectForKey:@"partners"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary * partnerDic in [[dic objectForKey:@"data"] objectForKey:@"partners"]) {
                MyMembersModel * model = [[MyMembersModel alloc] initWithDictionary:partnerDic];
                [weakSelf.dataArr addObject:model];
            }
            //weakSelf.partnerLab.attributedText = [weakSelf partnerCountLabAttStr:[[dic objectForKey:@"data"] objectForKey:@"count"]];
            [weakSelf.tableView.footer endRefreshing];
            [weakSelf.tableView reloadData];
            [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
            if (weakSelf.tableView.contentSize.height < ControllerViewHeight) {
                [weakSelf.tableView removeFooter];
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
        [[XCLoadMsg sharedLoadMsg:weakSelf] hideActivityLoading];
        [[XCLoadMsg sharedLoadMsg:weakSelf] showErrorMsgInView:weakSelf.view evn:^{
            [weakSelf loadData];
        }];
        
    }];
    
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        self.dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

@end
