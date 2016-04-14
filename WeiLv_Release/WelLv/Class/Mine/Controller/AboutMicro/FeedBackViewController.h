//
//  FeedBackViewController.h
//  WelLv
//
//  Created by lyx on 15/4/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCObjectViewController.h"

@class YXTextView;
@interface FeedBackViewController : XCObjectViewController
{
    YXTextView *_neriorView;
    UITextField *_phoneLabel;
}
@end


@interface YXTextView : UIView<UITextViewDelegate>
{
    UITextView *_contentView;
    UILabel *_placeholderLabel;
}
@property (nonatomic,readonly)UITextView *contentView;
@end