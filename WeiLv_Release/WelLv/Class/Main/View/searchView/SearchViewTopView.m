//
//  SearchViewTopView.m
//  weilvTest1
//
//  Created by 刘鑫 on 15/7/9.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
#define cellHeight 40


#import "SearchViewTopView.h"

@interface SearchViewTopView ()
{
    NSString *receiveType;
}
@property (nonatomic, strong) UITableViewCell * tempCell;

@end

@implementation SearchViewTopView

+ (SearchViewTopView *)sharedSearchTopView
{
    static SearchViewTopView *sharedSVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSVC = [[self alloc] init];
    });
    
    return sharedSVC;
}


-(id)initWithFrame:(CGRect)frame placeholderStr:(NSString *)placeholder searchType:(NSString*)type nameArr:(NSArray *)arr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius=5;
        self.layer.borderWidth=0.5;
        self.layer.borderColor=[[UIColor grayColor] CGColor];
        _isShow=NO;
        _typeArray=[NSMutableArray arrayWithArray:arr];
        [self initViewplaceholderStr:placeholder searchType:type];
    }
    return self;
}

-(void)initViewplaceholderStr:(NSString *)placeholder searchType:(NSString*)type
{
    if (!_searchTF) {
        receiveType=type;
        _typeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _typeBtn.frame=CGRectMake(0, 0, [self calculateContentWidth:type], self.frame.size.height);
        [_typeBtn setTitle:type forState:UIControlStateNormal];
        [_typeBtn addTarget:self action:@selector(changeTypeClick) forControlEvents:UIControlEventTouchUpInside];
        [_typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _typeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [self addSubview:_typeBtn];
        self.chooseIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_typeBtn.frame), _typeBtn.frame.size.height / 2 - 2.5, 5, 5)];
        self.chooseIcon.image = [UIImage imageNamed:@"矩形-3"];
        self.chooseIcon.transform = CGAffineTransformMakeRotation(M_PI_4);
        [_typeBtn addSubview:_chooseIcon];
        
        _line =[[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.chooseIcon.frame) + 10, 3, 0.5, self.frame.size.height-6)];
        _line.backgroundColor=[UIColor grayColor];
        [self addSubview:_line];
        
        _searchTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_line.frame) + 5, 0, self.frame.size.width - CGRectGetMaxX(_line.frame) - 5, self.frame.size.height)];
        [_searchTF setPlaceholder:placeholder];
        [_searchTF setValue:[UIFont boldSystemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
        _searchTF.returnKeyType = UIReturnKeySearch;
        _searchTF.borderStyle=UITextBorderStyleNone;
        _searchTF.delegate=self;
        [self addSubview:_searchTF];
        
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        _maskView=[[UIView alloc] initWithFrame:CGRectMake(0, 65, window.frame.size.width, window.frame.size.height)];
        _maskView.alpha=0.7;
        _maskView.backgroundColor=[UIColor blackColor];
        _maskView.hidden=YES;
        _maskView.userInteractionEnabled=YES;
        [window addSubview:_maskView];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteMask)];
        [_maskView addGestureRecognizer:tap];
        
        _typeTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, _maskView.frame.origin.y,  window.frame.size.width, _typeArray.count*cellHeight)];
        _typeTabView.delegate=self;
        _typeTabView.dataSource=self;
        _typeTabView.tableFooterView=[[UIView alloc] init];
        _typeTabView.hidden=YES;
        [window addSubview:_typeTabView];
        
    }
    
}

-(void)changeTypeClick
{
    if (_isShow==NO) {
        _isShow=YES;
        _maskView.hidden=NO;
        _typeTabView.hidden=NO;
        self.chooseIcon.transform = CGAffineTransformMakeRotation(-(M_PI * 3 / 4));
        
    }else{
        _isShow=NO;
        _maskView.hidden=YES;
        _typeTabView.hidden=YES;
        self.chooseIcon.transform = CGAffineTransformMakeRotation(M_PI_4);
        
    }
}

-(void)deleteMask
{
    _isShow=NO;
    _maskView.hidden=YES;
    _typeTabView.hidden=YES;
    self.chooseIcon.image = [UIImage imageNamed:@"矩形-3"];
    self.chooseIcon.transform = CGAffineTransformMakeRotation(M_PI_4);
}

- (CGFloat)calculateContentWidth:(NSString *)type {
    
    return type.length * 15 + 20;
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _typeArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier1 = @"cellIdentifier1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text=[_typeArray objectAtIndex:indexPath.row];
    NSInteger index=[_typeArray indexOfObject:receiveType];
    
    if (indexPath.row == index) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.tintColor = TimeGreenColor;
        self.tempCell = cell;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.tempCell isEqual:cell]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.tintColor = TimeGreenColor;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.tintColor = TimeGreenColor;
        if (self.tempCell) {
            self.tempCell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    self.tempCell = cell;
    
    [self.chooseIcon removeFromSuperview];
    
    _typeBtn.frame =CGRectMake(0, 0, [self calculateContentWidth:[_typeArray objectAtIndex:indexPath.row]], self.frame.size.height);
    [_typeBtn setTitle:[_typeArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    self.chooseIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_typeBtn.frame), _typeBtn.frame.size.height / 2 - 2.5, 5, 5)];
    self.chooseIcon.image = [UIImage imageNamed:@"矩形-3"];
    self.chooseIcon.transform = CGAffineTransformMakeRotation(M_PI_4);
    [_typeBtn addSubview:_chooseIcon];
    _line.frame = CGRectMake(CGRectGetMaxX(self.chooseIcon.frame) + 10, 3, 0.5, self.frame.size.height-6);
    _searchTF.frame = CGRectMake(CGRectGetMaxX(_line.frame) + 5, 0, self.frame.size.width - CGRectGetMaxX(_line.frame) - 5, self.frame.size.height);
    
    [self deleteMask];
    
    if (self.typeBlock) {
        self.typeBlock(indexPath.row+1);
    }
}

#pragma mark -
#pragma mark 点击键盘上的搜索按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (self.keywordsBlock) {
        self.keywordsBlock(textField.text);
    }
    
    textField.text = @"";
    
    return YES;
}


@end
