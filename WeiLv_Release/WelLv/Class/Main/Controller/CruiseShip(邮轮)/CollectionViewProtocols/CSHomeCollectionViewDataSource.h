//
//  CSHomeCollectionViewDataSource.h
//  WelLv
//
//  Created by nick on 16/3/10.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CSHomeViewController.h"

@interface CSHomeCollectionViewDataSource : NSObject<UICollectionViewDataSource>

@property(weak, nonatomic) id<CSHomeDelegate> delegate;

@end
