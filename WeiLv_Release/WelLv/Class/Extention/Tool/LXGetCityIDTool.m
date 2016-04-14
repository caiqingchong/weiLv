//
//  LXGetCityIDTool.m
//  WelLv
//
//  Created by 刘鑫 on 15/4/26.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXGetCityIDTool.h"
#import "YXLocationManage.h"


@implementation LXGetCityIDTool

+ (LXGetCityIDTool*)sharedMyTools
{
    static LXGetCityIDTool *sharedSVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSVC = [[self alloc] init];
    });
    
    return sharedSVC;
}

//城市id
-(void)getCity_id:(NSString *)cityName
{
    NSString *city;
    NSRange searchRange = [cityName rangeOfString:@"市"];
    if (searchRange.location != NSNotFound) {
        NSString *city1 = [cityName stringByReplacingOccurrencesOfString:@"市" withString:@""];
        city=city1;
    }
    else
    {
        city=cityName;
    }
    
    NSString *regionType;
    
    if ([city isEqualToString:@"北京"] || [city isEqualToString:@"上海"] || [city isEqualToString:@"天津"] || [city isEqualToString:@"重庆"] || [city isEqualToString:@"香港"]  || [city isEqualToString:@"澳门"] || [city isEqualToString:@"台湾"] )
    {
        regionType=@"3";
    }
    else
    {
        regionType=@"3";
    }
    
    
    NSDictionary *dic;
    if (city!=nil && regionType!=nil)
    {
        dic=@{@"region_name":city,@"region_type":regionType};
    }else
    {
        dic=@{@"region_name":@"郑州",@"region_type":@"3"};
    }
    
    NSString *url=GetCityIDUrl;
    __block NSString *city_regionID=nil;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dic
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

              //旅游列表(无搜索条件)
              DLog(@"Success: dic=%@--%@",dic, [dic objectForKey:@"msg"]);
              if ([[dic objectForKey:@"status"] integerValue]==1)
              {
                  NSArray *array=[dic objectForKey:@"data"];
                  NSDictionary *dict1=[[NSDictionary alloc] init];
                  //DLog(@"data=%@",array);
                  //NSArray *sellersArray=[NSArray array];
                  for (int i=0; i<array.count; i++)
                  {
                      
                      dict1=[array objectAtIndex:i];
                      
                      city_regionID=[dict1 objectForKey:@"region_id"];
                      
                      self.guanjiaCityid=city_regionID;
                  }
                  
                  //[self.tableView reloadData];
              }
              else
              {
                  //[[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                  DLog(@"注册失败");
              }
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              
          }];

    //return nil;
}

//出发地城市id
-(void)getF_cityID
{
    DLog(@"ccccccc--%@",[YXLocationManage shareManager].city);
    NSString *city;
    NSRange searchRange = [[YXLocationManage shareManager].city rangeOfString:@"市"];
    if (searchRange.location != NSNotFound) {
        NSString *city1 = [[YXLocationManage shareManager].city stringByReplacingOccurrencesOfString:@"市" withString:@""];
        city=city1;
    }
    else
    {
        city=[YXLocationManage shareManager].city;
    }
    NSString *regionType;
    
    if ([city isEqualToString:@"北京"] || [city isEqualToString:@"上海"] || [city isEqualToString:@"天津"] || [city isEqualToString:@"重庆"] || [city isEqualToString:@"香港"]  || [city isEqualToString:@"澳门"] || [city isEqualToString:@"台湾"] )
    {
        regionType=@"3";
    }
    else
    {
        regionType=@"3";
    }
    
    
    NSDictionary *dic;
    if (city!=nil && regionType!=nil)
    {
        dic=@{@"region_name":city,@"region_type":regionType};
    }else
    {
        dic=@{@"region_name":@"郑州",@"region_type":@"3"};
    }
    if ([LXGetCityIDTool sharedMyTools].city_regionID == nil) {
        NSString *url=GetCityIDUrl;
        [self sendRequest:dic aurl:url aTag:1];
    }
    //NSString *url=GetCityIDUrl;
    //[self sendRequest:dic aurl:url aTag:1];
    //return cityID;
}

//目的地城市id
-(void)getT_cityID:(NSString *)t_cityName region_type:(NSString *)region_type
{
    
    NSDictionary *dic=@{@"region_name":t_cityName,@"region_type":region_type};
    DLog(@"dic===%@",dic);
    NSString *url=GetCityIDUrl;
    //[self sendRequest:dic aurl:url aTag:1];
    __block NSString *city_regionID=nil;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dic
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

                  //旅游列表(无搜索条件)
                  DLog(@"Success: dic=%@--%@",dic, [dic objectForKey:@"msg"]);
                  if ([[dic objectForKey:@"status"] integerValue]==1)
                  {
                      NSArray *array=[dic objectForKey:@"data"];
                      NSDictionary *dict1=[[NSDictionary alloc] init];
                      //DLog(@"data=%@",array);
                      //NSArray *sellersArray=[NSArray array];
                      for (int i=0; i<array.count; i++)
                      {
                          
                          dict1=[array objectAtIndex:i];
                          
                          city_regionID=[dict1 objectForKey:@"region_id"];
                          
                          self.city_regionID=city_regionID;
                      }
                      
                      //[self.tableView reloadData];
                  }
                  else
                  {
                      //[[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                      DLog(@"注册失败");
                  }
                  
                  
              
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              
          }];

}

-(void)sendRequest:(NSDictionary *)parameters aurl:(NSString *)url aTag:(int)tag
{
    
    __block NSString *city_regionID=nil;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              if(tag==1)
              {
                  //旅游列表(无搜索条件)
                  DLog(@"Success: dic=%@--%@",dic, [dic objectForKey:@"msg"]);
                  if ([[dic objectForKey:@"status"] integerValue]==1)
                  {
                      NSArray *array=[dic objectForKey:@"data"];
                      NSDictionary *dict1=[[NSDictionary alloc] init];
                      //DLog(@"data=%@",array);
                      //NSArray *sellersArray=[NSArray array];
                      for (int i=0; i<array.count; i++)
                      {
                          
                          dict1=[array objectAtIndex:i];
                          
                          city_regionID=[dict1 objectForKey:@"region_id"];
                          
                          self.city_regionID=city_regionID;
                      }
                      
                      if (self.city_block)
                      {
                          self.city_block(self.city_regionID);
                      }
                      
                      //[self.tableView reloadData];
                  }
                  else
                  {
                      //[[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                      DLog(@"注册失败");
                      if (self.city_block)
                      {
                          self.city_block(@"149");
                      }

                  }
                  
                  
                  
              }
              
              
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
             // [[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
              if (self.city_block)
              {
                  self.city_block(@"149");
              }

          }];
   // return city_regionID;
}


- (void)returnCityIdWith:(GetedCityID)cityId {
    self.city_block = cityId;
    NSString *city;
    NSRange searchRange = [[YXLocationManage shareManager].city rangeOfString:@"市"];
    if (searchRange.location != NSNotFound) {
        NSString *city1 = [[YXLocationManage shareManager].city stringByReplacingOccurrencesOfString:@"市" withString:@""];
        city=city1;
    }
    else
    {
        city=[YXLocationManage shareManager].city;
    }
    NSString *regionType;
    
    if ([city isEqualToString:@"北京"] || [city isEqualToString:@"上海"] || [city isEqualToString:@"天津"] || [city isEqualToString:@"重庆"] || [city isEqualToString:@"香港"]  || [city isEqualToString:@"澳门"] || [city isEqualToString:@"台湾"] )
    {
        regionType=@"3";
    }
    else
    {
        regionType=@"3";
    }
    
    
    NSDictionary *dic;
    if (city!=nil && regionType!=nil)
    {
        dic=@{@"region_name":city,@"region_type":regionType};
    }else
    {
        dic=@{@"region_name":@"郑州",@"region_type":@"3"};
    }
    
    __block NSString *city_regionID=nil;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url=GetCityIDUrl;
    [manager POST:url parameters:dic
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              
                 // DLog(@"Success: dic=%@--%@",dic, [dic objectForKey:@"msg"]);
                  if ([[dic objectForKey:@"status"] integerValue]==1)
                  {
                      NSArray *array=[dic objectForKey:@"data"];
                      NSDictionary *dict1=[[NSDictionary alloc] init];
                       for (int i=0; i<array.count; i++) {
                          dict1=[array objectAtIndex:i];
                          city_regionID=[dict1 objectForKey:@"region_id"];
                      }
                      if (self.city_block) {
                          self.city_block(city_regionID);
                      }
                      
                  } else {
                      //[[LXAlterView sharedMyTools] createTishi:@"暂无数据"];
                      DLog(@"注册失败");
                      if (self.city_block) {
                          self.city_block(@"149");
                      }
                  }
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              if (self.city_block)
              {
                  self.city_block(@"149");
              }
          }];
}

- (void)return_city_id_name:(AddLocationCityIdAndName)city {
    NSLog(@"locationCity ===== %@", [YXLocationManage shareManager].city);
    self.city_id_name = city;
    NSString *cityName;
    NSRange searchRange = [[YXLocationManage shareManager].city rangeOfString:@"市"];
    if (searchRange.location != NSNotFound) {
        NSString *city1 = [[YXLocationManage shareManager].city stringByReplacingOccurrencesOfString:@"市" withString:@""];
        cityName=city1;
    }
    else
    {
        cityName=[YXLocationManage shareManager].city;
    }
    NSString *regionType;
    
    if ([cityName isEqualToString:@"北京"] || [cityName isEqualToString:@"上海"] || [cityName isEqualToString:@"天津"] || [cityName isEqualToString:@"重庆"] || [cityName isEqualToString:@"香港"]  || [cityName isEqualToString:@"澳门"] || [cityName isEqualToString:@"台湾"] )
    {
        regionType=@"3";
    }
    else
    {
        regionType=@"3";
    }
    NSDictionary *dic;
    if (cityName!=nil && regionType!=nil)
    {
        dic=@{@"region_name":cityName,@"region_type":regionType};
    }else
    {
        dic=@{@"region_name":@"郑州",@"region_type":@"3"};
    }
    
    __block NSString *city_regionID=nil;
    WS(ws);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url=GetCityIDUrl;
    [manager POST:url parameters:dic
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              DLog(@"Success: dic=%@--%@",dic, [dic objectForKey:@"msg"]);
              if ([[dic objectForKey:@"status"] integerValue]==1)
              {
                  NSArray *array=[dic objectForKey:@"data"];
                  NSDictionary *dict1=[[NSDictionary alloc] init];
                  for (int i=0; i<array.count; i++) {
                      dict1=[array objectAtIndex:i];
                      city_regionID=[dict1 objectForKey:@"region_id"];
                  }
                  ws.city_regionID = city_regionID;
                  if (ws.city_id_name) {
                      ws.city_id_name(city_regionID, [dict1 objectForKey:@"region_name"]);
                  }
              } else {
                  if (ws.city_id_name) {
                      ws.city_id_name(@"149", @"郑州");
                  }
                  ws.city_regionID = @"149";
              }
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              if (ws.city_id_name) {
                  ws.city_id_name(@"149", @"郑州");
              }
              ws.city_regionID = @"149";
          }];
}

@end
