//
//  AroundScenicLiscViewController.m
//  WelLv
//
//  Created by mac for csh on 15/11/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "AroundScenicLiscViewController.h"
#import "aroundSceincmodel.h"
#import "SenicCellView.h"
#import "MainViewController.h"
#import "TraveSearchViewController.h"
#import "TravelScreenViewController.h"
#import "LXGetCityIDTool.h"
#import "GuoneiViewController.h"

@interface AroundScenicLiscViewController ()
{
    UIScrollView *_scrollView;
}

@end

@implementation AroundScenicLiscViewController
@synthesize aroundSenicListArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // NSLog(@"ararr = %@",self.aroundSenicListArr);
    self.navigationItem.title = @"周边景点";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth,windowContentHeight)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_scrollView];
    
//    if (self.aroundSenicListArr && self.aroundSenicListArr.count > 0) {
//        [self initView];
//    }
    [self initData];
}
-(void)initData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:AdvertUrl(@"119", [[WLSingletonClass defaultWLSingleton] wlCityId]) parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject)
     {
         [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
         
         self.aroundSenicListArr = [[NSMutableArray alloc] init];
         [self.aroundSenicListArr removeAllObjects];
         NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         //DLog(@"周边景点广告===%@",array);
         if (array != nil) {
             for (int i=0; i<array.count; i++) {
                 aroundSceincmodel *detailModel = [[aroundSceincmodel alloc] init];
                 NSDictionary *dic=[array objectAtIndex:i];
                 [detailModel setValuesForKeysWithDictionary:dic];
                 [self.aroundSenicListArr addObject:detailModel];
             }
             [self initView];
         }else{
             //[[LXAlterView sharedMyTools]createTishi:@"暂无数据"];
         }

         
     }failure:^(AFHTTPRequestOperation *operation,NSError *error){
         [[LXAlterView sharedMyTools]createTishi:@"请检查网络设置"];
     }];


}

-(void)initView{
   
    float image_width = (windowContentWidth - 10 * 2 -5)/2;
    float image_Height = image_width / 35 * 22;
    
    for (int i = 0; i <aroundSenicListArr.count; i ++) {
        float x = i%2 == 0 ? 10:10+image_width+5;
        int heig = i/2;
        float y = 10 +(image_Height +5)*heig;
        //float y = i-2 < 0 ? 37.5:37.5+image_Y +5;
        NSString *imagestr = @"";
        NSString *titlestr = @"";
        NSString *detailstr = @"";
        if (self.aroundSenicListArr && self.aroundSenicListArr.count>i) {
            aroundSceincmodel *model = [self.aroundSenicListArr objectAtIndex:i];
            imagestr = model.src;
            titlestr = model.title;
            detailstr = model.descriptionn;
        }
        
        SenicCellView *seniccell = [[SenicCellView alloc] initWithFrame:CGRectMake(x,y,image_width,image_Height) AndImageString:imagestr AndTitle:titlestr AndDetailTitleString:detailstr];
        seniccell.btn.tag = i + 300;
        [seniccell.btn addTarget:self action:@selector(SenicClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:seniccell];
        if (i ==self.aroundSenicListArr.count -1 && (y+image_Height+5 > windowContentHeight - 64)) {
            _scrollView.contentSize =CGSizeMake(windowContentWidth, y + image_Height +5+64);
        }
    }
}
- (void)SenicClick:(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag-300);
    aroundSceincmodel * model = [self.aroundSenicListArr objectAtIndex:sender.tag - 300];
    
    GuoneiViewController *screenVC = [[GuoneiViewController alloc]init];
    screenVC.lastViewControllerTag = @"100";
    screenVC.search_type = @"1";
    screenVC.productListTitle = model.title;
    screenVC.cityTitle = model.title;
    screenVC.rote_ID = -11;
    [self.navigationController pushViewController:screenVC animated:YES];

    
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
