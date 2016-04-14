//
//  MessageViewController.h
//  WelLv
//
//  Created by mac for csh on 15/5/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#import "MessageView.h"
#import "MessageModel.h"
#import "MyMembersModel.h"


@interface MessageViewController : XCSuperObjectViewController<UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong) MyMembersModel *mesModel;
@end
