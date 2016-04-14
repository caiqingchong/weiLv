//
//  JsonHelper.h
//  DeserializationAndSerialization
//
//  Created by Maculish Ting on 14-8-5.
//  Copyright (c) 2014年 Leyard Optoelectronic Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JsonHelper : NSObject

+(JsonHelper*)shareSerializer;

-(NSString*)serializeObject:(id)theObject;

-(id)DeserializeJson:(NSString*)jsonString;

@end
