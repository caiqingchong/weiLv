//
//  JsonHelper.m
//  DeserializationAndSerialization
//
//  Created by Maculish Ting on 14-8-5.
//  Copyright (c) 2014年 Leyard Optoelectronic Co.,Ltd. All rights reserved.
//

#import "JsonHelper.h"
#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>
#import "CJSONSerializer.h"
#import "CJSONDeserializer.h"

@implementation JsonHelper

static JsonHelper* _helper=nil;

+(JsonHelper*)shareSerializer{
    
    if(!_helper){
        _helper=[[JsonHelper alloc]init];
    }
    return _helper;
}

//Convert object to json-string
-(NSString*)serializeObject:(id)theObject{
    
    
    NSString* ClassName=NSStringFromClass([theObject class]);
    
    const char* cClassName=[ClassName UTF8String];
    
    id theClass=objc_getClass(cClassName);
    
    unsigned int outCount,i;
    
    objc_property_t* properties=class_copyPropertyList(theClass, &outCount);
    
    NSMutableArray* propertyNames=[[NSMutableArray alloc]initWithCapacity:1];
    
    for (i=0; i<outCount; i++) {
        
        objc_property_t property=properties[i];
        
        NSString* propertyNameString=[[NSString alloc]initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        [propertyNames addObject:propertyNameString];
        
        NSLog(@"%s %s\n",property_getName(property),property_getAttributes(property));
    }
    
    NSMutableDictionary* finalDict=[[NSMutableDictionary alloc]initWithCapacity:1];
    
    for (NSString* key in propertyNames) {
        
        SEL selector= NSSelectorFromString(key);
        
        
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id value = [theObject performSelector: selector withObject: self];//此处是调用函数的地方
        #pragma clang diagnostic pop
        
        //id value=[theObject performSelector:selector];
        
        if(!value){
            
            value=[NSNull null];
        }
        
        [finalDict setObject:value forKey:key];
    }
    
    NSString* retString=[[CJSONSerializer serializer]serializeDictionary:finalDict];
    
    return retString;
}

//Convert json-string to object
-(id)DeserializeJson:(NSString *)jsonString{
    
    CJSONDeserializer* Deserializer=[CJSONDeserializer deserializer];
    
    NSData* targetData=[jsonString  dataUsingEncoding:NSUTF8StringEncoding];
    NSError* err=nil;
    id theObject = [Deserializer deserialize:targetData error:&err];
    
    return  theObject;
}

@end
