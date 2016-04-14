
//
//  ManageMemberInfoViewController.m
//  WelLv
//
//  Created by mac for csh on 15/5/6.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//
/*#define myUrl(code) [NSString stringWithFormat:@"https://www.weilv100.com/api/assistant/member_info/%@",code]
#define GjManagMemberURL @"https://www.weilv100.com/api/assistant/member_info"
#define membertagUrl @"https://www.weilv100.com/api/assistant/member_tag"*/

#import "ManageMemberInfoViewController.h"
#import "MyMembersModel.h"
#import "LXCommonTools.h"
#import <QuartzCore/QuartzCore.h>
#import "ManageMemberTableViewCell.h"
#import "LXCommonTools.h"
#import "TextFdViewController.h"
#import "MaritalStatusViewController.h"
#import "EducationalBGViewController.h"


#define Label_x1 0
#define Label_x2 130
#define LabelHeight 45
#define LabelWidth1 150


@interface ManageMemberInfoViewController ()
//<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *_scrollView;
    CGFloat locationY;
    
    UITextView *_textView;
    UITextField *_textField;
    NSMutableArray *_textFArray;
    UILabel *uilabel;
     
    NSMutableArray *_memberSortArray;//不可编辑部分左侧栏
    NSMutableArray *_memberInfoArray;//不可编辑部分右侧栏
    NSArray *_marital_statusArray;//婚姻状况
    NSArray *_educational_backgroundArray;//教育程度
    NSArray *_travel_modeArray;//出游偏好
    NSArray *_destination_typeArray;//目的地偏好
    NSMutableArray *_tagInfoArray;       //可编译部分右侧栏
    NSArray *_secondLeftArr;            //可编辑部分左侧栏
    NSArray *_keyArray;//传键给下个输入页面
    
    CGFloat _addressHeight;
    
    NSString *_address;
    
    NSString *_occupation;//职业
    NSString *_position;//职位
    NSString *_income;//收入
    NSString *_marital_status;//婚姻状况
    NSString *_educational_background;//教育程度
    NSString *_hobby;//兴趣爱好
    NSString *_character;//性格
    NSString *_travel_mode;//出游偏好
    NSString *_destination_type;//目的地偏好
    NSString *_remark;//备注
    
   // UILabel *_selectLab;
    UIButton *_selectBtn;
    
    BOOL _isShow;
    
    UITableView *_tableView;
    NSInteger _selectLabTag;
    
    //-------------------------
    NSMutableArray *travelArray;//存出游偏好选中项
    NSMutableArray *destinationArray;//存目的地选中项
    NSMutableArray *travelArr;//h
    NSMutableArray *destinationArr;
    NSMutableArray *buttonImageVArray;
    UIView *vc; //半透明view
    UIView * vv;
    UIButton *traveButton;
    UIButton *destinationButton;
    NSArray *tagArray;
}
@end

@implementation ManageMemberInfoViewController

-(void) viewWillAppear:(BOOL)animated{
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  //  self.title = self.memberModel.username;
    if (self.memberModel.realname == nil) {
        self.title=self.memberModel.username;
    } else {
        self.title=self.memberModel.realname;
        
    }

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(conserve)];
     self.navigationItem.rightBarButtonItem.tintColor = kColor(255, 165, 98);

 //   [self initData];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    _scrollView.backgroundColor = BgViewColor;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];

    
//touch miss kyboard
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];

}

#pragma mark --- getData
-(void)initData{
    NSString *sex;
    sex=@"保密";
    if (self.memberModel.sex == nil || [self.memberModel.sex isEqual:[NSNull null]] || self.memberModel.sex.length==0) {
        //sex=@"未填写";
    }else if([self.memberModel.sex intValue]==2)
    {
        sex=@"女";
    }else if ([self.memberModel.sex intValue]==1)
    {
        sex=@"男";
    }/*else if ([self.memberModel.sex intValue]==3)
    {
        sex=@"保密";
    }*/
    //证件类型
    NSString *idType;
    NSString *idNumber;
    if (self.memberModel.idtype == nil || [self.memberModel.idtype isEqual:[NSNull null]] || self.memberModel.idtype.length==0) {
        idType=@"未填写";
        idNumber=@"未填写";
    }else
    {
        if(self.memberModel.idnumber==nil)
        {
          idNumber=@"未填写";
        }
        else
        {
          idNumber=self.memberModel.idnumber;
        }
        switch ([self.memberModel.idtype intValue])
        {
                
            case 0:
            {
                idType=@"暂无证件";
                idNumber=@"未填写";
            }

                break;
                
            case 1:
            {
                idType=@"身份证";
            }
                break;
                
            case 2:
            {
                idType=@"护照";
            }
                break;
                
            case 3:
            {
                idType=@"军官证";
            }
                break;
                
            case 4:
            {
                idType=@"港澳通行证";
            }
                break;
                
            case 5:
            {
                idType=@"台胞证";
            }
                break;
                
            default:
                break;
        }
    }
    
    //邮箱
    NSString *email;
    if (self.memberModel.email == nil || [self.memberModel.email isEqual:[NSNull null]] ||self.memberModel.email.length==0)
    {
        email=@"未填写";
    }else
    {
        email=self.memberModel.email;
    }
    
    //家庭住址
    //_address;
    if (self.memberModel.address == nil || [self.memberModel.address isEqual:[NSNull null]] || self.memberModel.address.length==0)
    {
        _address=@"未填写";
    }else
    {
        _address=self.memberModel.address;
    }
    
    //SirsrSectiom 初始化属性
    _memberSortArray=[[NSMutableArray alloc] initWithObjects:@"姓名", @"性别",@"证件",@"手机",@"邮箱",@"家庭住址", nil];
    NSString *ID = [[NSString stringWithFormat:@"%@",idType] stringByAppendingString:[NSString stringWithFormat:@"\n%@",idNumber]];
    NSString *strrr =@"";
    if (self.memberModel.realname==nil || [self judgeString:self.memberModel.realname] == NO) {
        strrr = [self judgeReturnString:self.memberModel.username withReplaceString:@"未知"];
    }else {
        strrr = self.memberModel.realname;
    }
    _memberInfoArray=[[NSMutableArray alloc] initWithObjects:strrr,sex,ID,self.memberModel.phone,email,_address, nil];
    
    //SecondSectiom 初始化属性
    _secondLeftArr = [[NSArray alloc] initWithObjects:@"职业", @"职位", @"收入", @"婚姻状况", @"教育程度", @"兴趣爱好", @"性格", @"出游偏好", @"目的地偏好", @"备注", nil];
    _marital_statusArray=@[@"未婚",@"已婚",@"离异",@"丧偶"];
    _educational_backgroundArray=@[@"初中",@"高中",@"大专",@"本科",@"研究生"];
    _travel_modeArray=@[@"自驾游",@"自由行",@"跟团游"];
    _destination_typeArray=@[@"海岛",@"山水",@"古迹",@"周边",@"国内",@"出境"];
    _tagInfoArray=[[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"请选择",@"请选择",@"",@"",@"请选择",@"请选择",@"", nil];
    _keyArray = [[NSArray alloc] initWithObjects:@"occupation",@"position",@"income",@"marital_status",@"educational_background",@"hobby",@"character",@"travel_mode",@"destination_type", nil];
  
    //fuzhi
     _occupation=[_tagInfoArray objectAtIndex:0];
     _position=[_tagInfoArray objectAtIndex:1];
     _income=[_tagInfoArray objectAtIndex:2];
     _marital_status=[_tagInfoArray objectAtIndex:3];
     _educational_background=[_tagInfoArray objectAtIndex:4];
     _hobby=[_tagInfoArray objectAtIndex:5];
     _character=[_tagInfoArray objectAtIndex:6];
     _travel_mode=[_tagInfoArray objectAtIndex:7];
     _destination_type=[_tagInfoArray objectAtIndex:8];
     _remark=[_tagInfoArray objectAtIndex:9];
    
    //请求信息   获取会员信息
    NSString *str = self.memberModel.uid;
    NSString *url =[myUrl(str) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation,id responseObject){
        
        NSString *html = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"responseString%@,",dict);
        NSDictionary *infoDic = [dict objectForKey:@"data"];
        
        if (![(id)[dict objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
          //  [[LXAlterView sharedMyTools]createTishi:@"查询失败，暂无信息"];
        }else{
            
            if ([[dict objectForKey:@"status"]integerValue] == 1  ) {
                
                NSString *str1 = @"请选择";
                NSString *str2 = @"请选择";
                if ([(id)[infoDic objectForKey:@"destination_type"] isKindOfClass:[NSArray class]]&&[infoDic objectForKey:@"destination_type"]  != NO) {
                    NSArray *arr1 = [infoDic objectForKey:@"destination_type"];destinationArr = [NSMutableArray arrayWithArray:[infoDic objectForKey:@"destination_type"]];
                    NSLog(@"str1 = %@",arr1);
                    if (arr1.count > 0) {
                        str1 = @"";
                        for (int i = 0; i < arr1.count; i ++) {
                            str1 = [str1 stringByAppendingString:[NSString stringWithFormat:@"  %@",[arr1 objectAtIndex:i]]];
                        }
                        
                    }
                }
                
                
                if ([(id)[infoDic objectForKey:@"travel_mode"]isKindOfClass:[NSArray class]]&&[infoDic objectForKey:@"travel_mode"]  != NO) {
                    travelArr = [NSMutableArray arrayWithArray:[infoDic objectForKey:@"travel_mode"]];
                    NSArray *arr2 = [infoDic objectForKey:@"travel_mode"];
                    if (arr2.count > 0) {
                        str2 = @"";
                        for (int i = 0; i < arr2.count; i ++) {
                            str2 = [str2 stringByAppendingString:[NSString stringWithFormat:@"  %@",[arr2 objectAtIndex:i]]];
                        }
                    }
                    
                }
                NSLog(@"str2 = %@",str2);
                
                
                if (![[infoDic objectForKey:@"occupation"] isKindOfClass:[NSNull class]]) {
                    _occupation = [infoDic objectForKey:@"occupation"];
                }else{
                    _occupation = @"";
                }
                
                if(![[infoDic objectForKey:@"position"] isKindOfClass:[NSNull class]]) {
                    _position = [infoDic objectForKey:@"position"];
                }else{
                    _position = @"";
                }
                
                if(![[infoDic objectForKey:@"income"] isKindOfClass:[NSNull class]]) {
                    _income = [infoDic objectForKey:@"income"];
                }else{
                    _income = @"";
                }
                
                if(![[infoDic objectForKey:@"marital_status"] isKindOfClass:[NSNull class]]) {
                    _marital_status = [infoDic objectForKey:@"marital_status"];
                }else{
                    _marital_status = @"";
                }
                
                if(![[infoDic objectForKey:@"educational_background"] isKindOfClass:[NSNull class]]) {
                    _educational_background = [infoDic objectForKey:@"educational_background"];
                }else{
                    _educational_background = @"";
                }
                
                if(![[infoDic objectForKey:@"hobby"] isKindOfClass:[NSNull class]]) {
                    _hobby = [infoDic objectForKey:@"hobby"];
                }else{
                    _hobby = @"";
                }
                
                if(![[infoDic objectForKey:@"character"] isKindOfClass:[NSNull class]]) {
                    _character = [infoDic objectForKey:@"character"];
                }else{
                    _character = @"";
                }
                _travel_mode = str2;
                _destination_type = str1;
                
                _tagInfoArray = [[NSMutableArray alloc] initWithObjects:_occupation,_position,_income,_marital_status,_educational_background,_hobby,_character,_travel_mode,_destination_type,_remark,@"remark", nil];
                
                //NSLog(@"_tagInfoArray%@",_tagInfoArray);
               // [self viewWillAppear:YES];
               
            }

        }
        for(UIView *view in [_scrollView subviews])
        {
            [view removeFromSuperview];
        }
        
        [self initFirstSection];
        [self initSecondSection];
      
        }failure:^(AFHTTPRequestOperation *operation,NSError *error){
        NSLog(@"error = %@",error);
    }];

 
    
    //获取tag备注信息

    NSString *stringg = self.memberModel.uid;
    NSString *urll = [memberTagUrl(stringg) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url = %@",urll);
    AFHTTPRequestOperationManager *managerr = [AFHTTPRequestOperationManager manager];
    managerr.responseSerializer = [AFHTTPResponseSerializer serializer];
   [managerr GET:urll parameters:nil success:^(AFHTTPRequestOperation *operationn,id responseObject){
    
    NSString *htmll = operationn.responseString;
    NSData* dataa=[htmll dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * dictionary=[NSJSONSerialization  JSONObjectWithData:dataa options:0 error:nil];
       if ([[dictionary objectForKey:@"status"] integerValue] == 1 && [dictionary objectForKey:@"data"] && [[dictionary objectForKey:@"data"] isKindOfClass:[NSArray class]] && [[dictionary objectForKey:@"data"] count] != 0) {
           tagArray = [NSArray arrayWithArray:[dictionary objectForKey:@"data"]];
           NSLog(@"获取备注数据traveButtontag data is %@   tagArray is %@",dictionary,tagArray);
           for(UIView *view in [_scrollView subviews])
           {
               [view removeFromSuperview];
           }
           
           [self initFirstSection];
           [self initSecondSection];
       }
      
       
   }failure:^(AFHTTPRequestOperation *operation,NSError *error){
    NSLog(@"error = %@",error);
}];



}

-(void)initFirstSection{
    locationY = 0.0;
    locationY = locationY+ 15;
    CGFloat hh = 27;
    for (int i = 0; i < _memberSortArray.count; i ++) {
        if (i <2) {
            hh = 0;
        }else{
            hh = 27;
        }
        UILabel *label = [[UILabel alloc] init];
        [label setBackgroundColor:[UIColor whiteColor]];
        label.text = [NSString stringWithFormat:@"\t%@",[_memberSortArray objectAtIndex:i]];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor =[UIColor grayColor];
        [_scrollView addSubview:label];
        
        CGFloat width=ViewWidth(_scrollView)-Label_x2-20;
        UILabel *label1 = [[UILabel alloc] init];
        [label1 setBackgroundColor:[UIColor whiteColor]];
        label1.text = [NSString stringWithFormat:@"%@",[_memberInfoArray objectAtIndex:i]];
        label1.textAlignment = NSTextAlignmentRight;
        label1.font = [UIFont systemFontOfSize:16];
        label1.textColor =[UIColor blackColor];
        label1.numberOfLines=0;
        [_scrollView addSubview:label1];
    
        
        if (i==_memberSortArray.count-1){
            _addressHeight=[[LXCommonTools sharedMyTools] textHeight:_address Afont:16 width:width]+0;
            if(_addressHeight < LabelHeight){
                _addressHeight = LabelHeight;
            }
            label.frame=CGRectMake(0, locationY, ViewWidth(_scrollView), _addressHeight);
            label1.frame=CGRectMake(Label_x2, locationY, width, _addressHeight);
            locationY = locationY + _addressHeight;
        }else if (i == 2){
             label.frame=CGRectMake(0, locationY, ViewWidth(_scrollView), LabelHeight+hh);
             label1.frame=CGRectMake(Label_x2, locationY, width, LabelHeight + hh);
            locationY = locationY +hh +LabelHeight;
            UIView *viewv = [[UIView alloc] initWithFrame:CGRectMake(0, locationY-1, ViewWidth(label), 1)];
            viewv.backgroundColor = kColor(227, 233, 238);
            [_scrollView addSubview:viewv];
        }else{
            label.frame = CGRectMake(0, locationY,  ViewWidth(_scrollView), LabelHeight);
            label1.frame=CGRectMake(Label_x2, 15+LabelHeight*i +hh, width, LabelHeight);
            locationY = locationY + LabelHeight;
             UIView *viewv = [[UIView alloc] initWithFrame:CGRectMake(0, locationY - 1, ViewWidth(label), 1)];
             viewv.backgroundColor = kColor(227, 233, 238);
             [_scrollView addSubview:viewv];
        }

    }
    
}

-(void)initSecondSection{
    
    locationY = locationY +15;
       for (int i = 0; i < _secondLeftArr.count; i ++) {
           UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,  locationY, ViewWidth(_scrollView), LabelHeight)];
           [label setBackgroundColor:[UIColor whiteColor]];
           label.text = [NSString stringWithFormat:@"\t%@",[_secondLeftArr objectAtIndex:i]];
           label.textAlignment = NSTextAlignmentLeft;
           label.font = [UIFont systemFontOfSize:16];
           label.textColor =[UIColor grayColor];
           [_scrollView addSubview:label];
           
           CGFloat width=ViewWidth(_scrollView)-Label_x2-35;
           UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(Label_x2,  locationY, width, LabelHeight)];
           label1.text = [_tagInfoArray objectAtIndex:i];
           label1.textAlignment = NSTextAlignmentRight;
           label1.textColor = [UIColor blackColor];
           label1.font = [UIFont systemFontOfSize:16];
           label1.tag = i + 1;
           [_scrollView addSubview:label1];
           
           UIImageView *igv = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_scrollView) - 40,locationY + (LabelHeight-40)/2 + 6.65,40,26.7)];
           [igv setImage:[UIImage imageNamed:@"圆角矩形-65-拷贝-副本-3"]];
           [_scrollView addSubview:igv];
           
           UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0,locationY, ViewWidth(_scrollView), 1)];
           lab.backgroundColor = kColor(227, 233, 238);
           [_scrollView addSubview:lab];
        
           _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
           _selectBtn.frame=label.frame;
           _selectBtn.tag=i+1;
           if ( i == 3 || i ==4) {
               [_selectBtn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
           }else if(i == 9){
              // NSLog(@"beizhu");
           }else if( i == 7|| i == 8){
               [_selectBtn addTarget:self action:@selector(loadChoiceView:) forControlEvents:UIControlEventTouchUpInside];
           }else{
               [_selectBtn addTarget:self action:@selector(jumpSubView:) forControlEvents:UIControlEventTouchUpInside];
           }
           
           [_scrollView addSubview:_selectBtn];
           
           
           locationY = locationY + LabelHeight;
    }

    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, locationY+15, ViewWidth(_scrollView), 100)];
    vi.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:vi];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(30,ViewY(vi), ViewWidth(_scrollView)-30*2, 100)];
    _textView.font = [UIFont systemFontOfSize:14];
    //_textView.backgroundColor = kColor(227, 233, 238);
    _textView.textColor = [UIColor blackColor];
    _textView.textAlignment = NSTextAlignmentLeft;
    _textView.hidden = NO;
    _textView.delegate = self;
    [_scrollView addSubview:_textView];
    
    uilabel = [[UILabel alloc] initWithFrame:CGRectMake(30, ViewY(vi), ViewWidth(_scrollView)-30*2, 35)];
    uilabel.text = @"请输入备注内容...";
    uilabel.enabled = NO;//lable必须设置为不可用
    uilabel.backgroundColor = [UIColor clearColor];
    uilabel.font = [UIFont systemFontOfSize:14];
    [_scrollView addSubview:uilabel];

    locationY = locationY +100+15;
    

    
    //beizhu备注显示与输入
    locationY = locationY + 15;
    if(tagArray && tagArray.count != 0){
        for (int i = 0; i <tagArray.count; i++) {
            UIView * lab = [[UIView alloc]init];
            lab.backgroundColor = [UIColor whiteColor];
            [_scrollView addSubview:lab];
            
            UIImageView *igV = [[UIImageView alloc] initWithFrame:CGRectMake(30, 45/2-4, 8, 8)];
            igV.image =[UIImage imageNamed:@"椭圆-6-副本"];
            [lab addSubview:igV];
            
            UILabel *tagLabel = [[UILabel alloc] init];
            tagLabel.backgroundColor = [UIColor clearColor];
            tagLabel.text = [[tagArray objectAtIndex:tagArray.count-i-1] objectForKey:@"tag"];
            tagLabel.font = [UIFont systemFontOfSize:14];
            tagLabel.textColor = [UIColor grayColor];
            tagLabel.numberOfLines = 0;
            float x = [[LXCommonTools sharedMyTools] textHeight:[[tagArray objectAtIndex:tagArray.count-i-1] objectForKey:@"tag"] Afont:14 width:ViewWidth(_scrollView) -20*2-16];
            [tagLabel setFrame:CGRectMake(30+16, 10, ViewWidth(_scrollView) -30*2-16, x)];
            [lab addSubview:tagLabel];

           // locationY = locationY +45;
            if ((x+10)>45) {
                [lab setFrame:CGRectMake(0, locationY , ViewWidth(_scrollView), x+10)];
                locationY = locationY + x +10;
            }else {
                [lab setFrame:CGRectMake(0, locationY , ViewWidth(_scrollView), 45)];
                locationY = locationY +45;
            }
            UIView *viewv = [[UIView alloc] initWithFrame:CGRectMake(0, locationY - 1, ViewWidth(_scrollView), 1)];
            viewv.backgroundColor = kColor(227, 233, 238);
            [_scrollView addSubview:viewv];
        }
    }
   
   
    //_scrollView的偏移量设置
   // _scrollView.contentSize= CGSizeMake(windowContentWidth, ViewY(_textView)+ViewHeight(_textView)+300);
    _scrollView.contentSize = CGSizeMake(ViewWidth(_scrollView), locationY + 300);

}

#pragma mark --- 输入框
-(void)jumpSubView:(UIButton *)btn{
    TextFdViewController *teV = [[TextFdViewController alloc] init];
    teV.title = [_secondLeftArr objectAtIndex:btn.tag-1];//[NSString stringWithFormat:@"修改%@",[_secondLeftArr objectAtIndex:btn.tag-1]];
    teV.contentString = [_tagInfoArray objectAtIndex:btn.tag -1];
    teV.key = [_keyArray objectAtIndex:btn.tag - 1];
    teV.uid = self.memberModel.uid;
    [self.navigationController pushViewController:teV animated:YES];
}

/*
-(void)initTF:(CGRect)textFrame tag:(NSInteger)tag placeholder:(NSString *)placehoder
{
    _textField=[[UITextField alloc] init];
    _textField.frame=textFrame;
    _textField.delegate=self;
    _textField.text=placehoder;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.font = [UIFont systemFontOfSize:15];
    _textField.borderStyle=UITextBorderStyleNone;
    _textField.tag=tag;
    [_scrollView addSubview:_textField];
    [_textFArray addObject:_textField];
    
}*/

#pragma mark ---

-(void)selectClick:(UIButton *)btn
{
    _selectLabTag=btn.tag;
    switch (btn.tag) {
        case 4:
        {
            //婚姻状况
            //_selectTableArray=[NSMutableArray arrayWithArray:_marital_statusArray];
            MaritalStatusViewController *marryStatus = [[MaritalStatusViewController alloc] init];
            marryStatus.title = @"修改婚姻状况";
            marryStatus.uid = self.memberModel.uid;
            marryStatus.keywords = [_tagInfoArray objectAtIndex:3];
            marryStatus.key = [_keyArray objectAtIndex:btn.tag - 1];
            marryStatus.maritalArray = [NSMutableArray arrayWithArray:_marital_statusArray];
            [self.navigationController pushViewController:marryStatus animated:YES];
        }
            break;
            
        case 5:
        {
            //教育程度
            //_selectTableArray=[NSMutableArray arrayWithArray:_educational_backgroundArray];
            EducationalBGViewController *eduBG = [[EducationalBGViewController alloc] init];
            eduBG.title = @"修改教育程度";
            eduBG.uid = self.memberModel.uid;
            eduBG.keywords = [_tagInfoArray objectAtIndex:4];
            eduBG.key = [_keyArray objectAtIndex:btn.tag - 1];
            eduBG.educationalArray = [NSMutableArray arrayWithArray:_educational_backgroundArray];
            [self.navigationController pushViewController:eduBG animated:YES];
        }
            break;
            
        default:
            break;
    }
    
 /*
    if (_isShow==YES)
    {
        _isShow=NO;
        _tableView.hidden=YES;
    }else
    {
        _isShow=YES;
        _tableView.hidden=NO;
    }
    
    if (!_tableView)
    {
        _tableView=[[UITableView alloc] init];
        _tableView.tag=btn.tag;
        _tableView.rowHeight=40;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_scrollView addSubview:_tableView];
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
            
        }
        
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
            
        }
        
        _isShow=YES;
    }
    
    _tableView.frame=CGRectMake(ViewX(btn), ViewY(btn)+ViewHeight(btn), ViewWidth(btn), _selectTableArray.count*40);
    
    
    [_tableView reloadData];*/
}
/*
#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selectTableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier0 = @"cellIdentifier0";
    ManageMemberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier0];
    if (cell == nil)
    {
        cell = [[ManageMemberTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier0];
        //单元格的选择风格，选择时单元格不出现蓝条
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
      
    }
    cell.nameLabel.text=[_selectTableArray objectAtIndex:indexPath.row];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UILabel *labe=(UILabel *)[_scrollView viewWithTag:_selectLabTag];
    labe.text=[_selectTableArray objectAtIndex:indexPath.row];
    _tableView.hidden=YES;
    _isShow=NO;
    switch (_selectLabTag)
    {
        case 4:
        {
            //婚姻状况
            _marital_status=labe.text;
           //NSLog(@"%ld",indexPath.row);
        }
            break;
            
        case 5:
        {
            //教育程度
            _educational_background=labe.text;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 分割线左边对齐
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}*/


#pragma mark --- 背景半透明选择
-(void)loadChoiceView:(UIButton *)btn{
    if (btn.tag == 8) {
        [self loadTheView:_travel_modeArray Tagg:btn.tag];
    }else if(btn.tag == 9) {
        [self loadTheView:_destination_typeArray Tagg:btn.tag];
    }
    
}

-(void)loadTheView:(NSArray *)titleArray Tagg:(NSInteger)tagg{
    vc = [[UIView alloc] initWithFrame:self.view.frame];
    [vc setFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight)];
    vc.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    [self.view addSubview:vc];
    
    vv = [[UIView alloc] initWithFrame:CGRectMake(20, windowContentHeight/3, windowContentWidth-40, 115)];
    vv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vv];
    //touch miss
    UITapGestureRecognizer *tapGeRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viwHide:)];
    tapGeRecognizer.cancelsTouchesInView = NO;
    [vc addGestureRecognizer:tapGeRecognizer];
    
    // NSInteger xx = tagg;
    NSString *str= [NSString stringWithFormat:@"%ld",tagg];
    if (tagg == 8) {
        travelArray = [[NSMutableArray alloc] init];
    }else if(tagg == 9){
        destinationArray = [[NSMutableArray alloc] init];
    }
    
    if (buttonImageVArray) {
        [buttonImageVArray removeAllObjects];
    }
    buttonImageVArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < titleArray.count; i ++ ) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i >= 0 && i < 3) {
            btn.frame =  CGRectMake(20 + ((ViewWidth(vv)-60)/3+10)*i, 10, (ViewWidth(vv)-60)/3, 35);
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            btn.titleLabel.font = systemFont(14);
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            btn.layer.borderWidth = 0.5;
            btn.tag = i;
            btn.restorationIdentifier = str;
            [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
            [vv addSubview:btn];
            
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(btn)-12, ViewHeight(btn)-12, 12, 12)];
            imageV.image = [UIImage imageNamed:@"个人选中"];
            imageV.hidden = YES;
            [buttonImageVArray addObject:imageV];
            [btn addSubview:imageV];
            
        }else if(i>=3 && i<6){
            btn.frame = CGRectMake(20 + ((ViewWidth(vv)-60)/3+10)*(i-3), 10+35+10, (ViewWidth(vv)-60)/3, 35);
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:[titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            btn.titleLabel.font = systemFont(14);
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            btn.layer.borderWidth = 0.5;
            btn.tag = i;
            btn.restorationIdentifier = str;
            [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn.layer setCornerRadius:2.0]; //设置矩形四个圆角半径
            [vv addSubview:btn];
            
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(btn)-12, ViewHeight(btn)-12, 12, 12)];
            imageV.image = [UIImage imageNamed:@"个人选中"];
            imageV.hidden = YES;
            [buttonImageVArray addObject:imageV];
            [btn addSubview:imageV];
            //设置vv的高度
            [vv setFrame:CGRectMake(20, windowContentHeight/3, windowContentWidth-40, 115 + 35 +10)];
        }
        //            if (i == 0) {
        //                [self selectBtnClick:btn];
        //            }
        if (tagg == 8) {
            if (travelArr && [travelArr isKindOfClass:[NSArray class]] && travelArr.count>0) {
                for (int j = 0; j < travelArr.count; j++) {
                    if ([[titleArray objectAtIndex:i] isEqualToString:[travelArr objectAtIndex:j]]) {
                        [self selectBtnClick:btn];
                    }
                }
            }
        }else if (tagg == 9) {
            if (destinationArr && [destinationArr isKindOfClass:[NSArray class]] && destinationArr.count>0) {
                for (int j = 0; j < destinationArr.count; j++) {
                    if ([[titleArray objectAtIndex:i] isEqualToString:[destinationArr objectAtIndex:j]]) {
                        [self selectBtnClick:btn];
                    }
                }
            }
        }
    }
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(40, ViewHeight(vv) - 45, ViewWidth(vv) - 40*2, 35)];
    [submitButton setBackgroundColor:[UIColor orangeColor]];
    [submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitButton.tag = tagg;
    [submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [vv addSubview:submitButton];
}

-(void)selectBtnClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    UIImageView*imageV = [buttonImageVArray objectAtIndex:btn.tag];
    // NSInteger *indx = [btn.restorationIdentifier integerValue];
    if ([btn.restorationIdentifier isEqualToString:@"8"]) {
        if ( btn.layer.borderColor == [UIColor lightGrayColor].CGColor) {
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor orangeColor].CGColor;
            [travelArray addObject:btn.titleLabel.text];
            imageV.hidden = NO;
            // NSLog(@"travelArray%@",travelArray);
        }else{
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            NSInteger x = [travelArray indexOfObject:btn.titleLabel.text];
            [travelArray removeObjectAtIndex:x];
            imageV.hidden = YES;
            // NSLog(@"travelArray%@",travelArray);
        }
        
    }else if([btn.restorationIdentifier isEqualToString:@"9"]) {
        if ( btn.layer.borderColor == [UIColor lightGrayColor].CGColor) {
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor orangeColor].CGColor;
            [destinationArray addObject:btn.titleLabel.text];
            imageV.hidden = NO;
            //  NSLog(@"destinationArray%@",destinationArray);
        }else{
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            NSInteger x = [destinationArray indexOfObject:btn.titleLabel.text];
            [destinationArray removeObjectAtIndex:x];
            imageV.hidden = YES;
            //  NSLog(@"destinationArray%@",destinationArray);
        }
        
    }
}

-(void)submit:(UIButton *)button{
    if (button.tag == 8) {
        if (travelArray.count != 0) {
            NSString *string = @"";//[travelArray objectAtIndex:0];
            for (int i = 0; i < travelArray.count; i ++) {
                string = [string stringByAppendingString:[NSString stringWithFormat:@"  %@",[travelArray objectAtIndex:i]]];
            }
            NSLog(@"string is %@",string);
            _travel_mode = string;
            UILabel *labe=(UILabel *)[_scrollView viewWithTag:8];
            labe.text=string;
            [vc removeFromSuperview];
            [vv removeFromSuperview];
        }else{
            [[LXAlterView sharedMyTools]createTishi:@"请选择内容"];
        }
        
    }else if (button.tag == 9){
        if (destinationArray.count != 0) {
            NSString *string = @"";//[travelArray objectAtIndex:0];
            for (int i = 0; i < destinationArray.count; i ++) {
                string = [string stringByAppendingString:[NSString stringWithFormat:@"  %@",[destinationArray objectAtIndex:i]]];
            }
            NSLog(@"string is %@",string);
            _destination_type = string;
            UILabel *labe=(UILabel *)[_scrollView viewWithTag:9];
            labe.text=string;
            [vc removeFromSuperview];
            [vv removeFromSuperview];
        }else{
            [[LXAlterView sharedMyTools]createTishi:@"请选择内容"];
        }
        
    }
}



#pragma mark --- 保存按钮
-(void)conserve{
    [self.view endEditing:YES];

    if ([_travel_mode isEqualToString:@"请选择"]) {
        [[LXAlterView sharedMyTools]createTishi:@"请选择出游偏好"];
    }else if([_destination_type isEqualToString:@"请选择"]){
        [[LXAlterView sharedMyTools]createTishi:@"请选择目的地偏好"];
    }else{
        
        
        
        if(!travelArray || ![travelArray isKindOfClass:[NSMutableArray class]] || travelArray.count == 0){
        travelArray = [NSMutableArray arrayWithArray:travelArr];
        }
        
        if(!destinationArray || ![destinationArray isKindOfClass:[NSMutableArray class]] || destinationArray.count == 0){
            destinationArray = [NSMutableArray arrayWithArray:destinationArr];
        }
    
        
        
        
      AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSDictionary *infoarr = @{@"occupation":_occupation,@"position":_position,@"income":_income,@"marital_status":_marital_status,@"hobby":_hobby,@"educational_background":_educational_background,@"character":_character,@"travel_mode":travelArray,@"destination_type":destinationArray};
    NSDictionary *parameters = @{@"member_id":self.memberModel.uid,@"data":[self dictionaryToJson:infoarr]};
    [manager POST:GjManagMemberURL parameters:parameters
          success:^(AFHTTPRequestOperation *operation,id responseObject) {
              NSString *html = operation.responseString;
              NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
              NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
              [[LXAlterView sharedMyTools] createTishi:[dict objectForKey:@"msg"]];
              NSLog(@"dict = %@  \n msg = %@",dict,[dict objectForKey:@"msg"]);
              [self.navigationController popViewControllerAnimated:YES];
          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
              
              NSLog(@"Error: %@", error);
              
          }];
    }
    
    if (!_textView||[_textView.text isEqualToString:@""]) {
       // [[LXAlterView sharedMyTools]createTishi:@"您还没输入备注"];
    }else{
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSDictionary *parameters = @{@"member_id":self.memberModel.uid,@"assistant_id":[[LXUserTool alloc] getUid],@"tag":_textView.text};
        // NSDictionary *parameters = @{@"member_id":@"461"};
        [manager POST:membertagUrl parameters:parameters
              success:^(AFHTTPRequestOperation *operation,id responseObject) {
                  NSString *html = operation.responseString;
                  NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
                  NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
                  
                  NSLog(@"tagbackdictdata = %@ ",[dict objectForKey:@"data"]);
                  
              }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
                  
                  NSLog(@"Error: %@", error);
                  
              }];
    }
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

#pragma mark --textViewDelegate
//textViewDelegate
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView == _textView && textView.text.length == 0) {
        uilabel.text = @"请输入备注内容...";
       }else{
        uilabel.text = @"";
       }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    DLog(@"textView==%@",textView.text);
    _remark=textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    return YES;
}
/*
#pragma mark --- UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 1:
        {
            //职业
            _occupation=textField.text;
        }
            break;
            
        case 2:
        {
            //职位
            _position=textField.text;
        }
            break;
            
        case 3:
        {
            //收入
            _income=textField.text;
        }
            break;
            
        case 6:
        {
            //兴趣爱好
            _hobby=textField.text;
        }
            break;
            
        case 7:
        {
            //性格
            _character=textField.text;
        }
            break;
            
            
        default:
            break;
    }
    
    
}
*/


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_textView resignFirstResponder];
    [_textField resignFirstResponder];
}

-(void)viwHide:(UITapGestureRecognizer*)tap{
    if(vc.hidden == NO){
        vc.hidden = YES;
        vv.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
