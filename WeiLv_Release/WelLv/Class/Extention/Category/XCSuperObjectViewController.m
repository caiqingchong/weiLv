//
//  XCSuperObjectViewController.m
//  xmData
//
//  Created by wxc on 13-10-20.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "XCSuperObjectViewController.h"

@interface XCSuperObjectViewController ()

@end

@implementation XCSuperObjectViewController
@synthesize pushType=_pushType;
@synthesize backTitle = _backTitle;
@synthesize backBtn = _backBtn;

- (void)addGes{
    UISwipeGestureRecognizerDirection left = UISwipeGestureRecognizerDirectionRight;
    UISwipeGestureRecognizer *sw = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    sw.direction = left;
    [self.view addGestureRecognizer:sw];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_pushType == isModel)
    {
        _backBtn = [[BackBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        _backBtn.leftView.image = [UIImage imageNamed:@"back"];
        _backBtn.titleLab.text = self.backTitle;
        [_backBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    }
    else if (_pushType == isPush)
    {
        _backBtn = [[BackBtn alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        _backBtn.leftView.image = [UIImage imageNamed:@"back"];
        _backBtn.titleLab.text = self.backTitle;
        [_backBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    }
    
//    if (self.searchType) {
//        UIButton *searchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        searchBtn.frame=CGRectMake(0, 0, 20, 20);
//        [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//        [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
//        
//        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:searchBtn];
//    }
    
    [self addGes];
}

//-(void)searchClick
//{
//    SearchViewController *searchVc=[[SearchViewController alloc] init];
//    searchVc.searchType=self.searchType;
//    [self.navigationController pushViewController:searchVc animated:YES];
//}

- (void)close
{
    if (_pushType == isPush)
    {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    else if (_pushType == isModel)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
}
@end

@implementation BackBtn
@synthesize leftView = _leftView,titleLab = _titleLab;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.frame = frame;
    if (self) {
        _leftView = [YXTools allocImageView:CGRectMake(5, (self.frame.size.height - 25)/2, 16, 25) image:nil];
        [self addSubview:_leftView];
        
        _titleLab = [YXTools allocLabel:@"" font:systemFont(16) textColor:[UIColor orangeColor] frame:CGRectMake(20, 0, self.frame.size.width - 30, self.frame.size.height) textAlignment:0];
        _titleLab.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_titleLab];
    }
    return self;
}

@end
