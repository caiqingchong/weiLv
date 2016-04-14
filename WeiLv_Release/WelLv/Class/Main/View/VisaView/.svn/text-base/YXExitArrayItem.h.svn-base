//
//  YXExitArrayItem.h
//  WelLv
//
//  Created by lyx on 15/7/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import <UIKit/UIKit.h>
@class applyModel;
typedef enum {
    VisaCellStyle,
    TicketCellStyle,
} CellStyle;


@protocol YXExitArrayItemDelegate;
@interface YXExitArrayItem : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic)BOOL isEdit;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)id <YXExitArrayItemDelegate> delegate;
@property (nonatomic,assign) CellStyle cellStyle;
@property(nonatomic,strong)applyModel *model;
@property(nonatomic,assign)NSInteger recordCount;
- (id)initWithFrame:(CGRect)frame withCellStyle:(CellStyle)cellStyle;

@end


@protocol YXExitArrayItemDelegate <NSObject>

- (void)editArrayChangeFrame:(YXExitArrayItem *)item;
- (void)AddArrayForItem:(NSInteger)index;
- (void)delArrayForItem:(NSInteger)index;
-(void)chooseTypeView:(UIButton *)button;
@end


@interface YXEditArrayCell : UITableViewCell

@property (nonatomic,strong)UITextField *nameTextField;
@property (nonatomic,strong)UITextField *phoneTextField;
@property (nonatomic,strong)UIButton *chooseTypeBut;
@property (nonatomic,strong)UILabel *chooseTypeLabel;
@property (nonatomic,strong) UIButton *editBtn;
@property (nonatomic,strong)UIView *line1;
@property (nonatomic,assign) CellStyle cellStyle;
@property (nonatomic,strong)UITextField *voucherTypeTF;
@property (nonatomic,strong)UITextField *voucherNumberTF;
@property (nonatomic,strong)UITextField *emailTF;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame withType:(CellStyle)cellStle;


@end

@interface applyModel : NSObject
@property (nonatomic, copy) NSString * nameStr;
@property (nonatomic, copy) NSString * phoneStr;
@property (nonatomic, copy) NSString * eMailStr;
@property (nonatomic, copy) NSString * typeStr;
@property (nonatomic, copy) NSString * typeNO;       

@end
