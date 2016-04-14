//
//  JYCRightView.m
//  WelLv
//
//  Created by lyx on 15/11/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCRightView.h"
#import "DriveModel.h"
#import "JYCcurrentPosition.h"

@interface JYCRightView()
{
    UIScrollView *scrollView;
    AFHTTPRequestOperationManager *manager;
    NSDictionary *dict2;
}
@property(nonatomic,strong)NSMutableArray *baseArr;
@end

@implementation JYCRightView


- (id)initWithFrame:(CGRect)frame with:(NSString *)shopId
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _shopId=shopId;
        
        self.backgroundColor=[UIColor whiteColor];
       
        _baseArr=[[NSMutableArray alloc]init];
   
        scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-40)];
        scrollView.backgroundColor=BgViewColor;
        [self addSubview:scrollView];
        _imageArr=[[NSMutableArray alloc]init];
        [self initData];
    }
    return self;
}
-(void)initData
{
   // NSString *token = @"~0;id<zOD.{ll@]JKi(:";
   // NSString * memberId = [[WLSingletonClass defaultWLSingleton]wlUserID];
   
   // NSString *token1 = [token stringByAppendingString:memberId];
   
    NSDictionary *dict=@{@"shopId":self.shopId};
    DLog(@"dict ====  %@",dict);
    [self postWith:dict];
}
-(void)postWith:(NSDictionary *)dict
{
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:ShopDetailUrl parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject){
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        dict2=dict[@"data"];
        NSString *telStr=dict2[@"main_phone"];
        NSUserDefaults * telSets = [NSUserDefaults standardUserDefaults];
        [telSets setObject:telStr forKey:@"main_phone"];
         [telSets synchronize];
        
        NSLog(@"++++%@-----",dict2);
        NSMutableArray *arr=[[NSMutableArray alloc]init];
        arr=dict2[@"offline_info"];
        for (id obj in arr) {
            offline_infoModel *model=[[offline_infoModel alloc]init];
            [model setValuesForKeysWithDictionary:obj];
            [self.baseArr addObject:model];
        }
       [self createUI];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    

}
-(void)createUI
{
    
    NSLog(@"%@",dict2[@"open_hours"]);
    NSDictionary *dict= [[WLSingletonClass defaultWLSingleton]wlJsonStringToDicOrArr:dict2[@"open_hours"]];
    NSNumber *am=dict[@"AM"];
    NSString *amStr=[NSString stringWithFormat:@"%@",am];
    NSString *pm=dict[@"PM"];
    NSString *pmStr=[NSString stringWithFormat:@"%@",pm];
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, windowContentWidth, 40)];
    topView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:topView];
    UIImageView *leftImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 20, 24)];
    leftImage.image=[UIImage imageNamed:@"通过健康安全认证"];
    [topView addSubview:leftImage];
    
    UILabel *approveLeftLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(leftImage)+5, 0, 120, 40)];
    approveLeftLabel.textColor=[UIColor blackColor];
    //approveLeftLabel.textAlignment=NSTextAlignmentLeft;
    approveLeftLabel.text=@"通过健康安全认证";
    approveLeftLabel.font=systemFont(15);
    [topView addSubview:approveLeftLabel];
    UIImageView *rightView=[[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-10-120-25, 8, 21, 24)];
    rightView.image=[UIImage imageNamed:@"通过营业执照核查"];
    [topView addSubview:rightView];
    UILabel *approveRightLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(rightView)+5, 0, 120, 40)];
    approveRightLabel.textColor=[UIColor blackColor];
    approveRightLabel.text=@"通过营业执照核查";
    approveRightLabel.font=systemFont(15);
    //approveLeftLabel.textAlignment=NSTextAlignmentRight;
    [topView addSubview:approveRightLabel];
    
    UIView *timeView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(topView)+10, windowContentWidth, 70)];
    timeView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:timeView];
    UILabel *timeLable=[[UILabel alloc]initWithFrame:CGRectMake(10, 22.5, 80, 20)];
    timeLable.textColor=[UIColor blackColor];
    timeLable.text=@"营业时间";
    timeLable.font=systemFont(18);
    [timeView addSubview:timeLable];
    UILabel *timeLabel1=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(timeLable)+10, 10, 140, 20)];
    timeLabel1.textColor=[UIColor blackColor];
    if ([self judgeString:amStr]) {
    NSArray *amArr=[amStr componentsSeparatedByString:@"-"];
        NSLog(@"%@",amArr);
    timeLabel1.text=[NSString stringWithFormat:@"%@-%@",[self returnStrFromSeconds:[amArr[0] doubleValue]],[self returnStrFromSeconds:[amArr[1] doubleValue]]];
    }else{
      timeLabel1.text=@"";
    }
    
    timeLabel1.font=systemFont(18);
    [timeView addSubview:timeLabel1];
    UILabel *timeLabel2=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(timeLable)+10, 40, 140, 20)];
    timeLabel2.textColor=[UIColor blackColor];
    if ([self judgeString:pmStr]) {
        
        NSArray *pmArr=[pmStr componentsSeparatedByString:@"-"];
       // NSLog(@"%@",pmArr);
        timeLabel2.text=[NSString stringWithFormat:@"%@-%@",[self returnStrFromSeconds:[pmArr[0] doubleValue]],[self returnStrFromSeconds:[pmArr[1] doubleValue]]];
    }else{
        timeLabel2.text=@"";
    }

    
//    timeLabel2.text=[NSString stringWithFormat:@"%@-%@",[self returnStrFromSeconds:[pmArr[0] doubleValue]],[self returnStrFromSeconds:[pmArr[1] doubleValue]]];
    timeLabel2.font=systemFont(18);
    [timeView addSubview:timeLabel2];
    UILabel *yingYeLabel=[[UILabel alloc]initWithFrame:CGRectMake(windowContentWidth-10-70, 0, 70, 70)];
    yingYeLabel.textColor=[UIColor orangeColor];
    yingYeLabel.text=@"(营业中)";
    yingYeLabel.font=systemFont(18);
    [timeView addSubview:yingYeLabel];
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, 69, windowContentWidth, 1)];
    line1.backgroundColor=bordColor;
    [timeView addSubview:line1];
    UIView *beizhuView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(timeView), windowContentWidth, 40)];
    beizhuView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:beizhuView];
    UILabel *beizhuLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 40, 20)];
    beizhuLabel.textColor=[UIColor blackColor];
    beizhuLabel.text=@"备注";
    beizhuLabel.font=systemFont(18);
    [beizhuView addSubview:beizhuLabel];
    UILabel *beizhuLabel1=[[UILabel alloc]initWithFrame:CGRectMake(ViewX(timeLabel1), 0, windowContentWidth-ViewX(timeLabel1), 40)];
    beizhuLabel1.textColor=[UIColor grayColor];
    beizhuLabel1.font=systemFont(18);
    if (!dict2[@"remark"]) {
        beizhuLabel1.text=[NSString stringWithFormat:@"%@",dict2[@"remark"]];
    }
    beizhuLabel1.text=@"无";
    [beizhuView addSubview:beizhuLabel1];
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, 39, windowContentWidth, 1)];
    line2.backgroundColor=bordColor;
    [beizhuView addSubview:line2];
    
    UIView *addressView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(beizhuView), windowContentWidth, 40)];
    addressView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:addressView];
    UIButton *adressBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, 40)];
    [addressView addSubview:adressBtn];
    [adressBtn addTarget:self action:@selector(adressBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    addressLabel.textColor=[UIColor blackColor];
    addressLabel.text=@"商铺地址";
    addressLabel.font=systemFont(18);
    [addressView addSubview:addressLabel];
    
    UILabel *detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewX(timeLabel1), 10, windowContentWidth-120, 20)];
    detailLabel.textColor=[UIColor grayColor];
    detailLabel.text=[NSString stringWithFormat:@"%@",dict2[@"shop_dir"]];
    detailLabel.font=systemFont(12);
    [addressView addSubview:detailLabel];
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-24, 11, 14, 18)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    [addressView addSubview:rightBtn];
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0, 39, windowContentWidth, 1)];
    line3.backgroundColor=bordColor;
    [addressView addSubview:line3];
    
    UIView *driveView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(addressView), windowContentWidth, 80)];
    driveView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:driveView];
    UILabel *driveLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    driveLabel.textColor=[UIColor blackColor];
    driveLabel.font=systemFont(18);
    driveLabel.text=@"导航提示";
    [driveView addSubview:driveLabel];
    UILabel *detailDriveLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewX(timeLabel1),10, windowContentWidth-110, 60)];
    detailDriveLabel.textColor=[UIColor grayColor];
    detailDriveLabel.font=systemFont(15);
    detailDriveLabel.numberOfLines=3;
    detailDriveLabel.text=[NSString stringWithFormat:@"%@",dict2[@"friendly_msg"]];
    [driveView addSubview:detailDriveLabel];
    UIView *activeView=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(driveView)+10, windowContentWidth, 160)];
    
    activeView.backgroundColor=[UIColor whiteColor];
    [scrollView addSubview:activeView];
    UILabel *activeLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    activeLabel.textColor=[UIColor blackColor];
    activeLabel.font=systemFont(18);
    activeLabel.text=@"商家活动";
    [activeView addSubview:activeLabel];
  
    for (int i=0; i< self.baseArr.count; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, i*(20+10)+40, 20, 20)];
       
        
        
        offline_infoModel *mod=[[offline_infoModel alloc]init];
        mod=self.baseArr[i];
        
        NSString * str;
        
        if ([mod.type intValue]==1) {
            str=@"满";
        }if ([mod.type intValue]==2) {
            str=@"评";
        }if ([mod.type intValue]==3) {
            str=@"进";
        }if ([mod.type intValue]==4) {
            str=@"送";
        }

        imageView.image=[UIImage imageNamed:str];
        [activeView addSubview:imageView];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(imageView)+7, i*(20+10)+40, 200, 20)];
        label.font=[UIFont systemFontOfSize:18];
        label.text=[NSString stringWithFormat:@"%@",mod.info];
        label.textColor=[UIColor grayColor];
        [activeView addSubview:label];
        
    }

    
}
-(void)adressBtnClick:(UIButton *)button
{

    CLLocationCoordinate2D coor;
    coor.latitude=[dict2[@"latitude"] floatValue];
    coor.longitude=[dict2[@"longitude"] floatValue];
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:@(coor.latitude),@"1",@(coor.longitude),@"2", nil];
    if ([self.delegate respondsToSelector:@selector(clickPush:)]) {
        [self.delegate performSelector:@selector(clickPush:) withObject:dict];
    }
    
  
    
}
-(NSString *)returnStrFromSeconds:(double)seconds
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [formatter stringFromDate:date];
    return currentDateStr;
}

@end
