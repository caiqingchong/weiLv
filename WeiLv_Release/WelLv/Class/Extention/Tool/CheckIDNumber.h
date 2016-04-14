//
//  CheckIDNumber.h
//  WelLv
//
//  Created by mac for csh on 15/6/30.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckIDNumber : NSObject

+ (CheckIDNumber *)sharedMyTools;

- (BOOL)validateIDCardNumber:(NSString *)value;
@end
