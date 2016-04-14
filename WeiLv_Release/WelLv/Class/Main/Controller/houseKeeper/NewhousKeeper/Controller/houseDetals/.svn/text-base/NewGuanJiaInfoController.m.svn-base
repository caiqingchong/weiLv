//
//  NewGuanJiaInfoController.m
//  WelLv
//
//  Created by mac for csh on 16/1/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "NewGuanJiaInfoController.h"
#import "LoginAndRegisterViewController.h"
#import "XCLoadMsg.h"
#import "HouseKeeperViewController.h"
#import "MainViewController.h"
#import "UIDefines.h"
#import "IconAndTitleView.h"
#import "ZFJSteShopOtherVC.h"

#define  Space 40  //间隔
@interface NewGuanJiaInfoController ()
{
    YXAutoEditVIew *_bussiness;
    YXAutoEditVIew *_steShopView;
    YXAutoEditVIew *_workTime;
    YXAutoEditVIew *_jinTong;
    YXAutoEditVIew *_servce;
    YXAutoEditVIew *_addRessView;
   
    AFHTTPRequestOperationManager *_afManger;
    
}
@property (nonatomic, strong) YXHouseModel *detailModel;
@property (nonatomic,copy)NSString *addressTitle;
@property (nonatomic,copy)NSString *phonTitle;
@property (nonatomic,copy)NSString *addRessStr;
@property (nonatomic,copy)NSString *keeperJintong ;//精通内容
@property (nonatomic,copy)NSString *keepAddress;

@property (nonatomic,strong)UIButton *bangDingBtn;    //绑定按钮
@end

@implementation NewGuanJiaInfoController
@synthesize userID = _userID;
@synthesize userName = _userName;
@synthesize isBind = _isBind;

-(void)viewWillAppear:(BOOL)animated
{
    if ([[[LXUserTool alloc] getKeeper] intValue] != 0 && [self.userID intValue] == [[[LXUserTool alloc] getKeeper] intValue] && self.isNeedR == YES) {
        self.userID = nil;
        _scrollView = nil;
        [self viewDidLoad];
    }

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = [self judgeReturnString:self.userName withReplaceString:@" "];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64)];
    _scrollView.backgroundColor = [UIColor colorWithRed:232/255.0 green:237/255.0 blue:241/255.0 alpha:1];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    if (IS_IPHONE_4_OR_LESS)
    {
    _scrollView.contentSize = CGSizeMake(windowContentWidth, _scrollView.frame.size.height+190);
        
    }else if (IS_IPHONE_5)
    {
    _scrollView.contentSize = CGSizeMake(windowContentWidth, _scrollView.frame.size.height+64+64);

    }
    else if (IS_IPHONE_6)
    {
    _scrollView.contentSize = CGSizeMake(windowContentWidth, _scrollView.frame.size.height+64+44);
        
    }
    [self.view addSubview:_scrollView];
    _model = [[YXHouseModel alloc] init];
    [self getInit];
    //已绑定的管家id
    _isBind = [[[LXUserTool alloc] getKeeper] intValue];
    
}
#pragma mark -获取数据
-(void)getInit
{
    if ([[[LXUserTool alloc]getKeeper]intValue]!=0&&self.userID==nil) {
        self.userID = [NSString stringWithFormat:@"%@",[[LXUserTool alloc]getKeeper]];
        //    NSLog(@"%@",self.userID);
    }
    NSString *listStr = [NSString stringWithFormat:@"%@",houseDetailUrl(self.userID)];
    _afManger = [AFHTTPRequestOperationManager manager];
    _afManger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg", nil];
    __weak NewGuanJiaInfoController * weeakSelf = self;
    [_afManger GET:listStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSDictionary *dict =(NSDictionary *) responseObject;
        NSDictionary *dataDict = dict[@"data"];
        if (dict !=nil) {
            
            weeakSelf.detailModel = [[YXHouseModel alloc]init];
            [_detailModel setValuesForKeysWithDictionary:dataDict];
            
        }
        YXHouseModel *model = [[YXHouseModel alloc]init];
        model.name = dataDict[@"name"];
        model.mobile =dataDict[@"mobile"];
        model.goods_count = dataDict[@"goods_count"];
        model.partner_count = dataDict[@"partner_count"];
        model.order_count = dataDict[@"order_count"];
        model.advantage  =dataDict[@"advantage"];
        self.keeperJintong = model.advantage;
        self.phonTitle = model.mobile;
        
        NSArray *sellersArr = dataDict[@"sellers"];
        for (NSDictionary *sellersDict in sellersArr) {
            model.nickname = sellersDict[@"nickname"];
            model.address =sellersDict[@"address"];
            model.company = sellersDict [@"name"];
            self.keepAddress = model.address;
            self.addRessStr  = model.company;
            [self initView:_detailModel];
            //字段为空的情况下 判断字符串的内容
//            if ([YXTools stringReturnNull:model.company]) {
//                _addRess.text = @"Ta好像忘了填写该信息";
//            }else
//            {
//               _addRess.text = model.company;
//                NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
//                CGRect addRessFrame = [_addRess.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
//                
//            }
            //公司地址
            if ([YXTools stringReturnNull:model.address]) {
                [_addRessView setContentText:@"暂无信息"];
            }else
            {
             [_addRessView setContentText:[NSString stringWithFormat:@"%@",model.address]];
               
            }
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)initView:(YXHouseModel *)houser
{
    YXMemberHouseData *memberData = [[YXMemberHouseData alloc]init];
    if (houser.sellers.count>0) {
        
        memberData = [houser.sellers objectAtIndex:0];
    }
    //头像视图 背景
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 200)];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    bgView.image = [UIImage imageNamed:@"个人背景"];
    bgView.clipsToBounds = YES;
    bgView.userInteractionEnabled = YES;
    [_scrollView addSubview:bgView];
 
    UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ViewWidth(bgView)-100)/2,30, 90, 90)];
     [phoneImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,houser.avatar]] placeholderImage:[UIImage imageNamed:@"默认图2.png"]];
    phoneImageView.userInteractionEnabled = YES;
    phoneImageView.layer.masksToBounds=YES;
    phoneImageView.layer.cornerRadius = 90/2;
    [bgView addSubview:phoneImageView];
  
    //管理员 昵称
   _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewX(phoneImageView)+ViewWidth(phoneImageView)/4, ViewY(phoneImageView)+ViewHeight(phoneImageView)+10,200, 30)];
    _nameLabel.textColor = [UIColor whiteColor];
    if ([YXTools stringReturnNull:houser.name]) {
        
        _nameLabel.text = @"用户昵称";
    }else
    {
        _nameLabel.text =houser.name;
    }
    _nameLabel.font = [UIFont systemFontOfSize:16];
    [bgView addSubview:_nameLabel];
   //透明图 和label自适应
    //获取网络数据 字符串宽度
    NSDictionary *addDict = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:14]};
    CGRect  addFrame = [self.addRessStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:addDict context:nil];
    UIView *aphaView = [[UIView alloc]initWithFrame:CGRectMake(windowContentWidth/2-ViewWidth(phoneImageView), ViewY(_nameLabel)+ViewHeight(_nameLabel), addFrame.size.width+10, 30)];
    //给透明视图设置 一个中心点，
    aphaView.center = CGPointMake(self.view.center.x,aphaView.center.y);
    aphaView.backgroundColor = [UIColor grayColor];
    aphaView.alpha =0.5;
    aphaView.layer.masksToBounds = YES;
    aphaView.layer.cornerRadius = 15;
   
    _addRess = [[UILabel alloc]init];
    _addRess.font = [UIFont systemFontOfSize:13];
    _addRess.textColor = [UIColor whiteColor];
    _addRess.text = self.addRessStr;
    _addRess.frame= CGRectMake(10, 5, addFrame.size.width, addFrame.size.height);
    [aphaView addSubview:_addRess];
    [bgView addSubview:aphaView];

    //签名
    UIView *motoView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(bgView)+ViewHeight(bgView), ViewWidth(_scrollView), 60)];
    motoView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:motoView];
    //格言 =houser.motto
    if ([YXTools stringReturnNull:houser.motto]) {
        UILabel *motoLabel = [YXTools allocLabel:[NSString stringWithFormat:@"哎呦，Ta不知道说什么好..."] font:systemFont(15) textColor:[UIColor grayColor] frame:CGRectMake(Begin_X, 0, ViewWidth(motoView)-Begin_X*2, 60) textAlignment:0];
        [motoView addSubview:motoLabel];
        
    } else {
        
        UILabel *motoLabel = [YXTools allocLabel:[NSString stringWithFormat:@"“%@”",houser.motto] font:systemFont(15) textColor:[UIColor grayColor] frame:CGRectMake(Begin_X, 0, ViewWidth(motoView)-Begin_X*2, 60) textAlignment:0];
        [motoView addSubview:motoLabel];
    }
    //1.view
    _bussiness = [[YXAutoEditVIew alloc]initWithFrame1:CGRectMake(0, ViewY(motoView)+ViewHeight(motoView)+20, ViewWidth(_scrollView), 40)];
    _bussiness.leftImageView.image = [UIImage imageNamed:@"ste_call_icon"];
      _bussiness.titleLable.text = @"Ta的电话";
    //没有登录或 管家登录状态下，隐藏手机号中间四位数字
    NSString *mobile =[houser.mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    [_bussiness setContentText:mobile];

    [_scrollView addSubview:_bussiness];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goPlayPhone:)];
    [_bussiness addGestureRecognizer:tap1];
    UIImageView * goIcon1 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_bussiness) - 30, (ViewHeight(_bussiness) - 17) / 2 , 10, 17)];
    goIcon1.backgroundColor = [UIColor whiteColor];
    goIcon1.image = [UIImage imageNamed:@"矩形-32"];
    [_bussiness addSubview:goIcon1];
    [_scrollView addSubview:_bussiness];
    
    //2.部落信息view
    if ([NSString stringWithFormat:@"%@",houser.goods_count].length == 0) {
        _steShopView = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewY(_bussiness)+ViewHeight(_bussiness), ViewWidth(_bussiness), 40)];
        _steShopView.titleLable.text =@"Ta的部落";
        _steShopView.leftImageView.image = [UIImage imageNamed:@"ste_shop_icon"];
        _steShopView.hidden= YES;
        [_steShopView setContentText:[NSString stringWithFormat:@"暂未产品信息"]];
    }else
    {
     _steShopView = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewY(_bussiness)+ViewHeight (_bussiness), ViewWidth(_bussiness), 40)];
     _steShopView.titleLable.text =@"Ta的部落";
     _steShopView.leftImageView.image = [UIImage imageNamed:@"ste_shop_icon"];
     [_steShopView setContentText:[NSString stringWithFormat:@"产品数量%@",houser.goods_count]];
    }
    //添加手势 部落信息
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBuluo:)];
    [_steShopView addGestureRecognizer:tap2];
    UIImageView * goIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_steShopView) - 30, (ViewHeight(_steShopView) - 17) / 2 , 10, 17)];
    goIcon.backgroundColor = [UIColor whiteColor];
    goIcon.image = [UIImage imageNamed:@"矩形-32"];
    [_steShopView addSubview:goIcon];
    [_scrollView addSubview:_steShopView];
    
    //3.合伙人view
    _workTime = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewBelow(_steShopView), ViewWidth(_bussiness), 40)];
    _workTime.leftImageView.image = [UIImage imageNamed:@"ste_shop_partner_icon"];
    _workTime.titleLable.text = @"Ta的合伙人";
     if ([YXTools stringReturnNull:[NSString stringWithFormat:@"%@",houser.partner_count]])
     {
         [_workTime setContentText:@"暂无合伙人"];
     }
    else
    {
        [_workTime setContentText:[NSString stringWithFormat:@"合伙人%@",houser.partner_count]];
    }
    [_scrollView addSubview:_workTime];
    //添加手势 部落信息
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goHehuoren:)];
    [_workTime addGestureRecognizer:tap3];
//    UIImageView * goIcon2 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_workTime) - 30, (ViewHeight(_workTime) - 17) / 2 , 10, 17)];
//    goIcon2.backgroundColor = [UIColor whiteColor];
//    goIcon2.image = [UIImage imageNamed:@"矩形-32"];
   // [_workTime addSubview:goIcon2];
    [_scrollView addSubview:_workTime];
    
    //4.精通view4
    _jinTong = [[YXAutoEditVIew alloc]initWithFrame1:CGRectMake(0, ViewY(_workTime)+ViewHeight(_workTime)+20, ViewWidth(_bussiness), 40)];
     _jinTong.leftImageView.image = [UIImage imageNamed:@"ste_serve_icon"];
     _jinTong.titleLable.text = @"精通业务";
    if ([YXTools stringReturnNull:houser.advantage]) {
        [_jinTong setContentText:@"暂无信息"];
    }else
    {
        [_jinTong setContentText:houser.advantage];
        
    }
    [_scrollView addSubview:_jinTong];
    //添加手势 部落信息
    UITapGestureRecognizer * tap4= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gojinTong:)];
    [_jinTong addGestureRecognizer:tap4];
    UIImageView * goIcon4 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_jinTong) - 30, (ViewHeight(_jinTong) - 17) / 2 , 10, 17)];
    goIcon4.backgroundColor = [UIColor whiteColor];
    goIcon4.image = [UIImage imageNamed:@"矩形-32"];
    [_jinTong addSubview:goIcon4];
    [_scrollView addSubview:_jinTong];
    
    //5. 服务记录view5
    _servce = [[YXAutoEditVIew alloc]initWithFrame1:CGRectMake(0, ViewY(_jinTong)+ViewHeight(_jinTong), ViewWidth(_bussiness), 40)];
    _servce.titleLable.text = @"服务记录";
    _servce.leftImageView.image = [UIImage imageNamed:@"ste_serve_icon"];
    
    if ([YXTools stringReturnNull:houser.order_count]) {
        [_servce setContentText:@"暂无记录"];
        
    }else
    {
        [_servce setContentText:[NSString stringWithFormat:@"服务次数%@",houser.order_count]];
    }
    [_scrollView addSubview:_servce];
    //添加手势 部落信息
    UITapGestureRecognizer * tap5= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goServe:)];
    [_servce addGestureRecognizer:tap5];
    UIImageView * goIcon5 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_servce) - 30, (ViewHeight(_servce) - 17) / 2 , 10, 17)];
    goIcon5.backgroundColor = [UIColor whiteColor];
    goIcon5.image = [UIImage imageNamed:@"矩形-32"];
    [_servce addSubview:goIcon5];
    [_scrollView addSubview:_servce];
    
    //6 view6
    _addRessView = [[YXAutoEditVIew alloc]initWithFrame1:CGRectMake(0, ViewY(_servce)+ViewHeight(_servce), ViewWidth(_bussiness), 40)];
    _addRessView.titleLable.text = @"公司地址";
    _addRessView.leftImageView.image = [UIImage imageNamed:@"ste_address_icon"];
    [_scrollView addSubview:_addRessView];
    
    //添加手势 部落信息
    UITapGestureRecognizer * tap6= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goAddress:)];
    [_addRessView addGestureRecognizer:tap6];
    UIImageView * goIcon6 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_addRessView) - 30, (ViewHeight(_addRessView) - 17) / 2 , 10, 17)];
    goIcon6.backgroundColor = [UIColor whiteColor];
    goIcon6.image = [UIImage imageNamed:@"矩形-32"];
    [_addRessView addSubview:goIcon6];
    [_scrollView addSubview:_addRessView];
    
    //绑定按钮
    self.bangDingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bangDingBtn.frame = CGRectMake(0, ViewY(_addRessView)+ViewHeight(_addRessView)+20, windowContentWidth, 40);
    self.bangDingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.bangDingBtn setTitle:@"绑定我，为你服务" forState:UIControlStateNormal];
    self.bangDingBtn.backgroundColor = [UIColor orangeColor];
    [self.bangDingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bangDingBtn addTarget:self action:@selector(bangDingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:self.bangDingBtn];
    
        //绑定管家记录状态   管家登录状态下   隐藏绑定按钮
    //绑定管家记录状态   管家登录状态下   隐藏绑定按钮
    if ([[[LXUserTool sharedUserTool] getuserGroup] isEqualToString:@"assistant"]||([[LXUserTool alloc] getUid] && [[[LXUserTool sharedUserTool] getKeeper] intValue]!=0 ))
    {
        self.bangDingBtn.hidden =YES;
        
    }else if ([[[LXUserTool sharedUserTool]getuserGroup]intValue]==0) // 没有登录状态下
    {
        
        self.bangDingBtn.hidden = NO;
    }
    
//     if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"])
//     {
//         self.bangDingBtn.hidden =YES;
//         
//     }else if ([[[LXUserTool alloc]getuserGroup]intValue]==0) // 没有登录状态下
//     {
//         
//         self.bangDingBtn.hidden = NO;
//     }
    
}
#pragma mark - view-touchUp_____点击事件
//实现打电话功能
-(void)goPlayPhone:(UITapGestureRecognizer*)play
{
    if ([self judgeString:_phonTitle]) {
        NSString * telString = [NSString stringWithFormat:@"tel:%@", _phonTitle];
        NSURL * telUrl = [NSURL URLWithString:telString];
        [[UIApplication sharedApplication] openURL:telUrl];
    } else {
        [[LXAlterView sharedMyTools] createTishi:@"失败,请重试!"];
    }
    
}
#pragma mark -- 产品数量部落信息
-(void)goBuluo:(UITapGestureRecognizer *)buluo
{
    NSLog(@"部落信息");

    ZFJSteShopOtherVC *vc = [[ZFJSteShopOtherVC alloc]init];
    vc.assistant_id =self.userID;
    vc.assistant_mobile = self.detailModel.mobile;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//合伙人
-(void)goHehuoren:(UITapGestureRecognizer *)hehuo
{
    NSLog(@"合伙人");
    
}
-(void)gojinTong:(UITapGestureRecognizer*)jintong
{
    KeepViewController *kepView = [[KeepViewController alloc]init];
    kepView.type = typeYeWu;
    
    if ([YXTools stringReturnNull:self.keeperJintong]) { //防止self.keeperJintong为null时蹦，做判断
        kepView.keeperJing = @"暂无信息";
    }else
    {
     kepView.keeperJing = self.keeperJintong;
    }
    kepView.navTitle = @"精通业务";
    [self.navigationController pushViewController:kepView animated:YES];
    
}
//服务
-(void)goServe:(UITapGestureRecognizer*)serve
{
    GuanJiaServiceRecoredViewController *serview = [[GuanJiaServiceRecoredViewController alloc]init];
    serview.userId =self.userID;
    [self.navigationController pushViewController:serview animated:YES];
    
}
-(void)goAddress:(UITapGestureRecognizer *)address
{
    
    KeepViewController *kepView = [[KeepViewController alloc]init];
    kepView.type = typeAddRess;
    kepView.keepAdress = self.keepAddress;
    kepView.navTitle = @"公司地址";
    [self.navigationController pushViewController:kepView animated:YES];
}
#pragma mark -在没有登录的状态____________显示绑定按钮的时候
-(void)bangDingBtnClick
{
    NSLog(@"我擦 你干什么啊");
    if (![[LXUserTool alloc]getUserName]) {
        LoginAndRegisterViewController *loninVc = [[LoginAndRegisterViewController alloc]init];
        loninVc.pushType =isModel;
        WS(ws);
        loninVc.block = ^(NSDictionary*dic){
            for (UIView *vv in [ws.view subviews]) {
                [vv removeFromSuperview];
            }
            [ws viewDidLoad];
        };
        
        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loninVc];
        [self presentViewController:loginNav animated:YES completion:nil];
        return;
    }
    // 如果是管家登录的状态下
    if ([[[LXUserTool alloc] getuserGroup] isEqualToString:@"assistant"]) {
        //提示管家
        UIAlertView *alert=  [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您是管家，不能绑定管家。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }else if ([[[LXUserTool alloc]getuserGroup]intValue]==0)
    {
         //没有绑定管家
        [self postBangDing];
    }
    
}
/**
 *  会员绑定管家申请
 */
-(void)postBangDing
{
    
    NSString *UserId = [[LXUserTool alloc] getUid];
    NSDictionary *parm =@{@"member_id":UserId,@"assistant_id":self.userID};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:bindHouseUrl parameters:parm success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         //  NSString *statu = [dic objectForKey:@"status"];
         NSString *msg = [dic objectForKey:@"msg"];
         DLog(@"dic === %@", dic);
         DLog(@"msg === %@",msg);
         if ([msg isEqualToString:@"操作成功！"]) {
             [[LXAlterView sharedMyTools] createTishi:msg];
             [[NSUserDefaults standardUserDefaults] setObject:self.userID forKey:@"assistant_id"];
             [[NSUserDefaults standardUserDefaults] setObject:_model.mobile forKey:AssistantPhone];
             [[NSUserDefaults standardUserDefaults] synchronize];
              bindBtn.hidden = YES;
             
         }
         if (msg)
         {
             [[LXAlterView sharedMyTools] createTishi:msg];
             
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         [[LXAlterView sharedMyTools] createTishi:@"网洛请求失败"];
     }];
    
}

@end





