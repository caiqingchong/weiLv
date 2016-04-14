//
//  SHViewController.m
//  WelLv
//
//  Created by liuxin on 15/11/6.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//
#import "WXUtil.h"
#import "SHViewController.h"
#import "foodShowViewController.h"
#import "priceViewController.h"
#import "photoViewController.h"
#import "GTMBase64.h"//压缩图片
@interface SHViewController ()<UITextViewDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UITextFieldDelegate,UIScrollViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UILabel *_priceArr;
    NSString *_strPric1;
    NSString *_strPric2;
    NSString *_strPric3;
    UILabel *_label1;
    UILabel *_label2;
    UILabel *_label3;
    UIView *_priceView;
    NSInteger NumofButton;
}
@property(nonatomic,strong)UILabel *priceArr;
@property(nonatomic,strong)NSString *strPric1;
@property(nonatomic,strong)NSString *strPric2;
@property(nonatomic,strong)NSString *strPric3;
@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)UILabel *label3;
@property(nonatomic,strong)UIView *priceView;
@property(nonatomic,strong) MBProgressHUD *zxdHudSH;
@end

@implementation SHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NumofButton = 0;
    //增加键盘弹出的监听事件
    self.arrTextFrist = [[NSMutableArray alloc] init];
    self.arrTextFrist[0]=@"123";
    [self creatArrimage];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [self creatPrice1];
    [self creatScrollview];
    [self  creatView1];
    [self creatView2];
    [self creatBtn];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zxdTongzhi1:) name:@"ZxdTZ1" object:nil];
}
-(void)zxdTongzhi1:(NSNotification *)dic
{
    self.arrImageFrist = [[NSMutableArray alloc] init];
    //self.arrTextFrist = [[NSMutableArray alloc] init];
    self.arrTextFrist = dic.userInfo[@"arrText"];
    self.arrImageFrist = dic.userInfo[@"arrImage"];
    self.label2.text = @"已选择";
    NSLog(@"%@",self.arrImageFrist);
    NSLog(@"%@",self.arrTextFrist);
}
-(void)creatPrice1
{
     self.strPric1 = @"0.00";
     self.strPric2 = @"0.00";
     self.strPric3 = @"0.00";
     self.count = @"0";
     self.frist = @"1";
     self.type = @"1";
}
-(void)creatArrimage
{
    self.arrimage = [[NSMutableArray alloc] init];
    self.ziparrimage = [[NSMutableArray alloc] init];
}
-(void)creatScrollview
{
    self.zxdScrollview = [[UIScrollView alloc] init];
    self.zxdScrollview.frame = CGRectMake(0, 0, windowContentWidth, windowContentHeight);
    self.zxdScrollview.delegate = self;
    self.zxdScrollview.scrollEnabled = YES;
    self.zxdScrollview.backgroundColor = BgViewColor;
    self.zxdScrollview.contentSize = CGSizeMake(windowContentWidth, 408);
    [self.view addSubview:self.zxdScrollview];
}
-(void)creatView1
{
    UIView *view1 =[[UIView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    view1.frame = CGRectMake(0, 13, windowContentWidth, 128);
    self.textView = [[UITextView alloc] init];
    self.textView.frame = CGRectMake(9, 2, windowContentWidth, 69);
    self.textView.text = @"请输入产品名称与描述...";
    self.textView.scrollEnabled = YES;
    self.textView.editable = YES;
    self.textView.delegate= self;
    self.textView.tag = 21;
    self.textView.font = [UIFont systemFontOfSize:17];
    [view1 addSubview:self.textView];
    for (int i =0; i<4; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"添加"];
        imageView.userInteractionEnabled = YES;
        imageView.frame =CGRectMake(8+(52+8)*i, 68.5, 52, 52);
        imageView.tag = 101+i;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zxdtapSH:)];
        [imageView addGestureRecognizer:singleTap];
        [view1 addSubview:imageView];
//        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
//        btn1.tag = i+1;
//        btn1.frame =CGRectMake(8+(52+8)*i, 68.5, 52, 52);
//        [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        btn1.backgroundColor = [UIColor redColor];
//        [view1 addSubview:btn1];
    }
    [self.zxdScrollview addSubview:view1];
}
-(void)creatView2
{
    UIView *viewt = [[UIView alloc] init];
    viewt.backgroundColor = [UIColor whiteColor];
    viewt.frame = CGRectMake(0, 154, windowContentWidth, 190);
    [self.zxdScrollview addSubview:viewt];
    //分类
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor whiteColor];
    view1.frame = CGRectMake(0, 0, windowContentWidth, 38);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
    label1.font = [UIFont systemFontOfSize:17];
    label1.text = @"分类";
    [view1 addSubview:label1];
    UIButton *zxdbtn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [zxdbtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    zxdbtn1.frame = CGRectMake(0, 0, windowContentWidth, 38);
    zxdbtn1.backgroundColor = [UIColor clearColor];
    zxdbtn1.tag = 5;
    [view1 addSubview:zxdbtn1];
    UIImageView *IGV1 = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45 , 5, 45, 28)];
    [IGV1 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    
     [view1 addSubview:IGV1];
    self.label1 = [[UILabel alloc] init];
    self.label1.frame = CGRectMake(windowContentWidth-200, 5, 150, 30);
    self.label1.textAlignment = NSTextAlignmentRight;
    self.label1.text = @"菜品";
    self.label1.font = [UIFont systemFontOfSize:15];
    [view1 addSubview:self.label1];
    [viewt addSubview:view1];
    //食材展示
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor whiteColor];
    view2.frame = CGRectMake(0, 38, windowContentWidth, 38);
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
    label2.font = [UIFont systemFontOfSize:17];
    label2.text = @"食材展示";
    [view2 addSubview:label2];
    UIImageView *IGV2 = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45 , 5, 45, 28)];
    [IGV2 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    
    [view2 addSubview:IGV2];
    UIButton *zxdbtn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [zxdbtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    zxdbtn2.frame = CGRectMake(0, 0, windowContentWidth, 38);
    zxdbtn2.backgroundColor = [UIColor clearColor];
    zxdbtn2.tag = 6;
    [view2 addSubview:zxdbtn2];
    self.label2 = [[UILabel alloc] init];
    self.label2.frame = CGRectMake(windowContentWidth-200, 5, 150, 30);
    self.label2.textAlignment = NSTextAlignmentRight;
    //self.label2.text = @"12325663698";
    self.label2.font = [UIFont systemFontOfSize:15];
    [view2 addSubview:self.label2];

    [viewt addSubview:view2];
    //价格
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor whiteColor];
    view3.frame = CGRectMake(0, 76, windowContentWidth, 38);
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
    label3.font = [UIFont systemFontOfSize:17];
    label3.text = @"价格";
    [view3 addSubview:label3];
    UIImageView *IGV3 = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45 , 5, 45, 28)];
    [IGV3 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    
    [view3 addSubview:IGV3];
    UIButton *zxdbtn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [zxdbtn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    zxdbtn3.frame = CGRectMake(0, 0, windowContentWidth, 38);
    zxdbtn3.backgroundColor = [UIColor clearColor];
    zxdbtn3.tag = 7;
    [view3 addSubview:zxdbtn3];
    self.label3 = [[UILabel alloc] init];
    self.label3.frame = CGRectMake(windowContentWidth-200, 5, 150, 30);
    self.label3.textAlignment = NSTextAlignmentRight;
    //self.label3.text = @"12325663698";
    self.label3.font = [UIFont systemFontOfSize:15];
    [view3 addSubview:self.label3];

    [viewt addSubview:view3];
    //日供应量
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor whiteColor];
    view4.frame = CGRectMake(0, 114, windowContentWidth, 38);
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
    label4.font = [UIFont systemFontOfSize:17];
    label4.text = @"日供应量";
    [view4 addSubview:label4];
    UIButton *btnAdd = [UIButton buttonWithType:UIButtonTypeSystem];
    btnAdd.frame = CGRectMake(windowContentWidth-50, 3, 30, 30);
    btnAdd.backgroundColor = [UIColor clearColor];
    [btnAdd setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    //[btnAdd setImage:[UIImage imageNamed:@"增加"] forState:UIControlStateNormal];
    btnAdd.tag = 9;//设置标志
    [btnAdd addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view4 addSubview:btnAdd];
    UILabel *labelcount = [[UILabel alloc] init];
    labelcount.frame = CGRectMake(windowContentWidth-100, 3, 50, 30);
    labelcount.text = @"0";
    labelcount.tag = 33;
    labelcount.backgroundColor = [UIColor clearColor];
    labelcount.textAlignment = NSTextAlignmentCenter;
    [view4 addSubview:labelcount];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(windowContentWidth-130, 3, 30, 30);
    btn2.backgroundColor = [UIColor clearColor];
    btn2.tag = 8;//设置标志
    [btn2 setBackgroundImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
    //[btn2 setImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];

    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view4 addSubview:btn2];
    [viewt addSubview:view4];
    //设为招牌菜
    UIView *view5 = [[UIView alloc] init];
    view5.backgroundColor = [UIColor whiteColor];
    view5.frame = CGRectMake(0, 152, windowContentWidth, 38);
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
    label5.font = [UIFont systemFontOfSize:17];
    label5.text = @"设为招牌菜";
    [view5 addSubview:label5];
    self.sw1 = [[UISwitch alloc] init];
    self.sw1.frame = CGRectMake(windowContentWidth-100, 5, 50, 25);
    self.sw1.tag = 26;
    [self.sw1  setOn:NO];
    [self.sw1  addTarget:self action:@selector(SWClick:) forControlEvents:UIControlEventValueChanged];
    [view5 addSubview:self.sw1];
   
    [viewt addSubview:view5];
    
    for (int i=1; i<6; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 38*i, windowContentWidth, 1)];
        label.backgroundColor = BgViewColor;
        [viewt addSubview:label];
    }
}
-(void)creatBtn
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"确定发布" forState:UIControlStateNormal];
    btn.backgroundColor = kColor(250, 131, 11);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tintColor = [UIColor whiteColor];
    btn.tag = 10;
    btn.frame = CGRectMake(13, 370, windowContentWidth-26, 38);
    [self.zxdScrollview addSubview:btn];
}
-(void)SWClick:(UISwitch *)sender
{
    if ([sender isOn]) {
        self.frist = @"1";
    }
    else
    {
        self.frist = @"0";
    }
    NSLog(@"-----%@",self.frist);
    
    }
-(NSString *)numtoString:(UILabel *)lab num:(int)number
{
     UIButton *btn = (UIButton *)[self.view viewWithTag:8];
    NSInteger num1 = [lab.text integerValue];
    
    if (number == 1) {
        [btn setBackgroundImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
        num1++;
    }
    else if (number == 0 && num1 == 0) {
       
        [btn setBackgroundImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
        num1 = 0;
        
    }
   else
   {
        num1 --;
       if (num1==0) {
            [btn setBackgroundImage:[UIImage imageNamed:@"减少不可用"] forState:UIControlStateNormal];
       }
   }
    //NSString *str = [[NSString alloc] initWithFormat:@"%d",num1];
    return [[NSString alloc] initWithFormat:@"%d",num1];
}

-(void)btnClick:(UIButton *)btn
{
    [self.textView resignFirstResponder];
    switch (btn.tag) {
        case 5:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"选择分类" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"菜品",@"套餐",@"抵用卷",@"特产", nil];
            alertView.tag = 100;
            [alertView show];
            NSLog(@"第5个");
 
        }
            break;
        case 6:
        {
            foodShowViewController *foodS = [[foodShowViewController alloc] init];
            [self.navigationController pushViewController:foodS animated:YES];
            NSLog(@"第6个");

        }
            break;
        case 7:
        {
            [self creatprice];
            // priceViewController *pc= [[priceViewController alloc] init];
            //self.modalPresentationStyle = UIModalPresentationCurrentContext;
            //[self presentViewController:pc animated:YES completion:nil];
            //[self.navigationController pushViewController:pc animated:YES];
            NSLog(@"第7个");
        }
            break;
        case 8:
        {
            NSLog(@"---------------------减");
            UILabel *zxdlabel = (UILabel *)[self.view viewWithTag:33];
            zxdlabel.text = [self numtoString:zxdlabel num:0];
            self.count = zxdlabel.text;
  
        }
            break;
        case 9:
        {
            
            UILabel *zxdlabel = (UILabel *)[self.view viewWithTag:33];
            zxdlabel.text = [self numtoString:zxdlabel num:1];
            NSLog(@"---------------------加");

        }
            break;
        case 10:
        {
             NSLog(@"确认发布");
           // [self downUp];
            [self downData];
//            NSLog(@"%@",self.strPric1);
//             NSLog(@"%@",self.strPric2);
//             NSLog(@"%@",self.strPric3);
        }
            break;

        case 51:
        {
            NSLog(@"%@",[btn currentTitle] );
             [btn setTitle:@"" forState:UIControlStateNormal];
            //btn.titleLabel.text = @"";
             NumofButton = 51;
        }
            break;
        case 52:
        {
           // btn.titleLabel.text = @"";

            [btn setTitle:@"" forState:UIControlStateNormal];
             NumofButton = 52;
        }
            break;
        case 53:
        {
            btn.titleLabel.text = @"";

            [btn setTitle:@"" forState:UIControlStateNormal];
             NumofButton = 53;
        }
            break;

        default:
            break;
    }
        }
#pragma mark -textViewDelegate
//将要开始编辑

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
        return YES;
}

//将要结束编辑

- (BOOL)textViewShouldEndEditing:(UITextView *)textView

{
    
    return YES;
}
//开始编辑

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.textView becomeFirstResponder];

}

//结束编辑

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self.textView resignFirstResponder];

    }
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textView resignFirstResponder];

}
#pragma mark -textFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatprice
{
    self.priceView = [[UIView alloc] init];
    self.priceView.frame = CGRectMake(0, 0, windowContentWidth, windowContentHeight);
    self.priceView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.5];
    //[self.view addSubview:self.priceView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.priceView];
    UIView *view2 = [[UIView alloc] init];
    NSLog(@"+++++++++++++++++++++++++++++++++");
   
    view2.tag = 211;
    view2.frame = CGRectMake(0, windowContentHeight-330, windowContentWidth, 90);
    view2.backgroundColor = [UIColor whiteColor];
    [self.priceView addSubview:view2];
    //横线
    UILabel *labelline = [[UILabel alloc] init];
    labelline.backgroundColor = BgViewColor;
    labelline.frame = CGRectMake(0, 45, windowContentWidth, 1);
    [view2 addSubview:labelline];
    //竖线
    UILabel *labelhigh = [[UILabel alloc] init];
    labelhigh.backgroundColor = BgViewColor;
    labelhigh.frame = CGRectMake(windowContentWidth/2, 0, 1, 45);
    [view2 addSubview:labelhigh];
    //微旅价
    UILabel *labelPr1 = [[UILabel alloc] init];
    labelPr1.frame = CGRectMake(0, 0, windowContentWidth*0.25, 45);
    labelPr1.text = @"微旅价:￥";
    labelPr1.textAlignment = NSTextAlignmentRight;
    [view2 addSubview:labelPr1];
    UILabel *zxdlabel1 = [[UILabel alloc] init];
    zxdlabel1.frame = CGRectMake(windowContentWidth*0.25, 0, windowContentWidth*0.25, 45);
     zxdlabel1.text = @"";
    zxdlabel1.tag = 151;
    [view2 addSubview:zxdlabel1];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.backgroundColor = [UIColor clearColor];
    btn1.frame = CGRectMake(windowContentWidth*0.25, 0, windowContentWidth*0.25, 45);
    btn1.tag = 51;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
   
    //btn1.titleLabel.text = @"0.00";
    [btn1 setTitle:@"0.00" forState:UIControlStateNormal];
    btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [view2 addSubview:btn1];
    
//    UITextField *textfield1 = [[UITextField alloc] init];
//    textfield1.frame = CGRectMake(windowContentWidth*0.25, 0, windowContentWidth*0.25, 45);
//    textfield1.placeholder = @"0.00";
//    //[textfield1 becomeFirstResponder];
//    textfield1.delegate = self;
//    textfield1.tag = 51;
//    textfield1.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    [view2 addSubview:textfield1];
    //原价
    UILabel *labelPr2 = [[UILabel alloc] init];
    labelPr2.frame = CGRectMake(windowContentWidth/2, 0, windowContentWidth*0.25, 45);
    labelPr2.text = @"原价:￥";
    labelPr2.textAlignment = NSTextAlignmentRight;
    [view2 addSubview:labelPr2];
    UILabel *zxdlabel2 = [[UILabel alloc] init];
    zxdlabel2.frame = CGRectMake(windowContentWidth*0.75, 0, windowContentWidth*0.25, 45);
    zxdlabel2.text = @"";
    zxdlabel2.tag = 152;
    [view2 addSubview:zxdlabel2];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.backgroundColor = [UIColor clearColor];
    btn2.frame = CGRectMake(windowContentWidth*0.75, 0, windowContentWidth*0.25, 45);
    btn2.tag = 52;
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
   // btn2.titleLabel.text = @"0.00";
    [btn2 setTitle:@"0.00" forState:UIControlStateNormal];
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [view2 addSubview:btn2];

//    UITextField *textfield2 = [[UITextField alloc] init];
//    textfield2.frame = CGRectMake(windowContentWidth*0.75, 0, windowContentWidth*0.25, 45);
//    textfield2.placeholder = @"0.00";
//    //[textfield2 becomeFirstResponder];
//    textfield2.tag = 52;
//      textfield2.delegate =self;
//    textfield2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    [view2 addSubview:textfield2];

    //返佣
    UILabel *labelReturn = [[UILabel alloc] init];
    labelReturn.frame = CGRectMake(0, 46, windowContentWidth*0.25, 45);
    labelReturn.text = @"返佣:￥";
    labelReturn.textAlignment = NSTextAlignmentRight;
    [view2 addSubview:labelReturn];
    UILabel *zxdlabel3 = [[UILabel alloc] init];
    zxdlabel3.frame = CGRectMake(windowContentWidth*0.25, 46, windowContentWidth*0.25, 45);
    zxdlabel3.text = @"";
    zxdlabel3.tag = 153;
    [view2 addSubview:zxdlabel3];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn3.backgroundColor = [UIColor clearColor];
    btn3.frame = CGRectMake(windowContentWidth*0.25, 46, windowContentWidth*0.25, 45);
    btn3.tag = 53;
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //btn3.titleLabel.text = @"0.00";
    [btn3 setTitle:@"0.00" forState:UIControlStateNormal];
    btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [view2 addSubview:btn3];

//    UITextField *textfield3 = [[UITextField alloc] init];
//    textfield3.frame = CGRectMake(windowContentWidth*0.25, 46, windowContentWidth*0.25, 45);
//    textfield3.placeholder = @"0.00";
//    //[textfield3 becomeFirstResponder];
//    textfield3.tag = 53;
//      textfield3.delegate = self;
//    textfield3.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    [view2 addSubview:textfield3];

    //提示
    UILabel *warLabel = [[UILabel alloc] init];
    warLabel.frame = CGRectMake(windowContentWidth*0.5, 46, windowContentWidth*0.5, 45);
    warLabel.text = @"返佣仅限销售商查看";
    [view2 addSubview:warLabel];
    //创建键盘
    [self creatKeyButton];
}
//当键盘出现的时候调用
-(void)keyboardWillShow:(NSNotification *)notfication
{
    NSDictionary *myuserInfo = [notfication userInfo];
    NSValue *aValue  = [myuserInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.high = [aValue CGRectValue].size.height;
    UIView *view1 = (UIView *)[self.view viewWithTag:211];
    view1.frame = CGRectMake(0, windowContentHeight-[aValue CGRectValue].size.height-190, windowContentWidth, 90);
    //获取键盘的高度
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark -上传图片和预览
-(void)zxdtapSH:(UITapGestureRecognizer *)sender
{
    numimage = sender.self.view.tag;
    NSLog(@"++++%ld",numimage);
    UITextView *textView = (UITextView *)[self.view viewWithTag:21];
    [textView resignFirstResponder];
    UIImage *zxdimage1 = [UIImage imageNamed:@"添加"];
   
    UIImageView *zxdimageView = (UIImageView *)[self.view viewWithTag:sender.self.view.tag];
    // NSLog(@"+++++%d",[zxdimageView.image isEqual:zxdimage1]);
    if ([zxdimage1 isEqual:zxdimageView.image] == 1) {
        
        UIActionSheet *actionsheet = [[UIActionSheet alloc] initWithTitle:@"上传图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
        [actionsheet showInView:self.view];
    }
    else
    {
        NSLog(@"放大图片");
        photoViewController *pv = [[photoViewController alloc] init];
        pv.arrimagepv = self.arrimage;
        pv.index = sender.self.view.tag-101;
        [self.navigationController pushViewController:pv animated:YES];
    }
    

}
//选择照片
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
        UIImageView *imageview1 = (UIImageView *)[self.view viewWithTag:numimage];
        self.arrimage[numimage-101] = editedImage;
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
#pragma mark -分类
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag!=100) {
        return;
    }
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            self.label1.text = @"菜品";
            self.type = @"1";
            break;
        case 2:
            self.label1.text = @"套餐";
            self.type = @"2";
            break;
        case 3:
            self.label1.text = @"抵用卷";
           self.type = @"3";
            break;
        case 4:
             self.label1.text = @"特产";
            self.type = @"4";
            break;
        default:
           // self.label1.text = @"菜品";
            break;
    }
}
#pragma mark- 定制键盘
-(void)creatKeyButton
{
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@".",@""];
    for (int i=0; i<4; i++) {
        for (int j=0; j<3; j++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = CGRectMake(j*(windowContentWidth/4), i*60+windowContentHeight-240, windowContentWidth/4, 60);
            //[btn.layer setBorderWidth:1.0];
            
            btn.tag = 30+i*3+j+1;
            btn.backgroundColor = [UIColor whiteColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:30];
            [btn setTitle:array[i*3+j] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(keybuttonClick:) forControlEvents:UIControlEventTouchUpInside];
            //btn.titleLabel.textColor = [UIColor orangeColor];
            [self.priceView addSubview:btn];
        }
    }
    //删除按钮
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    btnBack.frame = CGRectMake(windowContentWidth*0.75, windowContentHeight-240, windowContentWidth*0.25, 120);
    btnBack.backgroundColor = [UIColor whiteColor];
    btnBack.tag = 43;
    [btnBack setTitle:@"删除" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(keybuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.priceView addSubview:btnBack];
    //确定按钮
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
    btnDone.frame = CGRectMake(windowContentWidth*0.75, windowContentHeight-120, windowContentWidth*0.25, 120);
    btnDone.backgroundColor = [UIColor orangeColor];
    [btnDone setTitle:@"确定" forState:UIControlStateNormal];
    btnDone.tag =44;
    [btnDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(keybuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.priceView addSubview:btnDone];
    //横线
    for (int k=0; k<4; k++) {
        
        UILabel *labelline = [[UILabel alloc] init];
        if (k==0||k==2) {
            labelline.frame = CGRectMake(0, windowContentHeight-240+60*k, windowContentWidth, 1);

        }
        else{
            labelline.frame = CGRectMake(0, windowContentHeight-240+60*k, windowContentWidth*0.75, 1);
        }
       
        labelline.backgroundColor =BgViewColor;
        [self.priceView addSubview:labelline];
    }
    //竖线
    for (int m=0; m<3; m++) {
        UILabel *labelline2 = [[UILabel alloc] init];
        labelline2.frame = CGRectMake(windowContentWidth*0.25*(m+1), windowContentHeight-240, 1, 240);
        labelline2.backgroundColor =BgViewColor;
        [self.priceView addSubview:labelline2];
    }

}
//处理键盘
-(void)keybuttonClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 44:
        {
            //确定
            UILabel *label1 = (UILabel *)[self.priceView viewWithTag:151];
            UILabel *label2 = (UILabel *)[self.priceView viewWithTag:152];
            UILabel *label3 = (UILabel *)[self.priceView viewWithTag:153];
            self.strPric1 = label1.text.length==0?@"0":label1.text;
            self.strPric2 = label2.text.length==0?@"0":label2.text;
            self.strPric3 = label3.text.length==0?@"0":label3.text;
//            NSLog(@"label1==%@",label1.text);
//            NSLog(@"label2==%@",label2.text);
//            NSLog(@"label3==%@",label3.text);
//            NSLog(@"label1==%@",self.strPric1);
//            NSLog(@"label2==%@",self.strPric2);
//            NSLog(@"label3==%@",self.strPric3);
            if (label1.text.length==0&&label2.text.length == 0&&label3.text.length == 0) {
                break;
            }
            self.label3.text = [NSString stringWithFormat:@"￥%@￥%@￥%@",self.strPric1,self.strPric2,self.strPric3];
            NSLog(@"labelPrice == %@",self.label3.text);
            NumofButton = 0;
            NSLog(@"%ld",btn.tag);
        }
            break;
        case 43:
        {
            //删除
            if (NumofButton == 0) {
                return;
            }
            else
            {
                UILabel *label = (UILabel *)[self.priceView viewWithTag:NumofButton+100];
                // NSString *str1 = label.text;
                //NSString *str2 = [btn currentTitle];
                if (label.text.length==0) {
                    return;
                }
                //NSString *str3 = [NSString stringWithFormat:@"%@%@",label.text,str2];
                label.text = [label.text substringToIndex:label.text.length-1];
                
            }

            NSLog(@"%ld",btn.tag);
        }
            break;
        case 42:
        {
            NumofButton = 0;
            self.priceView.hidden = YES;
            NSLog(@"%ld",btn.tag);
        }
            break;
        

        default:
        {
            //NSLog(@"++%d",btn.tag);
            if (NumofButton == 0) {
                return;
            }
            else
            {
                UILabel *label = (UILabel *)[self.priceView viewWithTag:NumofButton+100];
               // NSString *str1 = label.text;
                NSString *str2 = [btn currentTitle];
                if (label.text.length==7) {
                    return;
                }
                //NSString *str3 = [NSString stringWithFormat:@"%@%@",label.text,str2];
                label.text = [label.text stringByAppendingString:str2];
                
            }
            
        }
            break;
    }
    
}
#pragma mark-下载上传数据
-(void)downData
{
    if (self.arrimage.count==0) {
        UIAlertView *zxdViewImage = [[UIAlertView alloc] initWithTitle:@"提示" message:@"亲,菜品至少需要一张照片" delegate:self cancelButtonTitle:@"重新选择" otherButtonTitles:nil];
        [zxdViewImage show];
        return;
    }
   // NSData *data = [[NSData alloc] init];
    NSString *url = [NSString stringWithFormat:@"%@/%@",WLHTTP,@"api/drivingShop/productPub"];
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString * shopId = [[WLSingletonClass defaultWLSingleton] wlDEShopID];
    NSString *token1 = [token stringByAppendingString:shopId];
    /*
    NSArray *arr = @[@{@"Id":@"1",
                       @"features_eat_partner_id":@"2",
                       @"features_eat_partner_member_id":@"33060",
                       @"describe":@"你猜",
                       @"type":@"5",
                       @"original_price":@"12",
                       @"price":@"12",
                       @"commission":@"12",
                       @"number":@"9",
                       @"status":@"1",
                       @"sales":@"1",
                       @"create_time":@"1",
                       @"last_time":@"1",
                       @"is_main_product":@"1",
                       @"ingredients_images_describe":@[@"123456", @"123456"]}];
     */
    /*
     ,
     @"images":@{@"images-1":@""},
     @"ingredients_images":@{@"ingredients_images-1":@""}
     */
    NSLog(@"+++%@",self.strPric2);
    NSLog(@"%@",self.arrTextFrist);
    UILabel *labelNum =(UILabel *)[self.view viewWithTag:33];
    NSString *strData = [NSString stringWithFormat:@"%@",[NSData data]];
    NSDictionary * dic = @{@"status":self.frist,
                           @"original_price":self.strPric2,
                           @"number":labelNum.text,
                           @"ingredients_images_describe":self.arrTextFrist,
                           @"last_time":@"1448096785",
                           @"type":self.type,
                           @"features_eat_partner_member_id":[[WLSingletonClass defaultWLSingleton] wlUserID],
                           @"features_eat_partner_id":[[WLSingletonClass defaultWLSingleton] wlDEShopID],
                           @"price":self.strPric1,
                           @"sales":[NSString stringWithFormat:@"%@",self.count],
                           @"describe":self.textView.text,
                           @"create_time":strData,
                           @"commission":self.strPric3,
                           @"is_main_product":self.frist};
    
    NSDictionary *parameters = @{@"shopId":shopId,
                                 @"wltoken":[WXUtil md5:token1],
                                 @"data":[self dictionaryToJson:dic]};
    AFHTTPRequestOperationManager *zxdManager = [AFHTTPRequestOperationManager manager];
    zxdManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [zxdManager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
         //[formData appendPartWithFileData:UIImageJPEGRepresentation(imageview1.image, 0.1) name:@"logo" fileName:@"logo.jpg" mimeType:@"image/jpg"];
        for (int i =0; i<self.arrimage.count; i++) {
            NSString *str1 = [NSString stringWithFormat:@"%@%d",@"images-",i];
            NSString *str2 = [NSString stringWithFormat:@"%@%d%@",@"images-",i,@".jpg"];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.arrimage[i], 0.1) name:str1 fileName:str2 mimeType:@"image/jpg"];
        }
        for (int j =0; j<self.arrImageFrist.count; j++) {
            NSString *str3 = [NSString stringWithFormat:@"%@%d",@"ingredient_images-",j+1];
            NSString *str4 = [NSString stringWithFormat:@"%@%d%@",@"ingredient_images-",j+1,@".jpg"];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(self.arrimage[j], 0.1) name:str3 fileName:str4 mimeType:@"image/jpg"];
        }

       // [formData appendPartWithFileData:UIImageJPEGRepresentation([UIImage imageNamed:@"huanyingye.jpg"], 0.1) name:@"mages-2" fileName:@"2.jpg" mimeType:@"image/jpg"];
//        [formData appendPartWithFileData:UIImageJPEGRepresentation([UIImage imageNamed:@"huanyingye.jpg"], 0.1) name:@"ingredient_images-1" fileName:@"file" mimeType:@"image/jpg"];
//        [formData appendPartWithFileData:UIImageJPEGRepresentation([UIImage imageNamed:@"huanyingye.jpg"], 0.1) name:@"ingredient_images-2" fileName:@"file" mimeType:@"image/jpg"];

//        for (int i=0; i<self.arrimage.count; i++) {
//            NSData *data = UIImageJPEGRepresentation(self.arrimage[i], 0.1);
//            NSString *str = [@"mages-" stringByAppendingString:@"i+1"];
//             [formData appendPartWithFileData:data name:str fileName:@"" mimeType:@"image/jpeg"];
//        }
//        for (int j=0; j<self.arrImage2.count; j++) {
//            NSData *data = UIImageJPEGRepresentation(self.arrImage2[j], 0.1);
//            NSString *str = [@"ingredients_images-" stringByAppendingString:@"i+1"];
//            [formData appendPartWithFileData:data name:str fileName:@"" mimeType:@"image/jpeg"];
//        }
       
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *zxdDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",zxdDict);
                NSLog(@"%@",zxdDict[@"msg"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
//    [zxdManager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *zxdDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",zxdDict);
//        NSLog(@"%@",zxdDict[@"msg"]);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"下载失败");
//    }];
    

}
#pragma mark-字典或数组转换为json
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
-(void)downUp
{
    [self setHud:@"正在上传,,,,,"];
    NSString *url = [NSString stringWithFormat:@"%@/%@",WLHTTP,@"api/drivingShop/productInfo"];
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    //NSString * shopId = @"2";
     NSString * shopId = [[WLSingletonClass defaultWLSingleton] wlDEShopID];
    NSString *token1 = [token stringByAppendingString:shopId];
    NSDictionary *parameters = @{@"shopId":shopId,
                                 @"wltoken":[WXUtil md5:token1],
                                 @"data":@[@{@"Id":@"1"}]};
    AFHTTPRequestOperationManager *manager2 = [AFHTTPRequestOperationManager manager];
    manager2.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager2 POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *zxdDict2 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.zxdHudSH.labelText = zxdDict2[@"msg"];
        self.zxdHudSH.hidden = YES;
        NSLog(@"%@",zxdDict2);
        NSLog(@"%@",zxdDict2[@"msg"]);
        //UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:zxdDict2[@"msg"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        //[view show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"上传失败" message:@"亲,请检查你的网路是否可用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [view show];
        NSLog(@"下载失败");
    }];
}
-(void)setHud:(NSString *)str
{
    
    self.zxdHudSH = [[MBProgressHUD alloc] initWithView:self.view];
    self.zxdHudSH.frame = self.view.bounds;
    self.zxdHudSH.minSize = CGSizeMake(100, 100);
    self.zxdHudSH.mode = MBProgressHUDModeIndeterminate;
    self.zxdHudSH.labelText = str;
    [self.view addSubview:self.zxdHudSH];
    // [_zxdTableView bringSubviewToFront:self.zxdHud];
    [self.zxdHudSH show:YES];
}
@end
