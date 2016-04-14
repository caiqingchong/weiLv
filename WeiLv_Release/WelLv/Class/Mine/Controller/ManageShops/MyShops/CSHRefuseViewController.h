//
//  CSHRefuseViewController.h
//  WelLv
//
//  Created by mac for csh on 15/11/24.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"

@class CSHTextView;
@interface CSHRefuseViewController : XCSuperObjectViewController
{
    CSHTextView *textV;
}


@property (nonatomic ,strong) NSString *main_phone;
@property (nonatomic ,strong) NSString *shopid;
@property (nonatomic ,strong) NSString *member_id;


@end

@interface CSHTextView : UIView<UITextViewDelegate>
{
    UITextView *_contentView;
    UILabel *_placeholderLabel;
}
@property (nonatomic,readonly)UITextView *contentView;
@end