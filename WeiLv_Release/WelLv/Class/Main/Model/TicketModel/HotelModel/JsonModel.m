//
//  JsonModel.m
//  WelLv
//
//  Created by James on 15/11/30.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "JsonModel.h"

@implementation JsonModel

@synthesize Success=_Success;
@synthesize Msg=_Msg;
@synthesize Data=_Data;

-(id)init{
    
    self=[super init];
    if (self) {
        _Success=@"";
        _Msg=@"";
        _Data=nil;
    }
    return self;
}

@end
