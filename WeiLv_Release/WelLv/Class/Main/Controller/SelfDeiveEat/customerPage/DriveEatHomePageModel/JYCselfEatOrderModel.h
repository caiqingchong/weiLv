//
//  JYCselfEatOrderModel.h
//  WelLv
//
//  Created by lyx on 15/11/30.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYCselfEatOrderModel : NSObject
@property(nonatomic,copy)NSString *come_time;
@property(nonatomic,copy)NSString *contacts;
@property(nonatomic,copy)NSString *create_time;
@property(nonatomic,copy)NSString *describe;
@property(nonatomic,copy)NSString *driving_order_id;
@property(nonatomic,copy)NSString *is_delete;
@property(nonatomic,copy)NSString *logo;
@property(nonatomic,copy)NSString *nums;
@property(nonatomic,copy)NSString *order_status;
@property(nonatomic,copy)NSString *partner_shop_name;
@property(nonatomic,copy)NSString *pay_status;
@property(nonatomic,copy)NSString *pay_time;
@property(nonatomic,copy)NSString *pay_type;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *receive_time;
@property(nonatomic,copy)NSString *refund_time;
@property(nonatomic,copy)NSString *sn;
@property(nonatomic,copy)NSString *use_time;
@property(nonatomic,strong)NSMutableArray *productArr;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

@interface pdModel : NSObject
@property(nonatomic,copy)NSString *describe;
@property(nonatomic,copy)NSString *driving_order_driving_order_id;
@property(nonatomic,copy)NSString *images;
@property(nonatomic,copy)NSString *nums;
@property(nonatomic,copy)NSString *original_price;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *univalence;
@end
//describe = "\U9ed1\U6912\U725b\U67f3";
//"driving_order_driving_order_id" = 117;
//images = "[\"upload\\/image\\/de-images1448445110.jpg\",\"upload\\/image\\/de-images14484451101.jpg\"]";
//nums = 7;
//"original_price" = "18.00";
//price = "84.00";
//univalence = "12.00";
//



//"come_time" = 1448936116;
//contacts = rgg;
//"create_time" = 1448849782;
//describe = "\U5bab\U4fdd\U9e21\U4e012";
//"driving_order_id" = 31;
//"is_delete" = 0;
//logo = "upload/image/hygiene_licenses1448593536.png";
//nums = 2;
//"order_status" = 0;
//"partner_shop_name" = "\U6211\U7684\U94fa\U5b50";
//"pay_status" = 1;
//"pay_time" = 0;
//"pay_type" = 0;
//phone = 13838183917;
//price = "108.00";
//"receive_time" = "<null>";
//"refund_time" = 0;
//sn = 11151130081820001;
//"use_time" = 0;
//}