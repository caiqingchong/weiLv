//
//  WLSingletonClass.m
//  WelLv
//
//  Created by WeiLv on 15/10/30.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import "WLSingletonClass.h"
#import "LXUserTool.h"
#import "YXLocationManage.h"

@interface WLSingletonClass ()

@property (nonatomic, strong) NSDateFormatter * formatter;
@property (nonatomic, strong) UIView * bgView;

@end

@implementation WLSingletonClass

+ (WLSingletonClass *)defaultWLSingleton {
    static WLSingletonClass *singletonClass = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonClass = [[WLSingletonClass alloc] init];
    });
    return singletonClass;
}
- (NSString *)wlUserID {
    return [[LXUserTool sharedUserTool] getUid];
}

- (WLMemberType)wlUserType {
    
    if ([[LXUserTool sharedUserTool] getUid] == nil) {
        return WLMemberTypeNone;
    } else if ([[[LXUserTool sharedUserTool] getuserGroup] isEqualToString:@"member"]) {
        return WLMemberTypeMember;
    } else if ([[[LXUserTool sharedUserTool] getuserGroup] isEqualToString:@"assistant"]) {
        return WLMemberTypeSteward;
    }
    return WLMemberTypeNone;
}

- (BOOL)wlUserIsHaveSteward {
    if ([[NSString stringWithFormat:@"%@", [[LXUserTool sharedUserTool] getKeeper]] isEqual:@"0"]) {
        return NO;
    }
    return YES;
}

- (NSString *)wlUserStewardID {
    return [[LXUserTool sharedUserTool] getKeeper];
}

- (NSString *)wlProductTypeCatId:(WLProductType)productType {
    switch (productType) {
        case WLProductTypeAirTicket:
            return @"";
            break;
        case WLProductTypeHotel:
            return @"";
            break;
        case WLProductTypeShip:
            return @"-5";//新版邮轮的"-5"   old为"3"
            break;
        case WLProductTypeStudyTour:
            return @"-2";
            break;
        case WLProductTypeTicket:
            return @"-1";
            break;
        case WLProductTypeTravel:
            return @"1";
            break;
        case WLProductTypeVisa:
            return @"2";
            break;
        case WLProductTypeDriveEat:
            return @"-6";
            break;
        default:
            break;
    }
    return @"没有定义";
}



- (NSString *)wlUserSteShopID {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ste_shop_ID"];
}

/**
 *
 *  判断是不是合伙人-->stroe_id
 */
-(BOOL)wlSetHehuo
{
    NSString *store_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"store_id"];
    NSLog(@"%@",store_id);
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"store_id"] &&[[[NSUserDefaults standardUserDefaults] objectForKey:@"store_id"] integerValue] != 0)
    {
        
        return YES;
        
    }
    return NO;

}
- (BOOL)wlUserIsHaveSteShop {
    
    NSString *ste_shop_ID = [[NSUserDefaults standardUserDefaults] objectForKey:@"ste_shop_ID"];
    NSLog(@"%@",ste_shop_ID);
    if (([[NSUserDefaults standardUserDefaults] objectForKey:@"ste_shop_ID"]) &&([[[NSUserDefaults standardUserDefaults] objectForKey:@"ste_shop_ID"] intValue] != 0))
    {
        return YES;
    }
    return NO;
}
- (NSString *)wlJudgeThumbImageViewURLStr:(NSString *)urlStr {
   
    return [self wlJudgeImageViewURLStr:urlStr splicingStr:@"upload/thumb"];
}

- (NSString *)wlJudgeAlbumImageViewURLStr:(NSString *)urlStr {
       return [self wlJudgeImageViewURLStr:urlStr splicingStr:@"upload/album"];
}

- (NSString *)wlJudgeImageViewURLStr:(NSString *)urlStr splicingStr:(NSString *)splicingStr {
    if ([urlStr hasPrefix:@"http://"] || [urlStr hasPrefix:@"https://"]) {
        return urlStr;
    } else if ([urlStr hasPrefix:@"/upload"] || [urlStr hasPrefix:@"upload"] || splicingStr == nil) {
        return [NSString stringWithFormat:@"%@/%@", WLHTTP, urlStr];
    }
    return [NSString stringWithFormat:@"%@/%@/%@", WLHTTP, splicingStr,urlStr];
}

- (NSString*)wlDictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString*)wlArrayToJson:(NSArray *)arr {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (id)wlJsonStringToDicOrArr:(NSString *)jsonString {
    jsonString = [self judgeReturnString:jsonString withReplaceString:@""];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    return dic;
}

- (WLUserStewardModel *)wlGetStewardModel {
    WLUserStewardModel * model = nil;
    return model;
}

- (WLUserMemberModel *)wlGetMemberModel {
    WLUserMemberModel * model = nil;
    return model;
}

- (WLUserStewardModel *)modelSteawrd {
    if (!_modelSteawrd) {
        self.modelSteawrd = [LXUserTool sharedUserTool].modelSteward;
    }
    return _modelSteawrd;
}

- (WLUserMemberModel *)modelMember {
    if (!_modelMember) {
        self.modelMember = [LXUserTool sharedUserTool].modelMember;
    }
    return _modelMember;
}

- (NSString *)wlLocationCityName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCityName"];
}

- (NSString *)wlLocationCityId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"LocationCityID"];
}

- (NSString *)wlChooseCityName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"chooseCityName"];
}

- (NSString *)wlChooseCityId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"chooesCityID"];
}

- (NSString *)wlCityId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"useCityID"];

}

- (NSString *)wlCityName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"useCityName"];
}

- (BOOL)wlUserIsHaveDEShop {
    return [self judgeString:[LXUserTool sharedUserTool].modelMember.shop_id];
}

- (NSString *)wlDEShopID {
    
    return [LXUserTool sharedUserTool].modelMember.shop_id;
}

- (NSString *)wldeShopStatus {
    return [LXUserTool sharedUserTool].modelMember.shop_status;
}

- (NSString *)wlTimeYYYY_MM_dd_hh_mmWith1970Str:(NSString *)timeStr {
    [self.formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
   return [self.formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeStr integerValue]]];
}

- (NSString *)wlTimeYYYY_MM_ddWith1970Str:(NSString *)timeStr {
    [self.formatter setDateFormat:@"yyyy-MM-dd"];
    return [self.formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeStr integerValue]]];
}

- (NSDateFormatter *)formatter {
    if (!_formatter) {
        self.formatter = [[NSDateFormatter alloc] init];
    }
    return _formatter;
}

- (NSString *)wlNowTimeFormatterStr:(NSString *)formatterStr {
    [self.formatter setDateFormat:formatterStr];
    return [self.formatter stringFromDate:[NSDate date]];
}

- (NSString *)wlTimeFormatterStr:(NSString *)formatterStr timeStr:(NSString *)timeStr {
    [self.formatter setDateFormat:formatterStr];
    return [self.formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[timeStr integerValue]]];
}

- (void)wlAddNoDataViewWithSuperView:(UIView *)superView {
    if (self.bgView) {
        [self wlHiddenNoDataView];
    }
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, (windowContentHeight - 64))];
    self.bgView.backgroundColor = [UIColor whiteColor];
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"wl_no_data"];
    [self.bgView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_bgView);
        make.size.mas_equalTo(imageView.image.size);
    }];
    [superView addSubview:_bgView];
}

- (void)wlHiddenNoDataView {
    if (self.bgView.superview) {
        [self.bgView removeFromSuperview];
    }
    self.bgView = nil;
}

@end
