//
//  OpenShopViewController.m
//  WelLv
//
//  Created by mac for csh on 15/10/29.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "OpenShopViewController.h"
#import "OpenShopTFViewController.h"
#import "BankCardViewController.h"
#import "openShopCell.h"
#import "PhoneNumTFViewController.h"
#import "MapLocationViewController.h"
#import "BankCardModel.h"
#import "WXUtil.h"

#import "GTMBase64.h"
#import "GTMDefines.h"
@interface OpenShopViewController ()
{
    UITableView *_tableView;
    NSMutableArray *titleArray;
    NSMutableArray *detailTitleArray;
    
    UIImageView *logoIGV;
    UIImageView *zhizhaoIGV;
    UIImageView *weishengIGV;
    NSString *indexStr;
   
}
@property (nonatomic, strong) MBProgressHUD * hud;

@end

@implementation OpenShopViewController


-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"OStongzhi" object:nil];
    

}
- (void)tongzhi:(NSNotification *)dic{
    switch ([dic.userInfo[@"type"] integerValue]) {
        case 1:
        {
            NSInteger index =  [dic.userInfo[@"index"] integerValue];
            NSString *text = dic.userInfo[@"text"];
            [detailTitleArray replaceObjectAtIndex:index withObject:text];
            [_tableView reloadData];
//            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
//            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            
        }
            
            break;
            
        case 2:
        {
            NSInteger index =  [dic.userInfo[@"index"] integerValue];
            NSDictionary *dictionary = dic.userInfo[@"text"];
            [detailTitleArray replaceObjectAtIndex:index withObject:dictionary];
            [_tableView reloadData];
            
        }
            
            break;
            
        case 3:
        {
            NSInteger index =  [dic.userInfo[@"index"] integerValue];
            ShopLocationModel *model = dic.userInfo[@"text"];
            [detailTitleArray replaceObjectAtIndex:index withObject:model];
            [_tableView reloadData];
          //  NSLog(@"%@",model);
           
        }
            
            break;
            
        case 4:
        {
            NSInteger index =  [dic.userInfo[@"index"] integerValue];
            BankCardModel *model = dic.userInfo[@"text"];
            [detailTitleArray replaceObjectAtIndex:index withObject:model];
            [_tableView reloadData];
          //  NSLog(@"%@",model);
           
        }
            
            break;
            
        default:
            break;
    }
    
    
    
    //   NSLog(@"－－－－－接收到通知------");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.title = @"开户";
    

    
    NSArray *array1 = [NSArray arrayWithObjects:@"商铺名称",@"商铺logo", nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"营业执照",@"卫生许可证",@"地图定位",@"详细地址", nil];
    NSArray *array3 = [NSArray arrayWithObjects:@"店主姓名",@"登录名(店主手机号)",@"商铺微信号",@"联系电话(选填)", nil];
    NSArray *array4 = [NSArray arrayWithObjects:@"店主银行卡", nil];
    NSArray *array5 = [NSArray arrayWithObjects:@"开通商户", nil];
    titleArray = [NSMutableArray arrayWithObjects:array1,array2,array3,array4,array5, nil];
    
    BankCardModel *BCmodel = [[BankCardModel alloc] init];
    BCmodel.bank_sn = @"";
    BCmodel.cardholder = @"";
    BCmodel.open_bank_dir = @"";
    BCmodel.open_bank_name = @"";
    BCmodel.open_brance_name = @"";
    NSDictionary *ContentWay = [[NSDictionary alloc] initWithObjectsAndKeys:@"",@"phone",@"",@"mobile", nil];
    ShopLocationModel *model = [[ShopLocationModel alloc] init];
    model.shopDir = @"";
    model.province = @"";
    model.city =@"";
    model.longitude = @"";
    model.latitude = @"";
    detailTitleArray = [NSMutableArray arrayWithObjects:@"",@"选择照片",@"选择照片",@"选择照片",model,@"",@"",@"",@"",ContentWay,BCmodel, nil];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight - NavHeight)];
    _tableView.tableFooterView=[[UIView alloc] init];//去掉多余的cell
    _tableView.delegate = self; _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor ];
    [self.view addSubview:_tableView];
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:_tableView.tableHeaderView.frame];
    header.backgroundColor = [UIColor clearColor];
    
    return header;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return footerheighter;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[titleArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4) {
        return 80;
    }else{
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 4)
    {
        static NSString *CellIdentifier3 = @"cellIdentifier3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.separatorInset = UIEdgeInsetsMake(0, windowContentWidth, 0,0);
            
            UIButton *exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            exitBtn.frame=CGRectMake(25, 10, windowContentWidth - 25*2, 40);
            exitBtn.layer.cornerRadius=5;
            exitBtn.backgroundColor = kColor(66,250,162);
            [exitBtn setTitle:@"开通商户" forState:UIControlStateNormal];
            [exitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [exitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:exitBtn];
        }
        return cell;
    }else{
        static NSString *CellIdentifier10000 = @"cellIdentifier10000";
        openShopCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier10000];
        
        if (cell == nil)
        {
            cell = [[openShopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier10000];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.titleLabel.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        if (indexPath.section == 0) {
            cell.detailtitleLabel.text = [detailTitleArray objectAtIndex:indexPath.row];
        }else if (indexPath.section == 1) {
            if (indexPath.row == 2) {
                ShopLocationModel *model = [detailTitleArray objectAtIndex:indexPath.row+2];
                cell.detailtitleLabel.text = model.shopDir;
            }else{
                cell.detailtitleLabel.text  = [detailTitleArray objectAtIndex:indexPath.row+2];
            }
        }else if (indexPath.section == 2) {
            if (indexPath.row == 3) {
                NSDictionary  *dictionary = [detailTitleArray objectAtIndex:indexPath.row+2+4];
                cell.detailtitleLabel.numberOfLines = 2;
                cell.detailtitleLabel.text = [[[dictionary objectForKey:@"mobile"] stringByAppendingString:@"\n"] stringByAppendingString:[dictionary objectForKey:@"phone"]];
            }else{
                cell.detailtitleLabel.text  = [detailTitleArray objectAtIndex:indexPath.row+2+4] ;
            }
        }else if (indexPath.section == 3) {
            BankCardModel *model = [detailTitleArray objectAtIndex:indexPath.row+2+4+4];
            NSLog(@"%@",model);
            cell.detailtitleLabel.text = [self judgeReturnString:model.bank_sn withReplaceString:@""];
        }

        if (indexPath.section == 0 &&indexPath.row ==1 && !logoIGV) {
            logoIGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth -45 -40,cell.frame.size.height/2-40/2, 40, 40)];
            logoIGV.backgroundColor = [UIColor clearColor];
            [cell addSubview:logoIGV];
            logoIGV.hidden = YES;
        }else if (indexPath.section == 1 &&indexPath.row ==0 && !zhizhaoIGV) {
            zhizhaoIGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth -45 -40,cell.frame.size.height/2-40/2, 40, 40)];
            zhizhaoIGV.backgroundColor = [UIColor clearColor];
            [cell addSubview:zhizhaoIGV];
            zhizhaoIGV.hidden = YES;
        }else if (indexPath.section == 1 &&indexPath.row ==1 && !weishengIGV) {
            weishengIGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth -45 -40,cell.frame.size.height/2-40/2, 40, 40)];
            weishengIGV.backgroundColor = [UIColor clearColor];
            [cell addSubview:weishengIGV];
            weishengIGV.hidden =YES;
        }
        
       
        return cell;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"section = %ld  ---  row = %ld",indexPath.section,indexPath.row);
    if ((indexPath.section == 0&&indexPath.row ==0) || (indexPath.section == 2 && indexPath.row !=3))
    {
        OpenShopTFViewController *optxVC = [[OpenShopTFViewController alloc] init];
        optxVC.navigationItem.title = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        if (indexPath.section ==0) {
            optxVC.arrayIndex = indexPath.row;
        }else if(indexPath.section ==1) {
            optxVC.arrayIndex = indexPath.row+2;
        }else if(indexPath.section ==2) {
            optxVC.arrayIndex = indexPath.row+2+4;
        }
        
        [self.navigationController pushViewController:optxVC animated:YES];
    }
    else if(indexPath.section == 1 && indexPath.row == 3)
    {
    //友好提醒
        FriendlyMsgViewController *optxVC = [[FriendlyMsgViewController alloc] init];
        optxVC.navigationItem.title = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
         optxVC.arrayIndex = indexPath.row+2;
        [self.navigationController pushViewController:optxVC animated:YES];
    
    }
    else if (indexPath.section ==2 && indexPath.row == 3)
    {
    //电话
        PhoneNumTFViewController *phVC = [[PhoneNumTFViewController alloc] init];
        phVC.navigationItem.title = @"联系电话";
        phVC.arrayIndex = indexPath.row+2+4;
        [self.navigationController pushViewController:phVC animated:YES];
        
    }
    else if (indexPath.section == 1 && indexPath.row == 2)
    {
    //地图定位
        MapLocationViewController *locationVC = [[MapLocationViewController alloc] init];
        locationVC.arrayIndex = indexPath.row +2;
        [self.navigationController pushViewController:locationVC animated:YES];
        
    }
    else if(indexPath.section == 3)
    {
        BankCardViewController *bVC = [[BankCardViewController alloc] init];
        bVC.title = @"银行卡";
        bVC.arrayIndex = indexPath.row + 2+4 +4 ;
        BankCardModel *model = [detailTitleArray objectAtIndex:10];
        bVC.getmodel = model;
        [self.navigationController pushViewController:bVC animated:YES];
        
    }
    else if (indexPath.section == 0 && indexPath.row == 1)
    {
    //logo
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
        //actionsheet.tag = 1;
        [actionsheet showInView:self.view];
        indexStr =@"LOGO";
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
    //营业执照
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
        //actionsheet.tag = 2;
        [actionsheet showInView:self.view];
        indexStr =@"ZHIZHAO";
    }
    else if (indexPath.section == 1 && indexPath.row == 1)
    {
    //卫生许可证
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
        //actionsheet.tag = 3;
        [actionsheet showInView:self.view];
        indexStr =@"WEISHENG";
    }

}

#pragma mark 开通商户按钮
-(void)submit{

    
    ShopLocationModel *locationM = [detailTitleArray objectAtIndex:4];
    BankCardModel *bankM = [detailTitleArray objectAtIndex:10];
    NSDictionary *ContentWay = [detailTitleArray objectAtIndex:9];
   
    if ([[detailTitleArray objectAtIndex:0] isEqualToString:@"(null)"]||[[detailTitleArray objectAtIndex:5] isEqualToString:@"(null)"]||[[detailTitleArray objectAtIndex:6] isEqualToString:@"(null)"]||[[detailTitleArray objectAtIndex:7] isEqualToString:@"(null)"]||[[detailTitleArray objectAtIndex:8] isEqualToString:@"(null)"] || [[detailTitleArray objectAtIndex:0] isEqualToString:@""]||[[detailTitleArray objectAtIndex:5] isEqualToString:@""]||[[detailTitleArray objectAtIndex:6] isEqualToString:@""]||[[detailTitleArray objectAtIndex:7] isEqualToString:@""]||[[detailTitleArray objectAtIndex:8] isEqualToString:@""]) {
        [[LXAlterView alloc]createTishi:@"请完善必填内容"];
    }else if ([locationM.shopDir isEqualToString:@""] || [locationM.shopDir isEqualToString:@"(null)"]){
        [[LXAlterView alloc]createTishi:@"请选择地图定位"];
    }else if ([bankM.cardholder isEqualToString:@""] || [bankM.cardholder isEqualToString:@"(null)"]){
        [[LXAlterView alloc]createTishi:@"请填写银行卡信息"];
    }else if (![bankM.cardholder isEqualToString:[detailTitleArray objectAtIndex:6]] ){
        [[LXAlterView alloc]createTishi:@"银行卡开户人必须与店主信息一致"];
    }else if (logoIGV.image == nil || weishengIGV.image == nil || zhizhaoIGV.image == nil){
        [[LXAlterView alloc]createTishi:@"请上传图片"];
    }else{
        NSDictionary *dicD = @{ @"shop_dir": locationM.shopDir,
                                @"partner_shop_name": [detailTitleArray objectAtIndex:0],
                                @"contact_phone": ContentWay,
                                @"city": locationM.city,
                                @"main_phone": [detailTitleArray objectAtIndex:7],
                                @"friendly_msg":[detailTitleArray objectAtIndex:5],
                                @"province": locationM.province,
                                @"longitude": locationM.longitude,
                                @"latitude": locationM.latitude,
                                @"partner_shop_main_name": [detailTitleArray objectAtIndex:6],
                                @"wx_sn": [detailTitleArray objectAtIndex:8],
                                @"bank_sn":bankM.bank_sn,
                                @"open_bank_name":bankM.open_bank_name,
                                @"open_bank_dir":bankM.open_bank_dir,
                                @"open_branch_name":bankM.open_brance_name,
                                @"cardholder":bankM.cardholder
                                };
       // NSLog(@"%@",dicD);
        /* NSString *ssss= @"382";
         NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",ssss];
         md5str = [WXUtil md5:md5str];
         
         NSData *logo = UIImageJPEGRepresentation(logoIGV.image, 0.1);
         NSData* hygience = UIImageJPEGRepresentation(weishengIGV.image, 0.1);
         NSData* business = UIImageJPEGRepresentation(zhizhaoIGV.image, 0.1);
         
         NSDictionary *parameters =@{@"wltoken":md5str,
         @"member_id":@"382",
         @"data":[self dictionaryToJson:dicD]};*/
        
        
        NSString *md5str = [NSString stringWithFormat:@"~0;id<zOD.{ll@]JKi(:%@",[[LXUserTool alloc] getUid]];
        md5str = [WXUtil md5:md5str];
        
        if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward){
            
            NSDictionary *parameters =@{@"wltoken":md5str,
                                        @"assistant_id":[[LXUserTool alloc ] getUid],
                                        @"data":[self dictionaryToJson:dicD]};
            
            [self sendRequstUrl:DriveOpenShop WithParamers:parameters];
        }else{
            NSDictionary *parameters =@{@"wltoken":md5str,
                                        @"member_id":[[LXUserTool alloc] getUid],
                                        @"data":[self dictionaryToJson:dicD]};
            
            [self sendRequstUrl:DriveMemberApplyShop WithParamers:parameters];
        }
       
       
    }
   
}

-(void)sendRequstUrl:(NSString *)url WithParamers:(NSDictionary *)paramers{
    
    NSData *logo = UIImageJPEGRepresentation(logoIGV.image, 0.1);
    NSData* hygience = UIImageJPEGRepresentation(weishengIGV.image, 0.1);
    NSData* business = UIImageJPEGRepresentation(zhizhaoIGV.image, 0.1);
    
    [self setProgressHud];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:url parameters:paramers constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:logo name:@"logo" fileName:@"1.jpg" mimeType:@"image/jpg"];
        [formData appendPartWithFileData:hygience name:@"hygiene_licenses" fileName:@"2.jpg" mimeType:@"image/jpg"];
        [formData appendPartWithFileData:business name:@"business_licenses" fileName:@"3.jpg" mimeType:@"image/jpg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        if ([[dict objectForKey:@"state"] integerValue] == 1) {
            _hud.hidden = YES;
            [[LXAlterView alloc]createTishi:@"开户成功"];
        }else{
            _hud.hidden = YES;
            [[LXAlterView alloc] createTishi:[dict objectForKey:@"msg"]];
        }
        NSLog(@"dict = \n %@ \n %@",[dict objectForKey:@"msg"],dict  );
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _hud.hidden = YES;
    }];
}

//字典数据转Json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (void)setProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"正在提交";
    
    [self.view addSubview:_hud];
    [_hud show:YES];
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
        if ([indexStr isEqualToString:@"LOGO"]) {
            logoIGV.hidden =NO;
            [logoIGV setImage:editedImage];
            
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:1 inSection:0];
            openShopCell *cell = [_tableView cellForRowAtIndexPath:indexpath];
            cell.detailtitleLabel.hidden = YES;
        }else if ([indexStr isEqualToString:@"ZHIZHAO"]) {
            zhizhaoIGV.hidden =NO;
            [zhizhaoIGV setImage:editedImage];
            
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:1];
            openShopCell *cell = [_tableView cellForRowAtIndexPath:indexpath];
            cell.detailtitleLabel.hidden = YES;
        }else if ([indexStr isEqualToString:@"WEISHENG"]) {
            weishengIGV.hidden =NO;
            [weishengIGV setImage:editedImage];
            
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:1 inSection:1];
            openShopCell *cell = [_tableView cellForRowAtIndexPath:indexpath];
            cell.detailtitleLabel.hidden = YES;
        }
        
        //UIImage *image = [self imageWithImageSimple:editedImage scaledToSize:CGSizeMake(1000, 1000)];
        //[self UpdatePhoto:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
/*
//压缩图片
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

*/

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





@end
