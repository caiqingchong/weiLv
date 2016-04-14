//
//  weilvAnnounceDetailModel.h
//  WelLv
//
//  Created by mac for csh on 15/11/26.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weilvAnnounceDetailModel : NSObject

@property (nonatomic,copy)NSString *news_id;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *intro;
@property (nonatomic,copy)NSString *content;
//@property (nonatomic,copy)NSString *cate_id;
@property (nonatomic,copy)NSString *author;
@property (nonatomic,copy)NSString *source;
//@property (nonatomic,copy)NSString *admin_id;
@property (nonatomic,copy)NSString *thumb;
@property (nonatomic,copy)NSString *push_time;
//@property (nonatomic,copy)NSString *update_time;
//@property (nonatomic,copy)NSString *is_delete;
//@property (nonatomic,copy)NSString *city_id;
//@property (nonatomic,copy)NSString *sort;
//@property (nonatomic,copy)NSString *tag;

- (id)initWithDictionary:(NSDictionary *)dic;
@end
