//
//  JYCreturnTicketVC.m
//  WelLv
//
//  Created by lyx on 15/9/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCreturnTicketVC.h"
#import "JYCChooseLines.h"
#import "GTMBase64.h"
#define kViewHeight 40
#define kAnimationDuration 0.2
#define kurl  [NSString stringWithFormat:@"%@/flight/flight/tuipiao",WLHTTP]
#define lineCorlor  [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1]
@interface JYCreturnTicketVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate>

{
    AFHTTPRequestOperationManager *manager;
    UIScrollView *_scrollView;
    UISegmentedControl *segmentControl;
    UIImageView *ticketView;
    UITextView *textView;
    UITextField *userTextField;
    UIView *personView;
    UITextField *bankNameField;
    UITextField *bankNOField;
    NSData *imgData;
    NSInteger reftype;
    NSNumber *reftypeNO;
    NSArray *arr;//切割订单号得到的数组
    
    BOOL single;
}
@property(nonatomic,strong)NSMutableArray *topArr;
@property(nonatomic,copy)NSString *orderNumber;
@end

@implementation JYCreturnTicketVC
@synthesize passengerArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"退票";
    self.view.backgroundColor=[UIColor whiteColor];
    self.topArr=[NSMutableArray array];
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor=[UIColor colorWithRed:241/255.0 green:249/255.0 blue:253/255.0 alpha:1];
    //添加手势点击退出键盘
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
    //设置点击次数和点击手指数
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [_scrollView addGestureRecognizer:tapGesture];
    [_scrollView setContentSize:CGSizeMake(0, windowContentHeight+250)];
    reftype=0;

    [self.view addSubview:_scrollView];
   
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    if ([self.orderNo rangeOfString:@"and"].location!= NSNotFound) {
        single=NO;
      arr=[self.orderNo componentsSeparatedByString:@"and"];
      
    }else {
        single=YES;
        self.orderNumber=self.orderNo;
    }
    
    
    [self initView];

}
-(void)initView
{
    NSArray *items = @[@"去程",@"返程"];
    segmentControl = [[UISegmentedControl alloc] initWithItems:items];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:16.0],NSFontAttributeName,nil];
    [segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    segmentControl.tintColor = [UIColor orangeColor];
    
    segmentControl.frame = CGRectMake(10, 10,windowContentWidth-20, 40);
    
    segmentControl.selectedSegmentIndex = 0;
    [segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    
    [_scrollView addSubview:segmentControl];
    
    for (id obj in self.passengerArr) {
        [self.topArr addObject:obj[@"pname"]];
    }
    
    
    
    if (single) {
        segmentControl.hidden=YES;
        personView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, 40*self.topArr.count)];
        
    }else if(single==NO)
    {
        personView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(segmentControl)+10, windowContentWidth, 40*self.topArr.count)];
    }
    
    personView.backgroundColor=[UIColor whiteColor];
    for (int i=0;i<self.topArr.count;i++) {
        if (i==self.topArr.count-1) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, i*40, windowContentWidth-10, 39.5)];
            label.text=[NSString stringWithFormat:@"乘机人%d: %@",i+1,self.topArr[i]];
            [personView addSubview:label];
            
        }else {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, i*40, windowContentWidth-10, 39.5)];
            label.text=[NSString stringWithFormat:@"乘机人%d: %@",i+1,self.topArr[i]];
            [personView addSubview:label];
            UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0,40+i*40,windowContentWidth, 0.5)];
            line.backgroundColor=bordColor;
            
            [personView addSubview:line];
        }
    }
    
    [_scrollView addSubview:personView];
    //是否自愿退票选项
    JYCChooseLines *isVoluntary=[[JYCChooseLines alloc]initWithFrame:CGRectMake(0, ViewBelow(personView)+15, windowContentWidth, 40) withChooseLineArray:@[@"自愿退票",@"非自愿退票"]];
    
    [isVoluntary chooseOneRow:^(NSInteger row) {
        reftype=row;
        //reftypeNO=[NSNumber numberWithInteger:row];
        
        NSLog(@"%lu",reftype);
    }];
    
    [_scrollView addSubview:isVoluntary];
    
    
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 30)];
    [topView setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = @[btnSpace,doneButton];
    
    [topView setItems:buttonsArray];
    
    UIView *fieldView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(isVoluntary)+15, windowContentWidth, 120)];
    fieldView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:fieldView];
    UILabel *userLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0,120,39.5)];
    userLabel.text=@"银行开户姓名";
    [fieldView addSubview:userLabel];
    userTextField=[[UITextField alloc]initWithFrame:CGRectMake(130,0, windowContentWidth-120-10, 39.5)];
    userTextField.placeholder=@"请输入银行开户姓名";
    userTextField.clearButtonMode= UITextFieldViewModeAlways;
    //[userTextField setInputAccessoryView:topView];
    
    //[userTextField setInputAccessoryView:topView];
    
    [fieldView addSubview:userTextField];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 40, windowContentWidth, 0.5)];
    line1.backgroundColor=bordColor;
    [fieldView addSubview:line1];
    
    UILabel *bankNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,ViewBelow(userLabel),120,39.5)];
    bankNameLabel.text=@"开户行账号";
    [fieldView addSubview:bankNameLabel];
    bankNameField=[[UITextField alloc]initWithFrame:CGRectMake(130,ViewBelow(userLabel), windowContentWidth-120-10, 39.5)];
    bankNameField.placeholder=@"请输入开户行账号";
    bankNameField.clearButtonMode=UITextFieldViewModeAlways;
    //[bankNameField setInputAccessoryView:topView];
    [fieldView addSubview:bankNameField];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, 80, windowContentWidth, 0.5)];
    line2.backgroundColor=bordColor;
    [fieldView addSubview:line2];
    
    UILabel *bankNOLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,ViewBelow(bankNameField),120,39.5)];
    bankNOLabel.text=@"开户行名称";
    [fieldView addSubview:bankNOLabel];
    bankNOField=[[UITextField alloc]initWithFrame:CGRectMake(130,ViewBelow(bankNameField), windowContentWidth-120-10, 39.5)];
    bankNOField.placeholder=@"请输入开户行名称";
    bankNOField.clearButtonMode=UITextFieldViewModeAlways;
    
    //[bankNOField setInputAccessoryView:topView];
    [fieldView addSubview:bankNOField];
    
    //    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0, 120, windowContentWidth, 0.5)];
    //    line3.backgroundColor=bordColor;
    //    [fieldView addSubview:line3];
    
    
    
    UIView *photoView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(fieldView)+15, windowContentWidth, 80)];
    photoView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:photoView];
    UILabel *detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, windowContentWidth-135, 40)];
    detailLabel.text=@"请提供航空公司提供的航班延误证明或航班取消证明的图片";
    
    detailLabel.numberOfLines=0;
    detailLabel.font=systemFont(17);
    [photoView addSubview:detailLabel];
    ticketView=[[UIImageView alloc]initWithFrame:CGRectMake(ViewRight(detailLabel)+15, 10, 100, 60)];
    ticketView.image=[UIImage imageNamed:@"提供图片"];
    //ticketView.backgroundColor=[UIColor greenColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ViewTapClick)];
    ticketView.userInteractionEnabled = YES;
    [ticketView addGestureRecognizer:tap];
    [photoView addSubview:ticketView];
    //退票规则：
    UIView *ruleView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(photoView)+15, windowContentWidth, 80)];
    
    ruleView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:ruleView];
    UILabel *ruleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, windowContentWidth-10, 50)];
    ruleLabel.text=@"审核处理时间:自愿退票3-5个工作日内完成审核;非自愿退票15-21个工作日内完成审核。退款时间:根据各家航空公司退款结算时间处理";
    ruleLabel.numberOfLines=0;
    ruleLabel.font=systemFont(15);
    [ruleView addSubview:ruleLabel];
    UIView *noteView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(ruleView)+15, windowContentWidth, 90)];
    noteView.backgroundColor=[UIColor whiteColor];
    noteView.tag=1000;
    [_scrollView addSubview:noteView];
    UILabel *noteLebel=[[UILabel alloc]initWithFrame:CGRectMake(10, 9, 40, 25)];
    noteLebel.text=@"备注:";
    [noteView addSubview:noteLebel];
    textView=[[UITextView alloc]initWithFrame:CGRectMake(50,5, windowContentWidth-55, 70)];
    textView.returnKeyType = UIReturnKeyDefault; //键盘类
    textView.keyboardType = UIKeyboardTypeDefault;
    //    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 30)];
    //    [topView setBarStyle:UIBarStyleBlackTranslucent];
    //
    //    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    //    NSArray * buttonsArray = @[btnSpace, doneButton];
    //
    //    [topView setItems:buttonsArray];
    //[textView setInputAccessoryView:topView];
    
    [noteView addSubview:textView];
    UIButton *returnTicketBtn=[YXTools allocButton:@"提交申请" textColor:[UIColor whiteColor] nom_bg:[UIImage imageNamed:@"退票"] hei_bg:nil frame:CGRectMake(20, ViewBelow(noteView)+15, windowContentWidth-40, 40)];
    [returnTicketBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:returnTicketBtn];
    
}
#pragma mark --segmentControlAction
-(void)segmentControlAction:(id)sender
{
    switch ([sender selectedSegmentIndex]) {
        case 0:
        {
            self.orderNumber=arr[0];
        }
            break;
        case 1:
        {
            
            self.orderNumber=arr[1];
        }
            break;
        default:
            break;
    }
}

-(void)ViewTapClick
{
    UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
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
        
        UIImage *image = [self imageWithImageSimple:editedImage scaledToSize:CGSizeMake(100, 60)];
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
    return newImage;
}

//将图片转换为字符串
//- (NSString *)imageTransToBase64String:(UIImage *)image
//{
//    imgData = UIImageJPEGRepresentation(image,0.1);
//    NSString *imgStr = [GTMBase64 stringByEncodingData:imgData];
//    return imgStr;
//}
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

#pragma mark --btnCLick:
-(void)btnClick
{
//    if (reftype==3) {
//        [[LXAlterView sharedMyTools] createTishi:@"请选择是否自愿退票"];
//    }
    if (reftype==0)
    {
        reftypeNO=[NSNumber numberWithInt:0];
        if([self judgeString:userTextField.text]&&[self judgeString:bankNameField.text]&&[self judgeString:bankNOField.text])
        {
        
            [self sendRequest];
            
        }else
        {
           [[LXAlterView sharedMyTools] createTishi:@"退票需要您请填写完整的银行账户信息"];
        }
       
        
        
    }else if(reftype ==1)
    {
        reftypeNO=[NSNumber numberWithInt:1];

        if ([self judgeString:userTextField.text]&&[self judgeString:bankNameField.text]&&[self judgeString:bankNOField.text]&&imgData){
            [self sendRequest];
        }else if(!imgData)
        {
            [[LXAlterView sharedMyTools] createTishi:@"选择非自愿退票请上传符合规定的证明图片"];
        }else {
            [[LXAlterView sharedMyTools] createTishi:@"退票需要您请填写完整的银行账户信息"];
        }
  }
}
-(void)keyboardWillShow:(NSNotification *)notification
{
    NSValue *keyboardObject = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect;
    [keyboardObject getValue:&keyboardRect]; //调整放置有textView的view的位置
    //设置动画
    [UIView beginAnimations:nil context:nil];
    //定义动画时间
    [UIView setAnimationDuration:kAnimationDuration];
    //设置view的frame，往上平移
    [_scrollView setFrame:CGRectMake(0, -keyboardRect.size.height+100, windowContentWidth, windowContentHeight)];
    [UIView commitAnimations];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView beginAnimations:nil context:nil]; [UIView setAnimationDuration:kAnimationDuration];
    //设置view的frame，往下平移
    [_scrollView setFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    [UIView commitAnimations];
}
- (void)resignKeyboard {
    [textView resignFirstResponder];
    [userTextField resignFirstResponder];
    [bankNameField resignFirstResponder];
    [bankNOField resignFirstResponder];
}
-(void)dismissKeyBoard
{
    [textView resignFirstResponder];
    [userTextField resignFirstResponder];
    [bankNameField resignFirstResponder];
    [bankNOField resignFirstResponder];
    
}

-(void)sendRequest
{
    NSDictionary *parameters=nil;

    if (reftype==0) {
        if (imgData&&[self judgeString:textView.text]) {
            parameters =[NSDictionary dictionaryWithObjectsAndKeys:self.orderNumber,@"order_sn",reftypeNO,@"reftype",textView.text,@"remark",imgData,@"picture",userTextField.text,@"name",bankNameField.text,@"accountNumber", bankNOField.text,@"accountName",nil];
  
//parameters =@{@"order_sn":self.orderNumber,@"reftype":reftypeNO,@"remark":textView.text,@"picture":imgData,@"name":userTextField.text,@"accountNumber":bankNameField.text,@"accountName":bankNOField.text};

        }else if(imgData&&[textView.text isEqualToString:@""])
        {
            //parameters = @{@"order_sn":self.orderNumber,@"reftype":reftypeNO,@"remark":@"",@"picture":imgData,@"name":userTextField.text,@"accountNumber":bankNameField.text,@"accountName":bankNOField.text};
            
             parameters =[NSDictionary dictionaryWithObjectsAndKeys:self.orderNumber,@"order_sn",reftypeNO,@"reftype",@"",@"remark",imgData,@"picture",userTextField.text,@"name",bankNameField.text,@"accountNumber", bankNOField.text,@"accountName",nil];
        }else if(!imgData&&[self judgeString:textView.text])
        {
           // parameters = @{@"order_sn":self.orderNumber,@"reftype":reftypeNO,@"remark":textView.text,@"picture":@"",@"name":userTextField.text,@"accountNumber":bankNameField.text,@"accountName":bankNOField.text};
            parameters =[NSDictionary dictionaryWithObjectsAndKeys:self.orderNumber,@"order_sn",reftypeNO,@"reftype",textView.text,@"remark",@"",@"picture",userTextField.text,@"name",bankNameField.text,@"accountNumber", bankNOField.text,@"accountName",nil];

        }else if(!imgData&&[textView.text isEqualToString:@""])
        {
            //parameters = @{@"order_sn":self.orderNumber,@"reftype":reftypeNO,@"remark":@"",@"picture":@"",@"name":userTextField.text,@"accountNumber":bankNameField.text,@"accountName":bankNOField.text};
             parameters =[NSDictionary dictionaryWithObjectsAndKeys:self.orderNumber,@"order_sn",reftypeNO,@"reftype",@"",@"remark",@"",@"picture",userTextField.text,@"name",bankNameField.text,@"accountNumber", bankNOField.text,@"accountName",nil];

        }
    }else if(reftype==1)
    {
        if ([textView.text isEqualToString:@""]) {
            //parameters = @{@"order_sn":self.orderNumber,@"reftype":reftypeNO,@"remark":@"",@"picture":imgData,@"name":userTextField.text,@"accountNumber":bankNameField.text,@"accountName":bankNOField.text};
             parameters =[NSDictionary dictionaryWithObjectsAndKeys:self.orderNumber,@"order_sn",reftypeNO,@"reftype",@"",@"remark",imgData,@"picture",userTextField.text,@"name",bankNameField.text,@"accountNumber", bankNOField.text,@"accountName",nil];
        }else{
           // parameters = @{@"order_sn":self.orderNumber,@"reftype":reftypeNO,@"remark":textView.text,@"picture":imgData,@"name":userTextField.text,@"accountNumber":bankNameField.text,@"accountName":bankNOField.text};
             parameters =[NSDictionary dictionaryWithObjectsAndKeys:self.orderNumber,@"order_sn",reftypeNO,@"reftype",textView.text,@"remark",imgData,@"picture",userTextField.text,@"name",bankNameField.text,@"accountNumber", bankNOField.text,@"accountName",nil];
        }

    }
    
    
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:kurl parameters:parameters
           success:^(AFHTTPRequestOperation *operation,id responseObject) {
               
               NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
               NSLog(@"%@",dict1);
               
           }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
               //[[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
               [[LXAlterView sharedMyTools] createTishi:@"网络请求失败，请稍后重试"];
               
           }];
    
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

@end
