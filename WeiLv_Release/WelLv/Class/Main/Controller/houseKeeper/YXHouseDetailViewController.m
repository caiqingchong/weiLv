//
//  YXHouseDetailViewController.m
//  WelLv
//
//  Created by lyx on 15/4/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXHouseDetailViewController.h"
#import "LoginAndRegisterViewController.h"
#import "XCLoadMsg.h"
#import "HouseKeeperViewController.h"
#import "MainViewController.h"
#import "UIDefines.h"
#import "IconAndTitleView.h"
#import "ZFJSteShopOtherVC.h"

@interface YXHouseDetailViewController ()
{
    YXAutoEditVIew *_bussiness;
    YXAutoEditVIew *_workTime;
    YXAutoEditVIew *_service;
    YXAutoEditVIew *_qualifica;
    YXAutoEditVIew *_introduction;
    UIButton *btn;
    UIButton  *bindBtn;
    UIButton  *consultBtn;
    YXHouseModel *_model;
    
    NSString * is_detachable;//是否可以更换管家（0，1）
}
@property (nonatomic, strong) YXHouseModel *detailModel;

@end

@implementation YXHouseDetailViewController
@synthesize houseName = _houseName;
@synthesize houseID = _houseID;
@synthesize isBind = _isBind;

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];

     btn = [UIButton buttonWithType:UIButtonTypeCustom];
     btn.frame=CGRectMake(0, 0, 45/2, 46/2);
     [btn setBackgroundImage:[UIImage imageNamed:@"blacklist"] forState:UIControlStateNormal];
     [btn addTarget:self action:@selector(clickMine) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor = [UIColor colorWithRed:232/255.0 green:237/255.0 blue:241/255.0 alpha:1];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    _model = [[YXHouseModel alloc] init];
    [self loadData];
    //已绑定的管家id
    _isBind = [[[LXUserTool alloc] getKeeper] intValue];
   
}

- (void)loadData
{
    if ([[[LXUserTool alloc] getKeeper] intValue]!=0 && self.houseID==nil)
    {
        self.houseID= [NSString stringWithFormat:@"%@",[[LXUserTool alloc] getKeeper]];
    }
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    NSString *url = [houseDetailUrl(self.houseID) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"+++++%@", url);
    __weak YXHouseDetailViewController * weeakSelf = self;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         if (dic != nil) {
             weeakSelf.detailModel = [[YXHouseModel alloc] init];
             [_detailModel setValuesForKeysWithDictionary:[dic objectForKey:@"data"]];
             [self initView:_detailModel];
         }
         self.title=_detailModel.name;
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
         [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
             [self loadData];
         }];
     }];
}
//解除绑定
- (void)clickMine
{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[HouseKeeperViewController class]]) {
            [self close];
            return;
        }
        
    }
    HouseKeeperViewController *houseVC = [[HouseKeeperViewController alloc] init];
    [self.navigationController pushViewController:houseVC animated:YES];
    
}
//绑定
- (void)bindHouse
{
    if (![[LXUserTool alloc] getUserName])
    {
        LoginAndRegisterViewController *loginVC = [[LoginAndRegisterViewController alloc] init];
        loginVC.pushType = isModel;
        WS(ws);
        loginVC.block = ^(NSDictionary * dic)
        {
            for (UIView *vv in [ws.view subviews])
            {
                [vv removeFromSuperview];
            }
            [ws viewDidLoad];
        };
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginNav animated:YES completion:nil];
        return;
    }
    
    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"]) {
        UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是管家，不能绑定管家。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    
    [self bangdingGuanjia];
    //更换管家,这里有冲突 所以 不用alertView
//    UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"是否更换管家" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    alert.tag=2;
//    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1)
    {
        if (buttonIndex == 1)
        {
            NSString * telString = [NSString stringWithFormat:@"tel:%@", _model.mobile];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
        }
    }
    if (alertView.tag==2)
    {
        switch (buttonIndex)
        {
            case 0:
            {
                
            }
                break;
                
            case 1:
            {
                [self bangdingGuanjia];
            }
                break;
                
            default:
                break;
        }
        
    }
    
    if (alertView.tag == 188) {
        if (buttonIndex == 1) {
            self.houseID = nil;
            _scrollView = nil;
            [self viewDidLoad];
        }
        
    }
}

-(void)bangdingGuanjia
{
    DLog(@"%@",self.houseID);
    NSString *UserId = [[LXUserTool alloc] getUid];
    NSDictionary *parm =@{@"member_id":UserId,@"assistant_id":self.houseID};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:bindHouseUrl parameters:parm success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSString *msg = [dic objectForKey:@"msg"];
         DLog(@"dic === %@", dic);
         DLog(@"msg === %@",msg);
         DLog(@"%@",dic[@"status"]);
         //if ([msg isEqualToString:@"操作成功！"]) {
         if ([dic[@"status"]intValue]==1)
         {
             bindBtn.hidden = YES;
             consultBtn.frame = CGRectMake((windowContentWidth - ViewWidth(consultBtn))/2, ViewY(consultBtn), ViewWidth(consultBtn), ViewHeight(consultBtn));
             if ([is_detachable intValue]==1)
             {
                 btn.hidden = NO;
             }
             NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
             [userDefaults setObject:self.houseID forKey:@"assistant_id"];
             [userDefaults setObject:_model.mobile forKey:AssistantPhone];
             [[NSUserDefaults standardUserDefaults] synchronize];
             DLog(@"%@",[userDefaults objectForKey:@"assistant_id"]);
             
             [[LXAlterView sharedMyTools] createTishi:msg];
            
             
         }
    else
    {
             [[LXAlterView sharedMyTools]createTishi:msg];
             
             
    }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         [[LXAlterView sharedMyTools] createTishi:@"网洛请求失败"];
     }];
}
//咨询管家
- (void)callHouse
{
    NSString *tel = [NSString stringWithFormat:@"是否拨打%@",_model.mobile];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"电话咨询" message:tel delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=1;
    [alert show];
    
}


- (void)initView:(YXHouseModel *)houser
{
    YXMemberHouseData *memberData = [[YXMemberHouseData alloc] init];
    if (houser.sellers.count>0) {
        memberData = [houser.sellers objectAtIndex:0];
    }
    _model = houser;
    //self.title = houser.name;
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 150)];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    bgView.image = [UIImage imageNamed:@"个人背景"];
    bgView.clipsToBounds = YES;
    bgView.userInteractionEnabled = YES;
    [_scrollView addSubview:bgView];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake((ViewWidth(_scrollView)-96)/2, 47, 96, 96)];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = 48.0;
    view1.center = bgView.center;
    [bgView addSubview:view1];
    NSString *path =[NSString stringWithFormat:@"/%@",houser.avatar];
    NSString *imageStr = [WLHTTP stringByAppendingString:path];
    
    UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ViewWidth(_scrollView)-100)/2, 50, 90, 90)];
    [phoneImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"默认图2.png"]];
    phoneImageView.userInteractionEnabled = YES;
    phoneImageView.layer.masksToBounds=YES;
    phoneImageView.layer.cornerRadius = 45.0;
    phoneImageView.center = bgView.center;
    [bgView addSubview:phoneImageView];
    
    
    UIView *motoView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(bgView)+ViewHeight(bgView), ViewWidth(_scrollView), 60)];
    motoView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:motoView];
    
    if ([YXTools stringReturnNull:houser.motto]) {
        UILabel *motoLabel = [YXTools allocLabel:[NSString stringWithFormat:@""] font:systemFont(15) textColor:[UIColor grayColor] frame:CGRectMake(Begin_X, 0, ViewWidth(motoView)-Begin_X*2, 60) textAlignment:0];
        [motoView addSubview:motoLabel];
        
    } else {
        UILabel *motoLabel = [YXTools allocLabel:[NSString stringWithFormat:@"“%@”",houser.motto] font:systemFont(15) textColor:[UIColor grayColor] frame:CGRectMake(Begin_X, 0, ViewWidth(motoView)-Begin_X*2, 60) textAlignment:0];
        [motoView addSubview:motoLabel];
        motoLabel.numberOfLines=0;
        CGSize size=[self sizeWithString:houser.motto font:systemFont(15)];
        [motoLabel setFrame:CGRectMake(Begin_X, 0, ViewWidth(motoView)-Begin_X*2, size.height)];
    }
    
    
    _bussiness = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewY(motoView)+ViewHeight(motoView)+20, ViewWidth(_scrollView), 40)];
    _bussiness.leftImageView.image = [UIImage imageNamed:@"精通"];
    _bussiness.titleLable.text = @"精通业务";
    [_bussiness setContentText:houser.advantage];
    [_scrollView addSubview:_bussiness];
    
    
    
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeNone ||
        ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember && ([[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteward] == NO || [[WLSingletonClass defaultWLSingleton] wlUserStewardID] == self.houseID)) ||
        ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward && self.houseID == [[WLSingletonClass defaultWLSingleton] wlUserID])) {
        
        YXAutoEditVIew * steShopView = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewBelow(_bussiness), ViewWidth(_bussiness), 40)];
        steShopView.titleLable.text = M_STEWARD_SHOP_NAME;
        steShopView.leftImageView.image = [UIImage imageNamed:@"管家店铺"];
        [steShopView setContentText:@""];
        steShopView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goSteShop:)];
        [steShopView addGestureRecognizer:tap];
        UIImageView * goIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(steShopView) - 30, (ViewHeight(steShopView) - 17) / 2 , 10, 17)];
        goIcon.backgroundColor = [UIColor whiteColor];
        goIcon.image = [UIImage imageNamed:@"矩形-32"];
        [steShopView addSubview:goIcon];
        [_scrollView addSubview:steShopView];
        
        _workTime = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewBelow(steShopView), ViewWidth(_bussiness), 40)];
        _workTime.titleLable.text = @"管家所属";
        _workTime.leftImageView.image = [UIImage imageNamed:@"管家所属"];
        [_workTime setContentText:memberData.name];
        [_scrollView addSubview:_workTime];
        
    } else {
        _workTime = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewY(_bussiness)+ViewHeight(_bussiness), ViewWidth(_bussiness), 40)];
        _workTime.titleLable.text = @"管家所属";
        _workTime.leftImageView.image = [UIImage imageNamed:@"管家所属"];
        [_workTime setContentText:memberData.name];
        [_scrollView addSubview:_workTime];
        
    }
    
    
    
    _service = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewY(_workTime)+ViewHeight(_workTime), ViewWidth(_bussiness)+1, 40)];
    _service.titleLable.text = @"公司地址";
    _service.leftImageView.image = [UIImage imageNamed:@"地址"];
    [_service setContentText:memberData.address];
    [_scrollView addSubview:_service];
    
    _qualifica = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewY(_service)+ViewHeight(_service), ViewWidth(_bussiness), 40)];
    _qualifica.titleLable.text = @"联系电话";
    _qualifica.leftImageView.image = [UIImage imageNamed:@"管家手机"];
    [_qualifica setContentText:houser.mobile];
    [_scrollView addSubview:_qualifica];
    
    YXAutoEditVIew *emailView = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewY(_qualifica)+ViewHeight(_qualifica), ViewWidth(_bussiness), 40)];
    emailView.titleLable.text = @"个人邮箱";
    emailView.leftImageView.image = [UIImage imageNamed:@"newEmail"];
    [emailView setContentText:houser.email];
    [_scrollView addSubview:emailView];
    
    _scrollView.contentSize = CGSizeMake(0, ViewY(emailView)+ViewHeight(emailView)+150);
    
    bindBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    bindBtn.frame = CGRectMake(Begin_X, ViewY(emailView)+ViewHeight(emailView)+30, (windowContentWidth-Begin_X*3)/2, 40);
    [bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
    bindBtn.titleLabel.font = systemBoldFont(17);
    [bindBtn setBackgroundImage:[UIImage imageNamed:@"bind_House"] forState:UIControlStateNormal];
    [bindBtn addTarget:self action:@selector(bindHouse) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:bindBtn];
    
    consultBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    consultBtn.frame = CGRectMake(Begin_X+ViewX(bindBtn)+ViewWidth(bindBtn), ViewY(bindBtn), ViewWidth(bindBtn), 40);
    [consultBtn setTitle:@"咨询" forState:UIControlStateNormal];
    consultBtn.titleLabel.font = systemBoldFont(17);
    [consultBtn setBackgroundImage:[UIImage imageNamed:@"咨询"] forState:UIControlStateNormal];
    [consultBtn addTarget:self action:@selector(callHouse) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:consultBtn];
    
    if (_isBind == [self.houseID intValue])
    {
        bindBtn.hidden = YES;
        consultBtn.frame = CGRectMake((windowContentWidth - ViewWidth(consultBtn))/2, ViewY(consultBtn), ViewWidth(consultBtn), ViewHeight(consultBtn));
        if ([is_detachable intValue]==1)
        {
            btn.hidden = NO;
        }
        
    }
}

- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(windowContentWidth -20, 96)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}
#pragma mark --- 跳转管家店铺

- (void)goSteShop:(UITapGestureRecognizer *)tap {
    if (([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember && ([[WLSingletonClass defaultWLSingleton] wlUserIsHaveSteward] == NO || [[[WLSingletonClass defaultWLSingleton] wlUserStewardID] isEqualToString:self.houseID])) ||
        ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward && [self.houseID isEqualToString: [[WLSingletonClass defaultWLSingleton] wlUserID]])) {
        
        ZFJSteShopOtherVC * vc = [[ZFJSteShopOtherVC alloc] init];
        vc.assistant_id = self.houseID;
        vc.assistant_mobile = self.detailModel.mobile;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeNone) {
        LoginAndRegisterViewController * vc = [[LoginAndRegisterViewController alloc] init];
        WS(ws);
        vc.block = ^(NSDictionary * dic){
            for (UIView *vv in [ws.view subviews]) {
                [vv removeFromSuperview];
            }
            [ws viewDidLoad];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"对不起\n你不能看其他管家部落" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([[[LXUserTool alloc] getKeeper] intValue] != 0 && [self.houseID intValue] == [[[LXUserTool alloc] getKeeper] intValue] && self.isNeedR == YES) {
        self.houseID = nil;
        _scrollView = nil;
        [self viewDidLoad];
    }
    
}

@end
