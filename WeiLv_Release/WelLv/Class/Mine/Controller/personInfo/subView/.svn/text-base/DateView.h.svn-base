//
//  DateView.h
//  Sungrnw
//
//  Created by a on 15-2-4.
//  Copyright (c) 2015年 DSsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ssViewDelegate <NSObject>

-(void)sendDateToSup:(NSString *)date;

@end
@interface DateView : UIView

{
    UIDatePicker*datePick;
    NSString *dataText;
    //    放日期的view
    UIView *dataView;
}
@property(nonatomic,weak)id<ssViewDelegate> g_delegate;
@end
