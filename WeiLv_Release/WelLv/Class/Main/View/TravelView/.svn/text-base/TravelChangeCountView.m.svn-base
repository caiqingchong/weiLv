//
//  TravelChangeCountView.m
//  bottomView
//
//  Created by 张子乾 on 16/1/21.
//  Copyright © 2016年 张子乾. All rights reserved.
//

#import "TravelChangeCountView.h"
#import "TravelChangeTravellerNumberView.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kItemWidthAndHeight kScreenWidth/(kScreenWidth/28)

#define kMinusViewX kScreenWidth/(kScreenWidth/5)
#define kMinusViewY kItemWidthAndHeight/2
#define kMinusViewWidth kScreenWidth/(kScreenWidth/18)
#define kMinusViewHeight kScreenHeight/(kScreenHeight/4)


@interface TravelChangeCountView()
{
    NSString *isType;
    NSInteger addX;
    NSInteger addY;
    NSInteger minusX;
    NSInteger numberX;
    NSInteger minusY;
    NSInteger numberY;
}
@end
@implementation TravelChangeCountView

- (id)initWithFrame:(CGRect)frame and:(NSString *)type
{
    if (self=[super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"人数框"];
        [self layoutAllViews];
        self.userInteractionEnabled = YES;
        isType=type;
        
    }
    return self;
}

- (void) layoutAllViews {
    
    if (UISCREEN_HEIGHT == 667) {
        addX = 87;
        addY = 3;
        minusX = 3;
        minusY = 3;
        numberX = 45;
        numberY = 3;
    }else if (UISCREEN_HEIGHT == 736) {
        addX = 87;
        addY = 3;
        minusX = 3;
        minusY = 3;
        numberX = 45;
        numberY = 3;
    } else if (UISCREEN_HEIGHT < 569) {
        addX = 70;
        addY = 3;
        minusX = 3;
        minusY = 3;
        numberX = 35;
        numberY = 3;
    }
    
    
    //减
    self.minusView = [[UIImageView alloc]initWithFrame:CGRectMake(minusX, minusY, kItemWidthAndHeight, kItemWidthAndHeight)];
    [self.minusView setImage:[UIImage imageNamed:@"--灰色"]];
    [self addSubview:self.minusView];
    
    //数字显示
    self.countTextField = [[UITextField alloc]initWithFrame:CGRectMake(numberX, numberY, kItemWidthAndHeight, kItemWidthAndHeight)];
    self.countTextField.text = @"0";
    self.countTextField.delegate=self;
    self.countTextField.font=[UIFont systemFontOfSize:18];
    self.countTextField.returnKeyType=UIReturnKeyDone;
    self.countTextField.keyboardType=UIKeyboardTypeNumberPad;
    self.countTextField.textAlignment = NSTextAlignmentCenter;
    self.countTextField.userInteractionEnabled = NO;
    [self addSubview:self.countTextField];
    
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 30)];
    topView.backgroundColor=[UIColor whiteColor];
    [topView setBarStyle:UIBarStyleBlackTranslucent];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    //    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    self.doneButton = [[UIBarButtonItem alloc]init];
    [_doneButton setTitle:@"完成"];
    _doneButton.style = UIBarButtonItemStyleDone;
    [_doneButton setTintColor:[UIColor orangeColor]];
    
    NSArray * buttonsArray = @[btnSpace, _doneButton];
    
    [topView setItems:buttonsArray];
    [self.countTextField setInputAccessoryView:topView];
    
    
    //      //加
    self.addView = [[UIImageView alloc]initWithFrame:CGRectMake(addX, addY, kItemWidthAndHeight, kItemWidthAndHeight)];
    
    [self.addView setImage:[UIImage imageNamed:@"+"]];
    [self addSubview:self.addView];
    
    
}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
//    [self.countTextField resignFirstResponder];
//    return YES;
//}

- (void)dismissKeyBoard
{
    //    if ([isType isEqualToString:@"1"]) {
    //        if ([self.countTextField.text integerValue]==0) {
    //            self.countTextField.text=[NSString stringWithFormat:@"%d",1];
    //            [[LXAlterView sharedMyTools]createTishi:@"成人人数至少1位"];
    //            return;
    //        }else if([self.countTextField.text integerValue]==1){
    //          [self.countTextField resignFirstResponder];
    //            return;
    //        }else{
    //           self.countTextField.text=[NSString stringWithFormat:@"%ld",[self.countTextField.text integerValue]];
    //        }
    //    }else if([isType isEqualToString:@"2"]){
    //     self.countTextField.text=[NSString stringWithFormat:@"%ld",[self.countTextField.text integerValue]];
    //    }
    
    //    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    // 让通知中心发出通知
    // 第一个参数：通知的名字
    // 第二个参数：谁发的通知
    // 第三个参数：发送通知附加的信息
    
    //    [center postNotificationName:@"改变数量" object:self userInfo:@{@"text":self.countTextField.text}];
    [self.countTextField resignFirstResponder];
}
//
//- (void)findNotification:(NSNotification *)notification {
//    NSDictionary *userInfo    = notification.userInfo;
//    NSString *text= userInfo[@"text"];
////    self.view.backgroundColor = color;
//    DLog(@"%@",text);
//}

@end
