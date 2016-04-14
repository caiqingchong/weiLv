//
//  webViewController.m
//  WelLv
//
//  Created by 赵冉 on 16/1/30.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "webViewController.h"

@interface webViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation webViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    
    
    //    NSURL *url = [NSURL fileURLWithPath:self.path];
    NSData * data = [NSData dataWithContentsOfFile:self.path];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    [self.webView loadRequest:request];
    
    [self.webView loadData:data MIMEType:@"application/vnd.openxmlformats-officedocument.wordprocessingml.document" textEncodingName:@"UTF-8" baseURL:nil];
    [self.view addSubview:self.webView];
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
