//
//  PlaneTicketViewController.h
//  WelLv
//
//  Created by mac for csh on 15/9/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
#import "payRequsestHandler.h"

@interface PlaneTicketViewController : XCSuperObjectViewController<UIScrollViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
     UIScrollView *_scrollView;//  
}

@property(nonatomic,copy)NSString *order_id;
@property(nonatomic,copy)NSString *cat_id;
@property(nonatomic,copy)NSString *member_id;


@end

@interface  PlaneMessage : UIView

- (id)initWithFrame:(CGRect)frame titleString:(NSString *)title timeString:(NSString *)time ariportString:(NSString *)airport;
- (id)initWithFrame:(CGRect)frame string1:(NSString *)string1 string2:(NSString *)string2 ;

@end
//@interface OrderTextFieldView : UIView
//
//@property (nonatomic,strong)UITextField *nameTextField;
//@property (nonatomic,strong)UITextField *phoneTextField;
//@property (nonatomic,strong)UIButton *chooseTypeBut;
//@property (nonatomic,strong)UILabel *chooseTypeLabel;
//
//- (id)initWithFrame:(CGRect)frame placderName:(NSString *)name placderPhone:(NSString *)phone;
//- (id)initWithFrame:(CGRect)frame placderName:(NSString *)name placderPhone:(NSString *)phone chooesType:(BOOL)type;
//@end


