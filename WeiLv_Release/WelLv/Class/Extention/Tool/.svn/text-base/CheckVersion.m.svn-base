//
//  CheckVersion.m
//  WelLv
//
//  Created by James on 16/1/2.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "CheckVersion.h"

//获取本地App版本
#define kHarpyCurrentVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]

@implementation CheckVersion

+(void) checkVersion
{

    NSString *storeString = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",WeiLvAppID];
    NSURL *storeURL = [NSURL URLWithString:storeString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:storeURL];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if ( [data length] > 0 && !error )
        { 
            
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSArray *versionsInAppStore = [[appData valueForKey:@"results"] valueForKey:@"version"];
                
                if (![versionsInAppStore count])
                {
                    return;
                }
                else
                {
                    
                    NSString *currentAppStoreVersion = [versionsInAppStore objectAtIndex:0];
                    
                    if ([kHarpyCurrentVersion compare:currentAppStoreVersion options:NSNumericSearch] == NSOrderedAscending)
                    {
                        
                        [CheckVersion showAlertWithAppStoreVersion:currentAppStoreVersion];
                        
                    }
                    else
                    {
                        //[CheckVersion checkPCVersion];
                    }
                    
                }
                
            });
        }
        
    }];
}


#pragma mark - 检测PC端版本
+(void)checkPCVersion
{
    NSURL *pcURL = [NSURL URLWithString:CHECK_PC_VERSION_URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:pcURL];
    [request setHTTPMethod:@"GET"];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if ( [data length] > 0 && !error )
        {
            
            NSDictionary *appData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                int pcVersions=[[appData objectForKey:@"status"] intValue];
                //int web_Type=[[appData objectForKey:@"web_type"] intValue];
                NSString *pcMsg=[appData objectForKey:@"msg"];
                
                
                
                if (pcVersions==0)
                {
 
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"微旅管家"
                                                                        message:pcMsg
                                                                       delegate:self
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil, nil];
                    alertView.tag=101;
                    
                    [alertView show];
                }
                else
                {
                   
                }
                
            });
        }
        
    }];

}


+ (void)showAlertWithAppStoreVersion:(NSString *)currentAppStoreVersion
{
    
    //NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey];
    
    if ([ForceUpdate isEqual:@"1"])
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:WeiLvAlertViewTitle
                                                            message:[NSString stringWithFormat:@"%@ 发现新版本. 请现在立即更新 %@ ",WeiLvAppName, currentAppStoreVersion]
                                                           delegate:self
                                                  cancelButtonTitle:WeiLvUpdateButtonTitle
                                                  otherButtonTitles:nil, nil];
        alertView.tag=100;
        
        [alertView show];
        
    }
    else
    {
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:WeiLvAlertViewTitle
                                                            message:[NSString stringWithFormat:@"%@ 发现新版本. 请现在立即更新 %@ ", WeiLvAppName, currentAppStoreVersion]
                                                           delegate:self
                                                  cancelButtonTitle:WeiLvCancelButtonTitle
                                                  otherButtonTitles:WeiLvUpdateButtonTitle, nil];
        
        [alertView show];
        
    }
    
}


+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([ForceUpdate isEqual:@"1"])
    {
        //PC端版本 提示框 按钮
        if (alertView.tag==101)
        {
//            NSString *pcString = [NSString stringWithString:WLHTTP];
//            NSURL *pcURL = [NSURL URLWithString:pcString];
//            [[UIApplication sharedApplication] openURL:pcURL];
        }
        else
        {
            //APP端版本 提示框 按钮
            NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@",WeiLvAppID];
            NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
            [[UIApplication sharedApplication] openURL:iTunesURL];
        }
        [CheckVersion exitApplication];
    }
    else
    {
        
        switch ( buttonIndex )
        {
            case 0:
            {
                
            }
            break;
            case 1:
            {
                // Update1方法 (在网页中打开)
                //                NSString *iTunesString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", kCcpsptAppID];
                //                NSURL *iTunesURL = [NSURL URLWithString:iTunesString];
                //                [[UIApplication sharedApplication] openURL:iTunesURL];
                
                
                //itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=40461254  (在网页中打开)
                //Update2 在iPhone应用里直接打开app store
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",WeiLvAppID]]];
                [CheckVersion exitApplication];
            }
            break;
            default:
            break;
        }
    }
}

+(void)exitApplication
{
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];

}

@end
