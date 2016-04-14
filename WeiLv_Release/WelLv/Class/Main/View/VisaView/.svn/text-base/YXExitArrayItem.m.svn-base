//
//  YXExitArrayItem.m
//  WelLv
//
//  Created by lyx on 15/7/15.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "YXExitArrayItem.h"
#define ARRAY_CeLL 81

@implementation YXExitArrayItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = frame;
        _dataArray=[[NSMutableArray alloc]init];
        [_dataArray addObject:@"2"];
        self.cellStyle = VisaCellStyle;
        [self initView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withCellStyle:(CellStyle)cellStyle
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = frame;
        _dataArray=[[NSMutableArray alloc]init];
        [_dataArray addObject:@"0"];
        
        self.cellStyle = cellStyle;
        [self initView];
    }
    return self;
}

- (void)initView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = YES;
    _tableView.showsVerticalScrollIndicator = YES;
    _tableView.scrollEnabled = NO;
    [self addSubview:_tableView];
    
}
#pragma mark - 添加申请人 点击 事件
- (void)addSuplyPson
{
    self.recordCount=_dataArray.count;
    NSString *objc = @"1";
    [_dataArray addObject:objc];
    [_tableView reloadData];
    [self setChangeFrame];
    if ([self.delegate respondsToSelector:@selector(AddArrayForItem:)])
    {
        [self.delegate AddArrayForItem:0];
    }
  
}
- (void)setDataArray:(NSMutableArray *)dataArray
{
   
    _dataArray = dataArray;
    
   
    [_tableView reloadData];
    [self setChangeFrame];
    [self layoutSubviews];
    
}
#pragma mark - 动态设置表视图的尺寸大小
- (void) setChangeFrame
{
    if (self.cellStyle == VisaCellStyle)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, ARRAY_CeLL*(_dataArray.count)+ARRAY_CeLL);
            _tableView.frame = self.bounds;
        }];
    }
    else if (self.cellStyle == TicketCellStyle)
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, (ARRAY_CeLL * 2 + 40)*(_dataArray.count)+ARRAY_CeLL);
            _tableView.frame = self.bounds;
        }];
    }
   
}

- (void)layoutSubviews
{
    if ([self.delegate respondsToSelector:@selector(editArrayChangeFrame:)])
    {
        [self.delegate editArrayChangeFrame:self];
    }
}
#pragma mark - 设置是否 出现减号
- (void)setIsEdit:(BOOL)isEdit
{
    _isEdit = isEdit;
    [_tableView reloadData];
}
#pragma mark - 表视图刷新
- (void)reloadData
{
    [_tableView reloadData];
}


#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==1)
    {
        return 1;
    }
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.cellStyle == VisaCellStyle)
    {
        return ARRAY_CeLL;

    } else if (self.cellStyle == TicketCellStyle)
    {
        return ARRAY_CeLL * 2 + 40;

    }
    return ARRAY_CeLL;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        static NSString *cellIdentifier = @"YXEditArrayCell";
        YXEditArrayCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell==nil)
        {
            cell = [[YXEditArrayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier frame:CGRectMake(0, 0, self.frame.size.width, ARRAY_CeLL) withType:self.cellStyle] ;
            
        }
        
        if (indexPath.row >=self.recordCount)
        {
            cell.nameTextField.text=nil;
            cell.phoneTextField.text=nil;
            cell.emailTF.text=nil;
            cell.voucherNumberTF.text=nil;
            cell.voucherTypeTF.text=nil;
        }
        if (_dataArray.count==1)
        {
            
           cell.editBtn.hidden = YES;
    
        }
        else
        {
            cell.editBtn.hidden=NO;
        }
        //设置减号按钮Tag值
        cell.editBtn.tag = indexPath.row;
        
        //减号按钮点击事件
        [cell.editBtn addTarget:self action:@selector(selectRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //证件类型按钮点击事件
        [cell.chooseTypeBut addTarget:self action:@selector(selectedType:) forControlEvents:UIControlEventTouchUpInside];
        
        if (indexPath.row == _dataArray.count-1)
        {
            cell.line1.hidden = YES;
        }else
        {
            cell.line1.hidden = NO;
        }
        return cell;
        
    }else if(indexPath.section == 1)
    {
        static NSString *CellIdentifier3 = @"cellIdentifier3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier3];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier3];
            //单元格的选择风格，选择时单元格不出现蓝条
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
             UIButton *addBtn = [YXTools allocButton:@"添加出游人" textColor:[UIColor whiteColor] nom_bg:[UIImage imageNamed:@"咨询"] hei_bg:nil frame:CGRectMake(Begin_X*2, 10,self.frame.size.width - Begin_X*4, 40)];
            [addBtn addTarget:self action:@selector(addSuplyPson) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:addBtn];
        }
        return cell;
    }
    return nil;
}
#pragma mark - 证件类型 点击事件
- (void)selectedType:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(chooseTypeView:)])
    {
        [self.delegate chooseTypeView:sender];
    }
}
#pragma mark - 减号 点击事件
- (void)selectRightBtn:(UIButton *)sender
{
    
    YXEditArrayCell *cell=(YXEditArrayCell *)[sender superview];
    DLog(@"%@",cell.nameTextField);
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    DLog(@"%ld----%ld",indexPath.row,indexPath.section);
    
    [_dataArray removeObjectAtIndex:sender.tag];
   
    
    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
    
    [_tableView reloadData];
    [self setChangeFrame];
    if ([self.delegate respondsToSelector:@selector(delArrayForItem:)])
    {
        [self.delegate delArrayForItem:sender.tag];
    }
}

@end


@implementation YXEditArrayCell
@synthesize nameTextField = _nameTextField,phoneTextField = _phoneTextField;
@synthesize editBtn = _editBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame 
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        self.frame = frame;
        self.cellStyle = VisaCellStyle;
        [self initView];
    }
    return self;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect)frame withType:(CellStyle)cellStle {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.backgroundColor = [UIColor clearColor];
        self.frame = frame;
        self.cellStyle = cellStle;
        [self initView];
    }
    return self;
}
- (void) initView
{
    if (self.cellStyle == VisaCellStyle)
    {
        [self addVisaView];
    }
    else if (self.cellStyle == TicketCellStyle)
    {
        [self addTicketView];
    }
}

- (void)addVisaView {
    UILabel *nameLable = [YXTools allocLabel:@"姓名" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, 10, 60, 30) textAlignment:0];
    [self addSubview:nameLable];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(nameLable)+ViewX(nameLable), ViewY(nameLable), ViewWidth(self)-(ViewWidth(nameLable)+ViewX(nameLable))-40, 30)];
    _nameTextField.placeholder = @"请输入出游人姓名";
    _nameTextField.font = systemFont(14);
    [self addSubview:_nameTextField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(_nameTextField)+ViewHeight(_nameTextField), self.frame.size.width-40, 0.5)];
    line.backgroundColor = bordColor;
    [self addSubview:line];
    
    UILabel *phoneLable = [YXTools allocLabel:@"类别" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X,ViewY(line)+ViewHeight(line)+10, 60, 30) textAlignment:0];
    [self addSubview:phoneLable];
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(phoneLable)+ViewX(phoneLable), ViewY(phoneLable), self.frame.size.width-ViewWidth(phoneLable)-ViewX(phoneLable)-40, 30)];
    _phoneTextField.placeholder = @"请选择身份类别";
    _phoneTextField.font = systemFont(14);
    [self addSubview:_phoneTextField];
    
    _chooseTypeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _chooseTypeBut.frame = _phoneTextField.bounds;
    _chooseTypeBut.userInteractionEnabled = YES;
    [_phoneTextField addSubview:_chooseTypeBut];
    
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.frame = CGRectMake(self.frame.size.width-35, (ARRAY_CeLL-25)/2, 25, 25);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
    [self addSubview:_editBtn];
    
    _line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    _line1.backgroundColor = [UIColor orangeColor];
    [self addSubview:_line1];

}

- (void)addTicketView
{
    UILabel *nameLable = [YXTools allocLabel:@"出游人" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X, 10, 60, 30) textAlignment:0];
    [self addSubview:nameLable];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(nameLable)+ViewX(nameLable), ViewY(nameLable), ViewWidth(self)-(ViewWidth(nameLable)+ViewX(nameLable))-40, 30)];
    _nameTextField.placeholder = @"申请人";
    _nameTextField.font = systemFont(14);
    [self addSubview:_nameTextField];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(_nameTextField)+ViewHeight(_nameTextField), self.frame.size.width-40, 0.5)];
    line.backgroundColor = bordColor;
    [self addSubview:line];
    
    UILabel *phoneLable = [YXTools allocLabel:@"手机号" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X,ViewY(line)+ViewHeight(line)+10, 60, 30) textAlignment:0];
    [self addSubview:phoneLable];
    
    _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(phoneLable)+ViewX(phoneLable), ViewY(phoneLable), self.frame.size.width-ViewWidth(phoneLable)-ViewX(phoneLable)-40, 30)];
    _phoneTextField.placeholder = @"手机号";
    _phoneTextField.font = systemFont(14);
    [self addSubview:_phoneTextField];
    
    
    
    UIView *lineZero = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(_phoneTextField), self.frame.size.width-40, 0.5)];
    lineZero.backgroundColor =
    bordColor;
    [self addSubview:lineZero];
    
    UILabel *emailLabel = [YXTools allocLabel:@"邮箱" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X,ViewBelow(lineZero)+10, 60, 30) textAlignment:0];
    [self addSubview:emailLabel];
    
    
    self.emailTF = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(phoneLable)+ViewX(phoneLable), ViewY(emailLabel), self.frame.size.width-ViewWidth(emailLabel)-ViewX(emailLabel)-40, 30)];
    self.emailTF.placeholder = @"邮箱号";
    self.emailTF.font = systemFont(14);
    [self addSubview:self.emailTF];
    
    
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(_emailTF), self.frame.size.width-40, 0.5)];
    lineOne.backgroundColor = bordColor;
    [self addSubview:lineOne];
    
    UILabel *voucherTypeLabel = [YXTools allocLabel:@"证件类型" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X,ViewBelow(lineOne)+10, 60, 30) textAlignment:0];
    [self addSubview:voucherTypeLabel];

    
    self.voucherTypeTF = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(phoneLable)+ViewX(phoneLable), ViewY(voucherTypeLabel), self.frame.size.width-ViewWidth(voucherTypeLabel)-ViewX(voucherTypeLabel)-40, 30)];
    self.voucherTypeTF.placeholder = @"证件类型";
    self.voucherTypeTF.font = systemFont(14);
    [self addSubview:self.voucherTypeTF];
    
        _chooseTypeBut = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseTypeBut.frame = _voucherTypeTF.bounds;
        _chooseTypeBut.userInteractionEnabled = YES;
        [_voucherTypeTF addSubview:_chooseTypeBut];
    
    
    
    UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBelow(self.voucherTypeTF), self.frame.size.width-40, 0.5)];
    lineTwo.backgroundColor = bordColor;
    [self addSubview:lineTwo];
    
    UILabel *voucherNumberLabel = [YXTools allocLabel:@"证件号" font:systemFont(14) textColor:[UIColor blackColor] frame:CGRectMake(Begin_X,ViewBelow(lineTwo)+10, 60, 30) textAlignment:0];
    [self addSubview:voucherNumberLabel];
    

    
    self.voucherNumberTF = [[UITextField alloc] initWithFrame:CGRectMake(ViewWidth(voucherNumberLabel)+ViewX(voucherNumberLabel), ViewY(voucherNumberLabel), self.frame.size.width-ViewWidth(voucherNumberLabel)-ViewX(voucherNumberLabel)-40, 30)];
    self.voucherNumberTF.placeholder = @"证件号";
    self.voucherNumberTF.font = systemFont(14);
    [self addSubview:self.voucherNumberTF];
    
    
    
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _editBtn.frame = CGRectMake(self.frame.size.width-35, (ARRAY_CeLL * 2 + 20) / 2, 25, 25);
    [_editBtn setBackgroundImage:[UIImage imageNamed:@"减少可用"] forState:UIControlStateNormal];
    [self addSubview:_editBtn];
    
    _line1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 2 + 39.5, self.frame.size.width, 0.5)];
    _line1.backgroundColor = [UIColor orangeColor];
    [self addSubview:_line1];

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    _model.nameStr=_nameTextField.text;
//    _model.phoneStr=_phoneTextField.text;
//    _model.eMailStr=_emailTF.text;
//    _model.typeStr=_voucherTypeTF.text;
//    _model.typeNO=_voucherNumberTF.text;
}

@end



@implementation applyModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end

