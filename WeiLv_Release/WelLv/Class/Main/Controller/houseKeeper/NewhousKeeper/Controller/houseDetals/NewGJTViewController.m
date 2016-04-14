//
//  NewGuanjiaViewController.m
//  WelLv
//
//  Created by mac for csh on 16/1/12.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "NewGJTViewController.h"
#import "MiddleModel.h"
#import "LoginAndRegisterViewController.h"
#import "LXUserTool.h"

#define Limite @"10"

#define IS_LIST (([[LXUserTool alloc] getUid] && [[[LXUserTool alloc] getKeeper] intValue]!=0) ? false : true)
@interface NewGJTViewController ()<UIScrollViewDelegate>
{
    AFHTTPRequestOperationManager *_afMangerl;
    
    //记录当前页
    NSInteger _offest;
    NSInteger _page;
    YXHouseModel *_model;
    
    
    
    YXAutoEditVIew *_bussiness;
    YXAutoEditVIew *_steShopView;
    YXAutoEditVIew *_workTime;
    YXAutoEditVIew *_jinTong;
    YXAutoEditVIew *_servce;
    YXAutoEditVIew *_addRessView;
    
    UILabel *_nameLabel ; // 公司地址
    UILabel *_addRess ;//  头视图公司信息
    BOOL _isReoad; //判断数据请求
    BOOL list;
    
}
@property (nonatomic, strong) YXHouseModel *detailModel;
@property (nonatomic,strong)YXBannerView *headScrollView; //头试图轮播

@property(nonatomic,strong)UIScrollView *baseScrollView;
@property (nonatomic,strong)UIView *titleView;
@property (nonatomic,strong)UIView *midellView;
@property (nonatomic,strong)UIView *botmView;


@property(nonatomic,strong)UILabel *countLabel;//管家总人数
@property (nonatomic,strong)UILabel *hehuoLabel;//合伙人
@property (nonatomic,strong)NSMutableArray *imageArr1;//1数组
@property (nonatomic,strong)NSMutableArray *imageArr2;//2数组
@property(nonatomic,strong)NSMutableArray *personNameArr;//名称
@property(nonatomic,strong)NSMutableArray *personNameArr2;
@property (nonatomic,strong)NSMutableArray *sixArr1; //性别
@property (nonatomic,strong)NSMutableArray *sixeArr2;//
@property (nonatomic,strong)NSMutableArray *idArr;
@property (nonatomic,strong)NSMutableArray *newmottoArr;
@property (nonatomic,strong)NSMutableArray *newschoolArr;

@property (nonatomic,strong)UIButton *moreBtn;// 更过button
@property (nonatomic,strong)UIButton *nextBtn;//换一个button
//@property (nonatomic,strong)UIButton *bangDingBtn;    //绑定按钮

@property (nonatomic,copy)NSString *countNumber;//总数
@property (nonatomic,copy)NSString *hehuoNumber;//合伙人
@property (nonatomic,copy)NSString *newmotto;
@property (nonatomic,copy)NSString *newschool;
@property (nonatomic,copy)NSString *addressTitle;
@property (nonatomic,copy)NSString *phonTitle;

@end
@implementation NewGJTViewController
@synthesize houseName = _houseName;
@synthesize houseID = _houseID;
@synthesize isBind = _isBind;

#pragma mark   懒加载 初始化数组
-(NSMutableArray *)idArr
{
    if (_idArr == nil) {
        
        _idArr = [NSMutableArray array];
    }
    return _idArr;
}
-(NSMutableArray *)imageArr1
{
    if (_imageArr1 ==nil) {
        
        _imageArr1 = [NSMutableArray array];
    }
    return _imageArr1;
}
-(NSMutableArray *)imageArr2
{
    if (_imageArr2 ==nil) {
        
        _imageArr2 = [NSMutableArray array];
    }
    return _imageArr2;
}
-(NSMutableArray *)personNameArr2
{
    if (_personNameArr2 == nil) {
        
        _personNameArr2 = [NSMutableArray array];
    }
    return _personNameArr2;
}
-(NSMutableArray *)personNameArr
{
    if (_personNameArr == nil) {
        
        _personNameArr = [NSMutableArray array];
    }
    return _personNameArr;
    
}
-(NSMutableArray *)sixArr1
{
    if (_sixArr1 == nil) {
        _sixArr1 = [NSMutableArray array];
    }
    return _sixArr1;
}
-(NSMutableArray *)sixArr2
{
    if (_sixeArr2 == nil) {
        _sixeArr2 = [NSMutableArray array];
    }
    return _sixeArr2;
}
-(NSMutableArray *)newschoolArr
{
    if (_newschoolArr == nil) {
        _newschoolArr = [NSMutableArray array];
    }
    return _newschoolArr;
    
}
-(NSMutableArray *)newmottoArr
{
    if (_newmottoArr == nil) {
        _newmottoArr = [NSMutableArray array];
    }
    return _newmottoArr;
    
}
#pragma mark  -----
-(void)dealloc
{
    [XCLoadMsg removeLoadMsg:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    for (UIView *vv in [self.view subviews]) {
        [vv removeFromSuperview];
        
    }
    
    [self viewDidLoad];
}

#pragma mark 加载视图

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //self.backBtn.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title= @"旅行管家";
    self.view.backgroundColor = [UIColor colorWithRed:230/240.0f green:230/240.0f blue:250/240.0f alpha:1];
    //创建搜索按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [btn  setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btn];

    _isReoad = YES;
    _offest = 0;
    _page  =0;
            
    [self setupBaesView];
    [self creatScrollView];
    [self loadDataPage:_offest count:3]; //获取数据
    
}

#pragma mark - 创建全局滚动试图
- (void)setupBaesView
{
    self.baseScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64)];
    self.baseScrollView.bounces=YES;
    self.baseScrollView.alwaysBounceVertical = NO;
    [self.view addSubview:self.baseScrollView];
    
    NSMutableArray *imageAray=[NSMutableArray array];
    for (int i=0; i<2; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"单独-logo%d.png", i+2]];
        [imageAray addObject:image];
    }
    
    
}
#pragma mark------------ 创建滚动视图
-(void)creatScrollView
{
    [self.headScrollView removeFromSuperview];
    NSArray *imgGroup = @[@"banner1"];
    
    self.headScrollView = [[YXBannerView alloc]initWithFrameRect:CGRectMake(0, 0, windowContentWidth, 150) ImageArray:imgGroup];
    self.headScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.baseScrollView addSubview:self.headScrollView];
    
}
#pragma mark -h获取滚动视图数据
- (void)loadDataPage:(NSInteger )page count:(NSInteger)count
{
    NSString *str = @"api/assistant/assistant_index?";
    NSString *imagStr = [NSString stringWithFormat:@"%@/%@",WLHTTP,str];
    
    _afMangerl = [AFHTTPRequestOperationManager manager];
    _afMangerl.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",page*count],@"offset",[NSString stringWithFormat:@"%d",count],@"limit", nil];
    
    [_afMangerl POST:imagStr parameters:postDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 开始加载清空数组 ,
        [self.imageArr2 removeAllObjects];
        [self.personNameArr2 removeAllObjects];
        [self.sixeArr2 removeAllObjects];
        //  [self.personNameArr removeAllObjects];余怀安
        //[self.imageArr1 removeAllObjects];
        if (responseObject) {
            NSDictionary *assDict = (NSDictionary*)responseObject;
            NSString *assistant_count = [NSString stringWithFormat:@"%@",assDict[@"assistant_count"]];
            NSString *partner_count = [NSString stringWithFormat:@"%@",assDict [@"partner_count"]];
            self.countNumber = assistant_count;
            self.hehuoNumber = partner_count;
            NSArray *assistantsArr = assDict[@"assistants"]; //获取6组图片
            if(self.imageArr1.count==0) {
                // 把第一个for循环写里面
                for (NSDictionary *personIconDict in assistantsArr) {
                    MiddleModel *model = [[MiddleModel alloc]init];
                    model.avatar  = [NSString stringWithFormat:@"%@/%@",WLHTTP,personIconDict[@"avatar"]]; //头像
                    model.name = personIconDict[@"name"];
                    model.assistant_id = personIconDict[@"assistant_id"];  // 获取管家id
                    NSString * gender = personIconDict[@"gender"];         //性别
                    NSString *motto  = personIconDict[@"motto"];
                    NSString *school = personIconDict[@"school"];
                    
                    if ([motto isKindOfClass:[NSNull class]]) { //判定键值对为null的情况
                        model.motto = @"";
                    }else
                    {
                        model.motto = motto;
                    }
                    if ([school isKindOfClass:[NSNull class]]) {//判定键值对为null的情况
                        
                        model.school = @"";
                    }else
                    {
                        model.school = school;
                    }
                    
                    if ([gender isKindOfClass:[NSNull class]]) {//判定键值对为null的情况
                        model.gender = @"";
                    } else {
                        model.gender = gender;
                    }
                    [self.imageArr1 addObject:model.avatar ];
                    [self.personNameArr addObject:model.name];
                    [self.sixArr1 addObject:model.gender];
                    [self.idArr addObject:model.assistant_id];
                    [self.newmottoArr addObject:motto];      //格言
                    [self.newschoolArr addObject:school];    //学校
                }
                
                
            }
            [self setupTitleView];
            [self setupMiddleView];
            NSArray *partners = assDict[@"partners"];  //获取3组图片
            if (partners.count>0) {  //判断数组中的元素是否为0的执行内容
                for (NSDictionary *nextDict in partners) {
                    NSString *personImg = [NSString stringWithFormat:@"%@/%@",WLHTTP,nextDict[@"avater"]]; //头像
                    NSString *personNextName = nextDict[@"name"]; //名称
                    NSString *personSex  =nil; //性别
                    if ([personSex isKindOfClass:[NSNull class]]) {
                        personSex = @"";
                    }else
                    {
                        personSex = nextDict[@"sex"];
                    }
                    [self.imageArr2 addObject:personImg];
                    [self.personNameArr2 addObject:personNextName];
                    [self.sixeArr2 addObject:personSex];
                }
                //  [self setupBotmView];  //底部合伙人视图
            }
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"图片：%@",error);
    }];
}
-(void)setupTitleView
{
    [self.titleView removeFromSuperview]; //重新加载页面的时候 移除之前的视图防止复用
    
    self.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewX(self.headScrollView)+ViewHeight(self.headScrollView), windowContentWidth, 80)];
    self.titleView.backgroundColor = [UIColor colorWithRed:60/240.0f green:179/240.0f blue:113/240.0f alpha:1];
    
    [self.baseScrollView addSubview:self.titleView];
    
    CGFloat labelW = 150;
    CGFloat labX  = 50;
    self.countLabel = [[UILabel alloc]initWithFrame:CGRectMake(labX,10,labelW, 30)];
    self.countLabel.text =self.countNumber;
    self.countLabel.font = [UIFont systemFontOfSize:24];
    self.countLabel.textColor = [UIColor whiteColor];
    [self.titleView addSubview:self.countLabel];
    
    UILabel *nescLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.countLabel.frame.origin.x, self.countLabel.frame.origin.y+self.countLabel.frame.size.height+5, 200, 30)];
    nescLabel.textColor = [UIColor whiteColor];
    nescLabel.text = @"旅行管家为您服务!";
    nescLabel.font = [UIFont systemFontOfSize:13];
    [self.titleView addSubview:nescLabel];
    
    UIView *linView = [[UIView alloc]initWithFrame:CGRectMake(self.countLabel.frame.size.width+self.countLabel.frame.origin.x, 10, 1, 60)];
    linView.backgroundColor = [UIColor whiteColor];
    [self.titleView addSubview:linView];
    
    self.hehuoLabel = [[UILabel alloc]initWithFrame:CGRectMake(linView.frame.origin.x+20, self.countLabel.frame.origin.y, 100, 30)];
    
    self.hehuoLabel.text = self.hehuoNumber;
    self.hehuoLabel.textColor = [UIColor whiteColor];
    self.hehuoLabel.font = [UIFont systemFontOfSize:25];
    [self.titleView addSubview:self.hehuoLabel];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.hehuoLabel.frame.origin.x, self.countLabel.frame.origin.y+self.countLabel.frame.size.height+5, 200, 30)];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.text = @"微旅会员加入合伙人!";
    textLabel.font = [UIFont systemFontOfSize:13];
    [self.titleView addSubview:textLabel];
    //确定middleScrollView高度后再确定_baseScrollView的滑动区域
    CGFloat scrollY=self.titleView.frame.size.height+self.titleView.frame.origin.y+44;
    CGFloat scrollH = scrollY ;
    self.baseScrollView.contentSize = CGSizeMake(windowContentWidth, self.baseScrollView.frame.size.height+64);
}
#pragma mark -中间view
-(void)setupMiddleView
{
    
    [self.midellView removeFromSuperview];
    self.midellView = [[UIView alloc]initWithFrame:CGRectMake(0,self.titleView.frame.origin.y+self.titleView.frame.size.height, windowContentWidth, 280)];
    self.midellView.backgroundColor = [UIColor whiteColor];
    [self.baseScrollView addSubview:self.midellView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((windowContentWidth-100)/2, 5, 80, 20)];
    label.text = @"旅行管家";
    label.font = [UIFont systemFontOfSize:18];
    [self.midellView addSubview:label];
    
    UILabel *mdidlabel = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x-20, ViewY(label)+ViewHeight(label)+3, 150, 20)];
    
    mdidlabel.text = @"追逐梦想的旅程充满精彩";
    mdidlabel.font = [UIFont systemFontOfSize:13];
    [self.midellView addSubview:mdidlabel];
    
    //更多 按钮
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreBtn.frame = CGRectMake(ViewX(label)+150, 5, 60, 30);
    [self.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.moreBtn addTarget:self action:@selector(moreBtnClikc:) forControlEvents:UIControlEventTouchUpInside];
    [self.midellView addSubview:self.moreBtn];
    UIImageView *morImg = [[UIImageView alloc]initWithFrame:CGRectMake(ViewX(self.moreBtn)+ViewWidth(self.moreBtn)+2, 10, 15, 15)];
    morImg.image = [UIImage imageNamed:@"更多-首页"];
    [self.midellView addSubview:morImg];
    
    //间隔
    int space = 40;
    CGFloat btnW = (windowContentWidth - 4*20)/4;
    CGFloat btnH = btnW;
    for (int i = 0; i<self.imageArr1.count; i++) {
        
        int row = i/3;//行
        int line = i%3; //列
        CGFloat  X = space +line*(btnW+space);
        CGFloat  Y = 60+ (30+btnW)*row;
        CGFloat  W =btnW;
        CGFloat  H = btnH;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button sd_setImageWithURL:[NSURL URLWithString:self.imageArr1[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"未登录头像"]];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius =btnH/2;
        button.frame = CGRectMake(X, Y, W, H);
        button.tag = 100+i;
        [button addTarget:self action:@selector(personClick:) forControlEvents:UIControlEventTouchUpInside];
        //创建名字label
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(X-5, 60+btnW+row*(btnH+space), 57, 20)];
        label.text = self.personNameArr[i];
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentCenter;
        
        //创建性别img
        UIImageView *sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(X+ViewWidth(label)+2,60+btnW+row*(btnH+space), 15, 15)];
        NSString *sexStr = self.sixArr1[i];
        //2女   1男
        if ([sexStr isEqualToString:@"1"]||[sexStr isEqualToString:@""]){
            
            sexImg.image = [UIImage imageNamed:@"♂"];
            
        }else
        {
            sexImg.image = [UIImage imageNamed:@"♀"];
        }
        [self.midellView addSubview:sexImg];
        [self.midellView addSubview:label];
        [self.midellView addSubview:button];
        
    }
}

#pragma mark -导航栏右侧item
-(void)btnClick:(UIButton *)button
{
    SearchViewController *newSearch = [[SearchViewController alloc]init];
    newSearch.searchType = 4;
    [self.navigationController pushViewController:newSearch animated:YES];
}
#pragma mark -头像点击
-(void)personClick:(UIButton *)iconBtn
{
    switch (iconBtn.tag) {
        case 100:
        {
            NewGuanJiaInfoController *lxView = [[NewGuanJiaInfoController alloc]init];
            lxView.userName = self.personNameArr[iconBtn.tag-100];
            lxView.userIcon = self.imageArr1[iconBtn.tag-100];
            lxView.userID = self.idArr[iconBtn.tag-100];
            
            if ([self judgeString:self.newmottoArr[iconBtn.tag-100]]) {
                
                lxView.mottoLabel = self.newmottoArr[iconBtn.tag -100];
            }else
            {
                
                
            }
            
            if ([self judgeString:self.newschoolArr[iconBtn.tag-100]]) {
                
                lxView.schoolLabel = self.newschoolArr [iconBtn.tag-100];
            }else
            {
                
                
            }
            
            [self.navigationController pushViewController:lxView animated:YES];
            
        }
            break;
        case 101:
        {
            NewGuanJiaInfoController *lxView = [[NewGuanJiaInfoController alloc]init];
            lxView.userName = self.personNameArr[iconBtn.tag-100];
            lxView.userIcon = self.imageArr1[iconBtn.tag-100];
            lxView.userID = self.idArr[iconBtn.tag-100];
            
            if ([self judgeString:self.newmottoArr[iconBtn.tag-100]]) {
                
                lxView.mottoLabel = self.newmottoArr[iconBtn.tag -100];
            }else
            {
                lxView.mottoLabel =self.newmottoArr[iconBtn.tag-100];
            }
            
            if ([self judgeString:self.newschoolArr[iconBtn.tag-100]]) {
                
                lxView.schoolLabel = self.newschoolArr [iconBtn.tag-100];
            }else
            {
                
            }
            
            
            [self.navigationController pushViewController:lxView animated:YES];
            
        }
            break;
        case 102:
        {
            NewGuanJiaInfoController *lxView = [[NewGuanJiaInfoController alloc]init];
            lxView.userName = self.personNameArr[iconBtn.tag-100];
            lxView.userIcon = self.imageArr1[iconBtn.tag-100];
            lxView.userID = self.idArr[iconBtn.tag-100];
            
            if ([self judgeString:self.newmottoArr[iconBtn.tag-100]]) {
                
                lxView.mottoLabel = self.newmottoArr[iconBtn.tag -100];
                //  lxView.mottoLabel = @"Ta好像忘了填写该信息";
            }else
            {
                lxView.mottoLabel =self.newmottoArr[iconBtn.tag-100];
            }
            
            if ([self judgeString:self.newschoolArr[iconBtn.tag-100]]) {
                
                lxView.schoolLabel = self.newschoolArr [iconBtn.tag-100];
            }else
            {
                
            }
            
            [self.navigationController pushViewController:lxView animated:YES];
        }
            break;
        case 103:
        {
            NewGuanJiaInfoController *lxView = [[NewGuanJiaInfoController alloc]init];
            lxView.userName = self.personNameArr[iconBtn.tag-100];
            lxView.userIcon = self.imageArr1[iconBtn.tag-100];
            lxView.userID = self.idArr[iconBtn.tag-100];
            if ([self judgeString:self.newmottoArr[iconBtn.tag-100]]) {
                lxView.mottoLabel = self.newmottoArr[iconBtn.tag -100];
                //   lxView.mottoLabel = @"Ta好像忘了填写该信息";
            }else
            {
                lxView.mottoLabel =self.newmottoArr[iconBtn.tag-100];
            }
            
            if ([self judgeString:self.newschoolArr[iconBtn.tag-100]]) {
                
                lxView.schoolLabel = self.newschoolArr [iconBtn.tag-100];
            }else
            {
                
            }
            
            [self.navigationController pushViewController:lxView animated:YES];
        }
            break;
            
        case 104:
        {
            NewGuanJiaInfoController *lxView = [[NewGuanJiaInfoController alloc]init];
            lxView.userName = self.personNameArr[iconBtn.tag-100];
            lxView.userIcon = self.imageArr1[iconBtn.tag-100];
            lxView.userID = self.idArr[iconBtn.tag-100];
            if ([self judgeString:self.newmottoArr[iconBtn.tag-100]]) {
                
                lxView.mottoLabel = self.newmottoArr[iconBtn.tag -100];
                //  lxView.mottoLabel = @"Ta好像忘了填写该信息";
            }else
            {
                lxView.mottoLabel =self.newmottoArr[iconBtn.tag-100];
            }
            
            if ([self judgeString:self.newschoolArr[iconBtn.tag-100]]) {
                lxView.schoolLabel = self.newschoolArr [iconBtn.tag-100];
                
            }else
            {
                
            }
            
            [self.navigationController pushViewController:lxView animated:YES];
        }
            break;
        case 105:
        {
            NewGuanJiaInfoController *lxView = [[NewGuanJiaInfoController alloc]init];
            lxView.userName = self.personNameArr[iconBtn.tag-100];
            lxView.userIcon = self.imageArr1[iconBtn.tag-100];
            lxView.userID = self.idArr[iconBtn.tag-100];
            if ([self judgeString:self.newmottoArr[iconBtn.tag-100]]) {
                
                lxView.mottoLabel = self.newmottoArr[iconBtn.tag -100];
                //  lxView.mottoLabel = @"Ta好像忘了填写该信息";
            }else
            {
                lxView.mottoLabel =self.newmottoArr[iconBtn.tag-100];
            }
            
            if ([self judgeString:self.newschoolArr[iconBtn.tag-100]]) {
                
                lxView.schoolLabel = self.newschoolArr [iconBtn.tag-100];
            }else
            {
                
            }
            
            [self.navigationController pushViewController:lxView animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark- 更多
-(void)moreBtnClikc:(UIButton *)sender
{
    NewHouseKeeperViewController *newView = [[NewHouseKeeperViewController alloc]init];
    
    
    [self.navigationController pushViewController:newView animated:YES];
}

@end



















