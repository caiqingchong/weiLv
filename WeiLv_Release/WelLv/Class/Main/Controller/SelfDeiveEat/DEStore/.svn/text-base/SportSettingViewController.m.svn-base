//
//  SportSettingViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/10.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "SportSettingViewController.h"
#import "WXUtil.h"
#define soprtDownUrl [NSString stringWithFormat:@"%@/api/drivingShop/get_favourable_offline_list",WLHTTP]

#define soprtUpUrl [NSString stringWithFormat:@"%@/api/drivingShop/save_favourable_offline_info",WLHTTP]
@interface SportSettingViewController ()<UIAlertViewDelegate>
{
    NSString *_str1;
    NSString *_str2;
    NSString *_str3;
    NSString *_str4;
    
}
@property(nonatomic,strong)NSString *str1;
@property(nonatomic,strong)NSString *str2;
@property(nonatomic,strong)NSString *str3;
@property(nonatomic,strong)NSString *str4;
@property(nonatomic,strong) MBProgressHUD *zxdHudSport;
@end

@implementation SportSettingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initView];
    [self creatTitle];
    [self creatView1];
    [self creatView2];
    [self creatView3];
    [self zxdDownload];
   
}
//设置信息
-(void)initView
{
    self.navigationItem.title = @"活动设置";
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    
    self.scrollview = [[UIScrollView alloc] init];
    self.scrollview.frame = CGRectMake(0, 0, windowContentWidth,windowContentHeight);
    self.scrollview.backgroundColor = [UIColor whiteColor];
    self.scrollview.contentSize =CGSizeMake(windowContentWidth, windowContentHeight+50);
    [self.scrollview setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.scrollview];
    self.fieldtext1 = [[UITextField alloc] init];
    self.fieldtext2 = [[UITextField alloc] init];
    self.fieldtext3 = [[UITextField alloc] init];
    self.fieldtext4 = [[UITextField alloc] init];
    self.str1=@"";
    self.str2=@"";
    self.str3=@"";
    self.str4=@"";
}
-(void)creatTitle
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 13, windowContentWidth, 30);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"发布的活动将在店铺信息与商家列表信息中可见";
    label.backgroundColor = [UIColor clearColor];
    [self.scrollview addSubview:label];
    
}
-(void)creatView1
{
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.frame = CGRectMake(32.5, 45, windowContentWidth-65, 150);
    imageView1.userInteractionEnabled = YES;
    UIImage *image1 = [UIImage imageNamed:@"满送活动"];
    imageView1.image = image1;
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor clearColor];
    view1.frame = CGRectMake((windowContentWidth-65)*0.15, 30, (windowContentWidth-60)*0.7, 35);
    [imageView1 addSubview:view1];
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"消费满";
    label1.textAlignment = NSTextAlignmentRight;
    label1.font = [UIFont systemFontOfSize:17];
    label1.textColor = [UIColor whiteColor];
    label1.frame = CGRectMake(0, 10, (windowContentWidth-65)*0.21, 30);
    [view1 addSubview:label1];
    
    
    self.fieldtext1.frame = CGRectMake((windowContentWidth-65)*0.25,10,  (windowContentWidth-65)*0.4, 30);
    self.fieldtext1.borderStyle = UITextAutocapitalizationTypeNone;
    self.fieldtext1.delegate = self;
    self.fieldtext1.clearsOnBeginEditing = YES;
    self.fieldtext1.text = self.str1;
    self.fieldtext1.backgroundColor = [UIColor whiteColor];
    [view1 addSubview:self.fieldtext1];
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor clearColor];
    view2.frame = CGRectMake((windowContentWidth-65)*0.15, 85, (windowContentWidth-65)*0.7, 35);
    [imageView1 addSubview:view2];
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"送";
    label2.textAlignment = NSTextAlignmentRight;
    label2.font = [UIFont systemFontOfSize:17];
    label2.textColor = [UIColor whiteColor];
    label2.frame = CGRectMake(0, 0, (windowContentWidth-60)*0.21, 30);
    [view2 addSubview:label2];
    
    
    self.fieldtext2.frame = CGRectMake((windowContentWidth-65)*0.25,5,  (windowContentWidth-65)*0.4, 30);
    self.fieldtext2.borderStyle = UITextAutocapitalizationTypeNone;
    self.fieldtext2.delegate = self;
    self.fieldtext2.clearsOnBeginEditing = YES;
    self.fieldtext2.text = self.str2;
    self.fieldtext2.backgroundColor = [UIColor whiteColor];
    [view2 addSubview:self.fieldtext2];

    [self.scrollview addSubview:imageView1];
    
}
-(void)creatView2
{
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.frame = CGRectMake(32.5, 215, windowContentWidth-65, 150);
    imageView2.userInteractionEnabled = YES;
    UIImage *image2 = [UIImage imageNamed:@"好评送活动"];
    
    imageView2.image = image2;
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor clearColor];
    view3.frame = CGRectMake((windowContentWidth-65)*0.15, 30, (windowContentWidth-65)*0.7, 90);
    [imageView2 addSubview:view3];
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(0, 0, (windowContentWidth-65)*0.7, 30);
    label2.text= @"当场好评送";
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:17];
    label2.textColor = [UIColor whiteColor];
    [view3 addSubview:label2];
    
    self.fieldtext3.frame = CGRectMake(5, 45, (windowContentWidth-65)*0.6, 30);
    self.fieldtext3.borderStyle = UITextAutocapitalizationTypeNone;
    self.fieldtext3.delegate = self;
    self.fieldtext3.clearsOnBeginEditing = YES;
    self.fieldtext3.text = self.str3;
    self.fieldtext3.backgroundColor = [UIColor whiteColor];
    [view3 addSubview:self.fieldtext3];

    [self.scrollview addSubview:imageView2];
}
-(void)creatView3
{
    UIImageView *imageView3 = [[UIImageView alloc] init];
    imageView3.frame = CGRectMake(32.5, 385, windowContentWidth-65, 150);
    imageView3.userInteractionEnabled = YES;
    UIImage *image3 = [UIImage imageNamed:@"进店送活动"];
    imageView3.image = image3;
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor clearColor];
    view4.frame = CGRectMake((windowContentWidth-65)*0.15, 30, (windowContentWidth-65)*0.6, 90);
    [imageView3 addSubview:view4];
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(0, 0, (windowContentWidth-60)*0.6, windowContentWidth/8);
    label2.text= @"进店送";
    label2.backgroundColor = [UIColor clearColor];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:17];
    label2.textColor = [UIColor whiteColor];
    [view4 addSubview:label2];
        self.fieldtext4.frame = CGRectMake(5, 45, (windowContentWidth-65)*0.6, 30);
    self.fieldtext4.borderStyle = UITextAutocapitalizationTypeNone;
    self.fieldtext4.delegate = self;
    self.fieldtext4.clearsOnBeginEditing = YES;
    self.fieldtext4.text = self.str4;
    self.fieldtext4.backgroundColor = [UIColor whiteColor];
    [view4 addSubview:self.fieldtext4];
    

    [self.scrollview addSubview:imageView3];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.fieldtext1 resignFirstResponder];
    [self.fieldtext2 resignFirstResponder];
    [self.fieldtext3 resignFirstResponder];
    [self.fieldtext4 resignFirstResponder];
    self.scrollview.contentSize =CGSizeMake(windowContentWidth, windowContentHeight+50);
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.scrollview.contentSize =CGSizeMake(windowContentWidth, windowContentHeight+300);
    [textField becomeFirstResponder];
    
}
-(void)conserve
{
    NSLog(@"保存");
    [self upData];
}
-(void)zxdDownload
{
    [self setHud:@"正在下载,,,,"];
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString * shopId = [[WLSingletonClass defaultWLSingleton] wlDEShopID];
    NSString *token1 = [token stringByAppendingString:shopId];
    
    
    
    NSDictionary *parameters=@{@"wltoken":[WXUtil md5:token1],@"shopId":shopId};
    
    
    NSString *url=[soprtDownUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *zxdDict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.zxdHudSport.labelText = zxdDict1[@"msg"];
        self.zxdHudSport.hidden = YES;
        for (int i=0; i<[zxdDict1[@"data"] count]; i++) {
            switch (i) {
                case 0:
                    self.fieldtext1.text = [zxdDict1[@"data"][0] objectForKey:@"note"];
                    self.fieldtext2.text = [zxdDict1[@"data"][0] objectForKey:@"info"];
                    self.str1=self.fieldtext1.text;
                    self.str2=self.fieldtext2.text;
                    break;
                case 1:
                    self.fieldtext3.text = [zxdDict1[@"data"][1] objectForKey:@"info"];
                    self.str3=self.fieldtext3.text;
                    break;
                case 2:
                    self.fieldtext4.text = [zxdDict1[@"data"][2] objectForKey:@"info"];
                    self.str4=self.fieldtext4.text;
                    break;
                default:
                    break;
            }        }
                NSLog(@"%ld",[zxdDict1[@"data"] count]);
                NSLog(@"%@+++===%@", zxdDict1,[zxdDict1 objectForKey:@"msg"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertViewFail2 = [[UIAlertView alloc] initWithTitle:@"下载失败" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertViewFail2 show];
        NSLog(@"下载失败");
    }];
}
#pragma mark - 上传数据
-(void)upData
{
    [self setHud:@"正在上传,,,,,"];
    if ([self isUpdate]) {
        NSString *token = @"~0;id<zOD.{ll@]JKi(:";
        NSString * shopId =[[WLSingletonClass defaultWLSingleton] wlDEShopID];
        NSString *token1 = [token stringByAppendingString:shopId];
        NSString *memberId=[[WLSingletonClass defaultWLSingleton] wlUserID];
        
        
        NSDictionary *dict1 = [NSDictionary  dictionaryWithObjectsAndKeys:self.fieldtext2.text,@"info",self.fieldtext1.text,@"note",@"1",@"type", nil];
        NSDictionary *dict2 = [NSDictionary  dictionaryWithObjectsAndKeys:self.fieldtext3.text,@"info",@"",@"note",@"2",@"type", nil];
        NSDictionary *dict3 = [NSDictionary  dictionaryWithObjectsAndKeys:self.fieldtext4.text,@"info",@"",@"note",@"3",@"type", nil];
        NSArray *arr = [[NSArray alloc] initWithObjects:dict1,dict2,dict3, nil];
        
        NSLog(@"%@",dict1);
        NSDictionary *dict = @{
                               @"wltoken":[WXUtil md5:token1],
                               @"shopId":shopId,
                               @"memberId":memberId,
                               @"data":[self arrayToJson:arr]
                               };
        NSLog(@"%@",dict);
        
        AFHTTPRequestOperationManager *manager2 = [AFHTTPRequestOperationManager manager];
        manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
        [manager2 POST:soprtUpUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *zxdDict2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            self.zxdHudSport.labelText = zxdDict2[@"msg"];
            self.zxdHudSport.hidden = YES;
            //UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:zxdDict2[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            //[alertSuccess show];
            self.str1=self.fieldtext1.text;
            self.str2=self.fieldtext2.text;
            self.str3=self.fieldtext3.text;
            self.str4=self.fieldtext4.text;
            NSLog(@"+++===%@",zxdDict2[@"msg"]);
            return ;
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alertfail = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertfail show];
            return ;
        }];
    }else{
        UIAlertView *alertfail = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无可保存项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertfail show];
        return ;
    }
    
}
- (NSString*)arrayToJson:(NSArray *)arr {
    if (arr.count==0) {
        return @"";
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark - “判断活动设置”是否有修改
-(BOOL)isUpdate{
    if (self.str1!=self.fieldtext1.text) {
        return true;
    }else if (self.str2!=self.fieldtext2.text){
        return true;
    }
    else if(self.str3!=self.fieldtext3.text)
    {
        return  true;
    }
    else if (self.str4!=self.fieldtext4.text)
    {
        return true;
    }
    return false;
}
-(void)setHud:(NSString *)str
{
    
    self.zxdHudSport = [[MBProgressHUD alloc] initWithView:self.view];
    self.zxdHudSport.frame = self.view.bounds;
    self.zxdHudSport.minSize = CGSizeMake(100, 100);
    self.zxdHudSport.mode = MBProgressHUDModeIndeterminate;
    self.zxdHudSport.labelText = str;
    [self.view addSubview:self.zxdHudSport];
    // [_zxdTableView bringSubviewToFront:self.zxdHud];
    [self.zxdHudSport show:YES];
}

@end
