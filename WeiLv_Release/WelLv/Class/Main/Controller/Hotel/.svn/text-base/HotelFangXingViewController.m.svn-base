//
//  HotelFangXingViewController.m
//  WelLv
//
//  Created by mac for csh on 15/10/14.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//



#import "HotelFangXingViewController.h"

@interface HotelFangXingViewController ()
{
    UIScrollView *_scrollView;
    
}
@property(nonatomic,strong)UIView *containView;
@end

@implementation HotelFangXingViewController
@synthesize containView;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"房型详情";
    _scrollView  = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    [self initScrollview];
}

-(void)initScrollview{
    UILabel *phoneLab = [[UILabel alloc] initWithFrame:CGRectMake( Begin_X,0, 45, 45)];
    phoneLab.text = @"电话：";
    phoneLab.font = [UIFont systemFontOfSize:15];
    phoneLab.textAlignment = NSTextAlignmentLeft;
    phoneLab.textColor = [UIColor blackColor];
    [_scrollView addSubview:phoneLab];
    
    UIButton *tele = [[UIButton alloc] initWithFrame:CGRectMake(ViewX(phoneLab)+ViewWidth(phoneLab) ,0, windowContentWidth - ViewX(phoneLab)-ViewWidth(phoneLab), 45)];
    [tele setTitle:@"400-021-8888" forState:UIControlStateNormal];
    [tele setTitleColor:kColor(46, 205, 112) forState:UIControlStateNormal];
    tele.titleLabel.font = [UIFont systemFontOfSize:15];
    tele.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [tele addTarget:self action:@selector(MakeTeleCall:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:tele];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(phoneLab)+ViewHeight(phoneLab)-0.7, windowContentWidth, 0.7)];
    line.backgroundColor = bordColor;
    [_scrollView addSubview:line];
    

    UILabel *timeS = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X,ViewY(phoneLab)+ViewHeight(phoneLab), windowContentWidth -Begin_X, 30)];//[[UILabel alloc] initWithFrame:CGRectMake(Begin_X,ViewY(phoneLab)+ViewHeight(phoneLab), 80, 30)];
    timeS.text = @"开业时间：2014年12月12日";
    timeS.font = [UIFont systemFontOfSize:15];
    timeS.textAlignment = NSTextAlignmentLeft;
    timeS.textColor = [UIColor blackColor];
    [_scrollView addSubview:timeS];
    
    UILabel *timeE = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X,ViewY(timeS)+ViewHeight(timeS), windowContentWidth -Begin_X, 30)];
    timeE.text = @"装修时间：2015年12月12日";
    timeE.font = [UIFont systemFontOfSize:15];
    timeE.textAlignment = NSTextAlignmentLeft;
    timeE.textColor = [UIColor blackColor];
    [_scrollView addSubview:timeE];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(timeE)+ViewHeight(timeE)-0.7, windowContentWidth, 0.7)];
    line1.backgroundColor = bordColor;
    [_scrollView addSubview:line1];
    
    UILabel *Sheshilab = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X,ViewY(timeE)+ViewHeight(timeE), 80, 30)];
    Sheshilab.text = @"酒店设施";
    Sheshilab.font = [UIFont systemFontOfSize:15];
    Sheshilab.textAlignment = NSTextAlignmentLeft;
    Sheshilab.textColor = [UIColor blackColor];
    [_scrollView addSubview:Sheshilab];

    [self createContainView];

    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(self.containView)+ViewY(self.containView), windowContentHeight, 20)];
    line2.backgroundColor=BgViewColor;
    [_scrollView addSubview:line2];
    
    UILabel *hotelIns = [[UILabel alloc] initWithFrame:CGRectMake(Begin_X,ViewY(line2)+ViewHeight(line2), 80, 30)];
    hotelIns.text = @"酒店介绍";
    hotelIns.font = [UIFont systemFontOfSize:15];
    hotelIns.textAlignment = NSTextAlignmentLeft;
    hotelIns.textColor = [UIColor blackColor];
    [_scrollView addSubview:hotelIns];
    
   UITextView *mesTextView = [[UITextView alloc] initWithFrame:CGRectMake(Begin_X, ViewY(hotelIns)+ViewHeight(hotelIns), windowContentWidth -Begin_X*2, 150)];
    mesTextView.font = [UIFont systemFontOfSize:12];
    mesTextView.backgroundColor = [UIColor whiteColor];
    mesTextView.textColor = kColor(115, 115, 120);
    mesTextView.text = @"    文字介绍，首行缩进";
    mesTextView.textAlignment = NSTextAlignmentLeft;
    mesTextView.hidden = NO;
   // mesTextView.delegate = self;
    [_scrollView addSubview:mesTextView];
    
}

-(void)MakeTeleCall:(UIButton *)button{
    //拨打酒店电话
    NSString *number = button.titleLabel.text;
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

//创建包含条件的View
-(void)createContainView
{
    NSArray *imageNames = @[@"免费wifi",@"免费宽带",@"免费停车场",@"接机服务",@"游泳池",@"健身房",@"商务中心",@"会议室",@"酒店餐厅"];
    double a=0;
    if (imageNames.count%3==0) {
        a=(imageNames.count/3);
    }else
    {
        a=(imageNames.count/3)+1;
    }
    self.containView=[[UIView alloc]initWithFrame:CGRectMake(0, 45+30*3, windowContentHeight,a*20+(a+1)*15)];
    
    //横向的间隔
    CGFloat wSpace = (windowContentWidth - 3*100)/3;
    
    //纵向的间隔
    CGFloat hSpace = 15;
    
    
    //纵向的间隔
    
    for (int i = 0; i<imageNames.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image=[UIImage imageNamed:imageNames[i]];
        
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 10;
        //九宫格坐标的小算法:(横坐标:i%横向显示个数的最大值;纵坐标:i/纵向的个数的最大值)
        [imageView setFrame:CGRectMake(wSpace/2+10+(i%3)*(100+wSpace),hSpace +(i/3)*(hSpace+20), 20,20)];
        [self.containView addSubview:imageView];
        
        //创建label
        UILabel *label = [[UILabel alloc ]initWithFrame:CGRectMake(wSpace/2+25+10+(i%3)*(100+wSpace),hSpace + (i/3)*(hSpace+20), 75, 20)];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentLeft;
        label.text=imageNames[i];
        [self.containView addSubview:label];
        
        
    }

    [_scrollView addSubview:self.containView];
}

@end
