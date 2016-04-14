//
//  JYCcommentVC.m
//  WelLv
//
//  Created by lyx on 15/11/25.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCcommentVC.h"
#import "WXUtil.h"
#import "TimeLogModel.h"
#define commentUrl   [NSString stringWithFormat:@"%@/api/drivingApi/save_memeber_shop_appraise",WLHTTP]
@interface JYCcommentVC ()
{
    UIScrollView *scrollview;
    UIView *timeView;
    UILabel *commetLabel2;
    UIView *averangeCommentView;
    BOOL good;
    int type;
    AFHTTPRequestOperationManager *manager;
}
@end

@implementation JYCcommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"评价";
    self.view.backgroundColor=BgViewColor;
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //searchBtn.hidden=YES;
    searchBtn.frame=CGRectMake(0, 0, 40, 20);
    [searchBtn setTitle:@"提交" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    //[searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    scrollview.backgroundColor=[UIColor colorWithRed:221/255.0 green:230/255.0 blue:236/255.0 alpha:1];
    scrollview.contentSize=CGSizeMake(windowContentWidth, windowContentHeight+100);
    [self.view addSubview:scrollview];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    [self initUI];
}
-(void)initUI
{
   
    NSLog(@"%@",self.rArr);
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, 40*self.rArr.count)];
    topView.backgroundColor=[UIColor whiteColor];
    [scrollview addSubview:topView];
    for (int i=0; i<self.rArr.count; i++) {
        productsModel *model=[[productsModel alloc]init];
        model=self.rArr[i];
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15+40*i, 10, 10)];
        imageView.backgroundColor=[UIColor greenColor];
        imageView.layer.cornerRadius=5.0;
        [topView addSubview:imageView];
        UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(imageView)+10, 0+i*40, 100, 40)];
        nameLabel.font=systemFont(18);
        nameLabel.textColor=[UIColor blackColor];
       // model=self.arr[i];
        nameLabel.text=model.describe;
        [topView addSubview:nameLabel];
        UILabel *numBerLabel=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth/3*2, 0+40*i, 20, 40)];
        numBerLabel.textColor=[UIColor blackColor];
        numBerLabel.text=[NSString stringWithFormat:@"%d",[model.nums intValue]];
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
        if (i==self.rArr.count-1) {
            line.hidden=YES;
        }
    }
    timeView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(topView)+10, windowContentWidth, 40)];
    timeView.backgroundColor=[UIColor whiteColor];
    [scrollview addSubview:timeView];
    UILabel *timeLeftLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
    timeLeftLabel.text=@"购买时间";
    timeLeftLabel.textColor=[UIColor blackColor];
    timeLeftLabel.font=systemFont(18);
    [timeView addSubview:timeLeftLabel];
     UILabel  *timeRightLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(timeLeftLabel)+10, 0, windowContentWidth-100, 40)];
    timeRightLabel.textColor=[UIColor orangeColor];
    
    NSString *str=[self returnStrFromSeconds:[self.dict[@"create_time"]doubleValue]];
    
    
    timeRightLabel.text=[NSString stringWithFormat:@"%@",str];
    timeRightLabel.textAlignment=NSTextAlignmentLeft;
    timeRightLabel.font=systemFont(18);
    [timeView addSubview:timeRightLabel];
    averangeCommentView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(timeView)+10, windowContentWidth, 160)];
    averangeCommentView.backgroundColor=[UIColor whiteColor];
    [scrollview addSubview:averangeCommentView];
    UILabel *commentLabel1=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 40)];
    commentLabel1.text=@"总体评价";
    commentLabel1.textColor=[UIColor blackColor];
    [averangeCommentView addSubview:commentLabel1];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 40, windowContentWidth, 1)];
    line.backgroundColor=bordColor;
    [averangeCommentView addSubview:line];
    CGFloat space=(windowContentWidth-120)/3;
    NSArray *imagesArr=[NSArray arrayWithObjects:@"好评图标-默认",@"差评图标", nil];
    NSArray *titleAr=[NSArray arrayWithObjects:@"好评",@"差评", nil];
    
    for (int i=0; i<titleAr.count; i++) {
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(space+space*i+i*60,ViewBelow(line)+ 15, 60, 60)];
    [btn setBackgroundImage:[UIImage imageNamed:imagesArr[i]] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
     btn.tag=101+i;
    [averangeCommentView addSubview:btn];
        if (i==0) {
            commetLabel2=[[UILabel alloc]initWithFrame:CGRectMake(space+10, ViewBelow(btn)+10, 40, 20)];
        }else if(i==1)
        {
            commetLabel2=[[UILabel alloc]initWithFrame:CGRectMake(space+10+space+20+40, ViewBelow(btn)+10, 40, 20)];
        }
    commetLabel2.textAlignment=NSTextAlignmentCenter;
    commetLabel2.tag=1001+i;
    commetLabel2.text=[NSString stringWithFormat:@"%@",titleAr[i]];
    commetLabel2.textColor=[UIColor grayColor];
    [averangeCommentView addSubview:commetLabel2];
    }
   
   
}
-(void)btnClick:(UIButton *)btn
{
    
    if (btn.tag==101) {
        [btn setBackgroundImage:[UIImage imageNamed:@"好评图标"] forState:UIControlStateNormal];
        UIButton *button2=(UIButton *)[averangeCommentView viewWithTag:102];
        [button2 setBackgroundImage:[UIImage imageNamed:@"差评图标"] forState:UIControlStateNormal];
        UILabel *label1=(UILabel *)[averangeCommentView viewWithTag:1001];
        label1.textColor=[UIColor orangeColor];
        UILabel *label2=(UILabel *)[averangeCommentView viewWithTag:1002];
        label2.textColor=[UIColor grayColor];
        good=YES;
        
    }else if(btn.tag==102)
    {
        good=NO;
        [btn setBackgroundImage:[UIImage imageNamed:@"差评图标点击"] forState:UIControlStateNormal];
        UIButton *button2=(UIButton *)[averangeCommentView viewWithTag:101];
        [button2 setBackgroundImage:[UIImage imageNamed:@"好评图标-默认"] forState:UIControlStateNormal];
        UILabel *label1=(UILabel *)[averangeCommentView viewWithTag:1002];
        label1.textColor=[UIColor orangeColor];
        UILabel *label2=(UILabel *)[averangeCommentView viewWithTag:1001];
        label2.textColor=[UIColor grayColor];
    }
}
-(NSString *)returnStrFromSeconds:(double)seconds
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [formatter stringFromDate:localeDate];
    NSLog(@"%@",currentDateStr);
    return currentDateStr;
}

-(void)commitBtnClick
{
    
    
    if (good==YES) {
        type=1;
    }else if (good==NO)
    {
        type=2;
    }
    
    NSLog(@"%d",type);
    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
    NSString * memberId =[[WLSingletonClass defaultWLSingleton]wlUserID];
    NSString *token1 = [token stringByAppendingString:memberId];
    
    NSDictionary *parameters = @{@"driving_order_id":self.driveOrderId,@"type'":@(type),@"partner_id":self.dict[@"driving_features_eat_partner_id"],@"partner_member_id":self.dict[@"driving_features_eat_partner_member_id"]};
    
    NSString *str=[[WLSingletonClass defaultWLSingleton]wlDictionaryToJson:parameters];
    NSDictionary *dict=@{@"datajson":str,@"wltoken":[WXUtil md5:token1],@"'member_id":memberId};
    
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:EatCommentUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject){
   
        
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"++++%@----",dict);
        
            
            
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       // NSLog(@"%@",error);
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
