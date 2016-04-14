//
//  WWHHotelTopListBtn.h
//  WelLv
//
//  Created by 吴伟华 on 15/11/23.
//  Copyright © 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WWHHotelTopListBtn;
@protocol WWHHotelTopListBtnDelegate<NSObject>
@optional;
-(void)hotelTopBtnClickWithFirstCell:(NSInteger)first sectCell:(NSInteger)sectCell;
@end

@interface WWHHotelTopListBtn : UIButton
@property (nonatomic , strong, readonly) id model;
@property (nonatomic , assign, readonly) NSInteger firstCellRow;
@property (nonatomic , assign, readonly) NSInteger secCellRow;
@property (nonatomic , weak) id<WWHHotelTopListBtnDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame topListBtnWithModel:(id)model andFirstCell:(NSInteger)first sectCell:(NSInteger)sectCell andIsSelect:(BOOL)isSelect;

@end
