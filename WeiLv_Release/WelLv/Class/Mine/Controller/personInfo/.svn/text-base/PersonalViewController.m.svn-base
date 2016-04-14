//
//  PersonalViewController.m
//  aa
//
//  Created by mac for csh on 15/4/13.
//  Copyright (c) 2015年 mac for csh. All rights reserved.
//

#import "PersonalViewController.h"
#import "LXUserTool.h"
#import "AFNetworking.h"
#import "GTMBase64.h"
#import "LXCommonTools.h"



@interface PersonalViewController ()
{
    NSString *sex;
    CGSize cellSize;
}

@end

@implementation PersonalViewController
@synthesize picke,pView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    self.view.backgroundColor = BgViewColor;
    [self.navigationItem setTitle:@"个人资料"];

    titles1 = [[NSArray alloc] initWithObjects:@"头像",@"姓名",@"手机号",@"邮箱",nil];
    titles2 = [[NSArray alloc] initWithObjects:@"性别",@"出生日期",@"证件",@"地址", nil];
    
    NSString *path=[NSHomeDirectory() stringByAppendingString:@"/Library/Preferences/com.WelLv100.WeiLv.WelLv.plist"];
    DLog(@"----%@",path);

}
-(void) viewWillAppear:(BOOL)animated{
    for(UIView * vie in [self.view subviews]){
        [vie removeFromSuperview];
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64) style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
  //  _tableView.contentSize = CGSizeMake(windowContentWidth,windowContentHeight+2000);
    [self.view addSubview:_tableView];
    
    UILabel *tsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 ,self.view.frame.size.width-50, 40)];
    tsLabel.text = @"提示:您的资料将被默认为第一游客信息，请您完整如实填写，避免资料不实带来的不便";
    tsLabel.textColor = kColor(93, 159, 255);
    tsLabel.font = [UIFont systemFontOfSize:14];
    tsLabel.numberOfLines = 0;
    tsLabel.textAlignment = NSTextAlignmentLeft;
    _tableView.tableFooterView = tsLabel;//把备注设为tableFooterView
    names = [NSArray arrayWithObjects:@"男",@"女",@"保密",nil];
    picke = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 30, [[UIScreen mainScreen] bounds].size.width, 100)];
    picke.backgroundColor = [UIColor whiteColor];
    picke.delegate = self; picke.dataSource =self;
    pView= [[UIView alloc] initWithFrame:CGRectMake(0, windowContentHeight-130-64, [[UIScreen mainScreen] bounds].size.width, 130)];
    pView.backgroundColor =[UIColor clearColor]; //[UIColor colorWithWhite:1 alpha:1];
    pView.hidden = YES;
    [pView addSubview:picke];
    [self.view addSubview:pView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0,0,windowContentWidth, 30);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    
    if (windowContentWidth==320) {
        btn.titleEdgeInsets=UIEdgeInsetsMake(0,0,0,-windowContentWidth/2-100);
    }else{
        btn.titleEdgeInsets=UIEdgeInsetsMake(0,0,0,-windowContentWidth/2-140);
    }
    //DLog(@"%f",windowContentWidth);
    
    //btn.titleLabel.font = [UIFont systemFontOfSize:<#(CGFloat)#>];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [pView addSubview:btn];

    NSString *realname = @"";
    NSString *phone = @"";
    NSString *email = @"";
    if ([[LXUserTool alloc] getRealname] && ! [[[LXUserTool alloc] getRealname] isEqual:[NSNull null]]) {
        realname = [[LXUserTool alloc] getRealname];
    }
    if ([[LXUserTool alloc] getPhone] && ! [[[LXUserTool alloc] getPhone] isEqual:[NSNull null]]) {
        phone = [[LXUserTool alloc] getPhone];
    }
    if ([[LXUserTool alloc] getEmail] && ! [[[LXUserTool alloc] getEmail] isEqual:[NSNull null]]) {
        email = [[LXUserTool alloc] getEmail];
    }
 
    values1 = [[NSMutableArray alloc] initWithObjects:@"",realname,phone,email, nil];
    
    sex = @"";
    if ([[LXUserTool alloc] getEmail] && ! [[[LXUserTool alloc] getEmail] isEqual:[NSNull null]]) {
        sex = [[LXUserTool alloc] getSex];
    }
    if ( !([sex isEqualToString:@"1"] || [sex isEqualToString:@"2"])) {
        sex = @"保密";
    }else if ([sex isEqualToString:@"1"]) {
        sex = @"男";
    }else if ([sex isEqualToString:@"2"]) {
        sex = @"女";
    }
    NSString *BornDay = @"";
    if ([[LXUserTool alloc] getBirthday] && ! [[[LXUserTool alloc] getBirthday] isEqual:[NSNull null]]) {
        BornDay = [[LXUserTool alloc] getBirthday];
    }
    NSString *IdType = [[LXUserTool alloc] getIdtype];
    if ([IdType isEqualToString: @"1"]) {
        IdType = @"身份证";
    }else if([IdType isEqualToString: @"2"]){
        IdType = @"护照";
    }else if([IdType isEqualToString: @"3"]){
        IdType = @"军官证";
    }else if([IdType isEqualToString: @"4"]){
        IdType = @"港澳通行证";
    } else if([IdType isEqualToString: @"5"]){
        IdType = @"台胞证";
    }
    if (!([IdType isEqualToString: @"身份证"] || [IdType isEqualToString: @"护照"] || [IdType isEqualToString: @"军官证"] ||[IdType isEqualToString: @"港澳通行证"] || [IdType isEqualToString: @"台胞证"] || [IdType isEqualToString: @"回乡证"] ||[IdType isEqualToString: @"户口簿"] || [IdType isEqualToString: @"出生证明"])) {
        IdType = @"暂无证件";
    }
    NSString *ID = [NSString stringWithFormat:@"%@",IdType] ;
    if ([[LXUserTool alloc] getIdnumber] && ![[[LXUserTool alloc] getIdnumber] isEqual:[NSNull null]]) {
        ID = [[IdType stringByAppendingString:@"\t\t\n"] stringByAppendingString:[[LXUserTool alloc] getIdnumber]];
    }
   
  //  NSLog(@"ID is %@",ID);
    NSString *address = @"";//[[LXUserTool alloc] getAddress];
    if ([[LXUserTool alloc] getAddress] && ! [[[LXUserTool alloc] getAddress] isEqual:[NSNull null]]) {
        address = [[LXUserTool alloc] getAddress];
    }
    
    values2 = [[NSMutableArray alloc] initWithObjects:sex,BornDay,ID,address, nil];
  //  NSLog(@"1 is %@",values1);
  //  NSLog(@"2 is %@",values2);
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*-(void)getHeadPhoto{
    UILabel *headPLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, [[UIScreen mainScreen] bounds].size.width-50, 60)];
    headPLabel.text = @"头像";
    headPLabel.backgroundColor = [UIColor whiteColor];
    headPLabel.textAlignment = NSTextAlignmentLeft;
    headPLabel.font = [UIFont systemFontOfSize:15];
    headPLabel.textColor = [UIColor grayColor];
    [_scrollView addSubview: headPLabel];
    
    NSString *imageName = [NSString stringWithFormat:@"%@",[[LXUserTool alloc] getAvater]];
    NSString *avater=@"";
    if ([imageName hasPrefix:@"http://"] ||[imageName hasPrefix:@"https://"])
    {
        avater = imageName;
    }else
    {
        avater= [WLHTTP stringByAppendingString:imageName];
    }
    NSLog(@"avter is %@",avater);
   headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-90, 0 , 60, 60)];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:avater] placeholderImage:[UIImage imageNamed:@"未登录头像"]];
    headImageView.userInteractionEnabled = YES;
    [_scrollView addSubview:headImageView];
    headImageView.backgroundColor = [UIColor blackColor];
  
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewTapClick:)];
    [headImageView addGestureRecognizer:tap];
    headImageView.layer.masksToBounds=YES;
    headImageView.layer.cornerRadius = 30;
    headImageView.layer.borderColor = [UIColor redColor].CGColor;
    headImageView.layer.borderWidth = 5.0f;
    if (![imageName isEqualToString:ISNULL]) {
    //    [self asyncLoadImage:avater];
    }

}*/

- (void)ViewTapClick:(UIGestureRecognizer *)tap{
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"更换图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    [actionsheet showInView:self.view];
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
        
        UIImage *image = [self imageWithImageSimple:editedImage scaledToSize:CGSizeMake(1000, 1000)];
        [self UpdatePhoto:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

//更新头像
- (void)UpdatePhoto:(UIImage *)imageFile
{
    NSString * memberStr = @"";
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember) {
        memberStr = @"member";
    } else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward) {
        memberStr = @"assistant";
    }
    
    NSData *data=UIImageJPEGRepresentation(imageFile, 0.1);
    //上传时使用当前的系统事件作为文件名
    NSDateFormatter *formatter = [[ NSDateFormatter alloc ] init ];
    formatter. dateFormat = @"yyyyMMddHHmmss" ;
    NSString *str = [formatter stringFromDate :[ NSDate date ]];
    NSString *fileName = [ NSString stringWithFormat : @"%@.jpg" , str];
    
    NSString *userId = [[LXUserTool alloc] getUid];
    NSDictionary *parment = @{@"uid":userId,
                              @"usergroup":memberStr};
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager POST:UpdatePhotoUrl parameters:parment constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:data name:@"image_file" fileName:fileName mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         if (responseObject != nil) {
             if ([[responseObject objectForKey:@"status"] isEqualToString:@"1"]) {
                 NSData *da = [[NSData alloc]initWithBase64EncodedString:[self imageTransToBase64String:imageFile] options:NSDataBase64DecodingIgnoreUnknownCharacters];
                 UIImage *image = [UIImage imageWithData:da];
                 headImageView.image = image;
                // _bgView.image = [image drn_boxblurImageWithBlur:10 transparency:20];
                 
                 [[NSUserDefaults standardUserDefaults] setObject:[responseObject objectForKey:@"avatar"] forKey:@"avater"];
                 //tong通知“我的”页面更新头像
                 NSNotification *notification = [NSNotification notificationWithName:UpdateImage object:nil];
                 [[NSNotificationCenter defaultCenter] postNotification:notification];
             }
             
         }
     }failure:^(AFHTTPRequestOperation *operation,NSError *error)
     {
         [[LXAlterView sharedMyTools] createTishi:@"修改图像失败！"];
     }];
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




/*

-(void)getPhoneNum{
   //初始化手机号label
    UILabel *phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, [[UIScreen mainScreen] bounds].size.width-50, 25)];
    phoneNumLabel.text = @"手机号";
    phoneNumLabel.backgroundColor = [UIColor clearColor];
    phoneNumLabel.textAlignment = NSTextAlignmentLeft;
    phoneNumLabel.font = [UIFont systemFontOfSize:15];
    phoneNumLabel.textColor = [UIColor grayColor];
    [_scrollView addSubview: phoneNumLabel];
    
    UIButton *phoneNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 25, [[UIScreen mainScreen] bounds].size.width-50, 35)];
    [phoneNumBtn setTitle:[[LXUserTool alloc] getPhone] forState:UIControlStateNormal];
    phoneNumBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    phoneNumBtn.tintColor = [UIColor blackColor];
    [phoneNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    phoneNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [phoneNumBtn addTarget:self action:@selector(changePhoneNum) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:phoneNumBtn];
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(25,60 , [[UIScreen mainScreen] bounds].size.width-50, 0.5)];
    label.layer.borderColor = [[UIColor grayColor] CGColor];
    label.layer.borderWidth = 0.5;
    [_scrollView addSubview:label];
    
}

-(void)getEmail{
    //邮箱
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 60, [[UIScreen mainScreen] bounds].size.width-50, 25)];
    emailLabel.text = @"邮箱";
    emailLabel.backgroundColor = [UIColor clearColor];
    emailLabel.textAlignment = NSTextAlignmentLeft;
    emailLabel.font = [UIFont systemFontOfSize:15];
    emailLabel.textColor = [UIColor grayColor];
    [_scrollView addSubview: emailLabel];
    
    UIButton *emailNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 25+60, [[UIScreen mainScreen] bounds].size.width-50, 35)];
    [emailNumBtn setTitle:[[LXUserTool alloc] getEmail] forState:UIControlStateNormal];
    emailNumBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    emailNumBtn.tintColor = [UIColor blackColor];
    [emailNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    emailNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [emailNumBtn addTarget:self action:@selector(changeEmail) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:emailNumBtn];
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(25,60*2 , [[UIScreen mainScreen] bounds].size.width-50, 0.5)];
    label.layer.borderColor = [[UIColor grayColor] CGColor];
    label.layer.borderWidth = 0.5;
    [_scrollView addSubview:label];

}

-(void)getName{
   //姓名
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 60*2, [[UIScreen mainScreen] bounds].size.width-50, 25)];
    nameLabel.text = @"姓名";
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor grayColor];
    [_scrollView addSubview: nameLabel];
    
    UIButton *nameNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 25+60*2, [[UIScreen mainScreen] bounds].size.width-50, 35)];
    [nameNumBtn setTitle:[[LXUserTool alloc] getRealname] forState:UIControlStateNormal];
    nameNumBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    nameNumBtn.tintColor = [UIColor blackColor];
    [nameNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    nameNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [nameNumBtn addTarget:self action:@selector(changeName) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:nameNumBtn];
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(25,60*3 , [[UIScreen mainScreen] bounds].size.width-50, 0.5)];
    label.layer.borderColor = [[UIColor grayColor] CGColor];
    label.layer.borderWidth = 0.5;
    [_scrollView addSubview:label];

}

-(void)getIdentificationNum{
   //证件号
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 60*3, [[UIScreen mainScreen] bounds].size.width-50, 25)];
    nameLabel.text = @"证件号";
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor grayColor];
    [_scrollView addSubview: nameLabel];

    
    UILabel *IdNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(25+50, 60*3+5, 60, 15)];
    NSString *str = [[LXUserTool alloc] getIdtype];
    NSLog(@"Idtype is %@",str);
    if ([str isEqualToString: @"1"]) {
        str = @"身份证";
    }else if([str isEqualToString: @"2"]){
        str = @"护照";
    }else if([str isEqualToString: @"3"]){
        str = @"军官证";
    }else if([str isEqualToString: @"4"]){
        str = @"港澳通行证";
    } else if([str isEqualToString: @"5"]){
        str = @"台胞证";
    }
     NSLog(@"Idtype is %@",str);
    if (!([str isEqualToString: @"身份证"] || [str isEqualToString: @"护照"] || [str isEqualToString: @"军官证"] ||[str isEqualToString: @"港澳通行证"] || [str isEqualToString: @"台胞证"] || [str isEqualToString: @"回乡证"] ||[str isEqualToString: @"户口簿"] || [str isEqualToString: @"出生证明"])) {
        str = @"暂无证件";
        IdNumLabel.backgroundColor = [UIColor grayColor];
    }else{
      //  str = [[LXUserTool alloc] getIdtype];
        IdNumLabel.backgroundColor = kColor(225, 146, 20);
    }
   // UILabel *IdNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 60*3, [[UIScreen mainScreen] bounds].size.width-50, 25)];
    IdNumLabel.text = str;
    //IdNumLabel.backgroundColor = [UIColor clearColor];
    IdNumLabel.textAlignment = NSTextAlignmentCenter;
    IdNumLabel.font = [UIFont systemFontOfSize:11];
    IdNumLabel.textColor = [UIColor whiteColor];
    [_scrollView addSubview: IdNumLabel];
    
    UIButton *idNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 25+60*3, [[UIScreen mainScreen] bounds].size.width-50, 35)];
    [idNumBtn setTitle:[[LXUserTool alloc] getIdnumber] forState:UIControlStateNormal];
    idNumBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    idNumBtn.tintColor = [UIColor blackColor];
    [idNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    idNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [idNumBtn addTarget:self action:@selector(changeIdentificationNum) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:idNumBtn];
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(25,60*4 , [[UIScreen mainScreen] bounds].size.width-50, 0.5)];
    label.layer.borderColor = [[UIColor grayColor] CGColor];
    label.layer.borderWidth = 0.5;
    [_scrollView addSubview:label];
    
}
-(void)getAdress{
    //地址
    UILabel *IdNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 60*4, [[UIScreen mainScreen] bounds].size.width-50, 25)];
    IdNumLabel.text = @"地址";
    IdNumLabel.backgroundColor = [UIColor clearColor];
    IdNumLabel.textAlignment = NSTextAlignmentLeft;
    IdNumLabel.font = [UIFont systemFontOfSize:15];
    IdNumLabel.textColor = [UIColor grayColor];
    [_scrollView addSubview: IdNumLabel];
    
    UIButton *idNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 25+60*4, [[UIScreen mainScreen] bounds].size.width-50, 35+10)];
    [idNumBtn setTitle:[[LXUserTool alloc] getAddress] forState:UIControlStateNormal];
    idNumBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    idNumBtn.tintColor = [UIColor blackColor];
    [idNumBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    idNumBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [idNumBtn addTarget:self action:@selector(changeAdress) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:idNumBtn];
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(25,60*5+10 , [[UIScreen mainScreen] bounds].size.width-50, 0.5)];
    label.layer.borderColor = [[UIColor grayColor] CGColor];
    label.layer.borderWidth = 0.5;
    [_scrollView addSubview:label];
    
}

-(void)getSex{
    //性别
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 60*5+10, [[UIScreen mainScreen] bounds].size.width-50, 25)];
    sexLabel.text = @"性别";
    sexLabel.backgroundColor = [UIColor clearColor];
    sexLabel.textAlignment = NSTextAlignmentLeft;
    sexLabel.font = [UIFont systemFontOfSize:15];
    sexLabel.textColor = [UIColor grayColor];
    [_scrollView addSubview: sexLabel];
    
    NSString *str = [[LXUserTool alloc] getSex];
    if ( !([str isEqualToString:@"1"] || [str isEqualToString:@"2"])) {
         str = @"保密";
    }else if ([str isEqualToString:@"1"]) {
        str = @"男";
    }else if ([str isEqualToString:@"2"]) {
        str = @"女";
    }

    sexBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 25+60*5+10, [[UIScreen mainScreen] bounds].size.width-50, 35)];
    [sexBtn setTitle:str forState:UIControlStateNormal];
    sexBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    sexBtn.tintColor = [UIColor blackColor];
    [sexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sexBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [sexBtn addTarget:self action:@selector(changeSex) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:sexBtn];
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(25,60*6+10 , [[UIScreen mainScreen] bounds].size.width-50, 0.5)];
    label.layer.borderColor = [[UIColor grayColor] CGColor];
    label.layer.borderWidth = 0.5;
    [_scrollView addSubview:label];
}

-(void)getBornDay{
    //出生日期
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 60*6+10, [[UIScreen mainScreen] bounds].size.width-50, 25)];
    sexLabel.text = @"出生日期";
    sexLabel.backgroundColor = [UIColor clearColor];
    sexLabel.textAlignment = NSTextAlignmentLeft;
    sexLabel.font = [UIFont systemFontOfSize:15];
    sexLabel.textColor = [UIColor grayColor];
    [_scrollView addSubview: sexLabel];
    
    UIButton *bornDayBtn = [[UIButton alloc]initWithFrame:CGRectMake(25, 25+60*6+10, [[UIScreen mainScreen] bounds].size.width-50, 35)];
    [bornDayBtn setTitle:[[LXUserTool alloc] getBirthday] forState:UIControlStateNormal];
    bornDayBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    bornDayBtn.tintColor = [UIColor blackColor];
    [bornDayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bornDayBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bornDayBtn addTarget:self action:@selector(changeBornDay) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:bornDayBtn];
    
    UILabel* label = [[UILabel alloc] initWithFrame: CGRectMake(25,60*7+10 , [[UIScreen mainScreen] bounds].size.width-50, 0.5)];
    label.layer.borderColor = [[UIColor grayColor] CGColor];
    label.layer.borderWidth = 0.5;
    [_scrollView addSubview:label];
    

    _scrollView.contentSize= CGSizeMake(windowContentWidth, ViewY(label)+ViewHeight(label)+300);
}
*/

-(void)getBack{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)changePhoneNum{
   // NSLog(@"跳转修改手机号");
    changePhoneNumViewController *view1 = [[changePhoneNumViewController alloc] init];
    [self.navigationController pushViewController:view1 animated:YES];

}

-(void)changeEmail{
   // NSLog(@"跳转修改邮箱");
    changeEmailViewController *view1 = [[changeEmailViewController alloc] init];
    [self.navigationController pushViewController:view1 animated:YES];
}

-(void)changeName{
    //NSLog(@"跳转修改姓名");
    changeNameViewController *view1 = [[changeNameViewController alloc] init];
    [self.navigationController pushViewController:view1 animated:YES];
}

-(void)changeIdentificationNum{
    //NSLog(@"跳转修改证件号");
    changeIDNumViewController *view1 = [[changeIDNumViewController alloc] init];
    [self.navigationController pushViewController:view1 animated:YES];
    
}

-(void)changeAdress{
   // NSLog(@"跳转修改地址");
    changeAdressViewController *view1 = [[changeAdressViewController alloc] init];
    [self.navigationController pushViewController:view1 animated:YES];
}

-(void)changeSex{
    //NSLog(@"跳转修改性别");

   
      //  _tableView.contentSize = CGSizeMake(windowContentWidth,windowContentHeight+200);
       // _tableView.contentOffset = CGPointMake(0, 200);
       // [self loadPickerView];
    if (pView && pView.hidden == NO) {
        pView.hidden = YES;
         _tableView.contentOffset = CGPointMake(0, 0);
    }else if (pView && pView.hidden == YES){
      //  _tableView.contentSize = CGSizeMake(windowContentWidth,windowContentHeight+200);
        _tableView.contentOffset = CGPointMake(0, 200);
        pView.hidden = NO;
    }
}

-(void)changeBornDay{
   // NSLog(@"跳转修改出生日期");
    changeBirDayViewController *view1 = [[changeBirDayViewController alloc] init];
    [self.navigationController pushViewController:view1 animated:YES];
}

-(void)loadPickerView{
   
    if ([sex isEqualToString:@"男"]) {
        [picke selectRow:0 inComponent:0 animated:NO];
    }else if ([sex isEqualToString:@"女"]) {
        [picke selectRow:1 inComponent:0 animated:NO];
    }else if ([sex isEqualToString:@"保密"]) {
        [picke selectRow:2 inComponent:0 animated:NO];
    }else if ([sex isEqualToString:@"未知"]){
        [picke selectRow:2 inComponent:0 animated:NO];
       // [sexBtn setTitle:@"保密" forState:UIControlStateNormal];
    }
  
    
   
}

-(void )setting{
    pView.hidden = YES;
    
    //上传服务器
    NSString* sexInterage = @"0";
    if ([sex isEqualToString:@"男"]) {
        sexInterage = @"1";
    }else if([sex isEqualToString:@"女"]){
        sexInterage = @"2";
    }/*else if([sexBtn.titleLabel.text isEqualToString:@"保密"]){
        sex = @"3";
    }*/
   
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"uid":[[LXUserTool alloc] getUid],@"sex":sexInterage};
    
    [manager POST:UpdateUserInfo parameters:parameters
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              if ([dict objectForKey:@"status"]) {
                   NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
                  [settings setObject: sexInterage forKey:@"sex"];
                  [[LXAlterView sharedMyTools] createTishi:@"性别修改成功"];
                  [self viewWillAppear:YES];
                  [self.view addSubview:pView];
                  [_tableView reloadData];
              }else{
                  [[LXAlterView sharedMyTools] createTishi:@"性别修改失败，请检查网络"];
              }
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];

}

#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 2)) {
        return 72;
    }else if (indexPath.section==1&&indexPath.row==3)
    {
        if (cellSize.height<=45) {
            return 45;
        }else{
        return cellSize.height;
           
        }
    }else{
    return 45;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    /*if (section ==1 ) {
        return 100;
    }*/
    return 7;
}
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = [NSString stringWithFormat:@"Header Section NO %ld",section+1];
    return ;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *title = [NSString stringWithFormat:@"Footer Section NO %ld",section+1];
    return title;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 0)];
    [sectionView setBackgroundColor:[UIColor redColor]];
        sectionView.alpha = 0.1;
    return sectionView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 80)];
    [sectionView setBackgroundColor:[UIColor redColor]];
   if (section ==0) {
        sectionView.alpha = 0.5;
    }
    return sectionView;
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifie = @"cellIdentifie";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifie];
   
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifie];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (indexPath.section == 0) {
        cell.textLabel.text = [titles1 objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [[NSString stringWithFormat:@"%@",[values1 objectAtIndex:indexPath.row]] stringByAppendingString:@"\t\t"];
    }else if(indexPath.section == 1 ){
        cell.textLabel.text = [titles2 objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [[NSString stringWithFormat:@"%@",[values2 objectAtIndex:indexPath.row]] stringByAppendingString:@"\t\t"];
        [cell.detailTextLabel setFrame:CGRectMake(0, 0, cellSize.width, cellSize.height)];
       
    }
    if ((indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 2)) {
        if (indexPath.section == 1 && indexPath.row == 2) {
            cell.detailTextLabel.numberOfLines = 0;
        }
        UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, 16+6.67, 40, 26.7)];
        [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [cell addSubview:IGV];
    }else{
        UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - 40, 2.5+6.67, 40, 26.7)];
        [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
        [cell addSubview:IGV];
    }
    cell.textLabel.textColor= kColor(111, 115, 120);
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;

//头像
    if (indexPath.section == 0 && indexPath.row == 0) {
        NSString *imageName = [NSString stringWithFormat:@"%@",[[LXUserTool alloc] getAvater]];
        NSString *avater=@"";
        if ([imageName hasPrefix:@"http://"] ||[imageName hasPrefix:@"https://"])
        {
            avater = imageName;
        }else
        {
            avater= [WLHTTP stringByAppendingString:imageName];
        }
    //    NSLog(@"avter is %@",avater);
        headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-105, 6 , 60, 60)];
        [headImageView sd_setImageWithURL:[NSURL URLWithString:avater] placeholderImage:[UIImage imageNamed:@"未登录头像"]];
        headImageView.userInteractionEnabled = YES;
        [cell addSubview:headImageView];
        headImageView.backgroundColor = [UIColor blackColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewTapClick:)];
        [headImageView addGestureRecognizer:tap];
        headImageView.layer.masksToBounds=YES;
        headImageView.layer.cornerRadius = 30;
    }
    
    if (indexPath.section == 1 && indexPath.row == 3) {
        cell.detailTextLabel.numberOfLines = 0;
      
        //cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        //[cell.detailTextLabel sizeToFit];
        //[cell.textLabel sizeToFit];
        //[cell sizeToFit];
        
        cellSize=[self sizeWithString:cell.detailTextLabel.text font:systemFont(15)];
      
    }
    return cell;
}
// 定义成方法方便多个label调用 增加代码的复用性
- (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(windowContentWidth-120, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

//点击某一行时候触发的事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
                [self changeName];
                break;
            case 2:
                [self changePhoneNum];
                break;
            case 3:
                [self changeEmail];
                break;
            default:
                break;
        }
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                [self changeSex];
                break;
            case 1:
                [self changeBornDay];
                break;
            case 2:
                [self changeIdentificationNum];
                break;
            case 3:
                [self changeAdress];
                break;
                
            default:
                break;
        }

    }
        
        
}



#pragma mark -
#pragma mark UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *v=[[UIView alloc]
               initWithFrame:CGRectMake(0,0,
                                        [self pickerView:pickerView widthForComponent:component],
                                        [self pickerView:pickerView rowHeightForComponent:component])];
    [v setOpaque:TRUE];
    [v setBackgroundColor:[UIColor clearColor]];
    UILabel *lbl=nil;
    lbl= [[UILabel alloc]
          initWithFrame:CGRectMake(8,0,
                                   [self pickerView:pickerView widthForComponent:component]-16,
                                   [self pickerView:pickerView rowHeightForComponent:component])];
    lbl.textAlignment = NSTextAlignmentCenter;
    [lbl setBackgroundColor:[UIColor clearColor]];
    NSString *ret=@"";
    
    switch (component) {
        case 0:
            ret=[names objectAtIndex:row];
            break;
        }
    [lbl setText:ret];
    [lbl setFont:[UIFont boldSystemFontOfSize:18]];
    [v addSubview:lbl];
    return v;
  
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == 0) {
        sex = @"男";
    }else if(row == 1){
        sex = @"女";
    }else if(row == 2){
        sex = @"保密";
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 200;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 25;
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}



@end
