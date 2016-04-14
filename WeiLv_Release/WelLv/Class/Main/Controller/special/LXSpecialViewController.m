//
//  LXSpecialViewController.m
//  WelLv
//
//  Created by 刘鑫 on 15/6/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "LXSpecialViewController.h"
#import "YXDetailTraveViewController.h"
#import "ZFJShipDetailVC.h"
#import "ZFJVisaDetailVC.h"
#import "LXSTDetailViewController.h"
#import "ZFJTicketDetailVC.h"
#import "ProductDetailViewController.h"

@interface LXSpecialViewController ()
<UIWebViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation LXSpecialViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _webView=[[UIWebView alloc] init];
    _webView.frame=CGRectMake(0, 0, windowContentWidth, windowContentHeight-64);
    _webView.delegate=self;
    [self.view addSubview:_webView];
    
    NSURLRequest *urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]];
    [_webView loadRequest:urlRequest];
}

#pragma mark - 当网页视图被指示载入内容而得到通知。应当返回YES，这样会进行加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (navigationType==UIWebViewNavigationTypeLinkClicked)
    {
        DLog(@"导航类型：%@",@"UIWebViewNavigationTypeLinkClicked");
    }
    else if(navigationType==UIWebViewNavigationTypeFormSubmitted)
    {
        DLog(@"导航类型：%@",@"UIWebViewNavigationTypeFormSubmitted");
    }
    else if(navigationType==UIWebViewNavigationTypeBackForward)
    {
        DLog(@"导航类型：%@",@"UIWebViewNavigationTypeBackForward");
    }
    else if(navigationType==UIWebViewNavigationTypeReload)
    {
        DLog(@"导航类型：%@",@"UIWebViewNavigationTypeReload");
    }
    else if(navigationType==UIWebViewNavigationTypeFormSubmitted)
    {
        DLog(@"导航类型：%@",@"UIWebViewNavigationTypeFormSubmitted");
    }
    else if(navigationType==UIWebViewNavigationTypeOther)
    {
        DLog(@"导航类型：%@",@"UIWebViewNavigationTypeOther");
    }
    // 处理事件
    NSString *requestString = [[request URL] absoluteString];
    DLog(@"====%@",requestString);
    
    NSArray *array=[requestString componentsSeparatedByString:@"/"];
    DLog(@"array = %@",array);
 

    if(![self.loadUrl isEqualToString:requestString]){
        
        NSURLRequest *urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]];
        
        [_webView loadRequest:urlRequest];
    }
    
    //详情类型，1旅游，2签证，3邮轮 ,4游学,5门票
    NSString *typeID=[array objectAtIndex:array.count-2];
    if ([typeID intValue]==1)
    {
        ProductDetailViewController *productVC = [[ProductDetailViewController alloc]init];
        productVC.productID = [array objectAtIndex:array.count-1];
        [self.navigationController pushViewController:productVC animated:YES];
    }
    else if ([typeID intValue]==2)
    {
        ZFJVisaDetailVC *visaVc=[[ZFJVisaDetailVC alloc] init];
        visaVc.product_id=[array objectAtIndex:array.count-1];
        [self.navigationController pushViewController:visaVc animated:YES];
    }
    else if ([typeID intValue]==3)
    {
        ZFJShipDetailVC *shipVc=[[ZFJShipDetailVC alloc] init];
        shipVc.product_id=[array objectAtIndex:array.count-1];
        [self.navigationController pushViewController:shipVc animated:YES];
    }
    else if ([typeID intValue]==4)
    {
        LXSTDetailViewController *shipVc=[[LXSTDetailViewController alloc] init];
        shipVc.productId=[array objectAtIndex:array.count-1];
        [self.navigationController pushViewController:shipVc animated:YES];
    }
    else if ([typeID intValue]==5)
    {
        ZFJTicketDetailVC *ticket=[[ZFJTicketDetailVC alloc] init];
        ticket.product_id=[array objectAtIndex:array.count-1];
        [self.navigationController pushViewController:ticket animated:YES];
    }
    
    
    return YES;
}
#pragma mark - 当网页视图已经开始加载一个请求后，得到通知
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
}

#pragma mark - 当网页视图结束加载一个请求之后，得到通知
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
}

#pragma mark - 当在请求加载中发生错误时，得到通知。会提供一个NSSError对象，以标识所发生错误类型
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
    [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
        NSURLRequest *urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:self.loadUrl]];
        [_webView loadRequest:urlRequest];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
