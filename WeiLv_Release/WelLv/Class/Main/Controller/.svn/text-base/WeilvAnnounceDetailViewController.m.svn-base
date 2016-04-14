//
//  WeilvAnnounceDetailViewController.m
//  WelLv
//
//  Created by mac for csh on 15/11/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WeilvAnnounceDetailViewController.h"
#import "LXCommonTools.h"

@interface WeilvAnnounceDetailViewController ()

@end

@implementation WeilvAnnounceDetailViewController
@synthesize model,detailModel;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"微旅公告";
   
    [self getData];
}

-(void)getData{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *str = [NSString stringWithFormat:@"%@/%@",WeiLvAnnounce,model.news_id];
    [manager POST:str parameters:nil
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              if ([[dict objectForKey:@"state"] integerValue] ==1) {
                  self.detailModel = [[weilvAnnounceDetailModel alloc] init];
                  [detailModel setValuesForKeysWithDictionary:[dict objectForKey:@"data"]];
                  [self initView];
                }else{
                  [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
              }
              NSLog(@"Success: %@", [dict objectForKey:@"msg"] );
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];


}

-(void)initView{
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, windowContentWidth -20*2, 55)];
    titleLab.text = self.model.title;
    titleLab.textColor = kColor(40, 138, 1);
    titleLab.font = [UIFont systemFontOfSize:18];
    CGFloat hgt = [[LXCommonTools sharedMyTools] textHeight:titleLab.text Afont:18 width:ViewWidth(titleLab)];
    // NSLog(@"hhhhhh = %@",hgt);
    if (hgt>43) {
        titleLab.numberOfLines = 2;
        titleLab.frame = CGRectMake(20, 0, windowContentWidth -20*2, 55+20);
        titleLab.textAlignment = NSTextAlignmentLeft;
    }else{
        titleLab.numberOfLines = 1;
        titleLab.frame = CGRectMake(20, 0, windowContentWidth -20*2, 55);
        titleLab.textAlignment = NSTextAlignmentCenter;
    }
    [self.view addSubview:titleLab];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, ViewY(titleLab)+ViewHeight(titleLab)-7, windowContentWidth-30, 0.5)];
    line.backgroundColor = bordColor;
    [self.view addSubview:line];
    
    NSRange searchRange = [self.detailModel.content rangeOfString:@"(null)"];
    NSString *str=nil;
    if (searchRange.location != NSNotFound)
    {
        str=[self.detailModel.content stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    else
    {
        str = self.detailModel.content;
    }
    

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(15, ViewY(titleLab) + ViewHeight(titleLab), windowContentWidth-30, windowContentHeight-64- ViewY(titleLab) - ViewHeight(titleLab))];
    [webView loadHTMLString:str baseURL:nil];
    webView.delegate=self;
    [YXTools deleteWebViewBord:webView];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//#pragma mark - UIWebView 代理方法 实现
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    
//    NSURL *requestURL=[request URL];
//    if (([[requestURL scheme] isEqualToString:@"http"] || [[requestURL scheme] isEqualToString:@"https"] || [[requestURL scheme] isEqualToString:@"mailto"]) && (navigationType==UIWebViewNavigationTypeLinkClicked))
//    {
//        return ![[UIApplication sharedApplication] openURL:requestURL];
//    }
//    
//    return YES;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
