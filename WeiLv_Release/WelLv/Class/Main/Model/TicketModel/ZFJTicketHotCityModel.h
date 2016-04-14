//
//  ZFJTicketHotCityModel.h
//  WelLv
//
//  Created by 张发杰 on 15/8/13.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFJTicketHotCityModel : NSObject
//@property (nonatomic, copy) NSString * place_city;               // 城市名字
//@property (nonatomic, copy) NSString * place_province;           // 省名
//@property (nonatomic, copy) NSString * product_id;               // <#name#>
//@property (nonatomic, copy) NSString * product_name;             // 产品名称
//@property (nonatomic, copy) NSString * product_theme;            // <#name#>
//@property (nonatomic, copy) NSString * start_price;              // <#name#>
//@property (nonatomic, strong) NSDictionary * images;             // 图片字典
@property (nonatomic, copy) NSString * name;                    // <#name#>
@property (nonatomic, copy) NSString * des;                    // <#name#>
@property (nonatomic, copy) NSString * img;

- (id)initWithDictionary:(NSDictionary *)dic;
@end
