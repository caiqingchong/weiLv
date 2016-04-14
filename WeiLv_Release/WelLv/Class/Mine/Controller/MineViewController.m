//
//  MineViewController.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "MineViewController.h"
#import "UIImage+BoxBlur.h"
#import "AboutMicroViewController.h"
#import "MyOrderTableViewCOntroller.h"
#import "PersonalViewController.h"
#import "LXUserTool.h"
#import "LoginAndRegisterViewController.h"
#import "settingViewController.h"
#import "HouseKeeperViewController.h"
#import "YXHouseDetailViewController.h"
#import "ZFJMyMemberListVC.h"
#import "GuanjiaInfoViewController.h"
#import "RecommentFriendViewController.h"
#import "MyMemberOrderTableViewController.h"
#import "CommissionTableViewController.h"
#import "AnnoucementTableViewController.h"
#import "SChoolViewController.h"
#import "PersonalTravelsViewController.h"

#import "ZFJStewardShopOwnVC.h" //管家自己店铺
#import "ZFJPartnerShopOwnVC.h" //合伙人店铺

#import "ShopsManagementViewController.h"
#import "DPViewController.h"
#import "DDViewController.h"
#import "SHViewController.h"
#import "MYselfViewController.h"
#import "OpenShopViewController.h"
#import "JYCselfEatOrderVC.h"
/**/
#import "WLStewardHomeVC.h"

#import "JYCMyAccount.h"
#import "JYCMyBankCards.h"
//#import "NewGuanJiaInfoController.h"
//#import "NewGJTViewController.h"
#import "MyCollectViewController.h"

#import "LoginAndRegisterViewController.h"
#import "StewardInformationVC.h"
#define TopHeigh 150

@interface MineViewController ()<UITabBarControllerDelegate>
{
    UIView *view1;              //图像外环
    UIButton *loginBtn;        //登陆按钮
    UIButton *registerBtn;     //注册按钮
    UIView *assiteView;        //管家登陆应显示的view
    UILabel *lyCounselorLabel;  //管家姓名
    UILabel *xinyongLabel;      //服务次数
    UILabel *fangAnLabel;       //综合评分
    UIView *_myHehuoView;       //合伙人图标
    UIButton *_deletBtn;        //删除按钮
    YXHouseModel *detailModel;
    BOOL isClick1;//判断是否点击提现账户
    BOOL isClick2;//判断是否点击提现账户
    
}
@property (nonatomic, strong) Reachability *rea;
@property (nonatomic, copy) NSArray * section1_title_arr;
@property (nonatomic, copy) NSArray * section1_icon_arr;
@property (nonatomic, copy) NSArray * section2_title_arr;
@property (nonatomic, copy) NSArray * section2_icon_arr;
@property (nonatomic, copy) NSArray * section3_title_arr;
@property (nonatomic, copy) NSArray * section3_icon_arr;

@property (nonatomic, strong) UISegmentedControl * de_order_segmentedC;
@property (nonatomic, strong) UILabel * de_store_title_lab;
@property (nonatomic, strong) UIButton * backBut;

@property (nonatomic,strong)UIButton *deletBtn; //删除按钮
@property (nonatomic,strong)UIView *myHehuoView; //我的合伙人图片
@property (nonatomic,strong)WLMyHehuoView *deleView;
//@property (nonatomic,strong)UIView *deleView;
@property (nonatomic,strong)UIView *apha;  //透明层

@property (nonatomic,copy)NSString *assigID;
@property (nonatomic,copy)NSString *memberID;

@property (nonatomic,assign) BOOL isRegister;


@end

@implementation MineViewController
@synthesize assigID =_assigID;
@synthesize memberID =_memberID;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    
    isClick1=NO;
    isClick2=NO;
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember && [self judgeString:[[NSUserDefaults standardUserDefaults] objectForKey:@"memberDic"]] == NO)
    {
        
        [[LXUserTool sharedUserTool] deleteUser];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:AssitantData];
    }
    else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward && [self judgeString:[[NSUserDefaults standardUserDefaults] objectForKey:@"stewardDic"]] == NO)
    {
        [[LXUserTool sharedUserTool] deleteUser];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:AssitantData];
    }
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeNone) //未登录状态
    {
        //未登录
        view1.hidden = YES;//头像背景
        _phoneImageView.hidden = YES;//头像
        loginBtn.hidden = NO;//登录按钮
        registerBtn.hidden = NO;//注册按钮
        _realName.hidden = YES;//会员真实姓名
        _myHehuoView.hidden = YES;   //隐藏 弹出删除合伙人提示框
        _deletBtn.hidden = YES;//合伙人的删除按钮
        
    }else if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeMember)//会员登录状态
    {
        view1.hidden = NO;
        _phoneImageView.hidden = NO;
        loginBtn.hidden = YES;
        registerBtn.hidden = YES;
        
        //判断会员是不是 合伙人
        if ([[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteShop])
        {
           DLog(@"%d",[[WLSingletonClass defaultWLSingleton] wlSetHehuo]);
            //是合伙人显示图标
            _myHehuoView.hidden =NO;
            _deletBtn.hidden= NO;
            
        }else
        {
            //不是合伙人 隐藏  图标
            _myHehuoView.hidden =YES;
            _deletBtn.hidden = YES;
        }
        //会员登录
        self.section1_title_arr = @[@"管家资料",@"订单"];
        self.section1_icon_arr = @[@"管家",@"订单"];
        DLog(@"shopID === %@", [[WLSingletonClass defaultWLSingleton] wlDEShopID]);
        if(![[LXUserTool sharedUserTool] getUid])
        {
            //未登录
            self.section2_icon_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
            
            self.section2_title_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
        }
        else
        {
            //已登录
            self.section2_icon_arr = @[@"收藏",@"常用游客资料",@"个人资料",@"个人旅历",@"修改密码"];
            self.section2_title_arr = @[@"我的收藏",@"常用游客资料",@"个人资料",@"我的旅历",@"修改密码"];
            if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                self.section3_icon_arr = @[@"账户",@"银行卡",@"帮助中心",@"关于微旅"];
                self.section3_title_arr = @[@"我的账户",@"我的银行卡",@"帮助中心",@"关于微旅"];
            }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                self.section3_icon_arr = @[@"帮助中心",@"关于微旅"];
                self.section3_title_arr = @[@"帮助中心",@"关于微旅"];

            }
            
            
        }
        if ([[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteShop])
        {
//            self.section3_icon_arr = [NSArray arrayWithObjects:@"管家店铺", @"帮助中心",@"关于微旅",nil];
//            self.section3_title_arr = @[[NSString stringWithFormat:@"合伙人%@", M_STEWARD_SHOP_LAST_NAME], @"帮助中心", @"关于微旅"];
           //判断是否有提现权限
            if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                self.section3_icon_arr = @[@"账户",@"银行卡",@"帮助中心",@"关于微旅"];
                self.section3_title_arr = @[@"我的账户",@"我的银行卡",@"帮助中心",@"关于微旅"];
            }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                self.section3_icon_arr = @[@"帮助中心",@"关于微旅"];
                self.section3_title_arr = @[@"帮助中心",@"关于微旅"];
                
            }
        }
        _realName.hidden = NO;
        _realName.text = [[LXUserTool alloc] getRealname];
        [_tableView reloadData];
    }else if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward) //管家登录
    {
        view1.hidden = NO;
        _phoneImageView.hidden = NO;
        loginBtn.hidden = YES;
        registerBtn.hidden = YES;
        //管家登录
        _realName.hidden = NO;
        _realName.text = [[LXUserTool alloc] getRealname];
        _myHehuoView.hidden =YES; //  删除合伙人提示框-> 隐藏
        _deletBtn.hidden = YES;
        
        self.section1_icon_arr = @[@"管家",@"订单",@"我的会员",@"会员订单" ];
        
        self.section1_title_arr = @[@"管家资料",@"订单",@"我的会员",@"会员订单"];
        
        self.section2_title_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
        
        self.section2_icon_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
        
        if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
            self.section3_icon_arr = @[@"账户",@"银行卡",@"管家店铺",@"返佣明细",@"系统公告",@"推荐好友",@"管家学堂",@"帮助中心",@"关于微旅"];
            
            self.section3_title_arr = @[@"我的账户",@"我的银行卡",@"管家部落",@"返佣明细",@"系统公告",@"推荐好友",@"管家学堂",@"帮助中心",@"关于微旅"];
        }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
            self.section3_icon_arr = @[@"管家店铺",@"返佣明细",@"系统公告",@"推荐好友",@"管家学堂",@"帮助中心",@"关于微旅"];
            
            self.section3_title_arr = @[@"管家部落",@"返佣明细",@"系统公告",@"推荐好友",@"管家学堂",@"帮助中心",@"关于微旅"];
            
            
        }

        
       
        
        NSDictionary *userDic= [[NSUserDefaults standardUserDefaults] objectForKey:AssitantData];
        if (userDic == nil)
        {
            [self getAssiteData];
            //会员登录
            self.section1_title_arr = @[@"管家",@"订单"];
            self.section1_icon_arr = @[@"管家资料",@"订单"];
            DLog(@"shopID === %@", [[WLSingletonClass defaultWLSingleton] wlDEShopID]);
            if(![[LXUserTool sharedUserTool] getUid])
            {
                //未登录
                self.section2_icon_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
                self.section2_title_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
                
            }
            else
            {
                //已登录
                self.section2_icon_arr = @[@"常用游客资料",@"个人资料",@"个人旅历",@"修改密码"];
                self.section2_title_arr = @[@"常用游客资料",@"个人资料",@"我的旅历",@"修改密码"];
                if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                    self.section3_icon_arr = @[@"账户",@"银行卡",@"帮助中心",@"关于微旅"];
                    self.section3_title_arr = @[@"我的账户",@"我的银行卡",@"帮助中心",@"关于微旅"];
                }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                    self.section3_icon_arr = @[@"帮助中心",@"关于微旅"];
                    self.section3_title_arr = @[@"帮助中心",@"关于微旅"];
                    
                }

              
            }
            
            if ([[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteShop])
            {
                
                if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                    self.section3_icon_arr = [NSArray arrayWithObjects:@"账户",@"银行卡"@"管家店铺", @"帮助中心",@"关于微旅",nil];
                    self.section3_title_arr = @[@"我的账户",@"我的银行卡",[NSString stringWithFormat:@"合伙人%@", M_STEWARD_SHOP_LAST_NAME], @"帮助中心", @"关于微旅"];
                }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                   
                    self.section3_icon_arr = [NSArray arrayWithObjects:@"管家店铺", @"帮助中心",@"关于微旅",nil];
                    self.section3_title_arr = @[[NSString stringWithFormat:@"合伙人%@", M_STEWARD_SHOP_LAST_NAME], @"帮助中心", @"关于微旅"];
                }

                
              
               
//                                self.section3_icon_arr = [NSArray arrayWithObjects:@"管家店铺", @"帮助中心",@"关于微旅",nil];
//                                self.section3_title_arr = @[[NSString stringWithFormat:@"合伙人%@", M_STEWARD_SHOP_LAST_NAME], @"帮助中心", @"关于微旅"];
               
                
                
            }
            _realName.hidden = NO;
            _realName.text = [[LXUserTool alloc] getRealname];
        }
        else
        {
            lyCounselorLabel.text = [userDic objectForKey:@"name"];
            xinyongLabel.text = [NSString stringWithFormat:@"%@",[userDic objectForKey:@"order_count"]];
            fangAnLabel.text = [userDic objectForKey:@"level"];
        }
        
        
        self.section1_icon_arr = @[@"管家",@"订单",@"我的会员",@"会员订单" ];
        
        self.section1_title_arr = @[@"管家资料",@"订单",@"我的会员",@"会员订单"];
        
        self.section2_title_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
        
        self.section2_icon_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
        
//        self.section3_icon_arr = @[@"管家店铺",@"返佣明细",@"系统公告",@"推荐好友",@"管家学堂",@"帮助中心",@"关于微旅"];
//        
//        self.section3_title_arr = @[@"管家部落",@"返佣明细",@"系统公告",@"推荐好友",@"管家学堂",@"帮助中心",@"关于微旅"];
        if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
            self.section3_icon_arr = @[@"账户",@"银行卡",@"管家店铺",@"返佣明细",@"系统公告",@"推荐好友",@"管家学堂",@"帮助中心",@"关于微旅"];
            
            self.section3_title_arr = @[@"我的账户",@"我的银行卡",@"管家部落",@"返佣明细",@"系统公告",@"推荐好友",@"管家学堂",@"帮助中心",@"关于微旅"];
        }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
            self.section3_icon_arr = @[@"管家店铺",@"返佣明细",@"系统公告",@"推荐好友",@"管家学堂",@"帮助中心",@"关于微旅"];
            
            self.section3_title_arr = @[@"管家部落",@"返佣明细",@"系统公告",@"推荐好友",@"管家学堂",@"帮助中心",@"关于微旅"];

            
        }

        
        
        
        // NSDictionary *userDic= [[NSUserDefaults standardUserDefaults] objectForKey:AssitantData];
        if (userDic == nil)
        {
            [self getAssiteData];
        }
        else
        {
            lyCounselorLabel.text = [userDic objectForKey:@"name"];
            xinyongLabel.text = [NSString stringWithFormat:@"%@",[userDic objectForKey:@"order_count"]];
            fangAnLabel.text = [userDic objectForKey:@"level"];
        }
    }
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessUpdate) name:UpdateImage object:nil];
    //这里加载头像  放在viewWillappear；
    NSString *imageName = [NSString stringWithFormat:@"%@",[[LXUserTool sharedUserTool] getAvater]];
    NSString *avater=@"";
    if ([imageName hasPrefix:@"http://"])
    {
        avater = imageName;
    }else
    {
        NSString *str=[NSString stringWithFormat:@"/%@",imageName];
        avater= [WLHTTP stringByAppendingString:str];
    }
    [_phoneImageView sd_setImageWithURL:[NSURL URLWithString:avater] placeholderImage:[UIImage imageNamed:@"未登录头像"]];

    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember && [[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteShop] == NO)
    {
       // [self loadMemberShopID];
    }
    else
    {
        [_tableView reloadData];
    }
    
}

//- (void)loginSuccessUpdate
//{
//    NSString *imageName = [NSString stringWithFormat:@"%@",[[LXUserTool sharedUserTool] getAvater]];
//    NSString *avater=@"";
//    if ([imageName hasPrefix:@"http://"])
//    {
//        avater = imageName;
//    }else
//    {
//        NSString *str=[NSString stringWithFormat:@"/%@",imageName];
//        avater= [WLHTTP stringByAppendingString:str];
//    }
//    [_phoneImageView sd_setImageWithURL:[NSURL URLWithString:avater] placeholderImage:[UIImage imageNamed:@"未登录头像"]];
//    
//}

#pragma mark --- 获取管家信息
//获取管家信息
- (void)getAssiteData
{
    NSString *assiteId = [[LXUserTool alloc] getUid];
    NSString *url = [houseDetailUrl(assiteId) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         DLog(@"Mine ========  %@", dic);
         if (dic != nil)
         {
             detailModel = [[YXHouseModel alloc] init];
             detailModel = JsonStringTransToObject([dic objectForKey:@"data"], @"YXHouseModel");
             lyCounselorLabel.text = detailModel.name;
             xinyongLabel.text = [NSString stringWithFormat:@"%@",detailModel.order_count];
             fangAnLabel.text = detailModel.level;
             //调转管家信息
             YXMemberHouseData *memberData = [[YXMemberHouseData alloc] init];
             if (detailModel.sellers.count>0)
             {
                 memberData = [detailModel.sellers objectAtIndex:0];
             }
             NSDictionary *assitantDic = @{@"id":[NSString stringWithFormat:@"%@",detailModel.id],
                                           @"telephone":[NSString stringWithFormat:@"%@",detailModel.telephone],
                                           @"nickname":[NSString stringWithFormat:@"%@",detailModel.nickname],
                                           @"closed":[NSString stringWithFormat:@"%@",detailModel.closed],
                                           @"region":[NSString stringWithFormat:@"%@",detailModel.region],
                                           @"order_count":[NSString stringWithFormat:@"%@",detailModel.order_count],
                                           @"region_id":[NSString stringWithFormat:@"%@",detailModel.region_id],
                                           @"level":[NSString stringWithFormat:@"%@",detailModel.level],
                                           @"advantage":[NSString stringWithFormat:@"%@",detailModel.advantage],
                                           @"belong":[NSString stringWithFormat:@"%@",memberData.name],
                                           @"address":[NSString stringWithFormat:@"%@",memberData.address],
                                           @"motto":[NSString stringWithFormat:@"%@",detailModel.motto],
                                           @"name":[NSString stringWithFormat:@"%@",detailModel.name],
                                           @"birth_date":[NSString stringWithFormat:@"%@",detailModel.birth_date],
                                           @"mobile":[NSString stringWithFormat:@"%@",detailModel.mobile],
                                           @"gender":[NSString stringWithFormat:@"%@",detailModel.gender],
                                           @"email":[NSString stringWithFormat:@"%@",detailModel.email],
                                           @"horoscope":[NSString stringWithFormat:@"%@",detailModel.horoscope],
                                           @"avatar":[NSString stringWithFormat:@"%@",detailModel.avatar],
                                           @"create_time":[NSString stringWithFormat:@"%@",detailModel.create_time],
                                           @"bank_account":[NSString stringWithFormat:@"%@",detailModel.bank_account],
                                           @"bank_name":[NSString stringWithFormat:@"%@",detailModel.bank_name],
                                           @"company":[NSString stringWithFormat:@"%@",detailModel.company],
                                           @"education_background":[NSString stringWithFormat:@"%@",detailModel.education_background],
                                           @"froze":[NSString stringWithFormat:@"%@",detailModel.froze],
                                           @"group_id":[NSString stringWithFormat:@"%@",detailModel.group_id],
                                           @"native_place":[NSString stringWithFormat:@"%@",detailModel.native_place],
                                           @"occupation":[NSString stringWithFormat:@"%@",detailModel.occupation],
                                           @"order_count":[NSString stringWithFormat:@"%@",detailModel.order_count],
                                           @"position":[NSString stringWithFormat:@"%@",detailModel.position],
                                           @"qq":[NSString stringWithFormat:@"%@",detailModel.qq],
                                           @"residence":[NSString stringWithFormat:@"%@",detailModel.residence],
                                           @"school":[NSString stringWithFormat:@"%@",detailModel.school],
                                           @"trash":[NSString stringWithFormat:@"%@",detailModel.trash],
                                           @"signature":[NSString stringWithFormat:@"%@",detailModel.trash],
                                           @"wechat":[NSString stringWithFormat:@"%@",detailModel.wechat]};
             DLog(@"address === %@", [NSString stringWithFormat:@"%@",memberData.address]);
             
             [[NSUserDefaults standardUserDefaults] setObject:assitantDic forKey:AssitantData];
             [[NSUserDefaults standardUserDefaults] synchronize];
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         DLog(@"获取管家信息失败");
     }];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = BgViewColor;
    
    self.navigationItem.title = @"我的";
    
    [self initNav];
    
    self.section1_icon_arr = @[@"管家",@"订单"];
    
    self.section1_title_arr = @[@"管家资料",@"订单"];
    
    self.section2_icon_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
    
    self.section2_title_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
    
    self.section3_icon_arr = @[@"帮助中心",@"关于微旅"];
    
    self.section3_title_arr = @[@"帮助中心",@"关于微旅"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-49-44) style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    [self initHeaderView];
}


- (void)initNav
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 30, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}
- (void)initHeaderView
{
    NSString *imageName = [NSString stringWithFormat:@"%@",[[LXUserTool alloc] getAvater]];
    NSString *avater=@"";
    if ([imageName hasPrefix:@"http://"] ||[imageName hasPrefix:@"https://"])
    {
        avater = imageName;
    }else
    {
        avater= [WLHTTP stringByAppendingString:imageName];
    }
    _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, TopHeigh)];
    _bgView.image = [UIImage imageNamed:@"login_background"];
    _bgView.userInteractionEnabled = YES;
    _bgView.contentMode = UIViewContentModeScaleAspectFill;
    _bgView.clipsToBounds = YES;
    _tableView.tableHeaderView = _bgView;
    
    view1 = [[UIView alloc] initWithFrame:CGRectMake((ViewWidth(_bgView)-96)/2, 47, 96, 96)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = 48.0;
    [_bgView addSubview:view1];
    _phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ViewWidth(_bgView)-90)/2, 50, 90, 90)];
    [_phoneImageView sd_setImageWithURL:[NSURL URLWithString:avater] placeholderImage:[UIImage imageNamed:@"未登录头像"]];
     _phoneImageView.userInteractionEnabled = YES;
     view1.center = _bgView.center;
    _phoneImageView.center = _bgView.center;
    _realName=[[UILabel alloc]initWithFrame:CGRectMake(ViewX(_phoneImageView), ViewBelow(_phoneImageView)+5, 96, 20)];
    _realName.textAlignment=NSTextAlignmentCenter;
    _realName.textColor=[UIColor whiteColor];
    [_bgView addSubview:_realName];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewTapClick:)];
    [_phoneImageView addGestureRecognizer:tap];
    _phoneImageView.layer.masksToBounds=YES;
    _phoneImageView.layer.cornerRadius = 45.0;
    [_bgView addSubview:_phoneImageView];
    view1.hidden = YES;
    _phoneImageView.hidden = YES;
    
//    CGFloat width = (windowContentWidth -120*2)/3;
//    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
//    loginBtn.frame = CGRectMake(width, (TopHeigh -35)/2, 120, 35);
//    loginBtn.tag = 1;
//    [loginBtn.layer setCornerRadius:4.0];
//    loginBtn.backgroundColor = kColor(57 , 246, 177);
//    [loginBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
//    [_bgView addSubview:loginBtn];
//    
//    registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
//    registerBtn.frame = CGRectMake(width*2+120, (TopHeigh -35)/2, 120, 35);
//    registerBtn.backgroundColor = kColor(243, 178, 33);
//    [registerBtn.layer setCornerRadius:4.0];
//    registerBtn.tag = 2;
//    [registerBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
//    [_bgView addSubview:registerBtn];
//    
    
    CGFloat width = (windowContentWidth-150)/2;
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    loginBtn.frame = CGRectMake(width, (TopHeigh -40)/2, 150,40);
    loginBtn.tag = 1;
    [loginBtn.layer setCornerRadius:4.0];
    loginBtn.backgroundColor = kColor(91 , 220, 115);
    [loginBtn addTarget:self action:@selector(clickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:loginBtn];
    
    
    
    
    
    
    
    
    
    //3.合伙人删除按钮
    self.myHehuoView = [[UIView alloc]initWithFrame:CGRectMake(windowContentWidth/2-ViewWidth(_phoneImageView), ViewY(_phoneImageView)+ViewHeight(_phoneImageView)+4, ViewWidth(_phoneImageView)-20, 20)];
    self.myHehuoView.backgroundColor =[UIColor orangeColor];
    self.myHehuoView.layer.masksToBounds = YES;
    self.myHehuoView.layer.cornerRadius = 10;
    self.myHehuoView.center = CGPointMake(_bgView.center.x, self.myHehuoView.center.y);
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, ViewWidth(self.myHehuoView), 20)];
    myLabel.textColor = [UIColor whiteColor];
    myLabel.text = @"合伙人";
    myLabel.font = [UIFont systemFontOfSize:12];
    [self.myHehuoView addSubview:myLabel];
    [_bgView addSubview:self.myHehuoView];
    
    //3.1 删除按钮
    self.deletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deletBtn.frame= CGRectMake(windowContentWidth/2+ViewWidth(_phoneImageView)/2, ViewY(self.myHehuoView), 20, 20);
    [self.deletBtn setBackgroundImage:[UIImage imageNamed:@"6-取消"] forState:UIControlStateNormal];
    [self.deletBtn addTarget:self action:@selector(deletBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bgView addSubview:self.deletBtn];
    
}
- (void)changeAssitInfo:(UIButton *)sender
{
    if (![[LXUserTool sharedUserTool] getUid] )
    {
        [self showLogin];
    }
    else if (sender.tag ==1)
    {
        //跳转我的订单
        MyOrderTableViewCOntroller *myOrderVc=[[MyOrderTableViewCOntroller alloc] init];
        [self.navigationController pushViewController:myOrderVc animated:YES];
    }
    else if (sender.tag == 2)
    {
        //跳转我的会员
        ZFJMyMemberListVC *myMemberVc=[[ZFJMyMemberListVC alloc] init];
        myMemberVc.type=@"1";//如果从个人中心跳转
        [self.navigationController pushViewController:myMemberVc animated:YES];
    }
    else if (sender.tag == 3)
    {
        //跳转会员订单
        MyMemberOrderTableViewController *mymemberOL = [[MyMemberOrderTableViewController alloc] init];
        [self.navigationController pushViewController:mymemberOL animated:YES];
    }
    else if([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"])
    {
        //跳转管家资料
        NSDictionary *memberData = [[NSUserDefaults standardUserDefaults] objectForKey:AssitantData];
        GuanjiaInfoViewController *guanInfojiaVC = [[GuanjiaInfoViewController alloc] init];
        guanInfojiaVC.yewuString = [self judgeReturnString:[memberData objectForKey:@"advantage"] withReplaceString:@""];
        guanInfojiaVC.suoshuString = [self judgeReturnString:[memberData objectForKey:@"belong"] withReplaceString:@""];
        guanInfojiaVC.dizhiString = [self judgeReturnString:[memberData objectForKey:@"address"] withReplaceString:@""];
        guanInfojiaVC.geyanString = [self judgeReturnString:[memberData objectForKey:@"motto"] withReplaceString:@""];
        [self.navigationController pushViewController:guanInfojiaVC animated:YES];
    }
    else if ([[[LXUserTool alloc] getKeeper] intValue]==0)
    {
        //没有管家
        HouseKeeperViewController *keeperVC = [[HouseKeeperViewController alloc] init];
        keeperVC.pushType = isPush;
        [self.navigationController pushViewController:keeperVC animated:YES];
    
        //会员没有绑定管家的时候 重新管家界面
//        NewGJTViewController *keeperDetailVc = [[NewGJTViewController alloc]init];
//        keeperDetailVc.pushType = isPush;
//        [self.navigationController pushViewController:keeperDetailVc animated:YES];
    }
    else
    {
        //会员跳转我得管家
        //NewGuanJiaInfoController *keeperDetailVc = [[NewGuanJiaInfoController alloc]init];
        YXHouseDetailViewController *keeperDetailVc=[[YXHouseDetailViewController alloc] init];
        keeperDetailVc.pushType = isPush;
        [self.navigationController pushViewController:keeperDetailVc animated:YES];
        
    }
    
}
- (void)setting
{
    settingViewController *setVC = [[settingViewController alloc] init];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)ViewTapClick:(UIGestureRecognizer *)tap
{
    [self cameraClick];
}

- (void)clickLogin:(UIButton *)btn
{
    if (btn.tag == 1)
    {
        [self showLogin];
    }
    else
    {
        LoginAndRegisterViewController *registerVC = [[LoginAndRegisterViewController alloc] init];
        
        self.isRegister = YES;
        
        registerVC.isRegister = self.isRegister;
        
        [self.navigationController pushViewController:registerVC animated:YES];
        
    }
}
//点击拍照
- (void)cameraClick
{
    
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"更换图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    [actionsheet showInView:self.view];
    
}

#pragma mark  “登录”入口
- (void)showLogin
{
    LoginAndRegisterViewController *loginAndRegister = [[LoginAndRegisterViewController alloc] init];
    loginAndRegister.block=^(NSDictionary *dic)
    {
        [_tableView reloadData];
    };
    [self.navigationController pushViewController:loginAndRegister animated:YES];
}

#pragma mark  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypeCamera];
    }
    if (buttonIndex == 1)
    {
        [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

#pragma mark  UIImagePickerControllerDelegate
-(UIImagePickerController *)openPhotoToViewController:(UIViewController *)viewController sourceType:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && mediaTypes.count>0)
    {
        UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
        imagePick.mediaTypes = mediaTypes;
        imagePick.navigationBarHidden = YES;
        imagePick.allowsEditing = YES;
        imagePick.delegate = self;
        imagePick.sourceType = sourceType;
        [viewController presentViewController:imagePick animated:YES completion:nil];
        return imagePick;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"该设备不支持!" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
        [alert show];
    }
    return nil;
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是静态图像还是视频
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage* editedImage =nil;
        if ([info objectForKey:UIImagePickerControllerEditedImage]!=nil)
        {
            //获取用户编辑之后的图像
            editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        else
        {
            //获取原始的图像
            editedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        //判断是调用照相机还是图片库，如果是照相机的话，将图像保存到媒体库中
        if (picker.sourceType==UIImagePickerControllerSourceTypeCamera)
        {
            //将该图像保存到媒体库中
            UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            
        }
        
        UIImage *image = [self imageWithImageSimple:editedImage scaledToSize:CGSizeMake(1000, 1000)];
        [self UpdatePhoto:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

//压缩图片
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//将图片转换为字符串
- (NSString *)imageTransToBase64String:(UIImage *)image
{
    NSData *imgData = UIImageJPEGRepresentation(image,0.1);
    NSString *imgStr = [GTMBase64 stringByEncodingData:imgData];
    return imgStr;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    NSString *str=nil;
    if (!error)
    {
        str=@"picture saved with no error.";
    }
    else
    {
        str=@"error occured while saving the picture%@";
    }
}

//更新头像
- (void)UpdatePhoto:(UIImage *)imageFile
{
    NSString * memberStr = @"";
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember)
    {
        memberStr = @"member";
    }
    else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward)
    {
        memberStr = @"assistant";
    }
    
    NSData *data=UIImageJPEGRepresentation(imageFile, 0.1);
    //上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[ NSDateFormatter alloc ] init ];
    formatter. dateFormat = @"yyyyMMddHHmmss" ;
    NSString *str = [formatter stringFromDate :[ NSDate date ]];
    NSString *fileName = [ NSString stringWithFormat : @"%@.jpg" , str];
    
    NSString *userId = [[LXUserTool sharedUserTool] getUid];
    NSDictionary *parment = @{@"uid":userId, @"usergroup":memberStr};
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:UpdatePhotoUrl parameters:parment constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        [formData appendPartWithFileData:data name:@"image_file" fileName:fileName mimeType:@"image/jpeg"];
    }
    success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         if (responseObject != nil) {
             if ([[responseObject objectForKey:@"status"] isEqualToString:@"1"]) {
                 NSData *da = [[NSData alloc]initWithBase64EncodedString:[self imageTransToBase64String:imageFile] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                 UIImage *image = [UIImage imageWithData:da];
                 _phoneImageView.image = image;
                 
                 [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"avatar"] forKey:@"avater"];
             }
             
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         [[LXAlterView sharedMyTools] createTishi:@"修改图像失败！"];
     }];
}

#pragma mark --- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSString *username=[[LXUserTool sharedUserTool] getUid];
    if (!username)
    {
        return 3;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
    {
        return self.section2_title_arr.count;
    }
    if (section == 2)
    {
        return self.section3_title_arr.count;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 20)];
    [sectionView setBackgroundColor:[UIColor clearColor]];
    if (section ==0)
    {
        sectionView.alpha = 0;
    }
    return sectionView;
}


- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil;
    }
    return @"123";
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 3 || indexPath.section == 0)
    {
        return 80;
    }
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        static NSString *CellIdentifier0 = @"cellIdentifier0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier0];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth(_bgView), 80)];
        headerView.backgroundColor = [UIColor whiteColor];
        float with = (windowContentWidth-60)/self.section1_title_arr.count;
        for (int i = 0; i<self.section1_title_arr.count; i++)
        {
            UIButton *gjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            gjBtn.frame=CGRectMake(30+with*i, 10, with, 70);
            gjBtn.tag = i;
            [gjBtn addTarget:self action:@selector(changeAssitInfo:) forControlEvents:UIControlEventTouchUpInside];
            [headerView addSubview:gjBtn];
            
            UIImageView *gjImageV = [YXTools allocImageView:CGRectMake(0, 0, with, 30) image:[UIImage imageNamed:[self.section1_icon_arr objectAtIndex:i]]];
            [gjBtn addSubview:gjImageV];
            
            UILabel *gjLable = [YXTools allocLabel:[self.section1_title_arr objectAtIndex:i] font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(gjImageV), ViewY(gjImageV)+ViewHeight(gjImageV), with, 40) textAlignment:1];
            [gjBtn addSubview:gjLable];
            
            if (i == 2)
            {
                UILabel *memberCountLab = [[UILabel alloc] initWithFrame:CGRectMake(with/3*2+5, 70-12-27, with/3, 12)];
                memberCountLab.backgroundColor = kColor(251, 132, 10);
                memberCountLab.textColor = [UIColor whiteColor];
                memberCountLab.layer.cornerRadius = 5;
                memberCountLab.layer.masksToBounds =YES;
                memberCountLab.backgroundColor = kColor(251, 132, 10);
                memberCountLab.textAlignment = NSTextAlignmentCenter;
                memberCountLab.font = [UIFont systemFontOfSize:11];
                memberCountLab.text = [[LXUserTool alloc] getMember_count];
                if([memberCountLab.text isEqualToString:@"(null)"])
                {
                    memberCountLab.text = @"0";
                }
                [gjBtn addSubview:memberCountLab];
            }
            
        }
        
        [cell addSubview:headerView];
        return cell;
        
    }
    if (indexPath.section == 1)
    {
        static NSString *CellIdentifier1 = @"cellIdentifier1";
        setCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        
        if (cell == nil)
        {
            cell = [[setCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1 isJump:YES];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.leftImageVIew.image = [UIImage imageNamed:[self.section2_icon_arr objectAtIndex:indexPath.row]];
        cell.nameLabel.text = [self.section2_title_arr objectAtIndex:indexPath.row];
        return cell;
    }
    if (indexPath.section == 2)
    {
        static NSString *CellIdentifier2 = @"cellIdentifier2";
        setCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        if (cell == nil)
        {
            cell = [[setCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2 isJump:NO];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.leftImageVIew.image = [UIImage imageNamed:[self.section3_icon_arr objectAtIndex:indexPath.row]];
        cell.nameLabel.text = [self.section3_title_arr objectAtIndex:indexPath.row];
        return cell;
    }
    
    if (indexPath.section == 3)
    {
        static NSString *CellIdentifier3 = @"cellIdentifier3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            exitBtn.frame=CGRectMake(74, 25, windowContentWidth - 74*2, 35);
            //[exitBtn setImage:[UIImage imageNamed:@"退出登录"] forState:UIControlStateNormal];
            exitBtn.layer.cornerRadius=5;
            exitBtn.layer.borderWidth=.5;
            exitBtn.layer.borderColor=[kColor(250, 90, 95) CGColor];
            [exitBtn setTitle:@"退出登录" forState:UIControlStateNormal];
            [exitBtn setTitleColor:kColor(250, 90, 95) forState:UIControlStateNormal];
            [exitBtn addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:exitBtn];
        }
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *username=[[LXUserTool alloc] getUid];
    if (!username &&indexPath.section == 1)
    {
        [self showLogin];
        
    }else if (indexPath.section == 1)
    {
        switch (indexPath.row)
        {
            case 0:
                if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember){
                
                    //我的收藏
                    MyCollectViewController *myCollectVC = [[MyCollectViewController alloc]initWithStyle:UITableViewStylePlain];
                    [self.navigationController pushViewController:myCollectVC animated:YES];
                }else{
                    //跳转常用游客资料
                    CusInfoViewController *view = [[CusInfoViewController alloc] init];
                    view.isFromeOrder = NO;
                    [self.navigationController pushViewController:view animated:YES];
  
            }
            break;

            case 1:
            {

                 if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember){
                
                     //跳转常用游客资料
                     CusInfoViewController *view = [[CusInfoViewController alloc] init];
                     view.isFromeOrder = NO;
                     [self.navigationController pushViewController:view animated:YES];

                 }else{
                     [self gotoStewardInforView];
                 }
        
                break;
            }
            case 2:
            {
                if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
                    //管家跳转修改密码
                    ChangePasswordViewController *changePwd = [[ChangePasswordViewController alloc] init];
                    [self.navigationController pushViewController:changePwd animated:YES];
                    

                } else
                {
                    [self gotoMemberInfoView];
//                    //管家跳转修改密码
//                    ChangePasswordViewController *changePwd = [[ChangePasswordViewController alloc] init];
//                    [self.navigationController pushViewController:changePwd animated:YES];
                }
                break;
            case 10:
            {
                
                if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward)
                {
                    //管家 --- 自驾吃商铺管理
                    ShopsManagementViewController *shopmaVC = [[ShopsManagementViewController alloc] init];
                    [self.navigationController pushViewController:shopmaVC animated:YES];
                    
                }
                else
                {
                    /*会员 --- 自驾吃店铺*/
                    if ([[WLSingletonClass defaultWLSingleton] wlUserIsHaveDEShop])
                    {
                        switch ([[[WLSingletonClass defaultWLSingleton] wldeShopStatus] integerValue])
                        {
                            case 0:
                            {
                                DLog(@"0.申请中");
                                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"申请中" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                [alert show];
                                
                            }
                                break;
                            case 1:
                            {
                                [self goDEStore];
                                
                            }
                                break;
                            case 2:
                            {
                                DLog(@"2.禁用 ");
                                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"禁用" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                [alert show];
                                
                            }
                                break;
                            case 3:
                            {
                                DLog(@"申请失败");
                                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"申请失败" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
                                [alert show];
                            }
                                break;
                                
                            default:
                                break;
                        }
                        
                    } else {
                        //会员申请开户
                        OpenShopViewController * vc = [[OpenShopViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    }
                    
                }
            }
                break;
                
            case 3:
                
                
                if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember)
                {
                    
                    //跳转到我的旅历
                    PersonalTravelsViewController *personalTravelsController = [[PersonalTravelsViewController alloc] init];
                    
                    if([[LXUserTool sharedUserTool] getUid]){
                        
                        personalTravelsController.userType = UserTypeMember;
                        
                    }else{
                        
                        personalTravelsController.userType = UserTypeAssistant;
                    }
                    
                    [self.navigationController pushViewController:personalTravelsController animated:YES];
                
                }
//                else
//                {
//                    //管家跳转修改密码
//                    ChangePasswordViewController *changePwd = [[ChangePasswordViewController alloc] init];
//                    [self.navigationController pushViewController:changePwd animated:YES];
//
//                    
//                }

            
                
                break;
                
            case 4:
            {
                if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember)
                {
                    //跳转修改密码
                    ChangePasswordViewController *changePwd = [[ChangePasswordViewController alloc] init];
                    [self.navigationController pushViewController:changePwd animated:YES];
                    
                }
//                else
//                {
//                    //管家跳转修改密码
//                    ChangePasswordViewController *changePwd = [[ChangePasswordViewController alloc] init];
//                    [self.navigationController pushViewController:changePwd animated:YES];
//                    
//                }
            }
                break;
//                
//            case 5:
//            {
//                //跳转修改密码
//                ChangePasswordViewController *changePwd = [[ChangePasswordViewController alloc] init];
//                [self.navigationController pushViewController:changePwd animated:YES];
//            }
//                break;
                
            default:
                break;
        }
        }
        
    }else if (!username &&indexPath.section == 2)
    {
        switch (indexPath.row){
            case 0:
            {
                helpCenterController *helpVC = [[helpCenterController alloc] init];
                [self.navigationController pushViewController:helpVC animated:YES];
            }
                break;
                case 1:
            {
                AboutMicroViewController *aboutVC = [[AboutMicroViewController alloc] init];
                [self.navigationController pushViewController:aboutVC animated:YES];
            }
                break;
            default:
                break;

        }
        
    }
    else if (indexPath.section ==2&&username)
    {
        
        if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"])
        {
            
            switch (indexPath.row)
            {
                case 0:
                {
                   
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {

                        
                        if (isClick1) {
                            return;
                        }
                       
                        [self getVisitAllowAcount];
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        //跳转到管家店铺
                        ZFJStewardShopOwnVC * stewardShopVC = [[ZFJStewardShopOwnVC alloc] init];
                        [self.navigationController pushViewController:stewardShopVC animated:YES];
                       
                    }

                   
                }
                    break;
                case 1:
                {
                    
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
//                        JYCMyBankCards *bankVC=[[JYCMyBankCards alloc]init];
//                        [self.navigationController pushViewController:bankVC animated:YES];
                       
                        if (isClick2) {
                            return;
                        }

                        
                        [self getVisitAllowBankCards];
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        //跳转返佣明细
                        CommissionTableViewController *comm = [[CommissionTableViewController alloc] init];
                        [self.navigationController pushViewController:comm animated:YES];
                    }

                    
                   
                }
                    break;
                case 2:
                {
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                        //跳转到管家店铺
                        ZFJStewardShopOwnVC * stewardShopVC = [[ZFJStewardShopOwnVC alloc] init];
                        [self.navigationController pushViewController:stewardShopVC animated:YES];
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        //跳转系统公告
                        AnnoucementTableViewController *ann = [[AnnoucementTableViewController alloc] init];
                        [self.navigationController pushViewController:ann animated:YES];

                    }
     
                }
                    break;
                case 3:
                {
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                        //跳转返佣明细
                        CommissionTableViewController *comm = [[CommissionTableViewController alloc] init];
                        [self.navigationController pushViewController:comm animated:YES];

                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        //跳转推荐好友
                        RecommentFriendViewController *recommentVC = [[RecommentFriendViewController alloc] init];
                        [self.navigationController pushViewController:recommentVC animated:YES];
                        
                    }

                }
                    break;
                case 4:
                {
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                        //跳转系统公告
                        AnnoucementTableViewController *ann = [[AnnoucementTableViewController alloc] init];
                        [self.navigationController pushViewController:ann animated:YES];
                        
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        //跳转管家学堂
                        SChoolViewController *sch = [[SChoolViewController alloc] init];
                        [self.navigationController pushViewController:sch animated:YES];

                        
                    }
    
                }
                    break;
                case 5:
                {
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                        //跳转推荐好友
                        RecommentFriendViewController *recommentVC = [[RecommentFriendViewController alloc] init];
                        [self.navigationController pushViewController:recommentVC animated:YES];

                        
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        //跳转帮助中心
                        helpCenterController *helpVC = [[helpCenterController alloc] init];
                        [self.navigationController pushViewController:helpVC animated:YES];

                        
                        
                    }
 
                }
                    break;
                case 6:
                {
                   
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                        //跳转管家学堂
                        SChoolViewController *sch = [[SChoolViewController alloc] init];
                        [self.navigationController pushViewController:sch animated:YES];
                        
                        
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        //跳转关于微旅
                        AboutMicroViewController *aboutVC = [[AboutMicroViewController alloc] init];
                        [self.navigationController pushViewController:aboutVC animated:YES];
       
                    }

                }
                    break;
                case 7:
                {
                  
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                        //跳转帮助中心
                        helpCenterController *helpVC = [[helpCenterController alloc] init];
                        [self.navigationController pushViewController:helpVC animated:YES];
                        
                        
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        
                        
                        
                    }
                     }
                    break;
                case 8:
                {
                   
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                        //跳转关于微旅
                        AboutMicroViewController *aboutVC = [[AboutMicroViewController alloc] init];
                        [self.navigationController pushViewController:aboutVC animated:YES];
                        
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        
                        
                        
                    }
              
                    
                }
                    break;
                default:
                    break;
            }
            
        }
        else
        {
            
            switch (indexPath.row) {
                
                case 0:
                {
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                        //跳转到我的账户
//                        JYCMyAccount *vc=[[JYCMyAccount alloc]init];
//                        self.navigationController.navigationBar.hidden=YES;
//                        // [self presentViewController:vc animated:YES completion:nil];
//                        [self.navigationController pushViewController:vc animated:YES];
                     
                        if (isClick1) {
                            return;
                        }
                        [self getVisitAllowAcount];
                        
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        
                        //跳转帮助中心
                        helpCenterController *helpVC = [[helpCenterController alloc] init];
                        [self.navigationController pushViewController:helpVC animated:YES];
                        
                    }
                }
                    break;
                case 1:
                {
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
//                        JYCMyBankCards *bankVC=[[JYCMyBankCards alloc]init];
//                        [self.navigationController pushViewController:bankVC animated:YES];
                    
                        if (isClick2) {
                            return;
                        }

                        [self getVisitAllowBankCards];
                        
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        
                        //跳转关于微旅
                        AboutMicroViewController *aboutVC = [[AboutMicroViewController alloc] init];
                        [self.navigationController pushViewController:aboutVC animated:YES];

                        
                    }

                }
                    break;
                case 2:
                {
                    
//                    if ([[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteShop])
//                    {
//                        //跳转到合伙人店铺
//                        ZFJPartnerShopOwnVC * vc = [[ZFJPartnerShopOwnVC alloc] init];
//                        [self.navigationController pushViewController:vc animated:YES];
//                    }
                   // else
                   
                        //跳转帮助中心
                    
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                        helpCenterController *helpVC = [[helpCenterController alloc] init];
                        [self.navigationController pushViewController:helpVC animated:YES];
                        
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        
                        
                        
                    }

                }
                    break;
                case 3:
                {
                    
//                    if ([[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteShop])
//                    {
//                        //跳转帮助中心
//                        helpCenterController *helpVC = [[helpCenterController alloc] init];
//                        [self.navigationController pushViewController:helpVC animated:YES];
//                        
//                    }
                   // else
                   // {
                    
                    if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==1) {
                        //跳转关于微旅
                        AboutMicroViewController *aboutVC = [[AboutMicroViewController alloc] init];
                        [self.navigationController pushViewController:aboutVC animated:YES];
                    }else if ([[[LXUserTool sharedUserTool]getIs_withdraw]integerValue]==0){
                        
                        
                        
                    }

                    
                   
                   // }
                }
                    break;
//                case 2:
//                {
//                    //跳转关于微旅
//                    AboutMicroViewController *aboutVC = [[AboutMicroViewController alloc] init];
//                    [self.navigationController pushViewController:aboutVC animated:YES];
//                    
//                }
//                   break;
                    
                default:
                    break;
            }
            
        }
        
        
    }
    
}
#pragma mark - 跳转到会员和管家资料

- (void)gotoMemberInfoView {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *parameters = @{@"uid":[[WLSingletonClass defaultWLSingleton] wlUserID]};
    //接口
    NSString *url= M_URL_MERBER_INFOR;
    //发送请求
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DLog(@"获取数据 ==== \n%@", dict);
        if ([dict isKindOfClass:[NSDictionary class]] && [[dict objectForKey:@"status"] integerValue] == 1) {
            if ([[dict objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                NSDictionary * dic = [dict objectForKey:@"data"];
                //把用户信息存到本地
                [[LXUserTool sharedUserTool] saveUserNameAndPwd:[dic objectForKey:@"username"]
                                                         andPwd:[dic objectForKey:@"password"]
                                                     andBalance:[dic objectForKey:@"balance"]
                                                    andBirthday:[dic objectForKey:@"birthday"]
                                                  andCreatetime:[dic objectForKey:@"createtime"]
                                                        andDiqu:[dic objectForKey:@"diqu"]
                                                       andEmail:[dic objectForKey:@"email"]
                                                    andIdnumber:[dic objectForKey:@"idnumber"]
                                                      andIdtype:[dic objectForKey:@"idtype"]
                                                       andLevel:[dic objectForKey:@"level"]
                                                      andLevels:[dic objectForKey:@"levels"]
                                                   andLogintime:[dic objectForKey:@"logintime"]
                                                       andMtype:[dic objectForKey:@"mtype"]
                                                       andPhone:[dic objectForKey:@"phone"]
                                                    andRealname:[dic objectForKey:@"realname"]
                                                        andSalt:[dic objectForKey:@"salt"]
                                                         adnSex:[dic objectForKey:@"sex"]
                                              andShengshiquxian:[dic objectForKey:@"address"]
                                                         andUid:[dic objectForKey:@"uid"]
                                                adnAssistant_id:[dic objectForKey:@"assistant_id"]
                                               andIs_detachable:[dic objectForKey:@"is_detachable"]
                                                   andUsergroup:[dic objectForKey:@"usergroup"]
                                                      andAvater:[dic objectForKey:@"avater"]
                                                andMember_count:[dic objectForKey:@"member_count"]andPwd2:[[LXUserTool sharedUserTool]getPwd2]andIs_withdraw:[[LXUserTool sharedUserTool]getIs_withdraw]];
                
                [[LXUserTool sharedUserTool] addUserMemberWithDic:dic];
                //会员跳转个人资料
                PersonalViewController *changePwd = [[PersonalViewController alloc] init];
                [self.navigationController pushViewController:changePwd animated:YES];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //DLog(@"ERROR: %@", error);
        //会员跳转个人资料
        PersonalViewController *changePwd = [[PersonalViewController alloc] init];
        [self.navigationController pushViewController:changePwd animated:YES];
    }];
    
}

- (void)gotoStewardInforView {
    NSString *assiteId = [[LXUserTool alloc] getUid];
    NSString *url = [houseDetailUrl(assiteId) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         DLog(@"Mine ========  %@", dic);
         if (dic != nil) {
             detailModel = [[YXHouseModel alloc] init];
             detailModel = JsonStringTransToObject([dic objectForKey:@"data"], @"YXHouseModel");
             lyCounselorLabel.text = detailModel.name;
             xinyongLabel.text = [NSString stringWithFormat:@"%@",detailModel.order_count];
             fangAnLabel.text = detailModel.level;
             //调转管家信息
             YXMemberHouseData *memberData = [[YXMemberHouseData alloc] init];
             if (detailModel.sellers.count>0) {
                 memberData = [detailModel.sellers objectAtIndex:0];
             }
             NSDictionary *assitantDic = @{@"id":[NSString stringWithFormat:@"%@",detailModel.id],
                                           @"telephone":[NSString stringWithFormat:@"%@",detailModel.telephone],
                                           @"nickname":[NSString stringWithFormat:@"%@",detailModel.nickname],
                                           @"closed":[NSString stringWithFormat:@"%@",detailModel.closed],
                                           @"region":[NSString stringWithFormat:@"%@",detailModel.region],
                                           @"order_count":[NSString stringWithFormat:@"%@",detailModel.order_count],
                                           @"region_id":[NSString stringWithFormat:@"%@",detailModel.region_id],
                                           @"level":[NSString stringWithFormat:@"%@",detailModel.level],
                                           @"advantage":[NSString stringWithFormat:@"%@",detailModel.advantage],
                                           @"belong":[NSString stringWithFormat:@"%@",memberData.name],
                                           @"address":[NSString stringWithFormat:@"%@",memberData.address],
                                           @"motto":[NSString stringWithFormat:@"%@",detailModel.motto],
                                           @"name":[NSString stringWithFormat:@"%@",detailModel.name],
                                           @"birth_date":[NSString stringWithFormat:@"%@",detailModel.birth_date],
                                           @"mobile":[NSString stringWithFormat:@"%@",detailModel.mobile],
                                           @"gender":[NSString stringWithFormat:@"%@",detailModel.gender],
                                           @"email":[NSString stringWithFormat:@"%@",detailModel.email],
                                           @"horoscope":[NSString stringWithFormat:@"%@",detailModel.horoscope],
                                           @"avatar":[NSString stringWithFormat:@"%@",detailModel.avatar],
                                           @"create_time":[NSString stringWithFormat:@"%@",detailModel.create_time],
                                           @"bank_account":[NSString stringWithFormat:@"%@",detailModel.bank_account],
                                           @"bank_name":[NSString stringWithFormat:@"%@",detailModel.bank_name],
                                           @"company":[NSString stringWithFormat:@"%@",detailModel.company],
                                           @"education_background":[NSString stringWithFormat:@"%@",detailModel.education_background],
                                           @"froze":[NSString stringWithFormat:@"%@",detailModel.froze],
                                           @"group_id":[NSString stringWithFormat:@"%@",detailModel.group_id],
                                           @"native_place":[NSString stringWithFormat:@"%@",detailModel.native_place],
                                           @"occupation":[NSString stringWithFormat:@"%@",detailModel.occupation],
                                           @"order_count":[NSString stringWithFormat:@"%@",detailModel.order_count],
                                           @"position":[NSString stringWithFormat:@"%@",detailModel.position],
                                           @"qq":[NSString stringWithFormat:@"%@",detailModel.qq],
                                           @"residence":[NSString stringWithFormat:@"%@",detailModel.residence],
                                           @"school":[NSString stringWithFormat:@"%@",detailModel.school],
                                           @"trash":[NSString stringWithFormat:@"%@",detailModel.trash],
                                           @"signature":[NSString stringWithFormat:@"%@",detailModel.trash],
                                           @"wechat":[NSString stringWithFormat:@"%@",detailModel.wechat]};
             [[NSUserDefaults standardUserDefaults] setObject:assitantDic forKey:AssitantData];
             [[NSUserDefaults standardUserDefaults] synchronize];
             
             //跳转管家个人资料
             //StewardInformationVC *selfInfoVC = [[StewardInformationVC alloc] init];
             GuanJiaSelfInfoViewController *selfInfoVC = [[GuanJiaSelfInfoViewController alloc] init];
             [self.navigationController pushViewController:selfInfoVC animated:YES];
             
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         DLog(@"获取管家信息失败");
         //跳转管家个人资料
         GuanJiaSelfInfoViewController *selfInfoVC = [[GuanJiaSelfInfoViewController alloc] init];
         [self.navigationController pushViewController:selfInfoVC animated:YES];
         
     }];
}

#pragma mark --- 跳转到自驾吃的店铺

- (void)goDEStore {
    DPViewController * vc1 = [[DPViewController alloc] init];
    DDViewController * vc2 = [[DDViewController alloc] init];
    SHViewController * vc3 = [[SHViewController alloc] init];
    MYselfViewController * vc4 = [[MYselfViewController alloc] init];
    
    UITabBarController *tabBarC = [[UITabBarController alloc] init];
    tabBarC.navigationItem.hidesBackButton = YES;
    tabBarC.tabBar.backgroundColor = [UIColor whiteColor];
    tabBarC.viewControllers = @[vc1, vc2, vc3, vc4];
    tabBarC.tabBar.tintColor = [UIColor orangeColor];
    
    NSArray * titleArr = @[@"店铺",
                           @"订单",
                           @"上货",
                           @"我的"];
    
    NSArray * imageArr = @[@"de_store_home_icon",
                           @"de_tb_store_order_icon",
                           @"de_tb_store_upload_goods_icon",
                           @"de_tb_store_user_icon"];
    
    NSArray * selectedImageArr = @[@"de_store_home_select_icon",
                                   @"de_tb_store_order_select_icon",
                                   @"de_tb_store_upload_goods_select_icon",
                                   @"de_tb_store_user_select_icon"];
    
    for (int i = 0; i < tabBarC.tabBar.items.count; i++) {
        UITabBarItem * item = [tabBarC.tabBar.items objectAtIndex:i];
        item.title = titleArr[i];
        item.image =[[UIImage imageNamed:imageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:selectedImageArr[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    tabBarC.navigationItem.title = @"微旅店家";
    tabBarC.delegate = self;
    
    self.backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBut.frame = CGRectMake(0, 0, 16, 26);
    [self.backBut setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.backBut addTarget:self action:@selector(dismissDEView) forControlEvents:UIControlEventTouchUpInside];
    tabBarC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.backBut];
    
    self.de_order_segmentedC.selectedSegmentIndex = 0;
    [self.navigationController pushViewController:tabBarC animated:YES];
    
}
#pragma mark --- UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController.class isEqual:[DPViewController class]])
    {
        self.de_store_title_lab.text = @"微旅店家";
        self.backBut.hidden = NO;
        tabBarController.navigationItem.titleView = self.de_store_title_lab;
        
    }
    else if ([viewController.class isEqual:[DDViewController class]])
    {
        self.backBut.hidden = YES;
        tabBarController.navigationItem.titleView = self.de_order_segmentedC;
        
    }
    else if ([viewController.class isEqual:[SHViewController class]])
    {
        self.backBut.hidden = YES;
        self.de_store_title_lab.text = @"上货";
        tabBarController.navigationItem.titleView = self.de_store_title_lab;
        
    }
    else if ([viewController.class isEqual:[MYselfViewController class]])
    {
        self.backBut.hidden = YES;
        self.de_store_title_lab.text = @"商户管理";
        tabBarController.navigationItem.titleView = self.de_store_title_lab;
        
    }
}


#pragma mark --- segmentAction

- (UISegmentedControl *)de_order_segmentedC
{
    if (!_de_order_segmentedC)
    {
        self.de_order_segmentedC = [[UISegmentedControl alloc] initWithItems:@[@"未处理订单", @"已处理订单"]];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16.0],NSFontAttributeName,nil];
        [self.de_order_segmentedC setTitleTextAttributes:dic forState:UIControlStateNormal];
        self.de_order_segmentedC.tintColor = [UIColor orangeColor];
        self.de_order_segmentedC.frame = CGRectMake(0, 0,windowContentWidth-140, 30);
        self.de_order_segmentedC.selectedSegmentIndex = 0;
        [self.de_order_segmentedC addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _de_order_segmentedC;
}

- (void)segmentControlAction:(UISegmentedControl *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"de_order_segmented_control" object:sender];
}

- (UILabel *)de_store_title_lab
{
    if (!_de_store_title_lab)
    {
        self.de_store_title_lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth - 150, 30)];
        self.de_store_title_lab.textAlignment = NSTextAlignmentCenter;
    }
    return _de_store_title_lab;
}

- (void)dismissDEView
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ----------------------------------delet----删-----除-----合----伙-----人-----------------------
-(void)deletBtnClick:(UIButton *)btn
{
    self.apha = [[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    self.apha.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    [self.view addSubview:self.apha];
    if (IS_IPHONE_4_OR_LESS) {
        
    self.deleView =[[WLMyHehuoView alloc] initWithFrame:CGRectMake(20, 200, windowContentWidth-20*2,120)];
        
    }else if (IS_IPHONE_5)
    {
        self.deleView =[[WLMyHehuoView alloc] initWithFrame:CGRectMake(20, 200, windowContentWidth-20*2,120)];
        
    }else if (IS_IPHONE_6)
    {
        self.deleView =[[WLMyHehuoView alloc] initWithFrame:CGRectMake(30, 200, windowContentWidth-30*2,120)];
        
    }else if (IS_IPHONE_6P)
    {
        self.deleView =[[WLMyHehuoView alloc] initWithFrame:CGRectMake(30, 200, windowContentWidth-30*2,120)];
        
    }
    [[self.deleView layer]setCornerRadius:3.0];//圆角
    self.deleView.layer.masksToBounds = YES;
    self.deleView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor orangeColor]);
    self.deleView.backgroundColor = [UIColor whiteColor];
    [self.apha addSubview:self.deleView];
    
    [self.deleView.cancleBtn addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.deleView.okBtn addTarget:self action:@selector(okClick:) forControlEvents:UIControlEventTouchUpInside];
    
}
//取消
-(void)cancleClick:(UIButton *)button
{
    [self.apha removeFromSuperview];
    [self.deleView removeFromSuperview];
    
}
/**
 *  确定  合伙人取消合伙人资格
 */
-(void)okClick:(UIButton *)button
{
    [self.deleView removeFromSuperview]; //移除弹出选删除视图
    [self.apha removeFromSuperview];
    
    self.assigID =  [NSString stringWithFormat:@"%@",[[LXUserTool sharedUserTool] getKeeper]];
    self.memberID = [NSString stringWithFormat:@"%@",[[LXUserTool sharedUserTool]getUid]];
    
    NSString *hehuoStr = DeletePanter_Url;
    NSMutableDictionary *dict=nil;
    
    dict =[NSMutableDictionary dictionaryWithObjectsAndKeys:self.assigID,@"assistant_id",self.memberID,@"member_id",@"5",@"type", nil];
    AFHTTPRequestOperationManager *afManger = [AFHTTPRequestOperationManager manager];
    afManger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [afManger POST:hehuoStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *resultDict =(NSDictionary *)responseObject;
        NSString *restStr =[NSString stringWithFormat:@"%@",[resultDict objectForKey:@"status"]];
        if ([restStr isEqual:@"1"])
        {
            [[LXAlterView sharedMyTools] createTishi:[resultDict objectForKey:@"msg"]];
            //删除合伙人 需要将本地 合伙人id值 只为0，
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setValue:@"0" forKey:@"ste_shop_ID"];
           // [user setValue:@"" forKey:@"store_id"];

            [self.deleView removeFromSuperview]; //移除弹出选删除视图
            [self.apha  removeFromSuperview];
            
        }else
        {
            [[LXAlterView sharedMyTools] createTishi:[resultDict objectForKey:@"msg"]];
            [self.apha removeFromSuperview];//移除

            [self.deleView removeFromSuperview];
//            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//            //删除合伙人 需要将本地 合伙人id值 只为0，
//            [user setValue:@"0" forKey:@"ste_shop_ID"];
//            [user setValue:@"" forKey:@"store_id"];
        }
        self.myHehuoView.hidden= YES;
        self.deletBtn.hidden = YES;
        [_tableView reloadData];
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.myHehuoView.hidden= NO;
        self.deletBtn.hidden = NO;
        [[LXAlterView sharedMyTools]createTishi:@"操作失败"];
        
        NSLog(@"%@",error);
    }];
    
}
#pragma mark --- 退出登录
//退出登录
- (void)exitLogin
{
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要退出微旅吗？再次登录需要重新验证身份信息。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    self.deletBtn.hidden = YES;
    self.myHehuoView.hidden = YES;
    [alerView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [[LXUserTool alloc] deleteUser];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:AssitantData];
        self.section1_icon_arr = @[@"管家", @"订单"];
        self.section1_title_arr = @[@"管家", @"订单"];
        
        self.section2_icon_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
        self.section2_title_arr = @[@"常用游客资料",@"个人资料",@"修改密码"];
        
        self.section3_icon_arr = @[@"帮助中心", @"关于微旅"];
        self.section3_title_arr = @[@"帮助中心", @"关于微旅"];
        view1.hidden = YES;
        _phoneImageView.hidden = YES;
        loginBtn.hidden = NO;
        registerBtn.hidden = NO;
        _realName.hidden = YES;
        _phoneImageView.image = [UIImage imageNamed:@"未登录头像"];
        [_tableView reloadData];
        
    }
}

- (void)loadMemberShopID
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary * parameters = @{@"uid":[[WLSingletonClass defaultWLSingleton] wlUserID],
                                  @"id_type":@"2"};
    NSString * url = M_SS_URL_SHOP_ID;
    DLog(@"%@", parameters);
    WS(weakSelf);
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              DLog(@"shop_dic === %@", dic);
              DLog(@"%@", [dic objectForKey:@"msg"]);
              if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1)
              {
                  /**
                    注意：
                   1. 之前出现问题，删除 合伙人后，在切换界面 合伙人显示的图标又出来了。原因是请求数据 获取的ste_shop_ID，有多次保存在本地磁盘。导致每次删除后，切换界面又重新获取其他界面保存的ste_shop_ID，界面有显示合伙人图标。
                   2.其他控制器里的 注释掉的[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [self judgeReturnString:[[dic objectForKey:@"data"] objectForKey:@"store_id"]  withReplaceString:@"0"]] forKey:@"ste_shop_ID"];
                   不要动。
                   */
                  
                  if ([weakSelf judgeString:[[dic objectForKey:@"data"] objectForKey:@"store_id"]]) {
                      //[[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@", [self judgeReturnString:[[dic objectForKey:@"data"] objectForKey:@"store_id"]  withReplaceString:@"0"]] forKey:@"ste_shop_ID"];
                  }
                  else
                  {
                      [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"ste_shop_ID"];
                  }
              }
              else
              {
                  //[[WLSingletonClass defaultWLSingleton] wlAddNoDataViewWithSuperView:weakSelf.view];
              }
              [_tableView reloadData];
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error)
          {
              DLog(@"Error: %@", error);
              //[[WLSingletonClass defaultWLSingleton] wlAddNoDataViewWithSuperView:weakSelf.view];
              [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"ste_shop_ID"];
              [_tableView reloadData];
              
          }];
}
-(void)getVisitAllowAcount{
    //isClick=!isClick;
    isClick1=YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    NSDictionary *parameters = @{@"member_id":[[LXUserTool alloc] getUid],@"group_name":[[LXUserTool alloc] getuserGroup],@"_token":md5str};
    [manager POST:get_visit_allow parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         DLog(@"%@",dic);
         if ([dic[@"status"]integerValue]==1) {
           //  跳转到我的账
        
        JYCMyAccount *vc=[[JYCMyAccount alloc]init];
        self.navigationController.navigationBar.hidden=YES;
        
        [self.navigationController pushViewController:vc animated:YES];
  
         }else{
             [[LXAlterView sharedMyTools]createTishi:dic[@"message"]];
              return;
         }
         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         DLog(@"Error: %@", error);
          [[LXAlterView sharedMyTools]createTishi:@"网络不给力,请您检查一下网络设置"];
           return;
         
     }];

 
}

-(void)getVisitAllowBankCards{
    //isClick=!isClick;
    isClick2=YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
    md5str = [WXUtil md5:md5str];
    NSDictionary *parameters = @{@"member_id":[[LXUserTool alloc] getUid],@"group_name":[[LXUserTool alloc] getuserGroup],@"_token":md5str};    [manager POST:get_visit_allow parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         DLog(@"%@",dic);
         if ([dic[@"status"]integerValue]==1) {
             
             JYCMyBankCards *bankVC=[[JYCMyBankCards alloc]init];
             [self.navigationController pushViewController:bankVC animated:YES];
             
         }else{
             [[LXAlterView sharedMyTools]createTishi:dic[@"message"]];
             return;
         }
         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         DLog(@"Error: %@", error);
         [[LXAlterView sharedMyTools]createTishi:@"网络不给力,请您检查一下网络设置"];
         return;
         
     }];
    
    
}


@end

@implementation setCell
@synthesize leftImageVIew = _leftImageVIew,nameLabel = _nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier isJump:(BOOL)isShow
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _leftImageVIew = [[UIImageView alloc] initWithFrame:CGRectMake(20,(ViewHeight(self)-22)/2, 20, 20)];
        _leftImageVIew.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_leftImageVIew];
        
        _nameLabel = [YXTools allocLabel:@"" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(ViewX(_leftImageVIew)+ViewWidth(_leftImageVIew)+10, 0, 150,  ViewHeight(self))textAlignment:0];
        [self addSubview:_nameLabel];
        if (isShow)
        {
            UIImageView *rightView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-40, (ViewHeight(self)-20)/2, 30, 20)];
            rightView.contentMode = UIViewContentModeScaleAspectFit;
            rightView.image = [UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"];
            [self addSubview:rightView];
        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewHeight(self)-1, windowContentWidth, 0.8)];
        line.backgroundColor = bordColor;
        [self addSubview:line];
    }
    return self;
}
@end
