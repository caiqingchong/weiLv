//
//  foodShowViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/13.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "foodShowViewController.h"
#import "GTMBase64.h"
#import "photoViewController.h"
@interface foodShowViewController ()<UIActionSheetDelegate,UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation foodShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrText = [[NSMutableArray alloc] init];
    self.arrimage = [[NSMutableArray alloc] init];
    self.ziparrimage = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"发布";
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(zxdConserve)];
    self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);
    [self creatScrollview];
    [self creatView:0];
    [self creatButton];
    // Do any additional setup after loading the view.
}
-(void)creatScrollview
{
    self.zxdScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    self.zxdScrollview.showsVerticalScrollIndicator = NO;
    self.zxdScrollview.delegate= self;
    [self.zxdScrollview setContentSize:CGSizeMake(self.view.frame.size.width,self.view.frame.size.height*1.3)];
    self.zxdScrollview.backgroundColor = BgViewColor;
    [self.view addSubview:self.zxdScrollview];
}
-(void)creatView:(NSInteger )num
{
    UIView *view = [[UIView alloc] init];
    
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 13+num*111, windowContentWidth, 98);
    UITextField *textfield = [[UITextField alloc] init];
    textfield.placeholder = @"描述限12个字以内";
    textfield.clearButtonMode = UITextFieldViewModeAlways;
    textfield.tag = 21+ num ;
    textfield.frame = CGRectMake(10, 0, windowContentWidth-10, 38);
    [view addSubview:textfield];
    count = num+1;
    UIImageView *zxdimageview = [[UIImageView alloc] initWithFrame:CGRectMake(9, 38, 52, 52)];
    UIImage *zxdimage = [UIImage imageNamed:@"添加"];
    zxdimageview.tag = 11+num ;
    zxdimageview.userInteractionEnabled = YES;
    zxdimageview.image = zxdimage;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zxdtap:)];
    [zxdimageview addGestureRecognizer:singleTap];
    [view addSubview:zxdimageview];
//    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeSystem];
//    but2.frame = CGRectMake(10, 30, 50, 40);
//    but2.backgroundColor = [UIColor clearColor];
//    but2.tag = 11+num;
//    [but2 addTarget:self action:@selector(btnAdd:) forControlEvents:UIControlEventTouchUpInside];
//    [but2 setBackgroundImage:[UIImage imageNamed:@"增加"] forState:UIControlStateNormal];
//    [view addSubview:but2];
   // [self.arrText addObject:textfield.text];
    [self.zxdScrollview addSubview:view];
}
-(void)creatButton
{
    UIView *viewbtn = [[UIView alloc] init];
    viewbtn.tag = 15;
    viewbtn.frame = CGRectMake(0, 13+111*count, windowContentWidth, 38);
    viewbtn.backgroundColor = [UIColor whiteColor];
    [self.zxdScrollview addSubview:viewbtn];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, windowContentWidth, 38);
    label.textColor = kColor(255, 165, 98);
    label.text = @"  + 添加食材(仅限六种)";
    [viewbtn addSubview:label];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, windowContentWidth, 38);
    [viewbtn addSubview:btn];
}
//添加图片
-(void)btnClick:(UIButton *)btn
{
    UIImage *zxdimage = [UIImage imageNamed:@"添加"];
    for (int j=0; j<count; j++) {
        UIImageView *imageView1 = (UIImageView *)[self.view viewWithTag:10+count];
        if ([zxdimage isEqual:imageView1.image] == 1) {
            UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"警告" message:@"亲,请先补全上面的描述" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert1 show];
            return;
        }
    }
    for (int i=1; i<=count; i++) {
        UITextField *field = (UITextField *)[self.view viewWithTag:20+i];
        NSLog(@"+++++++");
        [field resignFirstResponder];
    }

    if (count <= 5) {
        [self creatView:count];
        UIView *view = (UIView *)[self.view viewWithTag:15];
        view.frame = CGRectMake(0, 13+111*count, windowContentWidth, 45);

    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"亲,不能超过6张哦" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
      NSLog(@"+++++++");
}
//上传图片和预览
-(void)zxdtap:(UITapGestureRecognizer *)sender
{
    for (int i=1; i<=count; i++) {
        UITextField *field = (UITextField *)[self.view viewWithTag:20+i];
        [field resignFirstResponder];
    }

    imageNum = sender.self.view.tag ;
    UIImage *zxdimage = [UIImage imageNamed:@"添加"];
    UIImageView *zxdimageView1 = (UIImageView *)[self.view viewWithTag:sender.self.view.tag];
    if ([zxdimage isEqual:zxdimageView1.image] == 1) {
        
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
        [actionsheet showInView:self.view];
    }
    else
    {
         NSLog(@"放大图片");
        photoViewController *pv = [[photoViewController alloc] init];
        pv.arrimagepv = self.arrimage;
        pv.index = imageNum-11;
        [self.navigationController pushViewController:pv animated:YES];
    }
   
    
     // NSLog(@"%@",zxdimageView1);
    
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
        [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypeCamera];
    if (buttonIndex == 1)
        [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
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
        
        UIImage *image1 = [self imageWithImageSimple:editedImage scaledToSize:CGSizeMake(50, 40)];
        UIImageView *imageview1 = (UIImageView *)[self.view viewWithTag:imageNum];
        self.arrimage[imageNum-11] = editedImage;
        imageview1.image = image1;
        
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
#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];

}
//收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (int i=1; i<=count; i++) {
        UITextField *field = (UITextField *)[self.view viewWithTag:20+i];
        [field resignFirstResponder];
    }
}

-(void)zxdConserve
{
    NSLog(@"%@",self.arrText);
    UIImage *image = [UIImage imageNamed:@"添加"];
    //NSMutableArray *arrtext = [[NSMutableArray alloc] init];
    //NSMutableArray *arrimage = [[NSMutableArray alloc] init];
    NSLog(@"%ld",count);
    for (int i =1; i<=count; i++) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:20+i];
        NSLog(@"=====1====%@",textField.text);
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:10+i];
        NSLog(@"=====2====%@",imageView.image);
        if ([image isEqual:imageView.image]==1) {
             NSLog(@"9999999");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲,您还没有选择图片哦" delegate:self cancelButtonTitle:@"重新选择" otherButtonTitles:@"放弃选择", nil];
            [alert show];
        }
        else
        {
            self.arrText[i-1] = textField.text;
            self.arrimage[i-1] = imageView.image;
            
           
            
        }
    }
    
    NSLog(@"=========%@",self.arrText);
    NSLog(@"=========%@",self.arrimage);
    NSDictionary *zxdDict = @{@"arrCount":[NSString stringWithFormat:@"%ld",self.arrimage.count],
                              @"arrText":self.arrText,@"arrImage":self.arrimage};
    NSNotification *notification = [NSNotification notificationWithName:@"ZxdTZ1" object:nil userInfo:zxdDict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];

    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self.navigationController popViewControllerAnimated:YES];
    };
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
