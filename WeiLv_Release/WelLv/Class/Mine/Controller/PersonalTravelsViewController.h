//
//  PersonalTravelsViewController.h
//  WelLv
//
//  Created by 赵阳 on 16/1/1.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UserType){
    
    UserTypeMember = 0,
    
    UserTypeAssistant
};

@interface PersonalTravelsViewController : XCSuperObjectViewController

@property(assign, nonatomic) NSInteger userType;

@property(strong, nonatomic) NSString *memberId;

@end
