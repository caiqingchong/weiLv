//
//  VideoViewController.m
//  WelLv
//
//  Created by mac for csh on 15/9/2.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView * webView;

@property (nonatomic, copy) NSString * urlStr;
@end

@implementation VideoViewController
@synthesize urlString;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self shouldAutorotate];
    [self supportedInterfaceOrientations];

  //  NSLog(@"%@", urlString);
    self.view.backgroundColor = [UIColor whiteColor];
    self.urlStr = [self.urlString stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
    self.urlStr = [self.urlStr stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
    //NSLog(@"%@", self.urlStr);
//    if ([self.urlStr hasPrefix:@"http://"] || [self.urlStr hasPrefix:@"https://"]) {
//        self.urlStr = [self.urlStr stringByReplacingOccurrencesOfString:@"http://" withString:@""];
//        self.urlStr = [self.urlStr stringByReplacingOccurrencesOfString:@"https://" withString:@""];
//    }
    if (!([self.urlStr hasPrefix:WLHTTP] || [self.urlStr hasPrefix:@"https://www.weilv100.com"])) {
        self.urlStr = [NSString stringWithFormat:@"%@/%@",WLHTTP, self.urlStr];
    }else if(![self.urlStr hasPrefix:@"http"]){
        self.urlStr = [NSString stringWithFormat:@"https://%@",self.urlStr];
    }
    NSLog(@"%@", self.urlStr);
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    //self.webView.backgroundColor = [UIColor blackColor];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;

    [self.view addSubview: self.webView];

    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", self.urlStr]]];
    [self.webView loadRequest:request];
    
    
}
// 支持设备自动旋转
- (BOOL)shouldAutorotate
{
    return YES;
}

// 支持横竖屏显示
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[XCLoadMsg sharedLoadMsg:self] hideAll];
    [[XCLoadMsg sharedLoadMsg:self] showActivityLoading:self.view];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
}

//当在请求加载中发生错误时，得到通知。会提供一个NSSError对象，以标识所发生错误类型。
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //[[LXAlterView sharedMyTools] createTishi:@"数据请求失败，请检查网络"];
    [[XCLoadMsg sharedLoadMsg:self] hideActivityLoading];
    [[XCLoadMsg sharedLoadMsg:self] showErrorMsgInView:self.view evn:^{
        NSURLRequest *urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]];
        [self.webView loadRequest:urlRequest];
    }];
}

@end
