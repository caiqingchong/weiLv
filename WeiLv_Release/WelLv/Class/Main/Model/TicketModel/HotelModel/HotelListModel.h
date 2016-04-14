//
//  HotelListModel.h
//  WelLv
//
//  Created by 吴伟华 on 15/11/19.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotelListModel : NSObject
@property (nonatomic,strong) NSString *HotelId;//酒店编码
@property (nonatomic,strong) NSString *LowRate;//最低价格
@property (nonatomic,strong) NSString *ThumbNailUrl;//封面图片
@property (nonatomic,strong) NSString *HotelName;//酒店名称
@property (nonatomic,strong) NSString *StarRate;//挂牌星级
@property (nonatomic,strong) NSString *Score;//好评率
@property (nonatomic,strong) NSString *Address;//地址
//+(instancetype)hotelListWithDic:(NSDictionary *)dic;
-(instancetype)initWithDic:(NSDictionary *)dic;
@end
