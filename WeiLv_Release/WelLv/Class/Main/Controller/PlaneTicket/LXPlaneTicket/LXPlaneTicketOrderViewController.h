//
//  LXPlaneTicketOrderViewController.h
//  WelLv
//
//  Created by liuxin on 15/9/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCObjectViewController.h"


@interface LXPlaneTicketOrderViewController : XCObjectViewController

@property (nonatomic , strong) NSMutableArray *planeInfoArray; // 机票信息数组
@end


@interface OrderTextFieldView : UIView

@property (nonatomic,strong)UITextField *nameTextField;
@property (nonatomic,strong)UITextField *phoneTextField;
@property (nonatomic,strong)UIImageView *contactImagV;
@property (nonatomic,strong)UIImageView *phoneImagV;

@property (nonatomic,strong)UITextField *emailTF;
@property (nonatomic,strong)UIImageView *emailImageView;

- (id)initWithFrame:(CGRect)frame placderName:(NSString *)name placderPhone:(NSString *)phone;
- (id)initWithFrame:(CGRect)frame placderName:(NSString *)name placderPhone:(NSString *)phone emial:(NSString *)emailStr;

@end