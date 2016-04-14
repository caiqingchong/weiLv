//
//  YXWebDetailViewController.m
//  WelLv
//
//  Created by lyx on 15/4/21.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXWebDetailViewController.h"

@interface YXWebDetailViewController ()

@end

@implementation YXWebDetailViewController
@synthesize WebTitle = _WebTitle,webContent = _webContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSRange searchRange = [self.webContent rangeOfString:@"(null)"];
    NSString *str=nil;
    if (searchRange.location != NSNotFound)
    {
        str=[self.webContent stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    else
    {
        str = self.webContent;
    }
    self.title = self.WebTitle;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(15, 0, windowContentWidth-30, windowContentHeight-64)];
    [webView loadHTMLString:str baseURL:nil];
    [YXTools deleteWebViewBord:webView];
    [self.view addSubview:webView];
    // Do any additional setup after loading the view.
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
