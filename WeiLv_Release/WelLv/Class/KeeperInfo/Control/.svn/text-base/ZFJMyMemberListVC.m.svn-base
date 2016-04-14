//
//  ZFJMyMemberListVC.m
//  WelLv
//
//  Created by 张发杰 on 15/5/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJMyMemberListVC.h"
#import "ZFJMyMemberCell.h"
#import "MessageViewController.h"
#import "ManageMemberInfoViewController.h"
#import "YXOrderViewController.h"
#import "LXUserTool.h"
#import "PersonalTravelsViewController.h"

#import "zxdManagerMemberInforViewController.h"

@interface ZFJMyMemberListVC ()<UITextFieldDelegate, UIScrollViewDelegate>
{
    int _currentPage;
    int _offset;
    UITextField * searchTF;
}
@property (nonatomic, strong) UITableView *myMemberListTableView;
@property (nonatomic, strong) NavSearchView *searchView;
@property (nonatomic, strong) UIView * blurView;
@property (nonatomic, strong) UIButton * cancelBut;
@property (nonatomic, strong) UITextField * phoneTextField;
@property (nonatomic, strong) UITextField * nameTextField;
@property (nonatomic, strong) UILabel * sexLabel;

@property (nonatomic, strong) UIView * addMemeberView;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSMutableArray * searchArray;

@property (nonatomic, assign) BOOL isSearchData;

@property (nonatomic, strong) UIView * warnView;

@property (nonatomic, strong) NSMutableArray * allDataArray;

@property (nonatomic, strong) UIView * chooseSexView;
@property (nonatomic, strong) NSString * sexNum;
@property (nonatomic, assign) BOOL KeyboardIsShow;
@property (nonatomic, assign) BOOL isOpen;

@end

@implementation ZFJMyMemberListVC
@synthesize delegate = _delegate;

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的会员";
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    [self coustomNavigationBar];
    [self initData];
    [self initView];
    NSString *path=[NSHomeDirectory() stringByAppendingString:@"/Library/Preferences/com.WelLv100.WeiLv.WelLv.plist"];
    DLog(@"----%@",path);
    
    // Do any additional setup after loading the view.
}



-(void)initData
{
    _currentPage=1;
    _offset=0;
}

-(void)initView
{
    _currentPage=1;
    NSString *offset1=[NSString stringWithFormat:@"%d",0];
    NSDictionary *dic=@{@"offset":offset1,@"limit":@"10",@"assistant_id":[[LXUserTool alloc] getUid]};
    [self sendRequest:dic aUrl:myMemberSearchURL aTag:1];
    
    // 状态栏(statusbar)
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    // 导航栏（navigationbar）
    CGRect rectNav = self.navigationController.navigationBar.frame;
    
    self.myMemberListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - rectStatus.size.height - rectNav.size.height)];
    self.myMemberListTableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
    self.myMemberListTableView.dataSource = self;
    self.myMemberListTableView.delegate = self;
    self.myMemberListTableView.rowHeight = 80;
    self.myMemberListTableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
    self.memberCountLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 25)];
   //从个人中心跳转的话，让点击失去第一响应者
    if ([self.type isEqualToString:@"1"]) {
        
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTableview)];
    [self.myMemberListTableView addGestureRecognizer:tap];
    }
    NSString *aa = [[LXUserTool sharedUserTool] getMember_count];
    self.memberCountLab.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<p><span style=color:#000000;font-size:15px;>&nbsp;&nbsp;&nbsp;&nbsp;会员数:&nbsp;<span style=color:#FF9900;font-size:15px;>%@人</span></p>", [self judgeReturnString:aa withReplaceString:@"0"]] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.myMemberListTableView.tableHeaderView = self.memberCountLab;
    self.myMemberListTableView.tableFooterView=[[UIView alloc] init];
    [self.view addSubview:self.myMemberListTableView];
    
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    
    /*
     //-----------下拉刷新
     // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
     [self.myMemberListTableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
     
     // 设置普通状态的动画图片
     [self.myMemberListTableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateIdle];
     // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
     [self.myMemberListTableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStatePulling];
     
     // 设置正在刷新状态的动画图片
     [self.myMemberListTableView.gifHeader setImages:imageAray forState:MJRefreshHeaderStateRefreshing];
     // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
     
     // 马上进入刷新状态
     [self.myMemberListTableView.gifHeader beginRefreshing];
     */
    
    //----------上拉加载更多
    [self.myMemberListTableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadLastData)];
    
    if ([self.myMemberListTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.myMemberListTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.myMemberListTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.myMemberListTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    [self loadSearchView];
}
-(void)tapTableview
{
     [searchTF resignFirstResponder];
}
/**
 *   加载搜索视图。
 */
- (void)loadSearchView {
    UIView * searchView = [[UIView alloc] initWithFrame:CGRectMake(0, -45, windowContentWidth, 45)];
    searchView.backgroundColor = kColor(154, 165, 175);
    [self.myMemberListTableView addSubview:searchView];
    
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
    leftView.frame = CGRectMake(5, 0,30, 15);
    //leftView.backgroundColor = [UIColor orangeColor];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    
    searchTF = [[UITextField alloc] initWithFrame:CGRectMake(15, 7.5, ViewWidth(searchView) - 30, 30)];
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
    [searchView addSubview:searchTF];
    
}


#pragma mark --- 下拉刷新
-(void)loadNewData
{
    [self.dataArray removeAllObjects];
    _currentPage=1;
    NSString *offset1=[NSString stringWithFormat:@"%d",0];
    NSDictionary *dic=@{@"offset":offset1,@"limit":@"10",@"assistant_id":[[LXUserTool alloc] getUid]};
    NSLog(@"%@", dic);
    //NSString *url= myMemberListURL;
    //    NSString * url = @"http://202.104.102.2/api/assistant/members";
    [self sendRequest:dic aUrl:myMemberSearchURL aTag:1];
    
    //    NSDictionary *allDic = @{@"assistant_id":[[LXUserTool alloc] getUid]};
    //    [self sendRequest:allDic aUrl:url];
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.myMemberListTableView.header endRefreshing];
}

#pragma mark -- 加载更多
-(void)loadLastData
{
    _offset=_currentPage*10;
    NSString *offset1=[NSString stringWithFormat:@"%ld",(long)_offset];
    NSDictionary *dic=@{@"offset":offset1,@"limit":@"10",@"assistant_id":[[LXUserTool alloc] getUid]};
    NSString *url= myMemberListURL;
    //NSString * url = @"http://202.104.102.2/api/assistant/members";
    [self sendRequest:dic aUrl:url aTag:1];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        //[self.myMemberListTableView reloadData];
        
        // 拿到当前的上拉刷新控件，变为没有更多数据的状态 [_tableView.footer noticeNoMoreData]
        
        [self.myMemberListTableView.footer endRefreshing];
        _currentPage++;
    });
}


- (void)coustomNavigationBar
{
    //    UIView * aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth-90, 30)];
    //    self.searchView = [[NavSearchView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth-140, 25) Feature:@"会员昵称/手机号/关键字"];
    //    _searchView.delegate = self;
    //    _searchView.searchBar.delegate = self;
    //    _searchView.searchBar.returnKeyType = UIReturnKeySearch;
    
    UIButton *addMemeber = [UIButton buttonWithType:UIButtonTypeCustom];
    addMemeber.frame = CGRectMake(windowContentWidth - 30, 0, 30, 30);
    [addMemeber setImage:[UIImage imageNamed:@"follow"] forState:UIControlStateNormal];
    [addMemeber addTarget:self action:@selector(addMemeber:) forControlEvents:UIControlEventTouchUpInside];
    //    [aView addSubview:addMemeber];
    //    [aView addSubview:_searchView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addMemeber];
    
}

- (void)addMemeber:(UIButton *)button
{
    [self.searchView.searchBar resignFirstResponder];
    
    if (self.blurView == nil) {
        self.blurView = [[UIView alloc] initWithFrame:self.view.bounds];
        _blurView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [_blurView addGestureRecognizer:tap];
        self.addMemeberView = [[UIView alloc] initWithFrame:CGRectMake(50, (self.view.frame.size.height -64)/2 - 90, windowContentWidth - 100, 180)];
        _addMemeberView.layer.cornerRadius = 5;
        _addMemeberView.layer.masksToBounds = YES;
        UILabel * addLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.addMemeberView.frame.size.width, 30)];
        addLabel.textAlignment= NSTextAlignmentCenter;
        addLabel.text = @"请输入会员信息";
        addLabel.textColor = [UIColor orangeColor];
        [self.addMemeberView addSubview:addLabel];
        
        
        self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, ViewHeight(addLabel) + ViewY(addLabel) + 10, ViewWidth(self.addMemeberView) * 1 / 2, 30)];
        self.nameTextField.clearButtonMode = UITextFieldViewModeAlways;
        self.nameTextField.delegate = self;
        self.nameTextField.placeholder = @" 姓名";
        self.nameTextField.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:232/255.0 alpha:1];
        [self.addMemeberView addSubview:_nameTextField];
        
        
        
        self.sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewX(self.nameTextField) + ViewWidth(self.nameTextField) + 15, ViewY(self.nameTextField), ViewWidth(self.addMemeberView) * 1 / 2 - 40 - 15, 30)];
        self.sexLabel.text = @"性别";
        self.sexLabel.textAlignment = NSTextAlignmentCenter;
        self.sexLabel.userInteractionEnabled = YES;
        
        self.sexLabel.textColor = [UIColor grayColor];
        self.sexLabel.textAlignment = NSTextAlignmentLeft;
        [self.addMemeberView addSubview:_sexLabel];
        UIImageView * lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ViewHeight(self.sexLabel) - 5, ViewWidth(self.sexLabel), 0.5)];
        lineView.backgroundColor = bordColor;
        //[lineView setImage:[UIImage imageNamed:@"选择线"]];
        UITapGestureRecognizer * sexTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sexTapView:)];
        [self.sexLabel addGestureRecognizer:sexTap];
        [self.sexLabel addSubview:lineView];
        
        self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, ViewHeight(self.nameTextField) + ViewY(self.nameTextField) + 15, self.addMemeberView.frame.size.width - 40, 30)];
        //self.phoneTextField.borderStyle = UITextBorderStyleRoundedRect;
        _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
        _phoneTextField.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:232/255.0 alpha:1];
        _phoneTextField.delegate = self;
        _phoneTextField.placeholder = @" 手机号";
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        [self.addMemeberView addSubview:_phoneTextField];
        
        self.addMemeberView.backgroundColor = [UIColor whiteColor];
        [_blurView addSubview:self.addMemeberView];
        
        UIButton * addBut = [UIButton buttonWithType:UIButtonTypeCustom];
        addBut.frame = CGRectMake(20, _phoneTextField.frame.origin.y + self.phoneTextField.frame.size.height + 15, self.addMemeberView.frame.size.width - 40, 30);
        addBut.layer.cornerRadius = 5;
        addBut.layer.masksToBounds = YES;
        addBut.backgroundColor = kColor(40, 218, 171);
        [addBut setTitle:@"添加" forState:UIControlStateNormal];
        [addBut addTarget:self action:@selector(addMemberBut:) forControlEvents:UIControlEventTouchUpInside];
        [self.addMemeberView addSubview:addBut];
        
        [self.view addSubview:_blurView];
    } else if (self.blurView.hidden == YES){
        self.blurView.hidden = NO;
    }
}

- (void)tapView:(UITapGestureRecognizer *)tap
{
    self.blurView.hidden = YES;
    [self.view endEditing:YES];
}

- (void)sexTapView:(UITapGestureRecognizer *)tap{
    
    if (self.chooseSexView == nil) {
        self.chooseSexView = [[UIView alloc] initWithFrame:CGRectMake(ViewX(self.sexLabel), ViewY(self.sexLabel)  + ViewHeight(self.sexLabel), ViewWidth(self.sexLabel), 75)];
        self.chooseSexView.backgroundColor = [UIColor whiteColor];
        NSArray * butTitle = @[@"女", @"男"];
        for (int i = 0; i < butTitle.count ; i++) {
            UIButton * sexBut = [UIButton buttonWithType:UIButtonTypeCustom];
            sexBut.frame = CGRectMake(0, i * 35 + 5, ViewWidth(self.sexLabel), 30);
            [sexBut setTitle:[butTitle objectAtIndex:i] forState:UIControlStateNormal];
            [sexBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [sexBut addTarget:self action:@selector(chooseSexBut:) forControlEvents:UIControlEventTouchUpInside];
            [_chooseSexView addSubview:sexBut];
        }
        
        [self.addMemeberView addSubview:_chooseSexView];
        
    } else if (self.chooseSexView.hidden == YES) {
        self.chooseSexView.hidden = NO;
    } else if (self.chooseSexView.hidden == NO) {
        self.chooseSexView.hidden = YES;
    }
    
    
}
// 性别选择
- (void)chooseSexBut:(UIButton *)button{
    self.sexLabel.text = button.titleLabel.text;
    if ([self.sexLabel.text isEqualToString:@"男"]){
        self.sexNum = @"1";
        
    } else if ([self.sexLabel.text isEqualToString:@"女"]){
        self.sexNum = @"2";
        
    }
    self.chooseSexView.hidden = YES;
}

//添加会员
- (void)addMemberBut:(UIButton *)but
{
    _phoneTextField.clearsOnBeginEditing = YES;
    self.blurView.hidden = YES;
    [self textFieldShouldClear:_phoneTextField];
    
    [self.phoneTextField resignFirstResponder];
    if (![YXTools isValidateMobile:_phoneTextField.text]) {
        [[LXAlterView sharedMyTools] createTishi:@"请输入正确的电话号码"];
        
        return;
    }
    
    if ([self.sexNum isEqual:@"2"] || [self.sexNum isEqual:@"1"]) {
        
    }else {
        [[LXAlterView sharedMyTools] createTishi:@"请输入性别"];
        
        return;
        
    }
    
    if (self.nameTextField.text.length == 0) {
        [[LXAlterView sharedMyTools] createTishi:@"请输入会员姓名"];
        return;
    }
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"assistant_id":[[LXUserTool alloc] getUid],@"mobile":_phoneTextField.text, @"name":self.nameTextField.text, @"gender":self.sexNum, @"mtype":@"3"};
    
    NSString *url= addMyMemberURL;
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation,id responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"++++++++++++++++++%@", dic);
        [[LXAlterView sharedMyTools] createTishi:[NSString stringWithFormat:@"%@", [dic objectForKey:@"msg"]]];
        if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] isEqual:@"1"]) {
            NSString *str = [[LXUserTool alloc] getMember_count];
            str = [NSString stringWithFormat:@"%ld",[str integerValue]+1];
            NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
            [settings setObject:str forKey:@"member_count"];
            
            self.memberCountLab.attributedText = [[NSAttributedString alloc] initWithData:[[NSString stringWithFormat:@"<p><span style=color:#000000;font-size:15px;>&nbsp;&nbsp;&nbsp;&nbsp;会员数:&nbsp;<span style=color:#FF9900;font-size:15px;>%@人</span></p>", str] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
            /* for (UIView *vv in [self.view subviews]) {
             [vv removeFromSuperview];
             [self viewDidLoad];
             }*/
            [self loadNewData];
        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        DLog(@"Error: %@", error);
//        [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
//        [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
//        [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
//            
//        }];
        
    }];
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearchData == YES) {
        return self.searchArray.count;
    }else {
        return self.dataArray.count;
    }
    //return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIndetifier = @"Cell";
    ZFJMyMemberCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (!cell) {
        cell = [[ZFJMyMemberCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsZero;
        //        cell.preservesSuperviewLayoutMargins = NO;
        //        cell.layoutMargins = UIEdgeInsetsZero;
#pragma mark --- 个人旅历图标
        [cell.travelsBut setImage:[UIImage imageNamed:@"会员列表-默认"] forState:UIControlStateNormal];
        [cell.travelsBut setImage:[UIImage imageNamed:@"会员列表-选中"] forState:UIControlStateHighlighted];

        [cell.editMemderInforBut setImage:[UIImage imageNamed:@"修改资料"] forState:UIControlStateNormal];
        [cell.editMemderInforBut setImage:[UIImage imageNamed:@"修改资料按下"] forState:UIControlStateHighlighted];
        
        [cell.sendMessagesBut setImage:[UIImage imageNamed:@"发信息"] forState:UIControlStateNormal];
        [cell.sendMessagesBut setImage:[UIImage imageNamed:@"发信息按下"] forState:UIControlStateHighlighted];
        
        
        
    }
    if (_isSearchData == YES) {
        MyMembersModel *model=[[MyMembersModel alloc] init];
        model=[self.searchArray objectAtIndex:indexPath.row];
        cell.memberModel=model;
    } else {
        if (self.dataArray.count>0)
        {
            MyMembersModel *model=[[MyMembersModel alloc] init];
            model=[self.dataArray objectAtIndex:indexPath.row];
            cell.memberModel=model;
            
            cell.travelsBut.tag = [model.uid integerValue];
        }
    }
    
    [cell.travelsBut addTarget:self action:@selector(memberTravels:) forControlEvents:UIControlEventTouchUpInside];
    [cell.sendMessagesBut addTarget:self action:@selector(sendMessages:) forControlEvents:UIControlEventTouchUpInside];
    cell.sendMessagesBut.tag = 10000 + indexPath.row;
    [cell.editMemderInforBut addTarget:self action:@selector(editMemderInfor:) forControlEvents:UIControlEventTouchUpInside];
    cell.editMemderInforBut.tag = 20000 + indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
   
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[YXOrderViewController class]]) {
            MyMembersModel *model=[[MyMembersModel alloc] init];
            model = [self.dataArray objectAtIndex:indexPath.row];
            if ([self.delegate respondsToSelector:@selector(getMember:)]) {
                [self.delegate getMember:model];
            }
            [self close];
        }
    }
}

#pragma mark ----navSearchDelegate
- (void)beginSearch:(NSString *)text
{
    NSLog(@"beginSearch");
}
//当键盘出现或改变时调用
- (void)keyboardShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    self.addMemeberView.frame = CGRectMake(50, self.view.frame.size.height /2 - height, windowContentWidth - 100, 180);
    self.KeyboardIsShow = YES;
}
- (void)keyboardHide:(NSNotification *)aNotification{
    self.addMemeberView.frame = CGRectMake(50, self.view.frame.size.height /2 - 100, windowContentWidth - 100, 180);
    self.KeyboardIsShow = NO;
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardShow:)
    //                                                 name:UIKeyboardWillShowNotification
    //                                               object:nil];
    return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([[textField superview] isEqual:self.addMemeberView]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
    }else {
        
        //        self.searchView.searchBar.frame = CGRectMake(0, 0, windowContentWidth - 160, 30);
        //
        //        if (self.cancelBut == nil) {
        //            self.cancelBut = [[UIButton alloc] initWithFrame:CGRectMake([self.searchView superview].frame.size.width - 70, 0, 40, 30)];
        //            [_cancelBut setTitle:@"取消" forState:UIControlStateNormal];
        //            _cancelBut.titleLabel.font = [UIFont systemFontOfSize:15];
        //            [_cancelBut setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        //            [_cancelBut addTarget:self action:@selector(cancelBut:) forControlEvents:UIControlEventTouchUpInside];
        //            [[self.searchView superview] addSubview:_cancelBut];
        //        } else {
        //            self.cancelBut.hidden = NO;
        //        }
    }
}

- (void)cancelBut:(UIButton *)but
{
    [self.searchView.searchBar resignFirstResponder];
    self.searchView.searchBar.frame = CGRectMake(0, 0, windowContentWidth - 130, 30);
    self.cancelBut.hidden = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    // self.addMemeberView.frame = CGRectMake(50, self.view.frame.size.height /2 - 100, windowContentWidth - 100, 180);
    
}

//go search
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([[textField superview] isEqual:self.addMemeberView]) {
        
    }else {
        [self.dataArray removeAllObjects];
        [self sendRequest:@{@"keywords":textField.text, @"assistant_id":[[LXUserTool alloc] getUid]} aUrl:myMemberSearchURL aTag:1];
        
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    
    if ([textField isEqual:self.phoneTextField] || [textField isEqual:self.nameTextField ]) {
        return YES;
    }
    [self loadNewData];
    return YES;
    
}


#pragma mark -----

- (void)memberTravels:(UIButton *)button {
    
    PersonalTravelsViewController *personalTravelsController = [[PersonalTravelsViewController alloc] init];
    
    personalTravelsController.userType = UserTypeAssistant;
    
    personalTravelsController.memberId = [NSString stringWithFormat:@"%li", button.tag];
    
    [self.navigationController pushViewController:personalTravelsController animated:YES];
}

- (void)sendMessages:(UIButton *)button
{
    MyMembersModel *model=[self.dataArray objectAtIndex:button.tag-10000];
    //NSLog(@"++++%ld", button.tag - 10000);
    MessageViewController * sendMessages = [[MessageViewController alloc] init];
    sendMessages.mesModel=model;
    [self.navigationController pushViewController:sendMessages animated:YES];
}

- (void)editMemderInfor:(UIButton *)button
{
    MyMembersModel *model=[self.dataArray objectAtIndex:button.tag-20000];
//    //NSLog(@"----%ld", button.tag - 20000);
//    ManageMemberInfoViewController * editMemderInforVC = [[ManageMemberInfoViewController alloc] init];
//    editMemderInforVC.memberModel=model;
   zxdManagerMemberInforViewController *editMemderInforVC = [[zxdManagerMemberInforViewController alloc] init];
    editMemderInforVC.memberModel=model;
    editMemderInforVC.navigationItem.title = [self judgeString:model.realname]?model.realname:model.phone;
    [self.navigationController pushViewController:editMemderInforVC animated:YES];


    
}



#pragma mark ----- 懒加载
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

- (NSMutableArray *)searchArray
{
    if (_searchArray == nil) {
        self.searchArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _searchArray;
}
- (NSMutableArray *)allDataArray {
    if (_allDataArray == nil) {
        self.allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}


#pragma mark --------


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"***\n%g\n***", scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <= -45) {
        [UIView animateWithDuration:0.8 animations:^{
            self.myMemberListTableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
            
        }];
        self.isOpen = YES;
        self.myMemberListTableView.contentOffset = CGPointMake(self.myMemberListTableView.contentOffset.x, -45);
        
    }
    
    if (self.isOpen && scrollView.contentOffset.y >= 0){
        [UIView animateWithDuration:0.8 animations:^{
            self.myMemberListTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }];
        self.isOpen = NO;
        
    }
    
    
    [self.searchView.searchBar resignFirstResponder];
    self.searchView.searchBar.frame = CGRectMake(0, 0, windowContentWidth - 130, 30);
    self.cancelBut.hidden = YES;
    
}


#pragma mark 请求数据-post
-(void)sendRequest:(NSDictionary *)parameters aUrl:(NSString *)url aTag:(NSUInteger)tag
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              NSLog(@"%@", dic);
              
              
              if ([[dic objectForKey:@"status"] integerValue]==1)
              {
                  NSArray *array=[dic objectForKey:@"data"];
                  
                  for (int i=0; i<array.count; i++)
                  {
                      NSDictionary *dic1=[array objectAtIndex:i];
                      MyMembersModel *detailModel = [[MyMembersModel alloc] init];
                      [detailModel setValuesForKeysWithDictionary:dic1];
                      [self.dataArray addObject:detailModel];
                      
                  }
                
                  if (windowContentWidth==320) {
                      //这样写的思路，页面上显示人数少于6人时，让加载更多按钮隐藏，不需要加载更多的操作
                      if (self.dataArray.count<6) {
                          if (self.dataArray.count==0) {
                              
                              [self.myMemberListTableView reloadData];
                              [[LXAlterView sharedMyTools]createTishi:@"没有您要找的会员信息，请试试其他搜索"];
                              self.myMemberListTableView.footer.hidden=YES;
                          }else{
                              self.myMemberListTableView.footer.hidden=YES;
                          }
                      }else{
                          self.myMemberListTableView.footer.hidden=NO;
                      }
                //5以上的 6，6plus小于8
                  }else{
                      //这样写的思路，页面上显示人数少于6人时，让加载更多按钮隐藏，不需要加载更多的操作
                      if (self.dataArray.count<8) {
                          if (self.dataArray.count==0) {
                              
                              [self.myMemberListTableView reloadData];
                              [[LXAlterView sharedMyTools]createTishi:@"没有您要找的会员信息，请试试其他搜索"];
                              self.myMemberListTableView.footer.hidden=YES;
                          }else{
                              self.myMemberListTableView.footer.hidden=YES;
                          }
                      }else{
                          self.myMemberListTableView.footer.hidden=NO;
                      }
 
                  }
              }else{
                 [[LXAlterView sharedMyTools]createTishi:dic[@"msg"]];
              }
            [self.myMemberListTableView reloadData];
            if (self.myMemberListTableView.contentSize.height<ControllerViewHeight) {
                  [self.myMemberListTableView removeFooter];
              }
            [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              DLog(@"Error: %@", error);
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              if (self.myMemberListTableView.contentSize.height<ControllerViewHeight) {
                  [self.myMemberListTableView removeFooter];
              }
//              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
//              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
//              [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
//                  //                  NSDictionary *parameterDic=@{@"offset":@"0",@"limit":@"10"};
//                  //                  [self sendRequest:parameterDic aUrl:@"http://m.weilv100.com:1025/api/assistant/lists" aTag:1];
//              }];
              
          }];
    
    
}
-(void)sendRequest:(NSDictionary *)parameters aUrl:(NSString *)url
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
              if ([[dic objectForKey:@"status"] integerValue]==1)
              {
                  NSArray *array=[dic objectForKey:@"data"];
                  for (int i=0; i<array.count; i++)
                  {
                      NSDictionary *dic1=[array objectAtIndex:i];
                      MyMembersModel *detailModel = [[MyMembersModel alloc] init];
                      [detailModel setValuesForKeysWithDictionary:dic1];
                      [self.allDataArray addObject:detailModel];
                  }
              }
              
              NSLog(@"allData = = = = = = = = %@", _allDataArray);
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              DLog(@"Error: %@", error);
//              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
//              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
//              [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
//                  
//              }];
              
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
