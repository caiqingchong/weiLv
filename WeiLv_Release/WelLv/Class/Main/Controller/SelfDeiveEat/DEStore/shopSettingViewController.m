//
//  shopSettingViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/7.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//
#import "JYClocationViewController.h"
#import "shopSettingViewController.h"
#import "WriteMessageViewController.h"
#import "JYCreturnTicketVC.h"
#import "GTMBase64.h"
#import "OpenTimeViewController.h"
#import "BackSettingViewController.h"
#import "WXUtil.h"
#import "shopModel.h"
#import "ShopLocationModel.h"
#import "MBProgressHUD.h"
@interface shopSettingViewController ()<UIActionSheetDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,MBProgressHUDDelegate,UINavigationControllerDelegate>
{
    UITableView *_zxdTableView;
    NSMutableArray *titleArray;
    NSMutableArray *rightArr;
    NSData *imgData;
    UIImageView *ticketView;
    UIImageView *imageview1;
    UIImageView *imageview2;
    UIImageView *imageview3;
    NSInteger im;
    UISwitch *sw1;
    UISwitch *sw2;
    NSString *_strOp1;
    NSString *_strOp2;
    NSString *_numPhone1;
    NSString *_numPhone2;
    NSString *_strBeizhu;
    AFHTTPRequestOperationManager *manager;
}
@property(nonatomic,strong) NSString *strOp1;
@property(nonatomic,strong) NSString *strOp2;
@property(nonatomic,strong) NSString *numPhone1;
@property(nonatomic,strong) NSString *numPhone2;
@property(nonatomic,strong) NSString *strBeizhu;
@property(nonatomic,retain)shopModel *zxdModel;
@property(nonatomic,strong) MBProgressHUD *zxdHud;
@property(nonatomic,strong) NSString *shopStringname;
@end

@implementation shopSettingViewController
-(void)creatBack
{
   

    self.strOp1 = [[NSString alloc] initWithFormat:@"%@",@""];
    
    self.strOp2 = [[NSString alloc] initWithFormat:@"%@",@""];
    self.numPhone1 = [[NSString alloc] initWithFormat:@"%@",@""];
    self.numPhone2 = [[NSString alloc] initWithFormat:@"%@",@""];
    self.strBeizhu = [[NSString alloc] initWithFormat:@"%@",@""];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zxdTongzhi:) name:@"ZxdTZ" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zzTongzhi:) name:@"zxdZZ" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MapTongzhi:) name:@"ZXDTongzhi" object:nil];
}
-(void)MapTongzhi:(NSNotification *)dic
{
//    ShopLocationModel *model=[[ShopLocationModel alloc]init];
//    model.latitude=chuLatitude;
//    model.longitude=chuLongitude;
//    model.province=chuProv;
//    model.city=chuCity;
//    model.shopDir=chuStr;
//    NSDictionary *dic = @{@"type":@"3",@"index":[NSString stringWithFormat:@"%ld",(long)self.arrayIndex],@"text":model};
//    NSNotification *notification =[NSNotification notificationWithName:@"ZXDTongzhi" object:nil
    ShopLocationModel *model = [[ShopLocationModel alloc] init];
    model = dic.userInfo[@"text"];
    UILabel *label = (UILabel *)[self.view viewWithTag:8];
    label.text = model.shopDir;
    self.zxdModel.latitude = [self judgeString:model.latitude]?model.latitude:@"34.767839";
    self.zxdModel.longitude = [self judgeString:model.longitude]?model.longitude:@"113.717261";
    self.zxdModel.city = [self judgeString:model.city]?model.city:@"郑州市";
    self.zxdModel.province = [self judgeString:model.province]?model.province:@"3940";
    
    
}
-(void)zzTongzhi:(NSNotification *)dic
{
    NSInteger index1 = [dic.userInfo[@"arrindex1"] integerValue];
    NSInteger index2 = [dic.userInfo[@"arrindex2"] integerValue];
    NSString *str1 = [self judgeString:dic.userInfo[@"text1"]]?dic.userInfo[@"text1"]:@"";
    //[self judgeString:dictArr[@"appointment"]]
    NSString *str2 = [self judgeString:dic.userInfo[@"text2"]]?dic.userInfo[@"text2"]:@"";
    NSString *str3 = dic.userInfo[@"text3"];
    NSMutableString *str4 = [[NSMutableString alloc] init];
    if (index2 == 0) {
        str4 = [NSMutableString stringWithFormat:@"%@\n%@\n%@",str1,str2,str3];
        self.strOp1 = str1;
        self.strOp2 = str2;
        self.strBeizhu = str3;
    }
    else
    {
        self.numPhone1 = str1;
        self.numPhone2 = str2;
        str4 = [NSMutableString stringWithFormat:@"%@\n%@",str1,str2];

        
    }
    UILabel *lab = (UILabel *)[self.view viewWithTag:5*index1+index2+1];
    [lab setText:str4];
 
}
-(void)zxdTongzhi:(NSNotification *)dic
{
    NSInteger index1 = [dic.userInfo[@"arrindex1"] integerValue];
    NSInteger index2 = [dic.userInfo[@"arrindex2"] integerValue];
    NSString *str = dic.userInfo[@"text"];
    NSLog(@"%@",str);
    NSMutableArray *arr = [NSMutableArray arrayWithArray:[rightArr objectAtIndex:index1]];
    
    [arr replaceObjectAtIndex:index2 withObject:str];
    [rightArr replaceObjectAtIndex:index1 withObject:arr];
    
    
    UILabel *lab = (UILabel *)[self.view viewWithTag:5*index1+index2+1];
    [lab setText:str];

    if (index1 == 0) {
        switch (index2) {
            case 0:
                self.zxdModel.partner_shop_name = str;
                break;
                
            default:
                break;
        }
    }
    else if (index1 == 1)
    {
        switch (index2) {
            case 2:
                self.zxdModel.shop_dir = str;
                break;
                case 3:
                self.zxdModel.friendly_msg = str;
                break;
            default:
                break;
        }

    }
    else if (index1 == 2)
    {
        switch (index2) {
            case 0:
                self.zxdModel.partner_shop_main_name = str;
                break;
            case 1:
                self.zxdModel.main_phone = str;
                break;
            case 2:
                self.zxdModel.wx_sn = str;
                break;
                          
            default:
                break;
        }

    }
    else if (index1 == 3)
    {
        switch (index2) {
            case 0:
                
                break;
                
                
            default:
                break;
        }

    }
    else if (index1 == 4)
    {
        switch (index2) {
            case 0:
                self.zxdModel.deduct = str;
                break;
                
            default:
                break;
        }

    }
    
}
- (void)viewDidLoad {
    im = 0;
    
    [super viewDidLoad];
     self.navigationItem.title = @"店铺设置";
    
    self.view.backgroundColor = BgViewColor;
    self.zxdModel = [[shopModel alloc] init];
    [self.zxdModel fill];
    
    [self creatBack];
    //[self creatHUD];
    imageview1 =[[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45-35, 8, 45, 30)];
    imageview2 =[[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45-35, 8, 45, 30)];
    imageview2.image = [UIImage imageNamed:@"默认图1"];
    imageview3 =[[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45-35, 8, 45, 30)];
    imageview3.image = [UIImage imageNamed:@"默认图1"];
    [self creatarr];
    [self creattitleHead];
     [self download];
    

    
    
    }
-(void)creatarr
{
   // NSLog(@"++99999999999999+++%@",self.zxdModel.rooms);
    NSMutableArray *arrayl1 = [NSMutableArray arrayWithObjects:@"3个月可修改一次",@"",@"", nil];
    NSMutableArray *arrayl2 = [NSMutableArray arrayWithObjects:@"",@"", @"",@"",nil];
    NSMutableArray *arrayl3 = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
    NSMutableArray *arrayl4 = [NSMutableArray arrayWithObjects:@"", @"",@"",@"",@"",nil];
    NSMutableArray *arrayl5 = [NSMutableArray arrayWithObjects:@"",@"",@"",nil];
    NSMutableArray *arrayl6 = [NSMutableArray arrayWithObjects:@"", @"",@"",@"",nil];
    NSMutableArray *arrayl7 = [NSMutableArray arrayWithObjects:@"", @"",@"",@"",nil];
    [rightArr removeAllObjects];
    rightArr = [NSMutableArray arrayWithObjects:arrayl1,arrayl2,arrayl3,arrayl4,arrayl5,arrayl6,arrayl7, nil];
   // NSLog(@"%@",rightArr);
}
-(void)creattitleHead
{
    
    
    NSArray *array1 = [NSArray arrayWithObjects:@"商铺名称",@"商铺logo", nil];
    NSArray *array2 = [NSArray arrayWithObjects:@"营业执照",@"卫生许可证",@"地图定位", @"行车路线",nil];
    NSArray *array3 = [NSArray arrayWithObjects:@"店主姓名",@"登录名(店主手机号)",@"商铺微信号",@"联系电话", nil];
    NSArray *array4 = [NSArray arrayWithObjects:@"营业时间", nil];
    NSArray *array5 = [NSArray arrayWithObjects:@"店铺订单(取消/退款)扣款设置",@"订餐是否需要预约",@"订餐是否提供包间", nil];
    NSArray *array6 = [NSArray arrayWithObjects:@"保存修改", nil];
    titleArray = [NSMutableArray arrayWithObjects:array1,array2,array3,array4,array5,array6, nil];
    _zxdTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-NavHeight)];
    _zxdTableView.tableFooterView = [[UIView alloc] init];//去掉多余的cell
    _zxdTableView.backgroundColor = [UIColor clearColor];
    _zxdTableView.delegate = self;
    _zxdTableView.dataSource = self;
    [_zxdTableView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_zxdTableView];

}
#pragma mark - tableView dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return titleArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:_zxdTableView.tableHeaderView.frame];
    header.backgroundColor = [UIColor clearColor];
    return header;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[titleArray objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 5) {
        return 60;
    }
    else if (indexPath.section ==2 && indexPath.row == 3)
    {
        return 60;
    }
    else if (indexPath.section == 3)
    {
        return 60;
    }

        return 45;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //保存修改
    if (indexPath.section == 5) {
        static NSString *CellIdtifier1 =@"cellIddertifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdtifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdtifier1];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                   }
        cell.backgroundColor = [UIColor clearColor];
        cell.separatorInset = UIEdgeInsetsMake(0, windowContentWidth, 0, 0);
        UILabel *label = [[UILabel alloc] init];
        label.frame =CGRectMake(25, 10, windowContentWidth-25*2, 40);
        label.layer.cornerRadius = 5;
        label.backgroundColor = kColor(66, 250, 162);
        label.text = @"保存修改";
        label.textAlignment = NSTextAlignmentCenter;
        [cell addSubview:label];

        return cell;
    }
    //系统开关控件
     if (indexPath.section == 4&&(indexPath.row == 1||indexPath.row ==2))
    {
               static NSString *cellIdentifier2 = @"cellIdentifier2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier2];
                    }
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        cell.textLabel.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];

                       if (indexPath.row == 1) {
            sw1 = [[UISwitch alloc] initWithFrame:CGRectMake(windowContentWidth-100, 5, 10, 10)];
            //sw1.frame = CGRectMake(windowContentWidth-100, 5, 50, 30);
            sw1.tag = 50+indexPath.row;
            [sw1 setOn:[self.zxdModel.appointment isEqual:@"1"]];
            [sw1 addTarget:self action:@selector(zxdSWClick:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw1];
        }
        if (indexPath.row == 2) {
            sw2 = [[UISwitch alloc] initWithFrame:CGRectMake(windowContentWidth-100, 5, 40, 10)];
            //sw2.frame = CGRectMake(windowContentWidth-100, 5, 50, 30);
            sw2.tag = 50+indexPath.row;
            [sw2 setOn:[self.zxdModel.rooms isEqual:@"1"]];
            [sw2 addTarget:self action:@selector(zxdSWClick:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:sw2];

        }
        return cell;
    }
    //营业时间 ，联系电话
      if ((indexPath.row == 3 && indexPath.section == 2)||(indexPath.section == 3))
     {
         static NSString *cellIdentifier3 = @"cellIdentifier3";
         //UITableViewCell *cell = [[UITableViewCell alloc] init];
         UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
         if (cell == nil) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier3];
             cell.selectionStyle = UITableViewCellSeparatorStyleNone;
             UIImageView *zxdView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45, ViewHeight(cell)/2-5, 45, 30)];
             [zxdView setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
             [cell addSubview:zxdView];
              }
        
         cell.textLabel.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
         
         cell.textLabel.font = [UIFont systemFontOfSize:15];
         UILabel *label = [[UILabel alloc] init];
         label.frame = CGRectMake(windowContentWidth-200-35, 0, 200, 60);
         label.textAlignment = NSTextAlignmentRight;
         //label.text = @"123456";
         label.numberOfLines = 0;
         label.tag = 5*indexPath.section+indexPath.row+1;
         label.text = [[rightArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
         
         label.font = [UIFont systemFontOfSize:15];
         [cell addSubview:label];

        

         return cell;
     }
    //正常的cell
    else
    {
        static NSString *cellIdentifier4 = @"cellIdentifier4";
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell = nil;
        //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier4];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            
            }
        
        cell.textLabel.text = [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        UIImageView *zxdView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45, ViewHeight(cell)/2-15, 45, 30)];
        [zxdView setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [cell addSubview:zxdView];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(windowContentWidth-200-35, 8, 200, 30);
        label.textAlignment = NSTextAlignmentRight;
        //label.text = @"123456";
        label.tag = 5*indexPath.section+indexPath.row+1;
        
        label.text = [[rightArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        label.font = [UIFont systemFontOfSize:15];
        [cell addSubview:label];


        
            if (indexPath.section == 0&&indexPath.row == 1) {
               
                
                
                [cell addSubview:imageview1];
            }
             if(indexPath.section==1&&indexPath.row == 0)
            {
               
        
                [cell addSubview:imageview2];
            }
             if(indexPath.section==1&&indexPath.row == 1)
            {
                

                [cell addSubview:imageview3];
            }
       
        return  cell;
    }
    return nil;
   
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section==1&&indexPath.row == 3)||(indexPath.section==0&&indexPath.row == 0)||indexPath.section == 2) {
        UILabel *labelstr = (UILabel *)[self.view viewWithTag:5*indexPath.section+indexPath.row+1];
        WriteMessageViewController *WrMs= [[WriteMessageViewController alloc] init];
        WrMs.arrindex1 = indexPath.section;
        WrMs.arrindex2 = indexPath.row;
        WrMs.strtext = labelstr.text;
        WrMs.navigationItem.title =[[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
       // NSLog(@"%ld---%ld",WrMs.arrindex1,WrMs.arrindex2);
        [self.navigationController pushViewController:WrMs animated:YES];

    }
    if (indexPath.section == 1&&indexPath.row == 2) {
        JYClocationViewController *map = [[JYClocationViewController alloc] init];
        [self.navigationController pushViewController:map animated:YES];
    }
     if (((indexPath.section==1)&&(indexPath.row==0||indexPath.row==1))||(indexPath.section == 0&& indexPath.row==1))
    {
        im =  3*indexPath.section+indexPath.row;

        
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
        [actionsheet showInView:self.view];
//        JYCreturnTicketVC *view = [[JYCreturnTicketVC alloc] init];
//        [self.navigationController pushViewController:view animated:YES];
    }
     if (indexPath.section == 3)
    {
        OpenTimeViewController *opView = [[OpenTimeViewController alloc] init];
        opView.navigationItem.title = @"营业时间";
        opView.arrindex1 = indexPath.section;
        opView.arrindex2 = indexPath.row;
        [self.navigationController pushViewController:opView animated:YES];
    }
     if(indexPath.section==4&&indexPath.row == 0)
    {
        BackSettingViewController *bck = [[BackSettingViewController alloc] init];
        bck.arrindex1 = indexPath.section;
        bck.arrindex2 = indexPath.row;
        [self.navigationController pushViewController:bck animated:YES];
    }
     if(indexPath.section == 5)
    {
        
       // NSLog(@"%@",rightArr);
        [self zxdUploadToServer];
       // NSLog(@"+++保存修改");
    }
        
    
}
#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
        [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypeCamera];
    if (buttonIndex == 1)
        [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary];}
#pragma mark UIimagePickerControllerDelegate
-(UIImagePickerController *)openPhotoToViewController:(UIViewController*)viewController sourceType:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]&& mediaTypes.count>0) {
        UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
        imagePick.mediaTypes = mediaTypes;
        imagePick.navigationBarHidden = YES;
        imagePick.allowsEditing = YES;
        imagePick.delegate = self;
        imagePick.sourceType = sourceType;
        [viewController presentViewController:imagePick animated:YES completion:nil];
        return imagePick;
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"设备不支持" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
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
        
        UIImage *image = [self imageWithImageSimple:editedImage scaledToSize:CGSizeMake(45, 45)];
        imgData = UIImageJPEGRepresentation(image,0.1);
        
        ticketView.image=image;
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
    if (im==1) {
        UILabel *label1 = (UILabel *)[self.view viewWithTag:2];
        label1.text = @"";
        imageview1.image = image;
//       UIImageView *imageView = (UIImageView *)[self.view viewWithTag:im];
//        imageView.image = image;
//        im=0;
    }
    else if (im==3){
        UILabel *label3 = (UILabel *)[self.view viewWithTag:6];
        label3.text = @"";

           imageview2.image = image;
    }
    else if (im== 4){
        UILabel *label4 = (UILabel *)[self.view viewWithTag:7];
        label4.text = @"";

          imageview3.image = image;
    }
    else{
        
    }
    
    return newImage;
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
-(void)zxdSWClick:(id)sender
{
    NSLog(@"++++++00000");
    UISwitch *switchButton = (UISwitch *)sender;
    BOOL isbuttonOn = [switchButton isOn];
    if (isbuttonOn) {
        switch (switchButton.tag) {
            case 51:
                self.zxdModel.appointment = @"1";
                
                break;
            case 52:
                self.zxdModel.rooms = @"1";
                break;
            default:
                break;
        }
    }
    else
    {
        switch (switchButton.tag) {
            case 51:
                self.zxdModel.appointment = @"0";
                break;
            case 52:
                self.zxdModel.rooms = @"0";
                break;
            default:
                break;
        }

        NSLog(@"-------");
    }
    //NSLog(@"---------%@",self.zxdModel.appointment);
    // NSLog(@"---------%@",self.zxdModel.rooms);
}
-(void)btnClick
{
    NSLog(@"11111");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -下载
-(void)download
{

    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *user_id = [LXUserTool sharedUserTool].getUid;
   // user_id = @"33058";
    NSString *token1 = [token stringByAppendingString:user_id];
    NSDictionary *parameters = @{@"member_id":user_id,
                                 @"wltoken":[WXUtil md5:token1]};
    [self sendWith:[NSString stringWithFormat:@"%@/%@",WLHTTP,@"api/drivingMemberApply/get_driving_features_eat"] dict:parameters];
}
-(void)sendWith:(NSString *)url dict:(NSDictionary *)dict
{
    [self setHud:@"正在下载,,,,,"];
    __weak typeof(self)weakSelf = self;
       manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //UIAlertView *alertViewSuccess= [[UIAlertView alloc] initWithTitle:@"下载成功" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
               //[alertViewSuccess show];
               [weakSelf datagroup:dict];
                 NSLog(@"%@",dict[@"data"]);
             self.zxdHud.labelText = dict[@"msg"];
              self.zxdHud.hidden = YES;
                       // NSLog(@"开户时间%@",[dict[@"data"] objectAtIndex:0][@"open_hours"] );
              [weakSelf creatUpdataArr];
        
              [_zxdTableView reloadData];
               //[self downPng];//下载图片
        
             [weakSelf initSwitch];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertViewFail = [[UIAlertView alloc] initWithTitle:@"下载失败" message:@"请检查您的网路是否正常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertViewFail show];
 
              // NSLog(@"%@",error);
        NSLog(@"下载失败");
    }];
}
-(void)downPng
{
    
    [imageview1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.logo]] placeholderImage:[UIImage imageNamed:@"默认图1.png"] options:SDWebImageProgressiveDownload];
    
    
    NSLog(@"图片1%@",[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.logo]);
    
    [imageview3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.hygiene_licenses]] placeholderImage:[UIImage imageNamed:@"默认图1.png"]];
    
        NSLog(@"图片2%@",[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.hygiene_licenses]);
    [imageview2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.business_licenses]] placeholderImage:[UIImage imageNamed:@"默认图1.png"] options:SDWebImageProgressiveDownload];
    
        NSLog(@"图片3%@",[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.business_licenses]);
    
    [_zxdTableView setNeedsDisplay];
   
}
-(void)creatUpdataArr
{
    NSMutableArray *arrayl1 = [NSMutableArray arrayWithObjects:self.zxdModel.partner_shop_name,@"",@"", nil];
    NSMutableArray *arrayl2 = [NSMutableArray arrayWithObjects:@"",@"", self.zxdModel.shop_dir,self.zxdModel.friendly_msg,nil];
    NSMutableArray *arrayl3 = [NSMutableArray arrayWithObjects:self.zxdModel.partner_shop_main_name,self.zxdModel.main_phone,self.zxdModel.wx_sn,@"",@"", nil];
    NSMutableArray *arrayl4 = [NSMutableArray arrayWithObjects:self.zxdModel.open_hours, @"32",@"",@"",@"",nil];
    NSMutableArray *arrayl5 = [NSMutableArray arrayWithObjects:self.zxdModel.deduct,@"",@"",nil];
    NSMutableArray *arrayl6 = [NSMutableArray arrayWithObjects:@"", @"",@"",@"",nil];
    NSMutableArray *arrayl7 = [NSMutableArray arrayWithObjects:@"", @"",@"",@"",nil];
//    NSLog(@"%@",arrayl1);
//    NSLog(@"%@",arrayl2);
//    NSLog(@"%@",arrayl3);
//    NSLog(@"%@",arrayl4);
//    NSLog(@"%@",arrayl5);
//    NSLog(@"%@",arrayl6);
    [rightArr removeAllObjects];
    rightArr = [NSMutableArray arrayWithObjects:arrayl1,arrayl2,arrayl3,arrayl4,arrayl5,arrayl6,arrayl7, nil];
}
//设置开关控制器
-(void)initSwitch
{
    if ([self.zxdModel.rooms isEqual:@"1"]) {
        [sw1 setOn:YES];
    }
    else
    {
        [sw1 setOn:NO];
    }
    if ([self.zxdModel.appointment isEqual:@"1"]) {
        [sw2 setOn:YES];
    }
    else
    {
        [sw2 setOn:NO];
    }
}
//数据解析
-(void)datagroup:(NSDictionary *)dict
{
    
    //NSLog(@"后台数据----%@",dict[@"data"]);
    
    if ([dict[@"data"] count]==0 ) {
        return;
    }
    
    
    NSDictionary *dictArr = [dict[@"data"] objectAtIndex:0];
  
    self.zxdModel.appointment = [self judgeString:dictArr[@"appointment"]]?dictArr[@"appointment"]:@"0";
   // self.zxdModel.appointment = [dictArr[@"appointment"] isEqual:@""]?@"":dictArr[@"appointment"];
    
    self.zxdModel.business_licenses = [self judgeString:dictArr[@"business_licenses"]]?dictArr[@"business_licenses"]:@"1";
    self.zxdModel.city = [self judgeString:dictArr[@"city"]]?dictArr[@"city"]:@"1";
    self.zxdModel.contact_phone = [self judgeString:dictArr[@"contact_phone"]]?dictArr[@"contact_phone"]:@"10086";
    //NSLog(@"%ld",self.zxdModel.contact_phone.length);
    if ([self judgeString:self.zxdModel.contact_phone]) {
        NSDictionary *dictPhone =  [[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:self.zxdModel.contact_phone];
      //  NSLog(@"%@",dictPhone);
        self.zxdModel.contact_phone = [NSString stringWithFormat:@"%@\n%@",dictPhone[@"phone"],dictPhone[@"mobile"]];
        //NSLog(@"+++9911++%@",self.zxdModel.contact_phone);
 
    }
    self.zxdModel.country = [self judgeString:dictArr[@"country"]]?dictArr[@"country"]:@"1";
    self.zxdModel.create_time = [self judgeString:dictArr[@"create_time"]]?dictArr[@"create_time"]:@"1448444632";
    self.zxdModel.deduct = [self judgeString:dictArr[@"deduct"]]?dictArr[@"deduct"]:@"0";
    self.zxdModel.friendly_msg = [self judgeString:dictArr[@"friendly_msg"]]?dictArr[@"friendly_msg"]:@"提示";
    self.zxdModel.hygiene_licenses = [self judgeString:dictArr[@"hygiene_licenses"]]?dictArr[@"hygiene_licenses"]:@"";
    self.zxdModel.uid = [self judgeString:dictArr[@"id"]]?dictArr[@"id"]:@"1";
    self.zxdModel.latitude = [self judgeString:dictArr[@"latitude"]]?dictArr[@"latitude"]:@"1.0";
   // NSLog(@"++++%@",self.zxdModel.latitude);
    self.zxdModel.logo = [self judgeString:dictArr[@"logo"]]?dictArr[@"logo"]:@"1";
    self.zxdModel.longitude = [self judgeString:dictArr[@"longitude"]]?dictArr[@"longitude"]:@"1.0";
    self.zxdModel.main_phone = [self judgeString:dictArr[@"main_phone"]]?dictArr[@"main_phone"]:@"10086";
    self.zxdModel.member_id = [self judgeString:dictArr[@"member_id"]]?dictArr[@"member_id"]:@"1";
    self.zxdModel.open_hours = [self judgeString:dictArr[@"open_hours"]]?dictArr[@"open_hours"]:@"";
    if ([self judgeString:self.zxdModel.open_hours]) {
        NSDictionary *dicthours =  [[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:self.zxdModel.open_hours];
        self.zxdModel.open_hours =[NSString stringWithFormat:@"%@\n%@",dicthours[@"AM"],dicthours[@"PM"]];

    }
    

    self.zxdModel.partner_shop_main_name = [self judgeString:dictArr[@"partner_shop_main_name"]]?dictArr[@"partner_shop_main_name"]:@"未设置";
    self.zxdModel.partner_shop_name = [self judgeString:dictArr[@"partner_shop_name"]]?dictArr[@"partner_shop_name"]:@"未设置";
    self.zxdModel.rooms = [self judgeString:dictArr[@"rooms"]]?dictArr[@"rooms"]:@"0";
    //NSLog(@"----%@",self.zxdModel.rooms);
    self.zxdModel.shop_dir = [self judgeString:dictArr[@"shop_dir"]]?dictArr[@"shop_dir"]:@"未设置";
    self.zxdModel.status = [self judgeString:dictArr[@"status"]]?dictArr[@"status"]:@"1";
    self.zxdModel.province = [self judgeString:dictArr[@"province"]]?dictArr[@"province"]:@"1";
    self.zxdModel.wx_sn = [self judgeString:dictArr[@"wx_sn"]]?dictArr[@"wx_sn"]:@"未设置";
    
//     NSLog(@"%@",self.zxdModel.status);
//     NSLog(@"%@",self.zxdModel.province);
//     NSLog(@"%@",self.zxdModel.open_hours);
//     NSLog(@"%@",self.zxdModel.hygiene_licenses);
//     NSLog(@"%@",self.zxdModel.latitude);
//     NSLog(@"%@",self.zxdModel.main_phone);
    
    [imageview1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.logo]] placeholderImage:[UIImage imageNamed:@"默认图1.png"] options:SDWebImageProgressiveDownload];
    
    
    NSLog(@"图片1%@",[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.logo]);
    
    [imageview3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.hygiene_licenses]] placeholderImage:[UIImage imageNamed:@"默认图1.png"]];
    
    NSLog(@"图片2%@",[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.hygiene_licenses]);
    [imageview2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.business_licenses]] placeholderImage:[UIImage imageNamed:@"默认图1.png"] options:SDWebImageProgressiveDownload];
    
    NSLog(@"图片3%@",[NSString stringWithFormat:@"%@/%@",WLHTTP,self.zxdModel.business_licenses]);
    
   // [_zxdTableView setNeedsDisplay];

}
#pragma mark-上传修改数据
-(void)zxdUploadToServer
{
    [self setHud:@"正在上传,,,,,"];
    
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString *user_id = [LXUserTool sharedUserTool].getUid;
   // user_id = @"33058";
    NSString *token1 = [token stringByAppendingString:user_id];
   
    //上传服务器
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *opTime = @{@"AM":[self judgeString:self.strOp1]?self.strOp1:@"",@"PM":[self judgeString:self.strOp2]?self.strOp2:@""};
    NSDictionary *contPhone = @{@"phone":self.numPhone2,@"mobile":self.numPhone1};
    NSDictionary *parameters = @{@"member_id":user_id,
                                 @"wltoken":[WXUtil md5:token1],
                                 @"id":[[WLSingletonClass defaultWLSingleton] wlDEShopID],
                                 @"data":[self dictionaryToJson:@{@"partner_shop_name":self.zxdModel.partner_shop_name ,
                                                                  @"partner_shop_main_name":self.zxdModel.partner_shop_main_name,
                                                                   @"longitude":self.zxdModel.longitude,
                                                                   @"latitude":self.zxdModel.latitude ,
                                                                   @"shop_dir":self.zxdModel.shop_dir,
                                                                   @"main_phone":self.zxdModel.main_phone,
                                                                   @"wx_sn": self.zxdModel.wx_sn,
                                                                   @"friendly_msg":self.zxdModel.friendly_msg,
                                                                    @"open_hours":opTime,
                                                                   @"deduct":self.zxdModel.deduct,
                                                                   @"rooms":self.zxdModel.rooms ,
                                                                   @"appointment":self.zxdModel.appointment,                                                                @"create_time":@"123",
                                                                   @"contact_phone":contPhone,
                                                                   @"country":self.zxdModel.country,
                                                                   @"province":self.zxdModel.province,
                                                                   @"city":self.zxdModel.city}]};
   
   
   // NSLog(@"-+++++++========%@",parameters);
    [manager POST:[NSString stringWithFormat:@"%@/%@",WLHTTP,@"/api/drivingMemberApply/update_driving_features_eat"] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
       [formData appendPartWithFileData:UIImageJPEGRepresentation(imageview1.image, 0.1) name:@"logo" fileName:@"logo.jpg" mimeType:@"image/jpg"];
        [formData appendPartWithFileData:UIImageJPEGRepresentation(imageview2.image, 0.1) name:@"business_licenses" fileName:@"business_licenses.jpg" mimeType:@"image/jpg"];
        [formData appendPartWithFileData:UIImageJPEGRepresentation(imageview3.image, 0.1) name:@"hygiene_licenses" fileName:@"hygiene_licenses.jpg" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *zxdDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        //UIAlertView *alertViewSuccess2= [[UIAlertView alloc] initWithTitle:@"上传成功" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
       // [alertViewSuccess2 show];
        self.zxdHud.labelText = zxdDict[@"msg"];
        self.zxdHud.hidden = YES;

        NSLog(@"上传结果++++%@",zxdDict[@"state"]);
        NSLog(@"上传++++%@",zxdDict[@"msg"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertViewFail2 = [[UIAlertView alloc] initWithTitle:@"上传失败" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertViewFail2 show];
               NSLog(@"%@", error);
    }];
//    [manager POST:zxdUpUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *zxdDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        
//        NSLog(@"%@",zxdDict[@"state"]);
//        NSLog(@"%@",zxdDict[@"msg"]);
//        //NSLog(@"+++++++%@",[[zxdDict[@"data"] objectAtIndex:0] objectForKey:@"state"]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
}

- (NSString*)arrayToJson:(NSArray *)arr {
   
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
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
@end
