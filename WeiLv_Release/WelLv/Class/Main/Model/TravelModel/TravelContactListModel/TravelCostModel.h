//
//  TravelCostModel.h
//  WelLv
//
//  Created by 张子乾 on 16/1/19.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravelCostModel : NSObject

//费用包含
@property (nonatomic, strong) NSString *fee_include;
//费用不包含
@property (nonatomic, strong) NSString *fee_not_include;
//预定须知
@property (nonatomic, strong) NSString *sign_way;
//特殊限制
@property (nonatomic, strong) NSString *special_limit;
//温馨提示
@property (nonatomic, strong) NSString *warm_prompt;

@end
