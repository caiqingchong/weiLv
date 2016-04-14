//
//  ZFJStewardShopMsgVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJStewardShopInfoVC.h"
#import "ZFJSteShopMsgView.h"
#import "ZFJSteShopChangeNameVC.h"
#import "GTMBase64.h"
#import "ZFJSteShopInfoModel.h"
#import "ZFJSteShopQRVC.h"
#define M_GAP_LEFT 10

@interface ZFJStewardShopInfoVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) ZFJSteShopMsgView * shopNameView;
@property (nonatomic, strong) ZFJSteShopMsgView * shopIcon;

@end

@implementation ZFJStewardShopInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor(240, 246, 251);
    self.title = [NSString stringWithFormat:@"%@资料", M_STEWARD_SHOP_LAST_NAME];
    
    self.shopNameView = [[ZFJSteShopMsgView alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 45)];
    _shopNameView.msgTitleLabel.text = [NSString stringWithFormat:@"%@名称", M_STEWARD_SHOP_LAST_NAME];
    _shopNameView.inforStr = self.infoModel.store_name;
    _shopNameView.isNeedLine = YES;
    [_shopNameView.chooseBut addTarget:self action:@selector(goAlterName:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shopNameView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShopName:) name:@"shopName" object:nil];
    
    self.shopIcon = [[ZFJSteShopMsgView alloc] initWithFrame:CGRectMake(0,ViewBelow(_shopNameView), windowContentWidth, 65)];
    _shopIcon.msgTitleLabel.text = @"头像";
    _shopIcon.isNeedLine = YES;
    [_shopIcon.msgImage sd_setImageWithURL:[NSURL URLWithString:[self judgeImageURL:self.infoModel.store_avatar]] placeholderImage:[UIImage imageNamed:@"默认图2"]];
     
    [_shopIcon.chooseBut addTarget:self action:@selector(changeShopIcon:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shopIcon];

    /*
    ZFJSteShopMsgView * shopQRView = [[ZFJSteShopMsgView alloc] initWithFrame:CGRectMake(0,ViewBelow(_shopIcon), windowContentWidth, 45)];
    shopQRView.msgTitleLabel.text = [NSString stringWithFormat:@"%@二维码", M_STEWARD_SHOP_LAST_NAME];
    shopQRView.isNeedLine = YES;
    [shopQRView.chooseBut addTarget:self action:@selector(goShopQRVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopQRView];
    
    ZFJSteShopMsgView * companyAddrssView = [[ZFJSteShopMsgView alloc] initWithFrame:CGRectMake(0,ViewBelow(shopQRView), windowContentWidth, 45)];
    companyAddrssView.msgTitleLabel.text = @"公司地址";
    //[self judgeReturnString:[[[[NSUserDefaults standardUserDefaults] objectForKey:AssitantData] mutableCopy] objectForKey:@"address"] withReplaceString:@""]
    //@"河南省郑州市金水区金水路和玉凤路交叉路口郑州浦发国家金融中心19楼1901号"
    companyAddrssView.inforStr = [self judgeReturnString:[[[[NSUserDefaults standardUserDefaults] objectForKey:AssitantData] mutableCopy] objectForKey:@"address"] withReplaceString:@""];
    companyAddrssView.style = ZFJMsgInfoStyle;
    companyAddrssView.isNeedLine = YES;
    [self.view addSubview:companyAddrssView];
    */
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember) {
        
        ZFJSteShopMsgView * incomeView = [[ZFJSteShopMsgView alloc] initWithFrame:CGRectMake(0,ViewBelow(_shopIcon), windowContentWidth, 45)];
        incomeView.msgTitleLabel.text = @"分销收入";
        incomeView.inforStr =[NSString stringWithFormat:@"¥%@", [self judgeReturnString:self.moneyCountStr withReplaceString:@"0.00"]];
        incomeView.inforLabel.textColor = UIColorFromRGB(0xff5b26);
        [self.view addSubview:incomeView];
        
    } else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        
        ZFJSteShopMsgView * companyAddrssView = [[ZFJSteShopMsgView alloc] initWithFrame:CGRectMake(0,ViewBelow(_shopIcon), windowContentWidth, 45)];
        companyAddrssView.msgTitleLabel.text = @"公司地址";
         companyAddrssView.inforStr = [self judgeReturnString:[[[[NSUserDefaults standardUserDefaults] objectForKey:AssitantData] mutableCopy] objectForKey:@"address"] withReplaceString:@""];
        companyAddrssView.style = ZFJMsgInfoStyle;
        companyAddrssView.isNeedLine = YES;
        [self.view addSubview:companyAddrssView];
    
        ZFJSteShopMsgView * incomeView = [[ZFJSteShopMsgView alloc] initWithFrame:CGRectMake(0,ViewBelow(companyAddrssView), windowContentWidth, 45)];
        incomeView.msgTitleLabel.text = @"分销收入";
        incomeView.inforStr =[NSString stringWithFormat:@"¥%@", [self judgeReturnString:self.moneyCountStr withReplaceString:@"0.00"]];
        incomeView.inforLabel.textColor = UIColorFromRGB(0xff5b26);
        [self.view addSubview:incomeView];
    }
    
}
#pragma mark --- 通知
- (void)changeShopName:(NSNotification *)notification {
    NSString * str = [notification object];
    _shopNameView.inforStr = str;
}
#pragma mark --- 按钮点击
- (void)goAlterName:(UIButton *)button {
    ZFJSteShopChangeNameVC * vc = [[ZFJSteShopChangeNameVC alloc] init];
    vc.title =  [NSString stringWithFormat:@"修改%@名称", M_STEWARD_SHOP_LAST_NAME];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)changeShopIcon:(UIButton *)button {
    
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"更换图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    [actionsheet showInView:self.view];
    
    
}
- (void)goShopQRVC:(UIButton *)button {
    ZFJSteShopQRVC * vc = [[ZFJSteShopQRVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
        [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypeCamera];
    if (buttonIndex == 1)
        [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

#pragma mark  UIImagePickerControllerDelegate
-(UIImagePickerController *)openPhotoToViewController:(UIViewController *)viewController sourceType:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && mediaTypes.count>0) {
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
        
        UIImage *image = [self imageWithImageSimple:editedImage scaledToSize:CGSizeMake(100, 100)];
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
        str=@"picture saved with no error.";
    else
        str=@"error occured while saving the picture%@";
}

//更新头像
- (void)UpdatePhoto:(UIImage *)imageFile
{
    
    NSData *data=UIImageJPEGRepresentation(imageFile, 0.1);
    //上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[ NSDateFormatter alloc ] init ];
    formatter. dateFormat = @"yyyyMMddHHmmss" ;
    NSString *str = [formatter stringFromDate :[ NSDate date ]];
    NSString *fileName = [ NSString stringWithFormat : @"%@.jpg" , str];
    
    NSDictionary *parment = @{@"store_id": [[WLSingletonClass defaultWLSingleton] wlUserSteShopID]};
    //NSLog(@"parameters =%@", parment);
    NSString * url = M_SS_URL_SHOP_ICON;
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:parment constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"store_avatar" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         NSLog(@"json == %@ \n %@", dic, [dic objectForKey:@"msg"]);
         if ([dic isKindOfClass:[NSDictionary class]] && [[dic objectForKey:@"status"] integerValue] == 1) {
             [[LXAlterView sharedMyTools] createTishi:@"修改成功!"];
             NSData *da = [[NSData alloc]initWithBase64EncodedString:[self imageTransToBase64String:imageFile] options:NSDataBase64DecodingIgnoreUnknownCharacters];
             UIImage *image = [UIImage imageWithData:da];
             _shopIcon.msgImage.image = image;
             [[NSNotificationCenter defaultCenter] postNotificationName:@"upload_shop_avatar" object:image];
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         NSLog(@"%@", error);
         [[LXAlterView sharedMyTools] createTishi:@"修改图像失败！"];
     }];
}

#pragma mark --- dealloc

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"upload_shop_avatar" object:nil];
}

@end
