//
//  ZFJSteShopListShipModel.h
//  WelLv
//
//  Created by WeiLv on 15/10/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFJSteShopListShipModel : NSObject
@property (nonatomic, copy) NSString * features;
@property (nonatomic, copy) NSString * line_name;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * product_name;
@property (nonatomic, copy) NSString * thumb;
@property(nonatomic,copy)NSString *picture;
- (id)initWithDictionary:(NSDictionary *)dic;

@end
