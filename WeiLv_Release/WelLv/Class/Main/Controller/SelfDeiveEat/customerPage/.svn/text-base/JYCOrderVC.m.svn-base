//
//  JYCOrderVC.m
//  WelLv
//
//  Created by lyx on 15/11/16.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCOrderVC.h"
#import "RestauantModel.h"
#import "JYCRestauantVC.h"
#import "JYCbeizhuViewVC.h"
#import "YXVisaPayViewController.h"
#import "JYCvisaOrderVC.h"
#import "YXTools.h"
#import "LoginAndRegisterViewController.h"

@interface JYCOrderVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIButton *totalBtn;
    UIScrollView *scrollview;
    float totalTitle;
    UIDatePicker *picker;
    UILabel *timeLabel;
    UIView *hejiVIew;
    UIView *viewBtn;
    UIButton *cancelBtn;
    UIButton *okBtn;
    UILabel *timeLabel2;
    UIPickerView *pickerView;
    //NSMutableArray *arr;
    UILabel *numLabel2;
    UILabel *beizhuLabel2;
    UITextField *contectField;
    UITextField *telField;
    NSString *chuStr;
    NSString *timeStr;
    NSString *numberStr;
    BOOL isNeed;
    AFHTTPRequestOperationManager *manager;
    
    UILabel *hejiRightLabel;
    NSTimeInterval timeStamp;
    
}
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *idArr;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation JYCOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    //self.title=@"XXX农家乐";
    _dataArr=[[NSMutableArray alloc]init];
    _idArr=[[NSMutableArray alloc]init];
    timeStamp=0;
    for (int i=1; i<=99; i++) {
        [self.dataArr addObject:@(i)];
    }
    for (RestauantModel *model in self.arr) {
        [self.idArr addObject:model.userid];
    }
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    scrollview.backgroundColor=[UIColor colorWithRed:221/255.0 green:230/255.0 blue:236/255.0 alpha:1];
    scrollview.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+100);
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignKeyboard)];
    //设置点击次数和点击手指数
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [scrollview addGestureRecognizer:tapGesture];
    
    [self.view addSubview:scrollview];
    [self createUI];
    [self createPicker];
}
-(void)resignKeyboard
{
    [scrollview setFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-40)];
    
    [contectField resignFirstResponder];
    [telField resignFirstResponder];
    
}
-(void)createUI
{
   // NSMutableArray *arr=[NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, self.arr.count*40)];
    topView.backgroundColor=[UIColor whiteColor];
    [scrollview addSubview:topView];
    for (int i=0; i<self.arr.count; i++) {
        RestauantModel *model=[[RestauantModel alloc]init];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15+40*i, 10, 10)];
        imageView.backgroundColor=[UIColor greenColor];
        imageView.layer.cornerRadius=5.0;
        [topView addSubview:imageView];
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(imageView)+10, 0+i*40, 100, 40)];
        nameLabel.font=systemFont(18);
        nameLabel.textColor=[UIColor blackColor];
        model=self.arr[i];
        nameLabel.text=model.describe;
        [topView addSubview:nameLabel];
        UILabel *numBerLabel=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth/3*2, 0+40*i, 20, 40)];
        numBerLabel.textColor=[UIColor blackColor];
        numBerLabel.text=[NSString stringWithFormat:@"%d",model.total];
        numBerLabel.font=systemFont(18);
        [topView addSubview:numBerLabel];
        UILabel *priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-90, 0+i*40, 80, 40)];
        priceLabel.textColor=[UIColor orangeColor];
        priceLabel.textAlignment=NSTextAlignmentRight;
        priceLabel.text=[NSString stringWithFormat:@"￥%0.1f",[model.price floatValue]];
        priceLabel.font=systemFont(18);
        [topView addSubview:priceLabel];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(ViewX(nameLabel), 39+i*40, windowContentWidth-ViewX(nameLabel), 1)];
        line.backgroundColor=bordColor;
        [topView addSubview:line];
        if (i==self.arr.count-1) {
            line.hidden=YES;
        }
    }
    hejiVIew=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(topView)+10, windowContentWidth, 40)];
    hejiVIew.backgroundColor=[UIColor whiteColor];
    [scrollview addSubview:hejiVIew];
    UILabel *hejiLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    hejiLabel.text=@"合计";
    hejiLabel.textColor=[UIColor blackColor];
    hejiLabel.font=systemFont(18);
    [hejiVIew addSubview:hejiLabel];
    hejiRightLabel=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-10-180, 0, 180, 40)];
    hejiRightLabel.textColor=[UIColor orangeColor];
    totalTitle=0;
    for (RestauantModel *model in self.arr) {
        totalTitle=totalTitle+[model.price floatValue]*model.total;
    }
    

    hejiRightLabel.text=[NSString stringWithFormat:@"￥%0.2f",totalTitle];
    hejiRightLabel.textAlignment=NSTextAlignmentRight;
    hejiRightLabel.font=systemFont(18);
    [hejiVIew addSubview:hejiRightLabel];
    UIView *middleView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(hejiVIew)+10, windowContentWidth, 160)];
    middleView.backgroundColor=[UIColor whiteColor];
    [scrollview addSubview:middleView];
    timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0,80 , 40)];
    timeLabel.text=@"就餐时间";
    UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, 40)];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn1.tag=101;
    
    timeLabel.textColor=[UIColor blackColor];
    timeLabel.font=systemFont(18);
    [middleView addSubview:timeLabel];
    timeLabel2=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-20-210, 0, 210, 40)];
    timeLabel2.textColor=[UIColor grayColor];
    timeLabel2.textAlignment=NSTextAlignmentRight;
    //timeLabel2.text=@"2015年11月25日 12：00";
    timeLabel2.font=systemFont(18);
    [middleView addSubview:timeLabel2];
    UIImageView *timeImage=[[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-19,11.5
                                                                        , 9, 17)];
    timeImage.image=[UIImage imageNamed:@"矩形-41"];
    [middleView addSubview:timeImage];
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 39, windowContentWidth, 1)];
    line1.backgroundColor=bordColor;
    [middleView addSubview:line1];
    [middleView addSubview:btn1];
    
    UILabel *numLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 80, 40)];
    numLabel.textColor=[UIColor blackColor];
    numLabel.text=@"就餐人数";
    numLabel.font=systemFont(18);
    [middleView addSubview:numLabel];
    numLabel2=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-20-45, 40, 40, 40)];
    //numLabel2.text=@"4人";
    numLabel2.textAlignment=NSTextAlignmentRight;
    numLabel2.textColor=[UIColor grayColor];
    [middleView addSubview:numLabel2];
    UIImageView *numImage=[[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-19, 11.5+40, 9, 17)];
    numImage.image=[UIImage imageNamed:@"矩形-41"];
    [middleView addSubview:numImage];
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, 79, windowContentWidth, 1)];
    line2.backgroundColor=bordColor;
    UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(0, 40, windowContentWidth, 40)];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag=102;

    [middleView addSubview:line2];
    [middleView addSubview:btn2];
    
    UILabel *canWeiLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 80, 80, 40)];
    canWeiLabel.textColor=[UIColor blackColor];
    canWeiLabel.text=@"餐位要求";
    canWeiLabel.font=systemFont(18);
    [middleView addSubview:canWeiLabel];
    UILabel *baojianLabel=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-115, 80, 40, 40)];
    baojianLabel.textColor=[UIColor grayColor];
    baojianLabel.text=@"包间";
    baojianLabel.textAlignment=NSTextAlignmentRight;
    [middleView addSubview:baojianLabel];
    UISwitch *switch1=[[UISwitch alloc]initWithFrame:CGRectMake(windowContentWidth-60, 85, 60, 30)];
    switch1.onTintColor=[UIColor orangeColor];
    [switch1 setOn:YES];
    [switch1 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [middleView addSubview:switch1];
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0, 119, windowContentWidth, 1)];
    line3.backgroundColor=bordColor;
    [middleView addSubview:line3];
    UILabel *beizhuLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 120, 40, 40)];
    beizhuLabel.text=@"备注";
    beizhuLabel.textColor=[UIColor blackColor];
    beizhuLabel.font=systemFont(18);
    [middleView addSubview:beizhuLabel];
    beizhuLabel2=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(beizhuLabel)+40, 120, windowContentWidth-19-50, 40)];
    beizhuLabel2.font=systemFont(18);
    
    beizhuLabel2.textColor=[UIColor grayColor];
    //beizhuLabel2.text=self.str;
    [middleView addSubview:beizhuLabel2];
    UIImageView *beizhuImage=[[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-19, 130.5, 9, 17)];
    beizhuImage.image=[UIImage imageNamed:@"矩形-41"];
    UIButton *btn3=[[UIButton alloc]initWithFrame:CGRectMake(0, 120, windowContentWidth, 40)];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn3.tag=103;
    [middleView addSubview:beizhuImage];
    [middleView addSubview:btn3];
    
    UIView *contectView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(middleView)+10, windowContentWidth, 80)];
    contectView.backgroundColor=[UIColor whiteColor];
    [scrollview addSubview:contectView];
    UILabel *contectLable=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 40)];
    contectLable.textColor=[UIColor blackColor];
    contectLable.text=@"联系人";
    contectLable.font=systemFont(18);
    [contectView addSubview:contectLable];
    contectField=[[UITextField alloc]initWithFrame:CGRectMake(ViewRight(contectLable)+20, 0, windowContentWidth-90, 40)];
    contectField.placeholder=@"必填";
    contectField.textColor=[UIColor grayColor];
    [contectView addSubview:contectField];
    UIView *line5=[[UIView alloc]initWithFrame:CGRectMake(0, 39, windowContentWidth, 1)];
    line5.backgroundColor=bordColor;
    [contectView addSubview:line5];
    UILabel *telLbale=[[UILabel alloc]initWithFrame:CGRectMake(10, 40, 60, 40)];
    telLbale.textColor=[UIColor blackColor];
    telLbale.text=@"手机号";
    telLbale.font=systemFont(18);
    [contectView addSubview:telLbale];
    telField=[[UITextField alloc]initWithFrame:CGRectMake(ViewRight(telLbale)+20, 40, windowContentWidth-90, 40)];
    telField.textColor=[UIColor grayColor];
    telField.placeholder=@"必填";
    [contectView addSubview:telField];
    
    UIButton *queBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, ViewBelow(contectView)+10, 15, 15)];
    [queBtn setBackgroundImage:[UIImage imageNamed:@"已同意"] forState:UIControlStateNormal];
    [queBtn addTarget:self action:@selector(queRenBtn:) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:queBtn];
    
    UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(queBtn)+10,ViewY(queBtn),110, 15)];
    textLabel.textColor=[UIColor grayColor];
    textLabel.font=systemFont(10);
    textLabel.text=@"请在提交前确认您已阅读";
    [scrollview addSubview:textLabel];
    UIButton *detailBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewRight(textLabel), ViewY(queBtn), 110, 15)];
    [detailBtn setTitle:@"平台条款(这里用什么)" forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    detailBtn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
    [scrollview addSubview:detailBtn];
    [detailBtn addTarget:self action:@selector(detailBtn) forControlEvents:UIControlEventTouchUpInside];
    [scrollview addSubview:detailBtn];
    UIView *botomView=[[UIView alloc]init];
   
    botomView.frame =CGRectMake(0,windowContentHeight-64-40, windowContentWidth, 40);
    botomView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:botomView];
    totalBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth/2, 40)];
    [totalBtn setTitle:[NSString stringWithFormat:@"总金额:%@",hejiRightLabel.text] forState:UIControlStateNormal];
    [totalBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [totalBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    totalBtn.tag=106;
    [botomView addSubview:totalBtn];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth(totalBtn)-23, 16.5, 13, 7)];
    image.image=[UIImage imageNamed:@"订单明细按钮"];
    [totalBtn addSubview:image];
    UIButton *orderBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth/2, 0, windowContentWidth/2, 40)];
    orderBtn.backgroundColor=[UIColor orangeColor];
    [orderBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    orderBtn.tag=107;
    [botomView addSubview:orderBtn];

}
-(void)switchAction:(UISwitch *)Switch
{
    if ([Switch isOn]) {
        isNeed=YES;
        chuStr=@"需要包间";
    }else if(![Switch isOn])
    {
        isNeed=NO;
         chuStr=@"不需要包间";
    }

}

-(void)createPicker
{
    
    picker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, ViewY(hejiVIew)+100, windowContentWidth, 300)];
    picker.backgroundColor=[UIColor whiteColor];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];//设置为中
    picker.locale = locale;
    [picker addTarget:self action:@selector(change) forControlEvents:UIControlEventValueChanged];
   
    pickerView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, ViewY(hejiVIew)+100, windowContentWidth, 100)];
    pickerView.backgroundColor=[UIColor whiteColor];
    pickerView.showsSelectionIndicator=YES;
   
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
    [self.view addSubview:pickerView];
    pickerView.hidden=YES;
       [self.view addSubview:picker];
    viewBtn=[[UIView alloc]initWithFrame:CGRectMake(0, ViewY(picker)-40, windowContentWidth, 40)];
    viewBtn.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:viewBtn];
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, 1)];
    line3.backgroundColor=bordColor;
    [viewBtn addSubview:line3];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 39, windowContentWidth, 1)];
    line.backgroundColor=bordColor;
    [viewBtn addSubview:line];
    viewBtn.hidden=YES;
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(windowContentWidth/2, 0, 1, 40)];
    line2.backgroundColor=bordColor;
    [viewBtn addSubview:line2];
    
    cancelBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0,windowContentWidth/2,40)];
    [cancelBtn setTitle:@"取消"forState:UIControlStateNormal];
    cancelBtn.tag=104;
    [cancelBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [viewBtn addSubview:cancelBtn];
    okBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth/2, 0, windowContentWidth/2, 40)];
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    okBtn.tag=105;
    [viewBtn addSubview:okBtn];
    picker.hidden=YES;
}
-(void)change
{
    NSDate *selected = [picker date];
    timeStamp= [selected timeIntervalSince1970];
    NSLog(@"%f",timeStamp);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    timeStr=[NSString stringWithFormat:@"%@",destDateString];
}
-(void)close
{
    //self.navigationController.navigationBarHidden=YES;
    if (self.type==1) {
        self.navigationController.navigationBarHidden=NO;
    }else if (self.type==2)
    {
        self.navigationController.navigationBarHidden=YES;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnClick:(UIButton *)button
{
    if (button.tag==101) {
        NSLog(@"123");
        picker.hidden=NO;
        viewBtn.hidden=NO;
    }else if(button.tag==102)
    {
        pickerView.hidden=NO;
        viewBtn.hidden=NO;
        NSLog(@"456");
    }else if(button.tag==103)
    {
        
        JYCbeizhuViewVC *VC=[[JYCbeizhuViewVC alloc]init];
        VC.chuBlock=^(NSString *str){
            beizhuLabel2.text=str;
        };
        [self.navigationController pushViewController:VC animated:YES];
    }else if(button.tag==104)
    {
        
        
        picker.hidden=YES;
        viewBtn.hidden=YES;
        pickerView.hidden=YES;
    
    }else if (button.tag==105)
    {
        timeLabel2.text=timeStr;
        
        if (!timeLabel2.text) {
            [[LXAlterView sharedMyTools]createTishi:@"请滑动选择日期"];
        }
       
        
        numLabel2.text=numberStr;
        if (!numLabel2.text) {
            
            [[LXAlterView sharedMyTools]createTishi:@"请滑动选择人数"];
            
        }
        //picker.hidden=YES;
         picker.hidden=YES;
        viewBtn.hidden=YES;
        pickerView.hidden=YES;
        
    }else if (button.tag==106)
    {
        
    }else if(button.tag==107)
    {
        if (!timeLabel2.text) {
            [[LXAlterView sharedMyTools]createTishi:@"请选择日期"];
            return;
        }if (!numLabel2.text) {
           [[LXAlterView sharedMyTools]createTishi:@"请选择人数"];
            return;
        }if (!chuStr) {
            chuStr=@"需要包间";
        }
        if (!beizhuLabel2.text) {
            beizhuLabel2.text=@"还没有填写备注...";
        }
        if ([contectField.text isEqualToString:@""]) {
            [[LXAlterView sharedMyTools] createTishi:@"请填写联系人信息"];
            return;
        }
        NSLog(@"%@发",contectField.text);
        
        if (![YXTools isValidateMobile:telField.text]) {
            [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
            return;
        }
       
        NSString * user_id = [[[LXUserTool alloc] init] getUid];
        if (user_id == nil) {
            LoginAndRegisterViewController * vc = [[LoginAndRegisterViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }

        NSString *token = @"~0;id<zOD.{ll@]JKi(:";
        NSString * memberId = user_id;
        NSString *token1 = [token stringByAppendingString:memberId];
        
        NSDictionary *parameters = @{@"come_time":@((int)timeStamp),@"nums":@([numLabel2.text intValue]),@"is_room":@(isNeed),@"mark":beizhuLabel2.text,@"phone":telField.text,@"contacts":contectField.text,@"model_id":@"-6",@"source":@"App",@"product_id":self.idArr};
    
        NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
        NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:token1],@"member_id":memberId};
        NSLog(@"%@",dict);
        [self sendWithDict:dict];
      }
}
-(void)sendWithDict:(NSDictionary *)dict
{
   // __weak typeof(self)weakSelf =self;
    [self setProgressHud];
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:EatPostOrderUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"++++%@------",dict);
        if ([dict[@"state"]integerValue]==1) {
            [_hud hide:YES];
            NSMutableArray *arr=[[NSMutableArray alloc]init];
            [arr removeAllObjects];
            arr=[NSMutableArray arrayWithObjects:timeLabel2.text,numLabel2.text,chuStr, beizhuLabel2.text,nil];
            NSDictionary *dict2=dict[@"data"];
            NSLog(@"贾玉川%@",dict2);
            JYCvisaOrderVC *vc=[[JYCvisaOrderVC alloc]init];
            vc.arr=arr;
            vc.sn=dict2[@"sn"];
            vc.price=dict2[@"price"];
            vc.bTitle=dict2[@"title"];
            vc.extra_common_param=dict2[@"extra_common_param"];
            vc.partner_shop_name=dict2[@"partner_shop_name"];
            vc.order_id=dict2[@"order_id"];
            vc.come_time=dict2[@"come_time"];
            vc.nums=dict2[@"nums"];
            vc.phone=dict2[@"phone"];
            vc.contacts=dict2[@"contacts"];
            NSLog(@"%@",vc.order_id);
            //YXVisaPayViewController *vc=[[YXVisaPayViewController alloc]init];
            vc.hejiStr=[NSString stringWithFormat:@"%@",hejiRightLabel.text];
            [self.navigationController pushViewController:vc animated:YES];

        
        }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [_hud hide:YES];
    }];

}

//数据加载完成之前显示转动的菊花圈
- (void)setProgressHud
{
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    _hud.frame = self.view.bounds;
    _hud.minSize = CGSizeMake(100, 100);
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.labelText = @"正在提交...";
    [self.view addSubview:_hud];
    [_hud show:YES];
}

-(void)detailBtn
{
    
}
-(void)queRenBtn:(UIButton *)button
{
    
    if (button.selected) {
       [button setBackgroundImage:[UIImage imageNamed:@"已同意"] forState:UIControlStateNormal];
    }else if(!button.selected)
    {
        [button setBackgroundImage:[UIImage imageNamed:@"不同意"] forState:UIControlStateNormal];
    }
    button.selected=!button.selected;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 99;
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
   return  90;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    numberStr=[NSString stringWithFormat:@"%@人",[self.dataArr objectAtIndex:row]];
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str=[NSString stringWithFormat:@"%@",[self.dataArr objectAtIndex:row]];
    return str;
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
