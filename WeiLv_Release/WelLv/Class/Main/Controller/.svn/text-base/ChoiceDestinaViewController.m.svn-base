//
//  ChoiceDestinaViewController.m
//  WelLv
//
//  Created by mac for csh on 15/11/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ChoiceDestinaViewController.h"
#import "DestiationModel.h"
#import "DestinationCellVIew.h"
//#import "YXDetailTraveViewController.h"
#import "TraveSearchViewController.h"
#import "TravelScreenViewController.h"
#import "GuoneiViewController.h"

@interface ChoiceDestinaViewController ()

{
    UIScrollView *_scrollView;
}

@end

@implementation ChoiceDestinaViewController
@synthesize destinaArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"ararr = %@",self.destinaArr);
    self.navigationItem.title = @"精选旅行目的地";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth,windowContentHeight)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
    //    if (self.destinaArr && self.destinaArr.count > 0) {
    //        [self initView];
    //    }
    [self initData];
}

-(void)initData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:ShouYeMoreDestinations([[WLSingletonClass defaultWLSingleton] wlCityId]) parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
         
         self.destinaArr = [[NSMutableArray alloc] init];
         [self.destinaArr removeAllObjects];
         /* NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
          //DLog(@"周边景点广告===%@",array);
          if (array != nil) {
          for (int i=0; i<array.count; i++) {
          DestiationModel *detailModel = [[DestiationModel alloc] init];
          NSDictionary *dic=[array objectAtIndex:i];
          [detailModel setValuesForKeysWithDictionary:dic];
          [self.destinaArr addObject:detailModel];
          }*/
         NSString *html = operation.responseString;
         NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
         NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
         if ([[dict objectForKey:@"state"] integerValue] == 1 && [dict objectForKey:@"data"] && [dict objectForKey:@"data"]!= nil && [[dict objectForKey:@"data"] isKindOfClass:[NSArray class]] && [[dict objectForKey:@"data"] count]>0) {
             NSArray *array = [dict objectForKey:@"data"];
             //DLog(@"周边景点广告===%@",array);
             if (array != nil) {
                 for (int i=0; i<array.count; i++) {
                     DestiationModel *detailModel = [[DestiationModel alloc] init];
                     NSDictionary *dic=[array objectAtIndex:i];
                     [detailModel setValuesForKeysWithDictionary:dic];
                     [self.destinaArr addObject:detailModel];
                 }
                 [self initView];
             }
         }else if([[dict objectForKey:@"state"] integerValue] == 0) {
             [[LXAlterView sharedMyTools]createTishi:@"城市ID缺失"];
         }else if([[dict objectForKey:@"state"] integerValue] == -1){
             [[LXAlterView sharedMyTools]createTishi:@"获取数据失败"];
         }else{
             [[LXAlterView sharedMyTools]createTishi:@"获取数据失败"];
         }
         
         
         
         
         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         [[LXAlterView sharedMyTools]createTishi:@"请检查网络设置"];
     }];
    
    
}

-(void)initView{
    float image_Width = (windowContentWidth - 10 * 2 );
    float image_Height = image_Width/ 71 * 37;
    
    for (int i = 0; i < self.destinaArr.count; i ++) {
        float y = 10 + (image_Height + 10)*i;
        DestiationModel * model = [self.destinaArr objectAtIndex:i];
        DestinationCellVIew *destinCV = [[DestinationCellVIew alloc] initWithFrame:CGRectMake(10, y, image_Width,image_Height ) AndImageString:model.src AndCityTitle:model.title];
        destinCV.btn.tag = 1000+i;
        [destinCV.btn addTarget:self action:@selector(destinationClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_scrollView addSubview:destinCV];
        
        if (i ==self.destinaArr.count -1 && (y+image_Height+5 > windowContentHeight - 64)) {
            _scrollView.contentSize =CGSizeMake(windowContentWidth, y + image_Height +5+64);
        }
    }
    
    
    
}

-(void)destinationClick:(UIButton *)sender{
//    NSLog(@"%ld",(long)sender.tag- 1000);
    
    DestiationModel * model = [self.destinaArr objectAtIndex:sender.tag - 1000];
    // NSDictionary *dic = model.gotoDic;
    // NSLog(@"%@",model.gotoDic);
    
#pragma mark ------------修改筛选页面--------------
    GuoneiViewController *travelScreenVC = [[GuoneiViewController alloc]init];
    travelScreenVC.productListTitle = model.title;
    travelScreenVC.search_type = @"1";
    travelScreenVC.lastViewControllerTag = @"200";
    travelScreenVC.rote_ID = -11;
    travelScreenVC.cityTitle = model.title;
    travelScreenVC.city_id = [[WLSingletonClass defaultWLSingleton] wlCityId];
    [self.navigationController pushViewController:travelScreenVC animated:YES];

}

@end
