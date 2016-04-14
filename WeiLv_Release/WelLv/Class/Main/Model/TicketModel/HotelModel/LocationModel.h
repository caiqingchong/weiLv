//
//  LocationModel.h
//  WelLv
//
//  Created by James on 15/11/30.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationModel : NSObject{
    NSString *__id;
    NSString *_pid;
    NSString *_name;
    NSString *_sort;
    NSMutableArray *_children;
}

@property(nonatomic,retain)NSString *_id;
@property(nonatomic,retain)NSString *pid;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *sort;
@property(nonatomic,retain)NSMutableArray *children;

@end
