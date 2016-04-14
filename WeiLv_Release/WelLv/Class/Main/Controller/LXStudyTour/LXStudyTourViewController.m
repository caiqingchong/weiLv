//
//  LXStudyTourViewController.m
//  WelLv
//
//  Created by lx on 15/8/11.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#define BannerHegit 150*HeightScale

#import "LXStudyTourViewController.h"
#import "YXBannerView.h"
#import "LXStudyTourView.h"
#import "LXSTListViewController.h"
#import "LXSTModel.h"
#import "HotCountryOrCityVC.h"
#import "LXThemeViewController.h"
#import "LXSTDetailViewController.h"
#import "LXGetCityIDTool.h"

@interface LXStudyTourViewController ()<UITableViewDataSource,UITableViewDelegate,EScrollerViewDelegate,LXStudyTourDelegate>
{
    UITableView *_tableView;
    YXBannerView *_bannerView;
    NSMutableArray *_adArray;
    NSMutableArray *_hot_cityArray;
    NSMutableArray *_themeArray;
}

@end

@implementation LXStudyTourViewController

- (void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"游学";
    
    UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame=CGRectMake(0, 0, 23, 23);
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    
    [self initData];
    [self initView];
}

-(void)searchBtnClick
{
    SearchViewController *seachVc=[[SearchViewController alloc] init];
    seachVc.searchType=5;
    [self.navigationController pushViewController:seachVc animated:YES];
}

-(void)initData
{
  
    _adArray=[[NSMutableArray alloc] initWithCapacity:0];
    _hot_cityArray=[[NSMutableArray alloc] initWithCapacity:0];
    _themeArray=[[NSMutableArray alloc] initWithCapacity:0];
    NSString *url=[NSString stringWithFormat:@"%@/api/yoosure/%@",WLHTTP,@"index"];
    [self sendRequest:nil aurl:url aTag:1];
    [self sendRequest:nil aurl:AdvertUrl(@"91", [[WLSingletonClass defaultWLSingleton] wlCityId]) aTag:2];
}

-(void)initView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, ControllerViewHeight)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
}

-(void)initHeaderView
{
    UIView *hearderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 180*HeightScale+BannerHegit)];
    
    //轮播图
    NSMutableArray *arr = [NSMutableArray  array];

    for (LXAdvertModel *model in _adArray)
    {
        NSString *imageUrl=[NSString stringWithFormat:@"%@%@", WLHTTP,model.src];
        [arr addObject:imageUrl];
    }
    if (_bannerView != nil)
    {
        [_bannerView removeFromSuperview];
    }
    _bannerView = [[YXBannerView alloc] initWithFrameRect:CGRectMake(0, 0, windowContentWidth, BannerHegit) ImageArray:arr];
    _bannerView.delegate = self;
    [hearderView addSubview:_bannerView];

    CGFloat leftBtnHeight = 180*HeightScale-20;
    
    UIButton *timeLimitBtn=[YXTools allocButton:nil textColor:nil nom_bg:[UIImage imageNamed:@"study_tour_product_rec"] hei_bg:nil frame:CGRectMake(10, ViewY(_bannerView)+ViewHeight(_bannerView)+10, windowContentWidth - 20, leftBtnHeight)];
    timeLimitBtn.backgroundColor=[UIColor redColor];
    timeLimitBtn.layer.cornerRadius=3;
    [timeLimitBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    timeLimitBtn.tag=1;
    [hearderView addSubview:timeLimitBtn];

   _tableView.tableHeaderView=hearderView;
    
}

-(void)btnClick:(UIButton *)btn
{
    if (btn.tag==1)
    {
        LXSTListViewController *listVc=[[LXSTListViewController alloc] init];
        
        [self.navigationController pushViewController:listVc animated:YES];
        
    }
    else if (btn.tag==2)
    {
        LXSTListViewController *listVc=[[LXSTListViewController alloc] init];
        
        [self.navigationController pushViewController:listVc animated:YES];
        
    }
    else if (btn.tag==3)
    {
        
        LXSTListViewController *listVc=[[LXSTListViewController alloc] init];
        
        [self.navigationController pushViewController:listVc animated:YES];
    }
}

#pragma mark EscrollViewDelegate
-(void)EScrollerViewDidClicked:(NSUInteger)index
{

    if (_adArray.count >0)
    {
        LXAdvertModel *model=[_adArray objectAtIndex:index-1];
        NSDictionary *dic = model.gotoDic;//[LXTools dictionaryWithJsonString:model.gotoDic];
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"type"] isEqualToString:@"list"])
        {
            //跳转列表页
                LXSTListViewController *yoosure = [[LXSTListViewController alloc] init];
                
                if ([self judgeString:[dic objectForKey:@"d_country"]]) {
                    yoosure.city_name = [[[dic objectForKey:@"d_country"] componentsSeparatedByString:@"-"] objectAtIndex:1];
                }
                if ([self judgeString:[dic objectForKey:@"yoosure_type"]]) {
                    yoosure.themeType = [dic objectForKey:@"yoosure_type"];
                }
                
                [self.navigationController pushViewController:yoosure animated:YES];
                
        }
        else if([[dic objectForKey:@"type"] isEqualToString:@"detail"])
        {
            //跳转详情页
                LXSTDetailViewController *yxDetailVc=[[LXSTDetailViewController alloc] init];
                yxDetailVc.productId=[dic objectForKey:@"product_id"];
                [self.navigationController pushViewController:yxDetailVc animated:YES];
                
        }
        else if ([[dic objectForKey:@"type"] isEqualToString:@"page"])
        {
            //跳转网页
            if ([[dic objectForKey:@"link"] hasPrefix:@"https://"] || [[dic objectForKey:@"link"] hasPrefix:@"http://"])
            {
                NSString *url=[model.link stringByReplacingOccurrencesOfString:@"android" withString:@"ios"];
                DLog(@"点击了-%@",url);
                LXSpecialViewController *specialVc=[[LXSpecialViewController alloc] init];
                specialVc.loadUrl=url;
                specialVc.title=model.title;
                [self.navigationController pushViewController:specialVc animated:YES];
            }
            else
            {
                DLog(@"没有连接");
            }
            
        }
        else if([[dic objectForKey:@"type"] isEqualToString:@"index"])
        {
            //跳转首页
            LXStudyTourViewController *yxDetailVc=[[LXStudyTourViewController alloc] init];
            [self.navigationController pushViewController:yxDetailVc animated:YES];
        }
    }

    
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0)
    {
        if (_hot_cityArray.count>4)
        {
            
            if ([UIScreen mainScreen].bounds.size.width == 320)
            {
                return 250;
            }
            else if ([UIScreen mainScreen].bounds.size.width == 375)
            {
                return 262;
            }
            else
            {
                return 270;
            }
            
        }
        else if (_hot_cityArray.count<=4)
        {
            if ([UIScreen mainScreen].bounds.size.width == 320)
            {
                return 147;
            }
            else if ([UIScreen mainScreen].bounds.size.width == 375)
            {
                return 155;
            }
            else
            {
                return 160;
            }
            
        }
    }
    else if (section==1)
    {
        if (_themeArray.count>2)
        {
            
            if ([UIScreen mainScreen].bounds.size.width == 320)
            {
                return 245;
            }
            else if ([UIScreen mainScreen].bounds.size.width == 375)
            {
                return 280;
            }
            else
            {
                return 308;
            }
        }
        else if (_themeArray.count<=2)
        {
            if ([UIScreen mainScreen].bounds.size.width == 320)
            {
                return 150;
            }
            else if ([UIScreen mainScreen].bounds.size.width == 375)
            {
                return 170;
            }
            else
            {
                return 180;
            }
            
        }
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil)
    {
        return nil;
    }
    
    UIView *sectionView = [[UIView alloc] init];
    if (section==0)
    {
        if (_hot_cityArray.count>4)
        {
            sectionView.frame=CGRectMake(0, 0, tableView.bounds.size.width, 270);
        }
        else if (_hot_cityArray.count<=4){
            sectionView.frame=CGRectMake(0, 0, tableView.bounds.size.width, 160);
        }
        
    }
    else if (section==1)
    {
        
        if (_themeArray.count>2)
        {
            sectionView.frame=CGRectMake(0, 0, tableView.bounds.size.width, 290);
        }
        else if (_themeArray.count<=2){
            sectionView.frame=CGRectMake(0, 0, tableView.bounds.size.width, 180);
        }
        
    }
    [sectionView setBackgroundColor:[UIColor whiteColor]];
    UIView *grayView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 10)];
    grayView.backgroundColor=kColor(240, 246, 251);
    [sectionView addSubview:grayView];
    
    UIImageView *leftImage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 25, 25)];
    if (section==0)
    {
        leftImage.image=[UIImage imageNamed:@"热门国家"];
        LXStudyTourView *hotView=[[LXStudyTourView alloc] initWithFrame:CGRectMake(0, ViewY(leftImage)+ViewHeight(leftImage), windowContentWidth, ViewHeight(sectionView)-ViewHeight(leftImage)-ViewY(leftImage)) showType:HotCountry data:_hot_cityArray];
        hotView.delegate=self;
        [sectionView addSubview:hotView];
    }
    else if (section==1)
    {
        leftImage.image=[UIImage imageNamed:@"主题活动"];
        LXStudyTourView *themeView=[[LXStudyTourView alloc] initWithFrame:CGRectMake(0, ViewY(leftImage)+ViewHeight(leftImage), windowContentWidth, ViewHeight(sectionView)-ViewHeight(leftImage)-ViewY(leftImage)) showType:Theme data:_themeArray];
        themeView.delegate=self;
        [sectionView addSubview:themeView];
    }
    
    [sectionView addSubview:leftImage];
    
    UILabel *title = [YXTools allocLabel:sectionTitle font:systemFont(15) textColor:[UIColor blackColor] frame:CGRectMake(50, 18, ViewWidth(sectionView)-10, 30) textAlignment:0];
    [sectionView addSubview:title];
    

    return sectionView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIButton *footerBtn=[YXTools allocButton:@"查看更多" textColor:kColor(70, 131, 240) nom_bg:nil hei_bg:nil frame:CGRectMake(0, 0, windowContentWidth, 40)];
    footerBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [footerBtn addTarget:self action:@selector(footerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    footerBtn.tag=section+1;
    return footerBtn;
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section ==0)
    {
        return @"热门地区";
    }
    if (section == 1)
    {
        return @"主题活动";
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier1 = @"cellIdentifier1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        //单元格的选择风格，选择时单元格不出现蓝条
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)footerBtnClick:(UIButton *)btn
{
    if (btn.tag==1)
    {
        DLog(@"更多热门国家");
        HotCountryOrCityVC *hotVc=[[HotCountryOrCityVC alloc] init];
        hotVc.type=2;
        hotVc.titleStr=@"热门地区";
        [self.navigationController pushViewController:hotVc animated:YES];
    }
    else if (btn.tag==2)
    {
        DLog(@"更多产品推荐");
        LXThemeViewController *themeVc=[[LXThemeViewController alloc] init];
        [self.navigationController pushViewController:themeVc animated:YES];
    }
}


#pragma mark ---
#pragma LXStudyTourDelegate
-(void)selectHotCountry:(NSUInteger)index
{
    LXSTModel *model=[_hot_cityArray objectAtIndex:index];
    DLog(@"热门国家--%lu,%@",(unsigned long)index,model.title);
    LXSTListViewController *listVc=[[LXSTListViewController alloc] init];
    listVc.city_name=model.title;
    listVc.sourceType=HotCity;
    [self.navigationController pushViewController:listVc animated:YES];
}

-(void)selectTheme:(NSUInteger)index
{
    LXSTModel *model=[_themeArray objectAtIndex:index];
    DLog(@"产品推荐--%lu,%@",(unsigned long)index,model.title);
    LXSTListViewController *listVc=[[LXSTListViewController alloc] init];
    listVc.themeType=model.title;
    listVc.sourceType=Theme1;
    [self.navigationController pushViewController:listVc animated:YES];
}


#pragma mark 请求方法
-(void)sendRequest:(NSDictionary *)parameters aurl:(NSString *)url aTag:(int)tag
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              if (tag ==1 )
              {
                  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                  if ([[dic objectForKey:@"status"] intValue]==1)
                  {

                      if ([[[dic objectForKey:@"data"] objectForKey:@"hot_city"] isKindOfClass:[NSArray class]])
                      {
                          //热门国家
                          NSArray *hotCityArray=[[dic objectForKey:@"data"] objectForKey:@"hot_city"];
                          for (NSDictionary *dic1 in hotCityArray)
                          {
                              LXSTModel *model=[[LXSTModel alloc] initWithDictionary:dic1];
                              [_hot_cityArray addObject:model];
                          }
                      }
                      
                      if ([[[dic objectForKey:@"data"] objectForKey:@"type"] isKindOfClass:[NSArray class]])
                      {
                          //主题
                          NSArray *themeArray=[[dic objectForKey:@"data"] objectForKey:@"type"];
                          for (NSDictionary *dic1 in themeArray)
                          {
                              LXSTModel *model=[[LXSTModel alloc] initWithDictionary:dic1];
                              [_themeArray addObject:model];
                          }
                      }

                        DLog(@"广告---%@,热门国家-%@,主题---%@",_adArray,_hot_cityArray,_themeArray);
                       [self initHeaderView];
                      [_tableView reloadData];
                  }

              }
              else if (tag == 2)
              {
                  
                  NSArray *array = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                  DLog(@"旅游广告===%@",array);
                  if (array != nil)
                  {
                      [_adArray removeAllObjects];
                      _adArray = [[NSMutableArray alloc] init];
                      for (int i=0; i<array.count; i++)
                      {
                          LXAdvertModel *detailModel = [[LXAdvertModel alloc] init];
                          NSDictionary *dic=[array objectAtIndex:i];
                          [detailModel setValuesForKeysWithDictionary:dic];
                          [_adArray addObject:detailModel];
                      }
                      [self initHeaderView];
                  }

              }
        
              
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              DLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
              [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
                  NSString *url=[NSString stringWithFormat:@"%@/api/yoosure/%@",WLHTTP,@"index"];
                  [self sendRequest:nil aurl:url aTag:1];
              }];
              
          }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
