//
//  GuanjiaInfoViewController.m
//  WelLv
//
//  Created by mac for csh on 15/5/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#define beginX1 15
#define beginY1 15
#define beginX2 90
#define offset 10

#import "GuanjiaInfoViewController.h"
#import "GuanjiaManageSelfinfoViewController.h"
#import "LXCommonTools.h"

@interface GuanjiaInfoViewController ()
{
    UIView* vieww;
}
@end

@implementation GuanjiaInfoViewController
@synthesize yewuString,suoshuString,dizhiString,geyanString;

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi:) name:@"tongzhi" object:nil];
    for(UIView *view in [vieww subviews])
    {
        [view removeFromSuperview];
    }

    [self initView];
  //   NSLog(@"----1%@-----2%@-----3%@---4%@---",yewuString,suoshuString,dizhiString,geyanString);
}

- (void)tongzhi:(NSNotification *)text{
    NSString* string =  text.userInfo[@"title"];
    if ([string isEqualToString:@"精通业务"]) {
        yewuString = text.userInfo[@"textViewString"];
    }else if ([string isEqualToString:@"管家所属"]) {
        suoshuString = text.userInfo[@"textViewString"];
    }else if ([string isEqualToString:@"公司地址"]) {
        dizhiString = text.userInfo[@"textViewString"];
    }else if ([string isEqualToString:@"人生格言"]) {
        geyanString = text.userInfo[@"textViewString"];
    }
 //   NSLog(@"－－－－－接收到通知------");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"管家信息";
    self.view.backgroundColor = BgViewColor;
    
    vieww = [[UIView alloc] initWithFrame:CGRectMake(0, beginY1, windowContentWidth, windowContentHeight/2)];
    vieww.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vieww];
    //[self initView];
    NSLog(@"load----1%@-----2%@-----3%@---4%@---",yewuString,suoshuString,dizhiString,geyanString);
}

-(void)initView{
    
  /*---------------------------------右侧label----------------------------*/
    
    UILabel *yewuLabel = [[UILabel alloc] initWithFrame:CGRectMake(beginX2, beginY1+10, windowContentWidth-beginX2-beginX1-offset, [[LXCommonTools sharedMyTools] textHeight:yewuString Afont:16 width:windowContentWidth-beginX2-beginX1-offset])];
    [yewuLabel setBackgroundColor:[UIColor clearColor]];
    //yewuLabel.text = [NSString stringWithFormat:@"多年海外旅行活动策划经验，法、意、澳资深行程设计师，顾客服务专家"];
    yewuLabel.text =yewuString;
    yewuLabel.textAlignment = NSTextAlignmentLeft;
    yewuLabel.font = [UIFont systemFontOfSize:16];
    yewuLabel.textColor =[UIColor blackColor];
    yewuLabel.numberOfLines = 0;
    UIButton *yewuBtn = [[UIButton alloc] initWithFrame:yewuLabel.frame];
    yewuBtn.backgroundColor = [UIColor clearColor];
    yewuBtn.tag = 0;
    [yewuBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [vieww addSubview:yewuLabel];
    [vieww addSubview:yewuBtn];
    UIImageView *igv1 = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45, ViewHeight(yewuLabel)/2+ViewY(yewuLabel)-15, 45, 30)];
    [igv1 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [vieww addSubview:igv1];
    UILabel *lab11 = [[UILabel alloc] initWithFrame:CGRectMake(0,ViewY(yewuLabel)+ViewHeight(yewuLabel)-1 , windowContentWidth, 1)];
    lab11.backgroundColor = kColor(227, 233, 238);
    [vieww addSubview:lab11];
    
    UILabel *suoshuLabel = [[UILabel alloc] initWithFrame:CGRectMake(beginX2, ViewY(yewuLabel)+ViewHeight(yewuLabel)+15, windowContentWidth-beginX2-beginX1-offset, [[LXCommonTools sharedMyTools] textHeight:suoshuString Afont:16 width:windowContentWidth-beginX2-beginX1-offset])];
    [suoshuLabel setBackgroundColor:[UIColor clearColor]];
    //suoshuLabel.text = [NSString stringWithFormat:@"郑州哪玩旅行社"];
    suoshuLabel.text = suoshuString;
    suoshuLabel.textAlignment = NSTextAlignmentLeft;
    suoshuLabel.font = [UIFont systemFontOfSize:16];
    suoshuLabel.textColor =[UIColor blackColor];
    suoshuLabel.numberOfLines = 0;
    UIButton *suoshuBtn = [[UIButton alloc] initWithFrame:suoshuLabel.frame];
    suoshuBtn.backgroundColor = [UIColor clearColor];
    suoshuBtn.tag = 1;
    [suoshuBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [vieww addSubview:suoshuLabel];
    [vieww addSubview:suoshuBtn];
    /*UIImageView *igv2 = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45, ViewHeight(suoshuLabel)/2+ViewY(suoshuLabel)-15, 45, 30)];
    [igv2 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [vieww addSubview:igv2];*/
    UILabel *lab12 = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewHeight(suoshuLabel)+ViewY(suoshuLabel)-1, windowContentWidth, 1)];
    lab12.backgroundColor = kColor(227, 233, 238);
    [vieww addSubview:lab12];

    UILabel *dizhiLabel = [[UILabel alloc] initWithFrame:CGRectMake(beginX2, ViewY(suoshuLabel)+ViewHeight(suoshuLabel)+15, windowContentWidth-beginX2-beginX1-offset, [[LXCommonTools sharedMyTools] textHeight:dizhiString Afont:16 width:windowContentWidth-beginX2-beginX1-offset])];
    [dizhiLabel setBackgroundColor:[UIColor clearColor]];
   // dizhiLabel.text = [NSString stringWithFormat:@"郑州市金水区金水路玉凤路浦发国际金融中心1901室"];
    dizhiLabel.text = dizhiString;
    dizhiLabel.textAlignment = NSTextAlignmentLeft;
    dizhiLabel.font = [UIFont systemFontOfSize:16];
    dizhiLabel.textColor =[UIColor blackColor];
    dizhiLabel.numberOfLines = 0;
    UIButton *dizhiBtn = [[UIButton alloc] initWithFrame:dizhiLabel.frame];
    dizhiBtn.backgroundColor = [UIColor clearColor];
    dizhiBtn.tag = 2;
    [dizhiBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [vieww addSubview:dizhiLabel];
    [vieww addSubview:dizhiBtn];
  /*  UIImageView *igv3 = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45, ViewHeight(dizhiLabel)/2+ViewY(dizhiLabel)-15, 45, 30)];
    [igv3 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [vieww addSubview:igv3];*/
    UILabel *lab13 = [[UILabel alloc] initWithFrame:CGRectMake(0, ViewY(dizhiLabel)+ViewHeight(dizhiLabel)-1, windowContentWidth, 1)];
    lab13.backgroundColor = kColor(227, 233, 238);
    [vieww addSubview:lab13];


    UILabel *geyanLabel = [[UILabel alloc] initWithFrame:CGRectMake(beginX2, ViewY(dizhiLabel)+ViewHeight(dizhiLabel)+15, windowContentWidth-beginX2-beginX1-offset, [[LXCommonTools sharedMyTools] textHeight:geyanString Afont:16 width:windowContentWidth-beginX2-beginX1-offset])];
    [geyanLabel setBackgroundColor:[UIColor clearColor]];
   // geyanLabel.text = [NSString stringWithFormat:@"追寻芬兰圣诞老人，领略挪威海下风光，沐浴在丹麦樱花下，漫步在瑞典"];
    geyanLabel.text = geyanString;
    geyanLabel.textAlignment = NSTextAlignmentLeft;
    geyanLabel.font = [UIFont systemFontOfSize:16];
    geyanLabel.textColor =[UIColor blackColor];
    geyanLabel.numberOfLines = 0;
    UIButton *geyanBtn = [[UIButton alloc] initWithFrame:geyanLabel.frame];
    geyanBtn.backgroundColor = [UIColor clearColor];
    geyanBtn.tag = 3;
    [geyanBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [vieww addSubview:geyanLabel];
    [vieww addSubview:geyanBtn];
    UIImageView *igv4 = [[UIImageView alloc] initWithFrame:CGRectMake(windowContentWidth-45, ViewHeight(geyanLabel)/2+ViewY(geyanLabel)-15, 45, 30)];
    [igv4 setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
    [vieww addSubview:igv4];
    
    [vieww setFrame:CGRectMake(0, beginY1, windowContentWidth, ViewHeight(geyanLabel)+ViewY(geyanLabel)+15)];
    
    /*----------------------------左侧label-----------------------------*/
    float lineHeight = [[LXCommonTools sharedMyTools] textHeight:@"" Afont:16 width:windowContentWidth-beginX2-beginX1-15];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(beginX1, ViewY(yewuLabel), windowContentHeight, lineHeight)];
    [label1 setBackgroundColor:[UIColor clearColor]];
    label1.text = [NSString stringWithFormat:@"精通业务"];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.font = [UIFont systemFontOfSize:16];
    label1.textColor =[UIColor grayColor];
    [vieww addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(beginX1, ViewY(suoshuLabel), windowContentHeight, lineHeight)];
    [label2 setBackgroundColor:[UIColor clearColor]];
    label2.text = [NSString stringWithFormat:@"管家所属"];
    label2.textAlignment = NSTextAlignmentLeft;
    label2.font = [UIFont systemFontOfSize:16];
    label2.textColor =[UIColor grayColor];
    [vieww addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(beginX1, ViewY(dizhiLabel), windowContentHeight, lineHeight)];
    [label3 setBackgroundColor:[UIColor clearColor]];
    label3.text = [NSString stringWithFormat:@"公司地址"];
    label3.textAlignment = NSTextAlignmentLeft;
    label3.font = [UIFont systemFontOfSize:16];
    label3.textColor =[UIColor grayColor];
    [vieww addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(beginX1, ViewY(geyanLabel), windowContentHeight, lineHeight)];
    [label4 setBackgroundColor:[UIColor clearColor]];
    label4.text = [NSString stringWithFormat:@"人生格言"];
    label4.textAlignment = NSTextAlignmentLeft;
    label4.font = [UIFont systemFontOfSize:16];
    label4.textColor =[UIColor grayColor];
    [vieww addSubview:label4];
}

-(void)click:(id)sender{
    UIButton *btn = sender;
    NSLog(@"%ld",(long)btn.tag);
    NSString *titleString = @"";
    if (btn.tag == 0) {
        titleString = @"精通业务";
    }else if(btn.tag == 1) {
        titleString = @"管家所属";
    }else if(btn.tag == 2) {
        titleString = @"公司地址";
    }else if(btn.tag == 3) {
        titleString = @"人生格言";
    }
    
    if (btn.tag == 1) {
        [[LXAlterView sharedMyTools] createTishi:@"您没有权限更换所属公司"];
    }else if (btn.tag == 2){
        [[LXAlterView sharedMyTools] createTishi:@"您没有权限更换公司地址"];
    }else{
    GuanjiaManageSelfinfoViewController *manageVc = [[GuanjiaManageSelfinfoViewController alloc] init];
    manageVc.title =titleString;
    [self.navigationController pushViewController:manageVc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
