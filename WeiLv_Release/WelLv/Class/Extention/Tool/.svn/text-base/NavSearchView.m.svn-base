//
//  NavSearchView.m
//  WelLv
//
//  Created by lyx on 15/4/7.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "NavSearchView.h"

@implementation NavSearchView
@synthesize searchBar = _searchBar;
@synthesize cancalBtn = _cancalBtn;
@synthesize leftview;
- (id)initWithFrame:(CGRect)frame Feature:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self initView:placeholder];
    }
    return self;
}

- (void)initView:(NSString *)str
{
    leftview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Search"]];
    leftview.frame = CGRectMake(5, 0,30, 15);
    leftview.contentMode = UIViewContentModeScaleAspectFit;
    _searchBar = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _searchBar.layer.cornerRadius = 5.0;
    _searchBar.clearButtonMode = UITextFieldViewModeAlways;
    _searchBar.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:232/255.0 alpha:0];
    _searchBar.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _searchBar.returnKeyType = UIReturnKeySearch;
    _searchBar.placeholder = str;
    _searchBar.font = [UIFont systemFontOfSize:14];
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.delegate = self;
    _searchBar.leftView = leftview;
    
    [self addSubview:_searchBar];
    
    _cancalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancalBtn.frame = CGRectMake(ViewWidth(_searchBar)+ViewX(_searchBar), 0, 40, self.frame.size.height);
    [_cancalBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancalBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_cancalBtn addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [_cancalBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    _cancalBtn.hidden = YES;
    [self addSubview:_cancalBtn];
}

#pragma mark 搜索框被点击的时候调用
- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [UIView animateWithDuration:0.25 animations:^{
//        _searchBar.frame = CGRectMake(0, 0, self.frame.size.width - 40 , self.frame.size.height);
//        _cancalBtn.frame = CGRectMake(ViewWidth(_searchBar)+ViewX(_searchBar), 0, 40, self.frame.size.height);
//        _cancalBtn.hidden = NO;
//    }];
    if ([self.delegate respondsToSelector:@selector(beginEdit)]) {
         [self.delegate beginEdit];
        [textField resignFirstResponder];
    }
   
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [UIView animateWithDuration:0.25 animations:^{
        _searchBar.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _cancalBtn.hidden = YES;
        [textField resignFirstResponder];
    }];
    if ([self.delegate respondsToSelector:@selector(beginSearch:)]) {
        [self.delegate beginSearch:textField.text];
    }
    return YES;
}

- (void)cancelSearch
{
    [UIView animateWithDuration:0.25 animations:^{
        _searchBar.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _cancalBtn.hidden = YES;
        [_searchBar resignFirstResponder];
    }];
    if ([self.delegate respondsToSelector:@selector(cancalEdit)]) {
        [self.delegate cancalEdit];
    }
}
@end
