//
// GuanJiaSelfInfoViewController.m
//  WelLv
//
//  Created by mac for csh on 15/5/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "GuanJiaSelfInfoViewController.h"
#import "LXGetCityIDTool.h"
#import "GTMBase64.h"
#import "TextFieldViewController.h"
#import "ChangeBornDayViewController.h"
#import "ChangHhoroscopeViewController.h"
#import "ChangEducationalViewController.h"

#define Y_height 15
#define cell_height 45
#define Right_width 40
#define Right_Height 26.7
#define beginx 120


@interface GuanJiaSelfInfoViewController ()
{
    UIScrollView *_scrollView;
    
    UIView *sexView;
    UIPickerView *picker;
    NSString *sexInteger;
    NSArray *names;
    UIButton *headImagebutton;
}
@end

@implementation GuanJiaSelfInfoViewController
@synthesize infoDivtionary;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   self.navigationItem.title = @"个人资料";
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor = BgViewColor;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    NSString* path = [NSHomeDirectory() stringByAppendingString:@"/Library/Preferences/com.WelLv100.WeiLv.WelLv.plist"];
    NSLog(@"----%@",path);

    //touch miss kyboard
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [_scrollView addGestureRecognizer:tapGestureRecognizer];

}

-(void)viewWillAppear:(BOOL)animated{
    for (UIView *detailView in [_scrollView subviews]) {
        [detailView removeFromSuperview];
    }
    infoDivtionary =[[NSMutableDictionary alloc]init];
    infoDivtionary =  [[[NSUserDefaults standardUserDefaults] objectForKey:AssitantData] mutableCopy];
    NSLog(@"indictionary is %@",infoDivtionary);
    
    infodic = [[NSDictionary alloc] init];
    sexInteger = @"";
    if ([infoDivtionary objectForKey:@"gender"] && ! [[infoDivtionary objectForKey:@"gender"] isEqual:[NSNull null]]) {
        sexInteger = [infoDivtionary objectForKey:@"gender"] ;
    }
   
    
    [self initView];
    [self initHomeTown];
    [self initSex];
    [self initQQ];
    [self initEmail];
    [self initBornDay];
    [self initHoroscope];
    [self initEducational];
    [self initOccupation];
    [self initRegion];
}

-(void)initView{
//不可编辑信息
    NSArray *arr1 = @[@"    姓名",@"    手机号"];
    NSArray *arr2 = @[[infoDivtionary objectForKey:@"name"],[infoDivtionary objectForKey:@"mobile"]];
    for (int i = 0; i< arr1.count; i ++ ) {
        UILabel *lab1 = [YXTools allocLabel:[arr1 objectAtIndex:i] font:systemFont(16) textColor:[UIColor grayColor] frame:CGRectMake(0, Y_height + cell_height*i, ViewWidth(_scrollView), cell_height) textAlignment:0];
        lab1.backgroundColor = [UIColor whiteColor];
        [_scrollView addSubview:lab1];
        
        UILabel * lab2  = [YXTools allocLabel:[arr2 objectAtIndex:i] font:systemFont(16) textColor:[UIColor blackColor] frame:CGRectMake(0, Y_height+cell_height*i, ViewWidth(_scrollView) - Right_width/2, cell_height) textAlignment:2];
        lab2.backgroundColor = [UIColor clearColor];
        [_scrollView addSubview:lab2];
        if (i == 0) {
            UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, Y_height + cell_height - 0.35, windowContentHeight, 0.35)];
            vvv.backgroundColor = kColor(212, 212, 212);
            [_scrollView addSubview:vvv];
        }

    }
//可编辑信息
    NSArray *leftTitleArray =@[@"    头像",@"    籍贯",@"    性别",@"    QQ",@"    邮箱",@"    出生日期",@"    星座",@"    学历",@"    职业",@"    居住地"];
    for (int i = 0; i< leftTitleArray.count; i ++ ) {
        if(i == 0){
            UILabel *lab3 = [YXTools allocLabel:[leftTitleArray objectAtIndex:i] font:systemFont(16) textColor:[UIColor grayColor] frame:CGRectMake(0,Y_height+ cell_height*2 + Y_height +cell_height*i, ViewWidth(_scrollView), 72) textAlignment:0];
            lab3.backgroundColor = [UIColor whiteColor];
            [_scrollView addSubview:lab3];
            UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, Y_height*2 + cell_height*2 + 72- 0.35, windowContentHeight, 0.35)];
            vvv.backgroundColor = [UIColor lightGrayColor];
            [_scrollView addSubview:vvv];
        }else{
            UILabel *lab4 = [YXTools allocLabel:[leftTitleArray objectAtIndex:i] font:systemFont(16) textColor:[UIColor grayColor] frame:CGRectMake(0,Y_height*2 + cell_height*2 + 72 + cell_height*(i - 1), ViewWidth(_scrollView), cell_height) textAlignment:0];
            lab4.backgroundColor = [UIColor whiteColor];
            [_scrollView addSubview:lab4];
            
            if (i != leftTitleArray.count -1) {
                UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, Y_height*2 + cell_height*2 + 72 + cell_height*i- 0.35, windowContentHeight, 0.35)];
                vvv.backgroundColor = kColor(212, 212, 212);
                [_scrollView addSubview:vvv];
            }

        }
    }
     _scrollView.contentSize= CGSizeMake(windowContentWidth,Y_height+ cell_height*2 + Y_height +cell_height*leftTitleArray.count + windowContentHeight*0.7);
    
    [self initHeadPhoto];
}

-(void)initHeadPhoto{
    //头像
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
    if (headImageView) {
        [headImageView removeFromSuperview];
        headImageView = nil;
    }
    if (headImagebutton) {
        [headImagebutton removeFromSuperview];
        headImagebutton = nil;
    }
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-90,Y_height*2 + cell_height*2 + 6 , 60, 60)];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:avater] placeholderImage:[UIImage imageNamed:@"未登录头像"]];
    headImageView.userInteractionEnabled = YES;
    [_scrollView addSubview:headImageView];
    headImageView.backgroundColor = [UIColor blackColor];
    
     headImagebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    headImagebutton.backgroundColor = [UIColor clearColor];
    headImagebutton.frame = CGRectMake(windowContentWidth-90,Y_height*2 + cell_height*2 + 6 , 60, 60);
    [headImagebutton addTarget:self action:@selector(changeHeadPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:headImagebutton];
    headImageView.layer.masksToBounds=YES;
    headImageView.layer.cornerRadius = 30;
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth - Right_width, ViewY(headImageView)+ViewHeight(headImageView)/2-Right_Height/2, Right_width , Right_Height)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [_scrollView addSubview:IGV];
}

- (void)changeHeadPhoto{
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
#pragma mark ------------ImagePickerCOntroller -----End


//籍贯
-(void)initHomeTown{
    NSString *string = @"";
    if ([infoDivtionary objectForKey:@"native_place"] && ![[infoDivtionary objectForKey:@"native_place"]isEqual:[NSNull null]] && ![[infoDivtionary objectForKey:@"native_place"] isEqualToString:@"(null)"]) {
            string = [infoDivtionary objectForKey:@"native_place"];
    }
  
    UIButton *hometownBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Y_height*2 + cell_height*2 + 72, ViewWidth(_scrollView), cell_height)];
    [hometownBtn addTarget:self action:@selector(changeHomeTown) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:hometownBtn];
    hometownLbl = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, 0, ViewWidth(hometownBtn) - Begin_X - Right_width, ViewHeight(hometownBtn))];
    hometownLbl.text = string;
    hometownLbl.textAlignment = NSTextAlignmentRight;
    [hometownBtn addSubview:hometownLbl];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(hometownBtn) - Right_width, ViewHeight(hometownBtn)/2-Right_Height/2, Right_width, Right_Height)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [hometownBtn addSubview:IGV];
}

-(void)changeHomeTown{
    TextFieldViewController *teVC = [[TextFieldViewController alloc] init];
    teVC.title = @"修改籍贯";
    teVC.textt = hometownLbl.text;
    [self.navigationController pushViewController:teVC animated:YES];
}

//性别
-(void)initSex{
    NSString *string = @"保密";
    if ([sexInteger integerValue] == 1) {
        string = @"男";
    }else if([sexInteger integerValue] == 2){
        string = @"女";
    }
    
    UIButton *sexBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Y_height*2 + cell_height*3 + 72, ViewWidth(_scrollView), cell_height)];
    [sexBtn addTarget:self action:@selector(changeSex) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:sexBtn];
    sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, 0, ViewWidth(sexBtn) - Begin_X - Right_width, ViewHeight(sexBtn))];
    sexLabel.text = string;
    sexLabel.textAlignment = NSTextAlignmentRight;
    [sexBtn addSubview:sexLabel];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(sexBtn) - Right_width, ViewHeight(sexBtn)/2-Right_Height/2, Right_width, Right_Height)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [sexBtn addSubview:IGV];
}

-(void)changeSex{
    if (!sexView) {
        [self loadPickerView];
    }else if (sexView && sexView.hidden == NO) {
        sexView.hidden = YES;
    }else if (sexView && sexView.hidden == YES){
        sexView.hidden = NO;
    }

}

-(void)loadPickerView{
    names = [NSArray arrayWithObjects:@"男",@"女",@"保密",nil];
    picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, windowContentHeight-64 -75, [[UIScreen mainScreen] bounds].size.width, 75)];
    picker.backgroundColor = [UIColor whiteColor];
    picker.delegate = self; picker.dataSource =self;
    sexView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentHeight , windowContentHeight-64)];
    sexView.backgroundColor =[UIColor colorWithWhite:0.3 alpha:0.8]; //[UIColor colorWithWhite:1 alpha:1];
    sexView.hidden = NO;
    [sexView addSubview:picker];
    [self.view addSubview:sexView];
    if ([sexLabel.text isEqualToString:@"男"]) {
        [picker selectRow:0 inComponent:0 animated:NO];
    }else if ([sexLabel.text isEqualToString:@"女"]) {
        [picker selectRow:1 inComponent:0 animated:NO];
    }else if ([sexLabel.text isEqualToString:@"保密"]) {
        [picker selectRow:2 inComponent:0 animated:NO];
    }else if ([sexLabel.text isEqualToString:@"未知"]){
        [picker selectRow:2 inComponent:0 animated:NO];
    }
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, windowContentHeight-64 -75 -25, [[UIScreen mainScreen] bounds].size.width, 25)];
    lb.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    [sexView addSubview:lb];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame= CGRectMake(windowContentWidth -45, windowContentHeight-64 -75 -25, 45, 25);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(setting) forControlEvents:UIControlEventTouchUpInside];
    [sexView addSubview:btn];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [sexView addGestureRecognizer:tapGestureRecognizer];

}

-(void )setting{
    sexView.hidden = YES;
    infodic = @{@"gender":sexInteger};
    [self conserve];
    
}


//QQ
-(void)initQQ{
    NSString *string = [infoDivtionary objectForKey:@"qq"];
    if ([string isEqualToString:@"(null)"]) {
        string = @"";
    }
    UIButton *QQBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Y_height*2 + cell_height*4 + 72, ViewWidth(_scrollView), cell_height)];
    [QQBtn addTarget:self action:@selector(changeQQ) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:QQBtn];
    QQLabel = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, 0, ViewWidth(QQBtn) - Begin_X - Right_width, ViewHeight(QQBtn))];
    QQLabel.text = string;
    QQLabel.textAlignment = NSTextAlignmentRight;
    [QQBtn addSubview:QQLabel];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(QQBtn) - Right_width, ViewHeight(QQBtn)/2-Right_Height/2, Right_width, Right_Height)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [QQBtn addSubview:IGV];

}

-(void)changeQQ{
    TextFieldViewController *teVC = [[TextFieldViewController alloc] init];
    teVC.title = @"修改QQ";
    teVC.textt = QQLabel.text;
    [self.navigationController pushViewController:teVC animated:YES];
}

//邮箱
-(void)initEmail{
    NSString *string = [infoDivtionary objectForKey:@"email"];
    if ([string isEqualToString:@"(null)"]) {
        string = @"";
    }
    
    UIButton *emailBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Y_height*2 + cell_height*5 + 72, ViewWidth(_scrollView), cell_height)];
    [emailBtn addTarget:self action:@selector(changeEmail) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:emailBtn];
    emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, 0, ViewWidth(emailBtn) - Begin_X - Right_width, ViewHeight(emailBtn))];
    emailLabel.text = string;
    emailLabel.textAlignment = NSTextAlignmentRight;
    [emailBtn addSubview:emailLabel];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(emailBtn) - Right_width, ViewHeight(emailBtn)/2-Right_Height/2, Right_width, Right_Height)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [emailBtn addSubview:IGV];
}

-(void)changeEmail{
    TextFieldViewController *teVC = [[TextFieldViewController alloc] init];
    teVC.title = @"修改邮箱";
    teVC.textt = emailLabel.text;
    [self.navigationController pushViewController:teVC animated:YES];
}

//出生日期
-(void)initBornDay{
    NSString *string = [infoDivtionary objectForKey:@"birth_date"];
    if ([string isEqualToString:@"(null)"]) {
        string = @"";
    }
    UIButton *bornDayBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Y_height*2 + cell_height*6 + 72, ViewWidth(_scrollView), cell_height)];
    [bornDayBtn addTarget:self action:@selector(changeBornDay) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:bornDayBtn];
    bornDayLabel = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, 0, ViewWidth(bornDayBtn) - Begin_X - Right_width, ViewHeight(bornDayBtn))];
    bornDayLabel.text = string;
    bornDayLabel.textAlignment = NSTextAlignmentRight;
    [bornDayBtn addSubview:bornDayLabel];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(bornDayBtn) - Right_width, ViewHeight(bornDayBtn)/2-Right_Height/2, Right_width, Right_Height)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [bornDayBtn addSubview:IGV];

}

-(void)changeBornDay{
    ChangeBornDayViewController *teVC = [[ChangeBornDayViewController alloc] init];
    teVC.title = @"修改出生日期";

    [self.navigationController pushViewController:teVC animated:YES];
}



/*
 水瓶座	01月21日─02月19日	创意、智慧 反叛、冷漠	双子座与天秤座	空气	黑	Aquarius
 双鱼座	02月20日─03月20日	浪漫、善解人意 粗心、意志薄弱	巨蟹座与天蝎座	水	蓝	Pisces
 白羊座	03月21日─04月20日	积极、直率 自我、没有耐性	狮子座与射手座	火	红	Aries
 金牛座	04月21日─05月21日	可靠、有耐心 贪婪、古板	处女座与摩羯座	土	绿	Taurus
 双子座	05月22日─06月21日	机智、适应力强 善变、不安份	天秤座与水瓶座	空气	黄	Gemini
 巨蟹座	06月22日─07月23日	真挚、有包容力 不理性、多愁善感	天蝎座与双鱼座	水	白	Cancer
 狮子座	07月24日─08月23日	热心、有领导能力 武断、自以为是	牧羊座与射手座	火	橙	Leo
 处女座	08月24日─09月23日	头脑清晰、完美主义 保守、吹毛求疵	金牛座与摩羯座	土	灰	Virgo
 天秤座	09月24日─10月23日	和谐、平易近人 轻浮、优柔寡断	双子座与水瓶座	空气	淡红	Libra
 天蝎座	10月24日─11月22日	果然、实际 多疑、狂妄	巨蟹座与双鱼座	水	深红	Scorpio
 射手座	11月23日─12月22日	活泼、思想开明 粗心、反覆无常	狮子座与牧羊座	火	紫红	Sagittarius
 摩羯座	12月23日─01月22日	有原则、家庭观念 太现实、缺乏热情	处女座与金牛座	土	黑	Capricorn
 */

//星座
-(void)initHoroscope{
    NSArray *consArray = @[@"",@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座"];
    NSString *string = @"";
    if (![[infoDivtionary objectForKey:@"horoscope"] isEqualToString:@"(null)"]) {
         string = [consArray objectAtIndex:[[infoDivtionary objectForKey:@"horoscope"] integerValue]];
    }
    UIButton *horoscopeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Y_height*2 + cell_height*7 + 72, ViewWidth(_scrollView), cell_height)];
    [horoscopeBtn addTarget:self action:@selector(changeHoroscope) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:horoscopeBtn];
    horoscopeLabel = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, 0, ViewWidth(horoscopeBtn) - Begin_X - Right_width, ViewHeight(horoscopeBtn))];
    horoscopeLabel.text = string;
    horoscopeLabel.textAlignment = NSTextAlignmentRight;
    [horoscopeBtn addSubview:horoscopeLabel];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(horoscopeBtn) - Right_width, ViewHeight(horoscopeBtn)/2-Right_Height/2, Right_width, Right_Height)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [horoscopeBtn addSubview:IGV];
}

-(void)changeHoroscope{
    ChangHhoroscopeViewController *teVC = [[ChangHhoroscopeViewController alloc] init];
    teVC.title = @"修改星座";
    [self.navigationController pushViewController:teVC animated:YES];
}

//学历
-(void)initEducational{
    NSString *string = [infoDivtionary objectForKey:@"education_background"];
    if ([string isEqualToString:@"(null)"]) {
        string = @"";
    }
    UIButton *ducationalBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Y_height*2 + cell_height*8 + 72, ViewWidth(_scrollView), cell_height)];
    [ducationalBtn addTarget:self action:@selector(changeducational) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:ducationalBtn];
    educationalLabel = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, 0, ViewWidth(ducationalBtn) - Begin_X - Right_width, ViewHeight(ducationalBtn))];
    educationalLabel.text = string;
    educationalLabel.textAlignment = NSTextAlignmentRight;
    [ducationalBtn addSubview:educationalLabel];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(ducationalBtn) - Right_width, ViewHeight(ducationalBtn)/2-Right_Height/2, Right_width, Right_Height)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [ducationalBtn addSubview:IGV];
}

-(void)changeducational{
    ChangEducationalViewController *teVC = [[ChangEducationalViewController alloc] init];
    teVC.title = @"修改学历";
    teVC.eduString = educationalLabel.text;
    [self.navigationController pushViewController:teVC animated:YES];
}


//职业
-(void)initOccupation{
    NSString *string = [infoDivtionary objectForKey:@"occupation"];
    if ([string isEqualToString:@"(null)"]) {
        string = @"";
    }
    UIButton *occupationBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Y_height*2 + cell_height*9 + 72, ViewWidth(_scrollView), cell_height)];
    [occupationBtn addTarget:self action:@selector(changeoccupation) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:occupationBtn];
    occupationLabel = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, 0, ViewWidth(occupationBtn) - Begin_X - Right_width, ViewHeight(occupationBtn))];
    occupationLabel.text = string;
    occupationLabel.textAlignment = NSTextAlignmentRight;
    [occupationBtn addSubview:occupationLabel];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(occupationBtn) - Right_width, ViewHeight(occupationBtn)/2-Right_Height/2, Right_width, Right_Height)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [occupationBtn addSubview:IGV];

}

-(void)changeoccupation{
    TextFieldViewController *teVC = [[TextFieldViewController alloc] init];
    teVC.title = @"修改职业";
    teVC.textt = occupationLabel.text;
    [self.navigationController pushViewController:teVC animated:YES];
}

//居住地
-(void)initRegion{
    NSString* string =[infoDivtionary objectForKey:@"region"];
    for (int i = 0; i < 3; i ++) {
        if ([string containsString:@" - "]) {
            NSRange range = [string rangeOfString:@" - "];//匹配得到的下标
            NSLog(@"rang.location:%ld",(long)range.location);
            string = [string substringFromIndex:range.location+3];//截取范围类的字符串
           // NSLog(@"截取的值为：%@",string);
        }
    }
    
    UIButton *regionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, Y_height*2 + cell_height*10 + 72, ViewWidth(_scrollView), cell_height)];
    [regionBtn addTarget:self action:@selector(changeregion) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:regionBtn];
    regionLabel = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X, 0, ViewWidth(regionBtn) - Begin_X - Right_width, ViewHeight(regionBtn))];
    regionLabel.text = string;
    regionLabel.textAlignment = NSTextAlignmentRight;
    [regionBtn addSubview:regionLabel];
    UIImageView *IGV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(regionBtn) - Right_width, ViewHeight(regionBtn)/2-Right_Height/2, Right_width, Right_Height)];
    [IGV setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [regionBtn addSubview:IGV];
}

-(void)changeregion{
    TextFieldViewController *teVC = [[TextFieldViewController alloc] init];
    teVC.title = @"修改居住地";
    teVC.textt = regionLabel.text;
    [self.navigationController pushViewController:teVC animated:YES];
}




//保存
-(void)conserve{
    //1、上传服务器
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"assistant_id":[infoDivtionary objectForKey:@"id"],@"data":[self dictionaryToJson:infodic]};
    [manager POST:GJManageSelfInfoUrl parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              if([[dict objectForKey:@"status"]integerValue] == 1){
                  [[LXAlterView sharedMyTools] createTishi:@"操作成功"];
                  // 2、cun 村本地
                  [infoDivtionary setValue:sexInteger forKey:@"gender"];
                 /* [infoDivtionary setValue:string1 forKey:@"gender"];
                  [infoDivtionary setValue:QQTextFd.text forKey:@"qq"];
                  [infoDivtionary setValue:emailTextFd.text forKey:@"email"];
                  [infoDivtionary setValue:birthDateBtn.titleLabel.text forKey:@"birth_date"];
                  [infoDivtionary setValue:string2 forKey:@"horoscope"];
                  [infoDivtionary setValue:string3 forKey:@"education_background"];
                  [infoDivtionary setValue:occupationTextFd.text forKey:@"occupation"];
                  [infoDivtionary setValue:city_regionID forKey:@"region_id"];*/
                  
                  [[NSUserDefaults standardUserDefaults] setObject:infoDivtionary forKey:AssitantData];
                  //3、修改成功刷新数据
                  [self viewWillAppear:YES];
              }else{
                 [[LXAlterView sharedMyTools] createTishi:@"修改失败"];
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];

}

//字典数据转Json
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


//手势keybooardMIss
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    sexView.hidden =YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
        sexInteger = @"1";
    }else if(row == 1){
       sexInteger = @"2";
    }else if(row == 2){
        sexInteger = @"0";
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
