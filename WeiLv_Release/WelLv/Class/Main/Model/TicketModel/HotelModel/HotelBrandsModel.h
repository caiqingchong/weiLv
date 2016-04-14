//
//  HotelBrandsModel.h
//  WelLv
//
//  Created by 吴伟华 on 15/11/20.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelBrandsModel : NSObject
@property (nonatomic,strong) NSString *brandname;
@property (nonatomic,strong) NSString *brandcode;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
