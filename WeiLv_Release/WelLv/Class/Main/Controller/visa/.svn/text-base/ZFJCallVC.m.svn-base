//
//  ZFJCallVC.m
//  WelLv
//
//  Created by 张发杰 on 15/7/16.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "ZFJCallVC.h"
#import "LXGetCityIDTool.h"
#import "IconAndTitleView.h"
#import "LXGuanJiaModel.h"
#import "ChooseTitleView.h"

@interface ZFJCallVC ()
@property (nonatomic, strong) UIButton * moreBut;
@property (nonatomic, strong) UIButton * dismissBut;
@property (nonatomic, assign) CGFloat callButheight;

@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, copy) MoreSteward moreSteward;

@property (nonatomic, strong)ChooseTitleView * callView;
@property (nonatomic, strong) NSDictionary * adminDic;

@end

@implementation ZFJCallVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    switch (self.memberType) {
        case WLMemberTypeNone:
        {
            if (self.prodductType == WLProductTypeTicket) {
                [self addCustomCallViewWithTelStr:@"15838198591"];
            } else if (self.prodductType == WLProductTypeStudyTour) {
                [self addCustomCallViewWithTelStr:@"18539980125"];
            } else {
                [self load_admin_data];
            }
           
        }
            break;
        case WLMemberTypeMember:
        {
            if (self.prodductType == WLProductTypeTicket) {
                [self addCustomCallViewWithTelStr:@"15838198591"];
            } else if (self.prodductType == WLProductTypeStudyTour) {
                [self addCustomCallViewWithTelStr:@"18539980125"];
            } else {
                [self load_admin_data];
            }
        }
            break;
        case WLMemberTypeSteward:
        {
            [self addStewardCellView];
        }
            break;

        default:
            break;
    }
    
    
    
    
    
    
    
    
    /*
    //self.view.layer.cornerRadius = 4.f;
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    if (self.isTicket && !self.isHousekeeper) {
        if (!self.callView) {
            NSArray * titleArr = [NSArray array];
            titleArr = @[@"咨询管家", @"咨询客服"];
            self.callView = [[ChooseTitleView alloc] initWithFrame:self.view.bounds withCallTitleArray:titleArr bigTitle:nil butBackgroundColor:@[kColor(40, 218, 171), kColor(111, 175, 255)]];
            __weak ZFJCallVC * callVC = self;
            [self.callView chooseIndex:^(NSIndexPath *index) {
                if (index.row == 0) {
                    callVC.moreSteward(nil);
                } else if (index.row == 1) {
                    //NSLog(@"咨询客服");
                    //NSLog(@"***\n%@\n***", [callVC.adminDic objectForKey:@"principal_tel"]);
                    NSString * telString = [NSString stringWithFormat:@"tel:%@", @"0371-86085375"];
                    NSURL * telUrl = [NSURL URLWithString:telString];
                    [[UIApplication sharedApplication] openURL:telUrl];
                }
                [callVC dismissViewControllerAnimated:YES completion:NULL];
            }];
            [self.callView chooseTitle:^(NSString *title) {
                [self dismissViewControllerAnimated:YES completion:NULL];
            }];
            
            [self.view addSubview:self.callView];
        }
    } else if (_isHousekeeper) {
        NSArray * titleArr = @[@"咨询客服"];
        self.callView = [[ChooseTitleView alloc] initWithFrame:self.view.bounds withCallTitleArray:titleArr bigTitle:nil butBackgroundColor:@[kColor(40, 218, 171), kColor(111, 175, 255)]];
        __weak ZFJCallVC * callVC = self;
        [self.callView chooseIndex:^(NSIndexPath *index) {
            if (_isTicket) {
                NSString * telString = [NSString stringWithFormat:@"tel:%@", @"0371-86085375"];
                NSURL * telUrl = [NSURL URLWithString:telString];
                [[UIApplication sharedApplication] openURL:telUrl];
                NSLog(@"%@", telString);
            } else {
                [self load_admin_data];
                
            }
            
            [callVC dismissViewControllerAnimated:YES completion:NULL];
        }];
        [self.callView chooseTitle:^(NSString *title) {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        
        [self.view addSubview:self.callView];
    } else  {
        [self load_admin_data];

    }
    */
    
    /*
    [self loadData];
    self.view.frame = CGRectMake(0, 0, ViewWidth(self.view), self.callButheight + 20 + 35 + 35 + 20);
    self.view.center = CGPointMake(windowContentWidth / 2, windowContentHeight / 2);
    //[self addDismissButton];
    
    
    self.dismissBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dismissBut.frame = CGRectMake(15, self.callButheight + 20 + 10 + 30 + 10, windowContentWidth - 50 - 30, 35);
    self.dismissBut.backgroundColor = [UIColor grayColor];
    self.dismissBut.layer.cornerRadius = 5.0;
    self.dismissBut.layer.masksToBounds = YES;
    [self.dismissBut addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.dismissBut setTitle:@"取消" forState:UIControlStateNormal];
    [self.dismissBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:self.dismissBut];
    */
    
}


- (void)addStewardCellView {
    if (self.prodductType == WLProductTypeTicket) {
        [self addServiceWithTelStr:@"15838198591"];
    } else if (self.prodductType == WLProductTypeStudyTour) {
        [self addServiceWithTelStr:@"18539980125"];
    } else {
        [self load_admin_data];
    }
}

- (void)addServiceWithTelStr:(NSString *)telStr {
    NSArray * titleArr = @[@"咨询客服"];
    self.callView = [[ChooseTitleView alloc] initWithFrame:self.view.bounds withCallTitleArray:titleArr bigTitle:nil butBackgroundColor:@[kColor(40, 218, 171), kColor(111, 175, 255)]];
    __weak ZFJCallVC * callVC = self;
    [self.callView chooseIndex:^(NSIndexPath *index) {
            NSString * telString = [NSString stringWithFormat:@"tel:%@", telStr];
            NSURL * telUrl = [NSURL URLWithString:telString];
            [[UIApplication sharedApplication] openURL:telUrl];
            NSLog(@"%@", telString);
        [callVC dismissViewControllerAnimated:YES completion:NULL];
    }];
    [self.callView chooseTitle:^(NSString *title) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }];
    [self.view addSubview:self.callView];
}


- (void)addCustomCallViewWithTelStr:(NSString *)telStr {
    if (!self.callView) {
        NSArray * titleArr = [NSArray array];
        if ([self judgeString:telStr]) {
            titleArr = @[@"咨询管家", @"咨询客服"];
        } else {
            titleArr = @[@"咨询管家"];
        }
        self.callView = [[ChooseTitleView alloc] initWithFrame:self.view.bounds withCallTitleArray:titleArr bigTitle:nil butBackgroundColor:@[kColor(40, 218, 171), kColor(111, 175, 255)]];
        __weak ZFJCallVC * callVC = self;
        [self.callView chooseIndex:^(NSIndexPath *index) {
            if (index.row == 0) {
                if (callVC.moreSteward) {
                    callVC.moreSteward(nil);
                }
            } else if (index.row == 1) {
                NSString * telString = [NSString stringWithFormat:@"tel:%@", telStr];
                NSURL * telUrl = [NSURL URLWithString:telString];
                [[UIApplication sharedApplication] openURL:telUrl];
            }
            [callVC dismissViewControllerAnimated:YES completion:NULL];
        }];
        [self.callView chooseTitle:^(NSString *title) {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        
        [self.view addSubview:self.callView];
    } else {
        if (self.callView.hidden == YES) {
            self.callView.hidden = NO;
        } else if (self.callView.hidden == NO){
            self.callView.hidden = YES;
        };
    }
}



- (void)addCustomCallView {
    if (!self.callView) {
        
        NSArray * titleArr = [NSArray array];
        if ([self judgeString:[self.adminDic objectForKey:@"mobile"]]) {
            titleArr = @[@"咨询管家", @"咨询客服"];
        } else {
            titleArr = @[@"咨询管家"];
        }

        self.callView = [[ChooseTitleView alloc] initWithFrame:self.view.bounds withCallTitleArray:titleArr bigTitle:nil butBackgroundColor:@[kColor(40, 218, 171), kColor(111, 175, 255)]];
        __weak ZFJCallVC * callVC = self;
        [self.callView chooseIndex:^(NSIndexPath *index) {
            if (index.row == 0) {
                if (callVC.moreSteward) {
                    callVC.moreSteward(nil);
                }
            } else if (index.row == 1) {
                //NSLog(@"咨询客服");
                //NSLog(@"***\n%@\n***", [callVC.adminDic objectForKey:@"principal_tel"]);
                NSString * telString = [NSString stringWithFormat:@"tel:%@", [callVC.adminDic objectForKey:@"mobile"]];
                NSURL * telUrl = [NSURL URLWithString:telString];
                [[UIApplication sharedApplication] openURL:telUrl];
            }
            [callVC dismissViewControllerAnimated:YES completion:NULL];
        }];
        [self.callView chooseTitle:^(NSString *title) {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        
        [self.view addSubview:self.callView];
    } else {
        if (self.callView.hidden == YES) {
            self.callView.hidden = NO;
        } else if (self.callView.hidden == NO){
            self.callView.hidden = YES;
        };
    }
}

/**
 *  请求销售商信息;
 */
- (void)load_admin_data {
    NSString * str = nil;

    if ([self judgeString:self.admin_id]) {
        str = [NSString stringWithFormat:@"%@%@", M_ADMIN_URL, self.admin_id];
    } else {
        
        [self addCustomCallView];
        return;
    }
    NSLog(@"Admin_URL_str %@", str);
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __weak ZFJCallVC * callVC = self;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        id dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"获取到的数据为：%@",dict);
        callVC.adminDic = [NSDictionary dictionaryWithDictionary:dict];
        if (callVC.memberType == WLMemberTypeSteward) {
            [callVC addServiceWithTelStr:[callVC.adminDic objectForKey:@"mobile"]];
        } else {
            [callVC addCustomCallView];
        }

    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (callVC.memberType == WLMemberTypeSteward) {
            [[LXAlterView sharedMyTools] createTishi:@"拨打失败,请重试!"];

        } else {
            [callVC addCustomCallView];
        }    }];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}















/**
 *  oldView
 */

- (void)customView {
    CGFloat itmeWidth = (windowContentWidth - 50 - 20 - 10 * 3) / 4.0;
    for (int i = 0; i < MIN(self.dataArray.count, 8); i++) {
        LXGuanJiaModel * model = [self.dataArray objectAtIndex:i];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTap:)];
        
        if (i < 4) {
            IconAndTitleView * itmeView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(itmeWidth * i + 10 + 10 * i, 10, itmeWidth , itmeWidth + 30) roundIconIamge:model.leftImageUrl titleStr:model.nameStr];
            itmeView.tag= 100 + i;
            [itmeView addGestureRecognizer:tap];
            [self.view addSubview:itmeView];
            self.callButheight = ViewBelow(itmeView);
        } else {
            IconAndTitleView * itmeView = [[IconAndTitleView alloc] initWithFrame:CGRectMake(itmeWidth * (i - 4) + 10 + 10 * (i - 4), 10 + itmeWidth + 30 + 10, itmeWidth , itmeWidth + 25) roundIconIamge:model.leftImageUrl titleStr:model.nameStr];
            itmeView.tag= 100 + i;
            [itmeView addGestureRecognizer:tap];
            [self.view addSubview:itmeView];
            self.callButheight = ViewBelow(itmeView);
        }
    }
    self.view.frame = CGRectMake(0, 0, ViewWidth(self.view), self.callButheight + 20 + 35 + 35 + 20);
    self.view.center = CGPointMake(windowContentWidth / 2, windowContentHeight / 2);
    
    self.moreBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreBut.frame = CGRectMake(15, self.callButheight + 20, windowContentWidth - 50 - 30, 35);

    self.moreBut.backgroundColor = kColor(40, 218, 171);
    self.moreBut.layer.cornerRadius = 5.0;
    self.moreBut.layer.masksToBounds = YES;
    [self.moreBut setTitle:@"查看更多" forState:UIControlStateNormal];
    [self.moreBut addTarget:self action:@selector(moreStewardVC:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    if (self.dataArray.count == 0) {
        UILabel * wamingLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ViewWidth(self.view), 50)];
        wamingLabel.text = @"你所在的地区暂时没有提供管家服务 :)";
        wamingLabel.textColor = [UIColor colorWithRed:123 /255.0 green:174 /255.0 blue:253 / 255.0 alpha:1.0];
        wamingLabel.numberOfLines= 0;
        wamingLabel.textAlignment = NSTextAlignmentCenter;
        [wamingLabel sizeToFit];
        [self.view addSubview:wamingLabel];
    } else {
        [self.view addSubview:self.moreBut];
    }
    
   self.dismissBut.frame = CGRectMake(15, self.callButheight + 20 + 10 + 30 + 10, windowContentWidth - 50 - 30, 35);
    
    
    
}
- (void)moreStewardVC:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:NULL];

    self.moreSteward(button);
}

- (void)chooseMoreSteward:(MoreSteward)moreSteward {
    self.moreSteward = moreSteward;
}

- (void)chooseTap:(UITapGestureRecognizer *)tap {
    UIView * tempView = tap.view;
    LXGuanJiaModel * model = [self.dataArray objectAtIndex:tempView.tag - 100];
    NSString * telString = [NSString stringWithFormat:@"tel:%@", model.phone];
    NSURL * telUrl = [NSURL URLWithString:telString];
    [[UIApplication sharedApplication] openURL:telUrl];
}
- (void)viewWillLayoutSubviews {
    
}
- (void)loadData {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:getHouseListUrl parameters:@{@"region_id":[[WLSingletonClass defaultWLSingleton] wlCityId]}
     
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              
              NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              DLog(@"Success: %@", dict);
              for (NSDictionary * dic in [dict objectForKey:@"data"]) {
                  LXGuanJiaModel * model = [[LXGuanJiaModel alloc] init];
                  model.leftImageUrl = [NSString stringWithFormat:@"%@/%@",WLHTTP,[dic objectForKey:@"avatar"]];
                  model.nameStr = [dic objectForKey:@"name"];
                  model.phone = [dic objectForKey:@"mobile"];
                  model.keeperID = [dic objectForKey:@"id"];
                  [self.dataArray addObject:model];
              }
              [self customView];
              //[self viewWillLayoutSubviews];
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
    
              
          }];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
