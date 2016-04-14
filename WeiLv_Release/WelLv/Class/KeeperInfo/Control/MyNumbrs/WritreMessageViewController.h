//
//  WritreMessageViewController.h
//  WelLv
//
//  Created by liuxin on 16/1/18.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "XCSuperObjectViewController.h"
@class WritreMessageViewController ;
@protocol WritreMessageViewControllerDeledate <NSObject>

-(void)zxdViewController:(WritreMessageViewController *)vc text:(NSString *)string number:(NSInteger)num;

@end
@interface WritreMessageViewController : XCSuperObjectViewController<UITextFieldDelegate>
{
    UITextField *_zxdTextField;
    //UITextField *_zxdTextField2;
    NSInteger _arrindex1;
    NSInteger _arrindex2;
    NSString *_strtext;
    NSInteger _type;
    
    
   // id <WritreMessageViewControllerDeledate>delegate;
    
}
@property(nonatomic,strong)NSString *uid;
@property(nonatomic,strong)UITextField *zxdTextField;
//@property(nonatomic,strong)UITextField *zxdTextField2;
@property(nonatomic,strong)NSString *strtext;
@property(nonatomic,assign)NSInteger arrindex1;
@property(nonatomic,assign)NSInteger arrindex2;
@property(nonatomic,assign)NSInteger type;

@property(nonatomic,assign) id <WritreMessageViewControllerDeledate> delegate;
@end
