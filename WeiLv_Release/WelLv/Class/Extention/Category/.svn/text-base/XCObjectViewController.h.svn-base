//
//  XCObjectViewController.h
//  xmData
//
//  Created by wxc on 13-8-6.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "XCSuperObjectViewController.h"

@interface XCObjectViewController : XCSuperObjectViewController
{
    UIScrollView *_scrollView;
    
    CGRect       _rect;
    
    NSTimeInterval _animationDuration;
    
    UIView      *_textView;
}
- (void)scrollContentOffsetAnimation:(CGPoint)point;

//- (void)hideKeyBoard;

- (void)keyboardWillShow:(NSNotification *)notification;
- (void)keyboardWillHide:(NSNotification *)notification;
@end
