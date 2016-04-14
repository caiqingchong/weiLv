//
//  XCLoadMsg.h
//  加载条
//
//  Created by apple on 13-7-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


#define ERROR_TITLE @""
#define ERROR_SUBTITLE @""

#define ERROR_SERVER_TITLE @"访问出错"
#define ERROR_SERVER_SUBTITLE @"访问出错!您可以尝试点击按钮来重新访问服务器!"

#define ERROR_NETIMG @"nil"
#define ERROR_SEVEVRIMG @"error_msg_t1.png"
@class StyledPageControl;
@class XCErrorMsgView;
@class XCErrorSmallMsgView;
@class XCLoadingMsg;
@class XCOKMsg;
@class XCLoadMsgNode;

@protocol XCErrorMsgViewDelegate <NSObject>
- (void)errorBtnClick;
@end

@interface XCLoadMsg : NSObject
{
    NSMutableDictionary *_manageDic;
}
+ (XCLoadMsg *)sharedLoadMsgManage;
+ (XCLoadMsgNode *)sharedLoadMsg:(id)cotroller;

+ (void)removeLoadMsg:(id)cotroller;
- (NSMutableDictionary *)getManageDic;

- (XCLoadMsgNode *)getMsgNode:(NSString *)key;
@end





@interface XCLoadMsgNode : NSObject<XCErrorMsgViewDelegate>
{
    NSInteger _indexPage;
    BOOL _isShowLoading;
    UIWindow *_window;
    StyledPageControl *_loadPage;
    
    XCErrorMsgView *_errorMsgView;   //大
    XCErrorSmallMsgView *_errorSmallMsgView; //小;
    XCLoadingMsg *_loadingMsgView;
    XCOKMsg      *_okMsgView;
    
    UIView     *_view;
    
    void (^errorBtn)(void);
}
@property (nonatomic,copy) void (^errorBtn)(void);
@property (nonatomic,readonly) StyledPageControl *loadPage;
@property (nonatomic,readonly) UIWindow *window;
@property (nonatomic,assign) UIView *view;

- (void)hideAll;

- (void)showLoading;
- (void)hideLoad;

- (void)showErrorMsgInView:(UIView *)view title:(NSString *)title subtitle:(NSString *)subtitle errorImage:(NSString *)errorImage evn:(void (^)(void))evn;
- (void)showErrorMsgInView:(UIView *)view title:(NSString *)title subtitle:(NSString *)subtitle evn:(void (^)(void))evn;
- (void)showErrorMsgInView:(UIView *)view evn:(void (^)(void))evn;
- (void)hideErrorMsg;

- (void)showErrorSmallMsgInView:(UIView *)view title:(NSString *)title evn:(void (^)(void))evn;
- (void)showErrorSmallMsgInView:(UIView *)view evn:(void (^)(void))evn;
- (void)hideErrorSmallMsg;

- (void)showActivityLoading:(UIView *)view;
- (void)showActivityLoading:(UIView *)view title:(NSString *)title;
- (void)hideActivityLoading;

- (void)showOKMsgInView:(UIView *)view title:(NSString *)title bgImage:(UIImage *)bgImage;
- (void)showOKMsgInView:(UIView *)view title:(NSString *)title;
- (void)hideOKMsg;
@end


@interface XCErrorMsgView : UIView
{
    id           _delegate;
    UIImageView *_errorImg;
    UILabel *_errorTitle;       //错误信息主标题
    UILabel *_errorSubtitle;    //错误信息副标题
    UIButton *_btn;
}
@property (nonatomic,assign) id delegate;
@property (nonatomic,readonly) UIImageView *errorImg;
@property (nonatomic,readonly) UILabel *errorTitle,*errorSubtitle;
@end



@interface XCErrorSmallMsgView : UIView
{
    id _delegate;
    UILabel *_errorTitle;       //错误信息主标题
    UIButton *_btn;
}
@property (nonatomic,assign) id delegate;
@property (nonatomic,readonly) UILabel *errorTitle;
@property (nonatomic,readonly) UIButton *btn;
@end




@interface XCLoadingMsg : UIView
{
    UIActivityIndicatorView *_activityView;
    UILabel *_title;
}
@property (nonatomic,readonly) UIActivityIndicatorView *activityView;
@property (nonatomic,readonly) UILabel *title;
@end

@interface XCOKMsg : UIView
{
    UILabel *_title;
    UIImageView *_bgImageView;
}
@property (nonatomic,readonly) UILabel *title;
@property (nonatomic,readonly) UIImageView *bgImageView;

- (void)setTitleString:(NSString *)title;
@end
