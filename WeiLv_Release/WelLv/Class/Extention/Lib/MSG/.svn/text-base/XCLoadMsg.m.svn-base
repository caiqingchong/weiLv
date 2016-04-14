//
//  XCLoadMsg.m
//  加载条
//
//  Created by apple on 13-7-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "XCLoadMsg.h"
#import "AppDelegate.h"


#define LOAD_PAGE_NUMBER 3
#define LOAD_PAGE_DELAY 0.28
static XCLoadMsg *loadMsg;
@implementation XCLoadMsg

+ (XCLoadMsg *)sharedLoadMsgManage
{
    if (loadMsg == nil)
    {
        loadMsg = [[XCLoadMsg alloc] init];
    }
    return loadMsg;
}

+ (XCLoadMsgNode *)sharedLoadMsg:(id)cotroller
{
    XCLoadMsg *obj = [self sharedLoadMsgManage];
    
    NSString *keyStr = [NSString stringWithFormat:@"%p",cotroller];
    return [obj getMsgNode:keyStr];
}
+ (void)removeLoadMsg:(id)cotroller
{
    XCLoadMsg *obj = [self sharedLoadMsgManage];
    NSString *keyStr = [NSString stringWithFormat:@"%p",cotroller];
    XCLoadMsgNode *node = [[obj getManageDic] objectForKey:keyStr];
    node.view = nil;
    [[obj getManageDic] removeObjectForKey:keyStr];
}
- (void)dealloc
{
    [_manageDic release];
    [super dealloc];
}
- (id)init
{
    if (self = [super init])
    {
        _manageDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}
- (NSMutableDictionary *)getManageDic
{
    return _manageDic;
}
- (XCLoadMsgNode *)getMsgNode:(NSString *)key
{
    XCLoadMsgNode *node = [_manageDic objectForKey:key];
    if (node == nil)
    {
        node = [[XCLoadMsgNode alloc] init];
        [_manageDic setObject:node forKey:key];
        [node release];
    }
    return node;
}
@end



@implementation XCLoadMsgNode
@synthesize window=_window;
@synthesize loadPage=_loadPage;
@synthesize errorBtn;
@synthesize view=_view;

- (void)dealloc
{
    [_errorMsgView release];   //大
    [_errorSmallMsgView release]; //小;
    [_loadingMsgView release];
    [_okMsgView release];
    [errorBtn release];
    [_window release];
    [super dealloc];
}

- (void)showLoading
{
    if (_isShowLoading == YES)
        return;
//    _loadPage.alpha = 1.0f;
    _indexPage = -1;
    _isShowLoading = YES;
    _window.windowLevel = [self getApp].window.windowLevel + UIWindowLevelStatusBar;
    [_window makeKeyAndVisible];
//    _loadPage.hidden = NO;
//    _loadPage.currentPage = _indexPage;
    [self performSelector:@selector(scrollPage) withObject:nil afterDelay:LOAD_PAGE_DELAY];
}
- (void)hideLoad
{
    if (_isShowLoading == NO)
        return;
    
    _window.windowLevel = - 1.0f;
//    _loadPage.alpha = 0.0f;
    UIWindow *window = [self getApp].window;
    [window makeKeyAndVisible];
    _isShowLoading = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)scrollPage
{
    _indexPage ++;
    if (_indexPage == LOAD_PAGE_NUMBER)
        _indexPage = -1 ;
    
//    _loadPage.currentPage = _indexPage;
    [self performSelector:@selector(scrollPage) withObject:nil afterDelay:LOAD_PAGE_DELAY];
}


- (AppDelegate *)getApp
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return app;
}

#pragma mark -
#pragma mark Error
- (void)initErrorMsgViewErrortype
{
    if (_errorMsgView != nil)
    {
        return;
    }
    _errorMsgView = [[XCErrorMsgView alloc] initWithFrame:CGRectZero];
    _errorMsgView.delegate = self;
}
- (void)showErrorMsgInView:(UIView *)view title:(NSString *)title subtitle:(NSString *)subtitle errorImage:(NSString *)errorImage evn:(void (^)(void))evn
{
    [self initErrorMsgViewErrortype];
    _view = view;
    self.errorBtn = evn;
    _errorMsgView.frame = view.bounds;
    _errorMsgView.errorTitle.text = title;
    _errorMsgView.errorSubtitle.text = subtitle;
    _errorMsgView.errorImg.image = [UIImage imageNamed:errorImage];
    [view addSubview:_errorMsgView];
    [view bringSubviewToFront:_errorMsgView];
}
- (void)showErrorMsgInView:(UIView *)view title:(NSString *)title subtitle:(NSString *)subtitle evn:(void (^)(void))evn
{
    [self initErrorMsgViewErrortype];
    _view = view;
    self.errorBtn = evn;
    _errorMsgView.frame = view.bounds;
    _errorMsgView.errorTitle.text = title;
    _errorMsgView.errorSubtitle.text = subtitle;
    [view addSubview:_errorMsgView];
    [view bringSubviewToFront:_errorMsgView];
}
- (void)showErrorMsgInView:(UIView *)view evn:(void (^)(void))evn
{
    [self initErrorMsgViewErrortype];
    _view = view;
    self.errorBtn = evn;
    _errorMsgView.frame = view.bounds;
    _errorMsgView.errorTitle.text = ERROR_TITLE;
    _errorMsgView.errorSubtitle.text = ERROR_SUBTITLE;
    [view addSubview:_errorMsgView];
    [view bringSubviewToFront:_errorMsgView];
}
- (void)showServiceErrorMsgInView:(UIView *)view evn:(void (^)(void))evn
{
    [self initErrorMsgViewErrortype];
    _view = view;
    self.errorBtn = evn;
    _errorMsgView.frame = view.bounds;
    _errorMsgView.errorTitle.text = ERROR_SERVER_TITLE;
    _errorMsgView.errorSubtitle.text = ERROR_SERVER_SUBTITLE;
    [view addSubview:_errorMsgView];
    [view bringSubviewToFront:_errorMsgView];
}
- (void)hideErrorMsg
{
    if (_errorMsgView == nil || (id)_errorMsgView == [NSNull null])
        return;
    
    [YXTools cATransitionAnimation:_view typeIndex:0 subTypeIndex:0 duration:0.25 animation:^{
        [_errorMsgView removeFromSuperview];
    }];
    [errorBtn release];
    errorBtn = nil;
}
- (void)errorBtnClick
{
    if (errorBtn == nil)
        return;
    
    self.errorBtn();
    [errorBtn release];
    errorBtn = nil;
}

#pragma mark -
#pragma mark Loading
- (void)initLoadingView
{
    if (_loadingMsgView != nil)
    {
        return;
    }
    _loadingMsgView = [[XCLoadingMsg alloc] initWithFrame:CGRectZero];
}
- (void)showActivityLoading:(UIView *)view
{
    [self initLoadingView];
    _view = view;

    _loadingMsgView.frame = view.bounds;
    [_loadingMsgView.activityView startAnimating];
    [view addSubview:_loadingMsgView];
    [view bringSubviewToFront:_loadingMsgView];
}
- (void)showActivityLoading:(UIView *)view title:(NSString *)title
{
    [self initLoadingView];
    _view = view;
    _loadingMsgView.frame = view.bounds;
    [_loadingMsgView.activityView startAnimating];
    _loadingMsgView.title.text = title;
    [view addSubview:_loadingMsgView];
    [view bringSubviewToFront:_loadingMsgView];
}
- (void)hideActivityLoading
{
    if (_view == nil || (id)_view == [NSNull null])
    {
        return;
    }
    if (_loadingMsgView == nil || (id)_loadingMsgView == [NSNull null])
        return;
    
    [_loadingMsgView.activityView stopAnimating];
    [YXTools cATransitionAnimation:_view typeIndex:0 subTypeIndex:0 duration:0.25 animation:^{
        [_loadingMsgView removeFromSuperview];
    }];
}

#pragma mark -
#pragma mark SmallError
- (void)initSmallErrorMsgView
{
    if (_errorSmallMsgView != nil)
    {
        return;
    }
    _errorSmallMsgView = [[XCErrorSmallMsgView alloc] initWithFrame:CGRectZero];
    _errorSmallMsgView.delegate = self;
}
- (void)showErrorSmallMsgInView:(UIView *)view title:(NSString *)title evn:(void (^)(void))evn
{
    [self initSmallErrorMsgView];
    _view = view;
    self.errorBtn = evn;
    _errorSmallMsgView.frame = view.bounds;
    _errorSmallMsgView.errorTitle.text = title;
    [view addSubview:_errorSmallMsgView];
    [view bringSubviewToFront:_errorSmallMsgView];
}
- (void)showErrorSmallMsgInView:(UIView *)view evn:(void (^)(void))evn
{
    [self initSmallErrorMsgView];
    _view = view;
    self.errorBtn = evn;
    _errorSmallMsgView.frame = view.bounds;
    _errorSmallMsgView.errorTitle.text = ERROR_TITLE;
    [view addSubview:_errorSmallMsgView];
    [view bringSubviewToFront:_errorSmallMsgView];
}
- (void)hideErrorSmallMsg
{
    if (_errorSmallMsgView == nil || (id)_errorSmallMsgView == [NSNull null])
        return;
    [YXTools cATransitionAnimation:_view typeIndex:0 subTypeIndex:0 duration:0.25 animation:^{
        [_errorSmallMsgView removeFromSuperview];
    }];
    [errorBtn release];
    errorBtn = nil;
}
#pragma mark -
#pragma mark OKMsg
- (void)initOKMsgView
{
    if (_okMsgView != nil)
    {
        return;
    }
    _okMsgView = [[XCOKMsg alloc] initWithFrame:CGRectZero];
}
- (void)showOKMsgInView:(UIView *)view title:(NSString *)title bgImage:(UIImage *)bgImage
{
    [self initOKMsgView];
    _view = view;
    _okMsgView.frame = view.bounds;
    [_okMsgView setTitleString:title];
    _okMsgView.bgImageView.image = bgImage;
    [view addSubview:_okMsgView];
    [view bringSubviewToFront:_okMsgView];
}
- (void)showOKMsgInView:(UIView *)view title:(NSString *)title
{
    [self initOKMsgView];
    _view = view;
    _okMsgView.frame = view.bounds;
    [_okMsgView setTitleString:title];
    [view addSubview:_okMsgView];
    [view bringSubviewToFront:_okMsgView];
}
- (void)hideOKMsg
{
    if (_okMsgView == nil || (id)_okMsgView == [NSNull null])
        return;
    
    [YXTools cATransitionAnimation:_view typeIndex:0 subTypeIndex:0 duration:0.25 animation:^{
        [_okMsgView removeFromSuperview];
    }];
    [errorBtn release];
    errorBtn = nil;
}


- (void)hideAll
{
    [YXTools cATransitionAnimation:_view typeIndex:0 subTypeIndex:0 duration:0.25 animation:^{

        [_okMsgView removeFromSuperview];
        [_errorSmallMsgView removeFromSuperview];
        [_loadingMsgView removeFromSuperview];
        [_errorMsgView removeFromSuperview];
        _view = nil;
    }];
}
@end


#define ERROR_BG_IMG @"error_msg_bg.png"

#define ERROR_BTN @"loadNomal.png"
#define mDeviceWidth [UIScreen mainScreen].bounds.size.width
@implementation XCErrorMsgView
@synthesize errorImg=_errorImg;
@synthesize errorTitle=_errorTitle,errorSubtitle=_errorSubtitle;
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, windowContentWidth, windowContentHeight-64)];
        imgView.image=[UIImage imageNamed:@"error_msg_bg"];
       
        [self addSubview:imgView];
        [self initView];
    }
    return self;
}

- (void)initView
{
    
    float y = (self.frame.size.height - 220)/2;
    
    _errorImg = [[UIImageView alloc] init];
    UIImage *netImage = [UIImage imageNamed:ERROR_NETIMG];
    _errorImg.image = netImage;
    _errorImg.frame = CGRectMake(self.frame.size.width/2-netImage.size.width/4, y, netImage.size.width/2, netImage.size.height/2);

//    _errorImg.frame = CGRectMake(self.frame.size.width/2-102.5/2, y, 102.5, 137/2);
    [self addSubview:_errorImg];
    [_errorImg release];
    
    _errorTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, _errorImg.frame.size.height+_errorImg.frame.origin.y+20, self.frame.size.width-20, 25)];
    _errorTitle.font = [UIFont systemFontOfSize:14.0f];
    _errorTitle.textAlignment = 1;
    _errorTitle.textColor = [UIColor blackColor];
    _errorTitle.backgroundColor = [UIColor clearColor];
    [self addSubview:_errorTitle];
    [_errorTitle release];
    
    _errorSubtitle = [[UILabel alloc] initWithFrame:CGRectMake(10, _errorTitle.frame.size.height+_errorTitle.frame.origin.y, self.frame.size.width-20, 20)];
    _errorSubtitle.font = [UIFont systemFontOfSize:12.0f];
    _errorSubtitle.textAlignment = 1;
    _errorSubtitle.textColor = [UIColor grayColor];
    _errorSubtitle.backgroundColor = [UIColor clearColor];
    [self addSubview:_errorSubtitle];
    [_errorSubtitle release];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(self.frame.size.width/2-200/2, windowContentHeight - 40, 200, 40);
    [_btn.layer setCornerRadius:5.0];
    _btn.layer.borderWidth = 0.2;
    _btn.layer.borderColor = [UIColor grayColor].CGColor;
    [_btn setTitle:@"重新加载" forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [_btn setBackgroundImage:[UIImage imageNamed:ERROR_BTN] forState:UIControlStateNormal];
//    [_btn setBackgroundImage:[UIImage imageNamed:@"loadHight.png"] forState:UIControlStateHighlighted];
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
}
- (void)setFrame:(CGRect)frame
{
    BOOL v = NO;
    if (CGRectEqualToRect(frame,self.frame))
        v = YES;
    
    [super setFrame:frame];
    
    if (v == YES)
        return;
    
    float y = (self.frame.size.height - 220)/2;
    
    _errorImg.frame = CGRectMake(self.frame.size.width/2-_errorImg.frame.size.width/2, y, _errorImg.frame.size.width, _errorImg.frame.size.height);
    _errorTitle.frame = CGRectMake(_errorTitle.frame.origin.x, _errorImg.frame.size.height+_errorImg.frame.origin.y+20, self.frame.size.width-(_errorTitle.frame.origin.x*2), _errorTitle.frame.size.height);
    _errorSubtitle.frame = CGRectMake(_errorSubtitle.frame.origin.x, _errorTitle.frame.size.height+_errorTitle.frame.origin.y, self.frame.size.width-(_errorSubtitle.frame.origin.x*2), _errorSubtitle.frame.size.height);
    _btn.frame = CGRectMake(self.frame.size.width/2-_btn.frame.size.width/2, self.frame.size.height - 100, _btn.frame.size.width, _btn.frame.size.height);
}

- (void)btnClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(errorBtnClick)])
    {
        [_delegate errorBtnClick];
    }
}
@end


@implementation XCErrorSmallMsgView
@synthesize errorTitle=_errorTitle;
@synthesize btn=_btn;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView
{
    _errorTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 16, 32)];
    _errorTitle.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-20);
    _errorTitle.textColor = [UIColor blackColor];
    _errorTitle.font = [UIFont systemFontOfSize:12.0f];
    _errorTitle.backgroundColor = [UIColor clearColor];
    _errorTitle.textAlignment = UITextAlignmentCenter;
    [self addSubview:_errorTitle];
    [_errorTitle release];
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(self.frame.size.width/2 - 30/2, _errorTitle.frame.origin.y+_errorTitle.frame.size.height, 60, 20);
    [_btn setBackgroundImage:[UIImage imageNamed:@"error_msg_btn.png"] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(smallButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
    
}

- (void)smallButtonClick:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(errorBtnClick)])
    {
        [_delegate errorBtnClick];
    }
}

- (void)setFrame:(CGRect)frame
{
    BOOL v = NO;
    if (CGRectEqualToRect(frame,self.frame))
        v = YES;
    
    [super setFrame:frame];
    
    if (v == YES)
        return;
    
    _errorTitle.frame = CGRectMake(0, 0, self.frame.size.width - 16, 32);
    _errorTitle.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-20);
    _btn.frame = CGRectMake(self.frame.size.width/2 - _btn.frame.size.width/2, _errorTitle.frame.origin.y+_errorTitle.frame.size.height, _btn.frame.size.width, _btn.frame.size.height);
}

@end


@implementation XCLoadingMsg
@synthesize activityView=_activityView;
@synthesize title=_title;
- (void)dealloc
{
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
        [self initView];
    }
    return self;
}
- (void)initView
{
    _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityView.frame = CGRectMake(0, 0, 25, 25);
    _activityView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:_activityView];
    [_activityView release];
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(10, _activityView.frame.size.height+_activityView.frame.origin.y+5, self.frame.size.width - 20, 20)];
    _title.textAlignment = UITextAlignmentCenter;
    _title.textColor = [UIColor blackColor];
    _title.font = [UIFont systemFontOfSize:13.0f];
    _title.backgroundColor = [UIColor clearColor];
    [self addSubview:_title];
    [_title release];
}
- (void)setFrame:(CGRect)frame
{
    BOOL v = NO;
    if (CGRectEqualToRect(frame,self.frame))
        v = YES;
    
    [super setFrame:frame];
    
    if (v == YES)
        return;
    
    _activityView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _title.frame = CGRectMake(10, _activityView.frame.size.height+_activityView.frame.origin.y+5, self.frame.size.width - 20, _title.frame.size.height);
}
@end



@implementation XCOKMsg
@synthesize title=_title;
@synthesize bgImageView=_bgImageView;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}
- (void)initView
{
    _title = [[UILabel alloc] init];
    _title.backgroundColor = [UIColor clearColor];
    _title.textAlignment = UITextAlignmentCenter;
    _title.font = [UIFont systemFontOfSize:14.0f];
    _title.textColor = [UIColor blackColor];
    _title.numberOfLines = 0;
    _title.text = @"成功!";
    //CGSize size = [_title.text sizeWithFont:_title.font forWidth:self.frame.size.width - 30 lineBreakMode:_title.lineBreakMode];
    _title.bounds = CGRectMake(0, 0, 80, 30);
    _title.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    [self addSubview:_title];
    [_title release];
    
    _bgImageView = [[UIImageView alloc] initWithFrame:_title.frame];
    _bgImageView.image = [UIImage imageNamed:@""];
    [self addSubview:_bgImageView];
    [self sendSubviewToBack:_bgImageView];
    [_bgImageView release];
}
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _title.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _bgImageView.frame = _title.frame;
}
- (void)setTitleString:(NSString *)title
{
    CGSize size = [title sizeWithFont:_title.font forWidth:self.frame.size.width - 30 lineBreakMode:_title.lineBreakMode];
    _title.bounds = CGRectMake(0, 0, size.width, size.height);
    _title.text = title;
    _bgImageView.frame = _title.frame;
}
@end

