//
//  WriteOffViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/7.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WriteOffViewController.h"
#import "writeOffBySelfViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QRViewController.h"
#import "ZFJQRResultVC.h"
#import "WXUtil.h"
@interface WriteOffViewController ()<UIAlertViewDelegate>

@end

@implementation WriteOffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"核销";
    self.view.backgroundColor = BgViewColor;
    [self creatView];
}
-(void)creatView
{
    NSArray *arr = [[NSArray alloc] initWithObjects:@"扫码核销",@"手动核销", nil];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 13, windowContentWidth, 90)];
    for (int i =0; i<arr.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(20, i*45+3, 100, 45);
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:17];
        label.textAlignment = NSTextAlignmentLeft;
        [view addSubview:label];
        UIImageView *zxdBut = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45, 45*i+7.5, 45, 30)];
        [zxdBut setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [view addSubview:zxdBut];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom] ;
        button.frame = CGRectMake(0, 45*i, windowContentWidth, 45);
        button.backgroundColor = [UIColor clearColor];
        button.tag = 201+i;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];

    }
    UILabel *labelline = [[UILabel alloc] init];
    labelline.backgroundColor = BgViewColor;
    labelline.frame = CGRectMake(0, 45, windowContentWidth, 1);
    [view addSubview:labelline];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}
-(void)btnClick:(UIButton *)btn
{
    if (btn.tag == 201) {
        [self zxdOpenQR];
        NSLog(@"扫描核销");
    }
    else
    {
        NSLog(@"手动核销");
        writeOffBySelfViewController *wrtSelf = [[writeOffBySelfViewController alloc] init];
        [self.navigationController pushViewController:wrtSelf animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 扫描二维码页面

- (void)zxdOpenQR{
     NSLog(@"相机");
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设置-隐私-相机中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        NSLog(@"相机权限受限");
        return;
        
    } else {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
            [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
           [self zxdShowQRViewController];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头或摄像头不可用" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    }
    
    
}
- (BOOL)validateCamera {
    
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] &&
    [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
- (void)zxdShowQRViewController {
    __weak WriteOffViewController * mianVC = self;
    QRViewController *qrVC = [[QRViewController alloc] initWithQRURL:^(NSString *url) {
        
        NSLog(@"二维码地址：%@", url);
        [self writeOff:url];
        
       // ZFJQRResultVC * resultVC = [[ZFJQRResultVC alloc] initWithURLString:url];
        //[mianVC.navigationController pushViewController:resultVC animated:YES];
    }];
    
    //模态
    
    qrVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:qrVC animated:YES completion:nil];
    
    
    
}
#pragma mark -核销
-(void)writeOff:(NSString *)str
{
    
    NSArray *zxdArr = [[NSArray alloc] init];
    zxdArr = [str componentsSeparatedByString:@":"];
    NSLog(@"%@",zxdArr);
    NSMutableArray *zxdArrMsg = [[NSMutableArray alloc] initWithArray:zxdArr];
    [zxdArrMsg removeObject:@""];
    if (zxdArrMsg.count!=2) {
        
        UIAlertView *zxdAlertView1 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无效的二维码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [zxdAlertView1 show];
        NSLog(@"1111111");
        return;
 
    }
    NSString *pwd = [zxdArrMsg objectAtIndex:1];
    
    NSLog(@"%@",zxdArrMsg);
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString * shopId = [[WLSingletonClass defaultWLSingleton] wlDEShopID];
    NSString *token1 = [token stringByAppendingString:shopId];
    NSString *tokenIsEqual = [token stringByAppendingString:pwd];
    if ([[zxdArrMsg objectAtIndex:0]isEqual:tokenIsEqual]==1) {
         NSString *url = [NSString stringWithFormat:@"%@/api/drivingShop/consumeTicket",WLHTTP];
        NSDictionary *parameters = @{@"shopId":shopId,
                                     @"wltoken":[WXUtil md5:token1],
                                     @"ticket_pwd":[zxdArrMsg objectAtIndex:1]
                                     };
        AFHTTPRequestOperationManager *zxdmanagerWriteOff = [AFHTTPRequestOperationManager manager];
        zxdmanagerWriteOff.responseSerializer = [AFHTTPResponseSerializer serializer];
        [zxdmanagerWriteOff POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *zxdDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            UIAlertView *zxdSuccess = [[UIAlertView alloc] initWithTitle:@"提示" message:zxdDict[@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            NSLog(@"222222");
            [zxdSuccess show];
            return ;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            UIAlertView *zxdFailView3 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"核销失败,请检查你们网络是否连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            NSLog(@"333333");
            [zxdFailView3 show];
            return ;
        }];

    }
    else
    {
        UIAlertView *zxdAlertView2 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无效的二维码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        NSLog(@"44444");
        
        [zxdAlertView2 show];
        return;
        
    }
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
