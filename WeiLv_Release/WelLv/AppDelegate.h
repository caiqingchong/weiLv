//
//  AppDelegate.h
//  WelLv
//
//  Created by 刘鑫 on 15/4/1.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTViewController.h"
#import "WXApi.h"
#import "BMapKit.h"
#import <AudioToolbox/AudioToolbox.h>
#import "FirstStartViewController.h"
#import "Reachability.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,UIAlertViewDelegate, BMKGeneralDelegate>
{
    BMKMapManager* _mapManager;
    Reachability *hostReach;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong ,nonatomic) NTViewController * viewController;
@property(nonatomic,strong)BMKMapManager* mapManager;
@property (nonatomic, strong) FirstStartViewController *introductionView;

@property (nonatomic,strong) UIImageView *launchBackImage;

@end

