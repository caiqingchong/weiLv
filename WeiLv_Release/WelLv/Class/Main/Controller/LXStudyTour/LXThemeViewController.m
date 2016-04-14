//
//  LXThemeViewController.m
//  WelLv
//
//  Created by 刘鑫 on 15/8/20.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXThemeViewController.h"
#import "LXSTModel.h"
#import "LXSTListViewController.h"

@interface LXThemeViewController ()
{
    NSMutableArray *_themeArray;
}

@end

@implementation LXThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"主题列表";
    [self initData];
}

-(void)initData
{
    _themeArray=[[NSMutableArray alloc] initWithCapacity:0];
    [self sendRequest];
    
}

-(void)sendRequest
{
    
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:StudyTourThemeUrl parameters:nil
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              DLog(@"列表dic===%@",dic);
              if ([[dic objectForKey:@"status"] intValue]==1) {
                  if ([[dic objectForKey:@"data"] isKindOfClass:[NSArray class]]) {
                      NSArray *adArr=[dic objectForKey:@"data"] ;
                      for (NSDictionary *dic1 in adArr) {
                          LXSTModel *model=[[LXSTModel alloc] initWithDictionary:dic1];
                          
                          [_themeArray addObject:model];
                      }
                  }
                  
                  if ([[dic objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                      NSArray *adArr=[[dic objectForKey:@"data"] allKeys];
                      for (int i=0; i<adArr.count; i++) {
                          LXSTModel *model=[[LXSTModel alloc] initWithDictionary:[[dic objectForKey:@"data"] objectForKey:[adArr objectAtIndex:i]]];
                         [_themeArray addObject:model];
                      }
                      
                  }
                  
                  [self initThemeView:_themeArray];
              }
              
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              DLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
                  [self sendRequest];
              }];
              
          }];

}

-(void)initThemeView:(NSMutableArray *)dataArray
{
    
   
    
    float space = 5;
    float w = (windowContentWidth-20-5)/2;
    float height =w*.63;
    float X = 10;
    
    NSUInteger number = dataArray.count%2==0 ? dataArray.count:dataArray.count+1;

    UIScrollView *bgScrollView=[[UIScrollView alloc] init];
    bgScrollView.frame=self.view.frame;
    bgScrollView.contentSize=CGSizeMake(windowContentWidth, height*(number/2)+50);
    [self.view addSubview:bgScrollView];
    
    for (int i = 0; i<dataArray.count; i++) {
        LXSTModel *model=[dataArray objectAtIndex:i];
        
        UIButton *traveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        traveBtn.frame = CGRectMake(X+(w+space)*(i%2), 10+space*(i/2)+i/2*height, w, height);

        [traveBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",WLHTTP,model.picture]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"默认图1"]];

        traveBtn.tag = i;
        [traveBtn addTarget:self action:@selector(traveClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgScrollView addSubview:traveBtn];
        
        UILabel *title = [YXTools allocLabel:model.title font:systemFont(16) textColor:[UIColor whiteColor] frame:CGRectMake(3, ViewHeight(traveBtn)-23, ViewWidth(traveBtn)-3, 20) textAlignment:0];
        [traveBtn addSubview:title];
     
    }
}

-(void)traveClick:(UIButton *)btn
{
    LXSTModel *model=[_themeArray objectAtIndex:btn.tag];
    DLog(@"产品推荐--%lu,%@",(unsigned long)index,model.title);
    LXSTListViewController *listVc=[[LXSTListViewController alloc] init];
    //listVc.stModel=model;
    listVc.themeType=model.name;
    listVc.sourceType=Theme1;
    [self.navigationController pushViewController:listVc animated:YES];
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
