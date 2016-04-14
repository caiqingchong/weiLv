//
//  XCObjectViewController.m
//  xmData
//
//  Created by wxc on 13-8-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "XCObjectViewController.h"
@interface XCObjectViewController ()

@end

@implementation XCObjectViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard:)];
    tap.numberOfTapsRequired=1;
    [self.view addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)hideKeyBoard:(UITapGestureRecognizer *)tap
{
    [YXTools autohideKeyBoard:_scrollView];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    _rect = [aValue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    _animationDuration = animationDuration;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, _rect.size.height, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    
}
- (void)keyboardWillHide:(NSNotification *)notification
{
    _textView = nil;
    
    NSDictionary* userInfo = [notification userInfo];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [YXTools uiViewAnimationTransition:nil typeIndex:0 duration:_animationDuration animation:^{
        _scrollView.contentInset = UIEdgeInsetsZero;
        _scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }];
}

- (void)scrollContentOffsetAnimation:(CGPoint)point
{
    [YXTools uiViewAnimationTransition:nil typeIndex:0 duration:_animationDuration animation:^{
        _scrollView.contentOffset = point;
    }];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _textView = textView;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    _textView = nil;
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _textView = textField;
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    _textView = nil;
    return YES;
}

@end
