//
//  ZFJWithdrawDepositsVC.m
//  WelLv
//
//  Created by WeiLv on 15/10/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJWithdrawDepositsVC.h"
#import "ZFJTextFildVIew.h"

@interface ZFJWithdrawDepositsVC ()<UITextFieldDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) ZFJTextFildVIew * wDview;
@property (nonatomic, strong) ZFJTextFildVIew * wDToview;


@end

@implementation ZFJWithdrawDepositsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现";
    self.view.backgroundColor = kColor(240, 246, 251);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    self.scrollView.contentSize = CGSizeMake(windowContentWidth, windowContentHeight + 10);
    self.scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    self.wDview = [[ZFJTextFildVIew alloc] initWithFrame:CGRectMake(0, 20, windowContentWidth, 45) withTitle:@"提现金额"];
    _wDview.textFiled.delegate = self;
    _wDview.textFiled.placeholder = @"可提现100";
    _wDview.textFiled.keyboardType = UIKeyboardTypeNumberPad;

    [self.scrollView addSubview:_wDview];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, ViewBelow(_wDview), windowContentWidth - 20, 45)];
    label.text = @"手续费4.7元";
    [self.scrollView addSubview:label];
    
   self.wDToview = [[ZFJTextFildVIew alloc] initWithFrame:CGRectMake(0, ViewBelow(label), windowContentWidth, 45) withTitle:@"提现至"];
    _wDToview.textFiled.delegate = self;
    _wDToview.textFiled.placeholder = @"123456789";
    _wDToview.textFiled.keyboardType = UIKeyboardTypeNumberPad;
    
    [self.scrollView addSubview:_wDToview];
    
    
    
    UIImageView * icon =[[UIImageView alloc] initWithFrame:CGRectMake(10, ViewBelow(_wDToview) + 5, 15, 15)];
    icon.backgroundColor =[UIColor groupTableViewBackgroundColor];
    [self.scrollView addSubview:icon];
    
    UILabel * warnLabel = [[UILabel alloc] initWithFrame:CGRectMake(ViewRight(icon) + 10, ViewBelow(_wDToview), windowContentWidth - ViewRight(icon) - 10, 25)];
    warnLabel.text =@"每天最高题现100元";
    [self.scrollView addSubview:warnLabel];
    
    UIButton * confirmBut = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBut.frame = CGRectMake(20, ViewBelow(warnLabel) + 20, windowContentWidth - 40, 45);
    confirmBut.backgroundColor = TimeGreenColor;
    [confirmBut setTitle:@"确认" forState:UIControlStateNormal];
    confirmBut.titleLabel.font = [UIFont systemFontOfSize:20];
    confirmBut.titleLabel.textColor = [UIColor whiteColor];
    confirmBut.layer.cornerRadius  = 3.0;
    confirmBut.layer.masksToBounds = YES;
    [confirmBut addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:confirmBut];
    
    
    
}
- (void)confirm:(UIButton *)button {
    //NSLog(@"&&&&&& %@ &&&  %@", _wDview.textFiled.text, _wDToview.textFiled.text);
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
     [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}


@end
