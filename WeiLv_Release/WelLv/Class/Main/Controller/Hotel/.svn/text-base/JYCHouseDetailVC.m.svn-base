//
//  JYCHouseDetailVC.m
//  WelLv
//
//  Created by lyx on 15/10/10.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCHouseDetailVC.h"
#define M_HeadImageHeight  self.view.frame.size.width * (333 / 640.0)

@interface JYCHouseDetailVC ()


@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *headImageView;
@property(nonatomic,strong)UIView *topview;
@property(nonatomic,strong)UIView *containView;
@property(nonatomic,strong)UIView *tiaoJianView;
@property(nonatomic,strong)UIView *confirmView;
@property(nonatomic,strong)UIView *BookView;
@end

@implementation JYCHouseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"房型详情";
    self.view.backgroundColor=[UIColor whiteColor];
    [self addScrollView];
    
}
-(void)addScrollView
{
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
    [self.view addSubview:self.scrollView];
    [self.scrollView setContentSize:CGSizeMake(0, windowContentHeight+100)];
    self.scrollView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self addHeaderView];
}
-(void)addHeaderView
{
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, M_HeadImageHeight)];
    self.headImageView.backgroundColor = [UIColor whiteColor];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", WLHTTP]] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    
    [self.scrollView addSubview:self.headImageView];
    [self createTopView];
}
-(void)createTopView
{
    self.topview=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(self.headImageView), windowContentWidth, 80)];
    //self.topview.backgroundColor=[UIColor redColor];
    UILabel *typeHouse=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 200, 20)];
    typeHouse.text=@"商务间（有床）";
    typeHouse.font=systemFont(18);
    typeHouse.textColor=[UIColor blackColor];
    [self.topview addSubview:typeHouse];
    UILabel *isFirstBread=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(typeHouse)+15, 200, 20)];
    isFirstBread.text=@"有早餐";
    isFirstBread.font=systemFont(15);
    isFirstBread.textColor=[UIColor grayColor];
    [self.topview addSubview:isFirstBread];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(self.topview)-1, windowContentHeight, 0.5)];
    line1.backgroundColor=bordColor;
    [self.topview addSubview:line1];
    [self.scrollView addSubview:self.topview];
    [self createContainView];
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
    self.containView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(self.topview), windowContentHeight,a*20+(a+1)*15)];
    
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
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(self.containView)-0.5, windowContentHeight, 0.5)];
    line2.backgroundColor=bordColor;
    [self.containView addSubview:line2];
    [self.scrollView addSubview:self.containView];
    [self createTiaoJianView];
}
-(void)createTiaoJianView
{
    self.tiaoJianView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(self.containView), windowContentWidth, 100)];
    //纵向的间隔
    CGFloat hSpace = (ViewHeight(self.tiaoJianView) - 3*20)/4;

    UILabel *cancelLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, hSpace, 80, 20)];
    cancelLabel.text=@"限时取消:";
    cancelLabel.textColor=[UIColor grayColor];
    [self.tiaoJianView addSubview:cancelLabel];
    UILabel *cancelContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(cancelLabel)+5, hSpace, windowContentWidth-ViewRight(cancelLabel), 20)];
    cancelContentLabel.text=@"nirong";
    cancelContentLabel.textAlignment=NSTextAlignmentLeft;
    [self.tiaoJianView addSubview:cancelContentLabel];
    UILabel *bedLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(cancelLabel)+hSpace, 80, 20)];
    bedLabel.text=@"加床:";
    bedLabel.textColor=[UIColor grayColor];
    [self.tiaoJianView addSubview:bedLabel];
    UILabel *bedContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(bedLabel)+5, ViewBelow(cancelLabel)+hSpace, windowContentWidth-ViewRight(cancelLabel), 20)];
    bedContentLabel.text=@"4544432";
    bedContentLabel.textAlignment=NSTextAlignmentLeft;
    [self.tiaoJianView addSubview:bedContentLabel];
    UILabel *otherLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(bedLabel)+hSpace, 80, 20)];
    otherLabel.text=@"其他:";
    otherLabel.textColor=[UIColor grayColor];
    [self.tiaoJianView addSubview:otherLabel];
    UILabel *otherContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(otherLabel)+5, ViewBelow(bedLabel)+hSpace, windowContentWidth-ViewRight(cancelLabel), 20)];
    otherContentLabel.text=@"dfdfdsfds";
    otherContentLabel.textAlignment=NSTextAlignmentLeft;
    [self.tiaoJianView addSubview:otherContentLabel];
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0,ViewHeight(self.tiaoJianView)-0.5, windowContentHeight, 0.5)];
    line3.backgroundColor=bordColor;
    [self.tiaoJianView addSubview:line3];
    [self.scrollView addSubview:self.tiaoJianView];
    [self createConfirmView];
    
}
-(void)createConfirmView
{
    self.confirmView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(self.tiaoJianView), windowContentWidth, 100)];
    UILabel *confirmLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 60, 20)];
    confirmLabel.backgroundColor=[UIColor greenColor];
    confirmLabel.text=@"立即确认";
    confirmLabel.textColor=[UIColor whiteColor];
    confirmLabel.font=systemFont(15);
    [self.confirmView addSubview:confirmLabel];
    UILabel *confirmContentLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(confirmLabel)+8, 10, windowContentWidth-ViewRight(confirmLabel), 20)];
    confirmContentLabel.text=@"该房型一旦确认，无需等待，马上有房。";
    confirmContentLabel.font=systemFont(12);
    [self.confirmView addSubview:confirmContentLabel];
    
    [self.scrollView addSubview:self.confirmView];
    [self createBookView];
}
-(void)createBookView
{
    self.BookView=[[UIView alloc]initWithFrame:CGRectMake(0, ControllerViewHeight - 40, windowContentWidth, 40)];
   // self.BookView.backgroundColor = [UIColor blackColor];
    UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(0,0, windowContentHeight, 0.5)];
    line4.backgroundColor=bordColor;
    [self.BookView addSubview:line4];
    UILabel *priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,(40-20)/2 , 100, 20)];
    priceLabel.textColor=[UIColor colorWithRed:253/255.0 green:76/255.0 blue:36/255.0 alpha:1];
    priceLabel.text=[NSString stringWithFormat:@"￥%d",3569];
    [self.BookView addSubview:priceLabel];
    UIButton *bookBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth/2, 0, windowContentWidth/2,40)];
    bookBtn.backgroundColor=[UIColor colorWithRed:253/255.0 green:91/255.0 blue:38/255.0 alpha:1];
    [bookBtn setTitle:@"立即预订" forState:UIControlStateNormal];
    [bookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bookBtn addTarget:self action:@selector(btnClick) forControlEvents: UIControlEventTouchUpInside];
    [self.BookView addSubview:bookBtn];
    [self.view addSubview:self.BookView];
    
}
-(void)btnClick
{
    NSLog(@"111");
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
