//
//  JsonModel.h
//  WelLv
//
//  Created by James on 15/11/30.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonModel : NSObject{
    NSString *_Success;
    NSString *_Msg;
    NSMutableArray *_Data;
}

@property(nonatomic,retain)NSString *Success;
@property(nonatomic,retain)NSString *Msg;
@property(nonatomic,retain)NSMutableArray *Data;

@end
