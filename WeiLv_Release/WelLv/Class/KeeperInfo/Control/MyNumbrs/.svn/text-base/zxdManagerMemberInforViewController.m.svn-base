//
//  zxdManagerMemberInforViewController.m
//  WelLv
//
//  Created by liuxin on 16/1/15.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "zxdManagerMemberInforViewController.h"
#import "zxdinforSelfViewController.h"
#import "likeOfSelfViewController.h"
#import "zxdExternViewController.h"
#import "MemberInformationViewController.h"
#import "zxdRemarksViewController.h"
#import "MyMembersModel.h"
#import "MBProgressHUD.h"


@interface zxdManagerMemberInforViewController ()<MBProgressHUDDelegate,zxdRemarksViewControllerDelegate>
@property(strong,nonatomic)UIImageView *headImage;
@property(strong,nonatomic)NSDictionary *zxdDateDict;
@property(nonatomic,strong) MBProgressHUD *zxdHud;
@property(nonatomic,strong) UIView *zxdView1;
@property(nonatomic,strong) UIView *zxdView2;
@property(nonatomic,assign) NSInteger zxdCount;
@property(nonatomic,strong)UILabel *zxdlabelcount;

@end

@implementation zxdManagerMemberInforViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creattitle];
    [self creatView1];
    [self creatView2];
    [self downDate];
   // [self downDataCount];
    
   // NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
   //NSMutableArray *array = [YXTools jsonToArray:str class:[NSMutableArray class]];
    //[self downDate];
    
    // Do any additional setup after loading the view.
}

-(void)creattitle
{
    self.view.backgroundColor = BgViewColor;
     [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[YXTools stringToColor:@"#3c4042"]}];//[YXTools stringToColor:@"#3c4042"]
}

-(void)creatView1
{
    _zxdView1 = [[UIView alloc] init];
    _zxdView1.frame = CGRectMake(0, 15, windowContentWidth, 75);
    _zxdView1.backgroundColor = [UIColor whiteColor];
    _zxdView1.userInteractionEnabled = YES;
    [self.view addSubview:_zxdView1];
    //头像
    self.headImage = [[UIImageView alloc] init];
    self.headImage.frame = CGRectMake(15, 8, 60, 60);
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 30;
    //self.headImage.image = [UIImage imageNamed:@"默认图1"];
    NSString *str = [self judgeString:self.memberModel.avater]?self.memberModel.avater:@"";
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,str]] placeholderImage:[UIImage imageNamed:@"默认图1"]];
    [_zxdView1 addSubview:self.headImage];
    //基本信息
    UILabel *labelInfor = [[UILabel alloc] init];
    labelInfor.frame = CGRectMake(90, 25, 150, 25);
    labelInfor.textAlignment = NSTextAlignmentLeft;
    labelInfor.text = @"基本信息";
    labelInfor.textColor = [YXTools stringToColor:@"#6f7378"];
    //labelInfor.tintColor = [UIColor redColor];
    labelInfor.font = [UIFont systemFontOfSize:15];
    [_zxdView1 addSubview:labelInfor];
    UIImageView *zxdView11  = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-23, 30, 10, 17)];
    [zxdView11 setImage:[UIImage imageNamed:@"zxdf"]];
    [_zxdView1 addSubview:zxdView11];
    zxdView11.userInteractionEnabled = YES;
    UIButton *zxdBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    zxdBtn.tag = 101;
    zxdBtn.frame= CGRectMake(60, 5, windowContentWidth-60, 65);
    //zxdBtn.backgroundColor = [UIColor redColor];
    [zxdBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_zxdView1 addSubview:zxdBtn];
    NSLog(@"=============点击btn==================");
}
-(void)creatView2
{
    NSArray *arrTitle = @[@"完善资料",@"扩展信息",@"个人偏好",@"备注信息"];
    _zxdView2 = [[UIView alloc] init];
    _zxdView2.frame = CGRectMake(0, 105, windowContentWidth, 180);
    _zxdView2.backgroundColor = [UIColor whiteColor];
    _zxdView2.userInteractionEnabled = YES;
    [self.view addSubview:_zxdView2];
    for (int i=0; i<4; i++) {
        //描述信息
        UILabel *labelTitle = [[UILabel alloc] init];
        labelTitle.frame = CGRectMake(15, 10+i*45, 150, 25);
        labelTitle.text = [arrTitle objectAtIndex:i];
        labelTitle.font = [UIFont systemFontOfSize:15];
        labelTitle.textColor = [YXTools stringToColor:@"#6f7378"];
        [_zxdView2 addSubview:labelTitle];
        //横线
        UILabel *labelLine = [[UILabel alloc] init];
        labelLine.frame = CGRectMake(0, 45*i, windowContentWidth, 1);
        labelLine.backgroundColor = BgViewColor;
        [_zxdView2 addSubview:labelLine];
        //箭头
        UIImageView *zxdView2 = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-25, 15+i*45, 10, 18)];
        //[zxdView2 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [zxdView2 setImage:[UIImage imageNamed:@"zxdf"]];
        [_zxdView2 addSubview:zxdView2];
        //点击事件
        UIButton *zxdBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        zxdBtn2.frame = CGRectMake(0, 45*i, windowContentWidth, 40);
        //zxdBtn2.backgroundColor = [UIColor redColor];
        zxdBtn2.tag = 102+i;
        [zxdBtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_zxdView2 addSubview:zxdBtn2];
    }
    _zxdlabelcount = [[UILabel alloc] init];
    _zxdlabelcount.frame = CGRectMake(windowContentWidth-60, 147, 30, 25);
    //_zxdlabelcount.backgroundColor = [UIColor redColor];
    _zxdlabelcount.textColor = [YXTools stringToColor:@"#6f7378"];
    _zxdlabelcount.textAlignment = NSTextAlignmentCenter;
    //[_zxdView2 addSubview:_zxdlabelcount];
}
-(void)btnClick:(UIButton *)btn
{
   // btn.backgroundColor = [UIColor yellowColor];
    switch (btn.tag) {
        case 101:
        {
            zxdinforSelfViewController *zxdInforSelf = [[zxdinforSelfViewController alloc] init];
            zxdInforSelf.memberModel = self.memberModel;
            [self.navigationController pushViewController:zxdInforSelf animated:YES];
        }
            break;
        case 102:
        {
            MemberInformationViewController *zxdMeberVc = [[MemberInformationViewController alloc] init];
            zxdMeberVc.memberModel = self.memberModel;
            [self.navigationController pushViewController:zxdMeberVc animated:YES];
        }
            break;
        case 103:
        {
            zxdExternViewController *zxdExternVc = [[zxdExternViewController alloc] init];
            zxdExternVc.uid = self.memberModel.uid;
            [self.navigationController pushViewController:zxdExternVc animated:YES];
        }
            break;
        case 104:
        {
            likeOfSelfViewController *zxdLikeVC = [[likeOfSelfViewController alloc] init];
            zxdLikeVC.uid = self.memberModel.uid;
            [self.navigationController pushViewController:zxdLikeVC animated:YES];
        }
            break;
        case 105:
        {
            zxdRemarksViewController *zxdVc = [[zxdRemarksViewController alloc] init];
            zxdVc.navigationItem.title = @"备注信息";
            zxdVc.uid = self.memberModel.uid;
            zxdVc.assId = self.memberModel.uid;
            zxdVc.delegate = self;
            [self.navigationController pushViewController:zxdVc animated:YES];
        }
            break;
        default:
            break;
    }
    NSLog(@"=============点击btn==================");
    NSLog(@"sdfasdfasdf");
}
-(void)downDate
{
    NSString *url = [NSString stringWithFormat:@"%@/%@",WLHTTP,@"api/assistant/edit_member_info"];
    
//    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
//                          @"select":@"*"};
    NSDictionary *dic = @{@"token":@"7a6bd7af36e5db226281a037909fbdfd",
                          };
    //@"remark_name":[self judgeString:self.memberModel.remark_name]?self.memberModel.remark_name:self.memberModel.phone
   // NSArray *arr = [[NSArray alloc] initWithObjects:dic, nil];
    NSDictionary *parameters = @{@"member_id":self.memberModel.uid,
                                 @"data":[[WLSingletonClass defaultWLSingleton] wlDictionaryToJson:dic]};
    //data={"token":"7a6bd7af36e5db226281a037909fbdfd","select":"*"}&member_id=31040
   // [self setHud:@"正在下载"];
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        weakSelf.zxdHud.hidden = YES;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([dict count]==0) {
            [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
           
        }
        else if ([[dict objectForKey:@"status"] integerValue]!=1)
        {
             [[LXAlterView sharedMyTools] createTishi:@"下载失败"];
           
        }
        else
        {
           // NSDictionary *zxdDict = dict[@"msg"];
           self.zxdDateDict = dict[@"data"];
        }
        //weakSelf.zxdHud.labelText = dict[@"msg"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        weakSelf.zxdHud.hidden = NO;
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
-(BOOL)isPureInt:(NSString *)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    int Val;
    return [scan scanInt:&Val]&&[scan isAtEnd];
}
-(void)downDataCount
{
    //获取tag备注信息
    
    NSString *stringg = self.memberModel.uid;
    NSString *urll = [memberTagUrl(stringg) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url = %@",urll);
    
    __weak typeof (self)weakSelf = self;
    AFHTTPRequestOperationManager *managerr = [AFHTTPRequestOperationManager manager];
    managerr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [managerr GET:urll parameters:nil success:^(AFHTTPRequestOperation *operationn,id responseObject){
            NSString *htmll = operationn.responseString;
        NSData* dataa=[htmll dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dictionary=[NSJSONSerialization  JSONObjectWithData:dataa options:0 error:nil];
        if ([[dictionary objectForKey:@"status"] integerValue] == 1 && [dictionary objectForKey:@"data"] && [[dictionary objectForKey:@"data"] isKindOfClass:[NSArray class]] && [[dictionary objectForKey:@"data"] count] != 0) {
            NSArray  *zxdArr= [NSArray arrayWithArray:[dictionary objectForKey:@"data"]];
            weakSelf.zxdCount = zxdArr.count;
            [weakSelf labelCountHid];

        }
        else
        {
            weakSelf.zxdCount = 0;
            [weakSelf labelCountHid];

        }
        
    }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        NSLog(@"error = %@",error);
        weakSelf.zxdCount = 0;
    }];
    }
-(void)labelCountHid
{
    _zxdlabelcount.text = [NSString stringWithFormat:@"%ld",_zxdCount];
    if (_zxdCount==0) {
        _zxdlabelcount.hidden = YES;
    }
    else
    {
        _zxdlabelcount.hidden = NO;
    }

}
#pragma mark---回调代理
-(void)zxdCountViewController:(zxdRemarksViewController *)vc number:(NSInteger)countNumber
{
    _zxdCount = countNumber;
    //[self labelCountHid];
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
