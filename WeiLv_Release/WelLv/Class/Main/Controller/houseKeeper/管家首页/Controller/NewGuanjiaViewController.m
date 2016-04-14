//
//  NewGuanjiaViewController.m
//  WelLv
//
//  Created by mac for csh on 16/1/12.
//  Copyright © 2016年 WeiLvTechnology. All rights reserved.
//

#import "NewGuanjiaViewController.h"
#import "MiddleModel.h"
#import "LoginAndRegisterViewController.h"
#import "LXUserTool.h"

#define Limite @"10"

#define IS_LIST (([[LXUserTool alloc] getUid] && [[[LXUserTool alloc] getKeeper] intValue]!=0) ? false : true)
@interface NewGuanjiaViewController ()<UIScrollViewDelegate>
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
@property (nonatomic,strong)YXBannerView *headScrollView; //头视图轮播

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

@property (nonatomic,strong)UIButton *bangDingBtn;    //绑定按钮

@property (nonatomic,copy)NSString *countNumber;//总数
@property (nonatomic,copy)NSString *hehuoNumber;//合伙人
@property (nonatomic,copy)NSString *newmotto;
@property (nonatomic,copy)NSString *newschool;
@property (nonatomic,copy)NSString *addressTitle;
@property (nonatomic,copy)NSString *phonTitle;
@property (nonatomic,copy)NSString *addRessFirstStr;

@property (nonatomic,copy)NSString *keerJintong ;//精通内容
@property (nonatomic,copy)NSString *keerAddress;

@end
@implementation NewGuanjiaViewController
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
//    //判断是否 会员 和 管家登录
//    if ([[WLSingletonClass defaultWLSingleton]wlUserType] ==WLMemberTypeMember && [self judgeString:[[NSUserDefaults standardUserDefaults] objectForKey:@"memberDic"]] == NO) {
//        
//        [[LXUserTool sharedUserTool]deleteUser];
//        
//    }else if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeSteward && [self judgeString:[[NSUserDefaults standardUserDefaults] objectForKey:@"stewardDic"]] == NO) {
//        
//        [[LXUserTool sharedUserTool] deleteUser];
//        
//    }
    
     [self viewDidLoad];
    
}
#pragma mark 加载视图
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.backBtn.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title= @"旅行管家";
    self.view.backgroundColor = [UIColor colorWithRed:230/240.0f green:230/240.0f blue:250/240.0f alpha:1];
    
//    if ([[WLSingletonClass defaultWLSingleton]wlUserType] == WLMemberTypeNone){ //没有登录
//        if (IS_LIST) {
//            [_scrollView removeFromSuperview];
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake(0, 0, 50, 30);
//            [btn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//            [btn  setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//            self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
//            self.bangDingBtn.hidden = YES;
//            _isReoad = YES;
//            _offest = 0;
//            _page  =0;
//            [self setupBaesView];
//            [self creatScrollView];
//            [self loadDataPage:_offest count:3]; //获取数据
//            
//        }else
//        {
//            //绑定管家后
//            _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight -64-49)];
//            _scrollView.backgroundColor = [UIColor colorWithRed:232/255.0 green:237/255.0 blue:241/255.0 alpha:1];
//            _scrollView.showsHorizontalScrollIndicator = NO;
//            _scrollView.showsVerticalScrollIndicator = NO;
//            _scrollView.contentSize = CGSizeMake(windowContentWidth, _scrollView.frame.size.height+100);
//            [self.view addSubview:_scrollView];
//            
//            _model =[[YXHouseModel alloc]init];
//            [self loadData];
//            self.bangDingBtn.hidden = NO;
//           _isBind = [[[LXUserTool alloc]getKeeper]intValue];
//        
//        }
    
//    }else if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeSteward) //管家
//    {
//        
//        [_scrollView removeFromSuperview];
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(0, 0, 50, 30);
//        [btn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//        [btn  setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
//        self.bangDingBtn.hidden = YES;
//        _isReoad = YES;
//        _offest = 0;
//        _page  =0;
//        [self setupBaesView];
//        [self creatScrollView];
//        [self loadDataPage:_offest count:3]; //获取数据
//        
//    }else if ([[WLSingletonClass defaultWLSingleton]wlUserType]==WLMemberTypeMember)
//    {
//        //绑定管家后
//        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight -64-49)];
//        _scrollView.backgroundColor = [UIColor colorWithRed:232/255.0 green:237/255.0 blue:241/255.0 alpha:1];
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.contentSize = CGSizeMake(windowContentWidth, _scrollView.frame.size.height+100);
//        [self.view addSubview:_scrollView];
//       
//        _model =[[YXHouseModel alloc]init];
//        [self loadData];
//        self.bangDingBtn.hidden = NO;
//        _isBind = [[[LXUserTool alloc]getKeeper]intValue];
//        
//    }
    
    /**
     *  执行判断条件，会员登录状态，管家登录和未登录状态
     */
    if ([[WLSingletonClass defaultWLSingleton] wlUserType] == WLMemberTypeMember)
    {
        /**
         *  会员登录状态，如果没有绑定管家 和绑定管家
         */
        if (IS_LIST) {
            
            //没有绑定管家
            [_scrollView removeFromSuperview];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 50, 30);
            [btn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
            [btn  setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
            self.bangDingBtn.hidden = NO;
            _isReoad = YES;
            _offest = 0;
            _page  =0;
            
            [self setupBaesView];
            [self creatScrollView];
            [self loadDataPage:_offest count:3]; //获取数据
            _isBind = [[[LXUserTool alloc]getKeeper]intValue];
           
        }else
        {
            //绑定管家后
            _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64-49)];
            _scrollView.backgroundColor = [UIColor colorWithRed:232/255.0 green:237/255.0 blue:241/255.0 alpha:1];
            _scrollView.showsHorizontalScrollIndicator = NO;
            _scrollView.showsVerticalScrollIndicator = NO;
            _scrollView.contentSize = CGSizeMake(windowContentWidth, _scrollView.frame.size.height+100);
            [self.view addSubview:_scrollView];
            _model =[[YXHouseModel alloc]init];
            [self loadData];
             self.bangDingBtn.hidden = YES;  //绑定后隐藏按钮
            _isBind = [[[LXUserTool alloc]getKeeper]intValue];
            
        }
    }else
    {
        /**
         *  管家登录状态和未登录、会员没有绑定管家
         */
        //移除会员登录视图
        [_scrollView removeFromSuperview];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 50, 30);
        [btn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [btn  setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:btn];
        self.bangDingBtn.hidden = YES;
        _isReoad = YES;
        _offest = 0;
        _page  =0;
        [self setupBaesView];
        [self creatScrollView];
        [self loadDataPage:_offest count:3]; //获取数据
    }

}

#pragma mark - 创建全局滚动试图
- (void)setupBaesView
{
    self.baseScrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, windowContentHeight-64)];
     self.baseScrollView.bounces=YES;
     self.baseScrollView.alwaysBounceVertical = NO;
    [self.view addSubview:self.baseScrollView];
    
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
    
    NSDictionary *postDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",page*count],@"offset",[NSString stringWithFormat:@"%ld",(long)count],@"limit", nil];
    
    [_afMangerl POST:imagStr parameters:postDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 开始加载清空数组 ,
        [self.imageArr2 removeAllObjects];
        [self.personNameArr2 removeAllObjects];
        [self.sixeArr2 removeAllObjects];
        //[self.personNameArr removeAllObjects];余怀安
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
                NSString *motto   = personIconDict[@"motto"];
                NSString *school  = personIconDict[@"school"];
                    
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
                    }else {
                        
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
                 //  [self setupBotmView];  //底部合伙人视图 ,暂时用不到
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
    
    //中间 白线
     UIView *linView = [[UIView alloc]init];
    linView.center = CGPointMake(windowContentWidth/2, self.titleView.frame.size.height/2);
    linView.bounds = CGRectMake(0, 0, 1, 60);
    linView.backgroundColor = [UIColor whiteColor];
    [self.titleView addSubview:linView];
    
    /*
     左侧数字
     */
    CGFloat labX  =40;
    CGFloat labY  =10;
    NSDictionary *addDict = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:24]};
    CGRect  addFrame = [self.countNumber boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:addDict context:nil];
    self.countLabel = [[UILabel alloc]init];
    self.countLabel.frame = CGRectMake(labX, labY, addFrame.size.width, 30);
    self.countLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    self.countLabel.text =[NSString stringWithFormat:@"%@",self.countNumber];
    self.countLabel.textColor = [UIColor whiteColor];
    UILabel *labe1 = [[UILabel alloc]initWithFrame: CGRectMake(ViewX(self.countLabel)+ViewWidth(self.countLabel), labY+2,30, 30)];
    labe1.text = @"位";
    labe1.font = [UIFont systemFontOfSize:14];
    labe1.textColor = [UIColor whiteColor];
    [self.titleView addSubview:labe1];
    [self.titleView addSubview:self.countLabel];
   
    UILabel *nescLabel = [[UILabel alloc]init];
    nescLabel.frame = CGRectMake(labX, ViewY(self.countLabel)+ViewHeight(self.countLabel), windowContentWidth/2-labX, 30);
    nescLabel.text = @"旅行管家为您服务!";
    nescLabel.textColor = [UIColor whiteColor];
    nescLabel.font = [UIFont systemFontOfSize:12];
    [self.titleView addSubview:nescLabel];
    /*
     右侧数字
     */
    NSDictionary *addDict2 = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:24]};
    CGRect  addFrame2 = [self.hehuoNumber boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:addDict2 context:nil];
    self.hehuoLabel = [[UILabel alloc]init];
    self.hehuoLabel.frame = CGRectMake(windowContentWidth/2+labX,ViewY(self.countLabel),addFrame2.size.width, 30);
    self.hehuoLabel.text = [NSString stringWithFormat:@"%@",self.hehuoNumber];
    self.hehuoLabel.textColor = [UIColor whiteColor];
    self.hehuoLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    UILabel *labe2 = [[UILabel alloc]initWithFrame: CGRectMake(ViewWidth(self.hehuoLabel)+ViewX(self.hehuoLabel), labY+2,30, 30)];
    labe2.text = @"位";
    labe2.font = [UIFont systemFontOfSize:14];
    labe2.textColor = [UIColor whiteColor];
    [self.titleView addSubview:labe2];
    [self.titleView addSubview:self.hehuoLabel];
    
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.hehuoLabel.frame.origin.x, ViewY(self.hehuoLabel)+ViewHeight(self.hehuoLabel), windowContentWidth/2, 30)];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.text = @"微旅会员加入合伙人";
    textLabel.font = [UIFont systemFontOfSize:12];
    [self.titleView addSubview:textLabel];
    //确定middleScrollView高度后再确定_baseScrollView的滑动区域
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
    label.center = CGPointMake(self.view.center.x, label.center.y);
    label.text = @"旅行管家";
    label.font = [UIFont systemFontOfSize:18];
    [self.midellView addSubview:label];
    
    UILabel *mdidlabel = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x-20, ViewY(label)+ViewHeight(label)+3, 150, 20)];
    mdidlabel.text = @"追逐梦想的旅程充满精彩";
    mdidlabel.font = [UIFont systemFontOfSize:13];
    [self.midellView addSubview:mdidlabel];
    UIImageView *morImg = [[UIImageView alloc]initWithFrame:CGRectMake(windowContentWidth-15-5, 10, 15, 15)];
    morImg.image = [UIImage imageNamed:@"更多-首页"];
    [self.midellView addSubview:morImg];
    //更多 按钮
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.moreBtn.frame = CGRectMake(windowContentWidth-ViewWidth(morImg)-60, 5, 60, 30);
    [self.moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self.moreBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.moreBtn addTarget:self action:@selector(moreBtnClikc:) forControlEvents:UIControlEventTouchUpInside];
    [self.midellView addSubview:self.moreBtn];
   
    //间隔
    int space = 35
    ;
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
#pragma mark -底部视图
-(void)setupBotmView
{
   [self.botmView removeFromSuperview];
    
    self.botmView = [[UIView alloc]initWithFrame:CGRectMake(0, ViewY(self.midellView)+ViewHeight(self.midellView)+20, windowContentWidth, 210)];
    self.botmView.backgroundColor = [UIColor whiteColor];
    [self.baseScrollView addSubview:self.botmView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake((windowContentWidth-100)/2, 5, 100, 20)];
    label.text = @"管家合伙人";
    label.font = [UIFont systemFontOfSize:18];
    [self.botmView addSubview:label];
    
    UILabel *mdidlabel = [[UILabel alloc]initWithFrame:CGRectMake(label.frame.origin.x-20, ViewY(label)+ViewHeight(label)+3, 150, 20)];
    mdidlabel.text = @"新设计 加速梦想启航";
    mdidlabel.font = [UIFont systemFontOfSize:13];
    [self.botmView addSubview:mdidlabel];
    //间隔
    int space = 40;
    CGFloat btnW = (windowContentWidth - 4*20)/4;
    CGFloat btnH = btnW;
    for (int i = 0; i<self.imageArr2.count; i++) {
        
        int row = i/3;//行
        int line = i%3; //列
        CGFloat  X = space +line*(btnW+space);
        CGFloat  Y = 60+ (30+btnW)*row;
        CGFloat  W =btnW;
        CGFloat  H = btnH;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button sd_setImageWithURL:[NSURL URLWithString:self.imageArr2[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"未登录头像"]];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius =btnH/2;
        button.frame = CGRectMake(X, Y, W, H);
        //创建姓名label
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(X, 60+btnW+row*(btnH+space), 57, 20)];
        label.text = self.personNameArr2[i];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        
        //创建性别img
        UIImageView *sexImg = [[UIImageView alloc]initWithFrame:CGRectMake(X+ViewWidth(label),60+btnW+row*(btnH+space), 15, 15)];
        NSString *sexStr = self.sixeArr2[i];
        //2女   0男
        if ([sexStr isEqualToString:@"0"]||[sexStr isEqualToString:@""]){
            
            sexImg.image = [UIImage imageNamed:@"♂"];
        }else
        {
            sexImg.image = [UIImage imageNamed:@"♀"];
        }
        //设置button切换按钮
        self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nextBtn.frame =CGRectMake(10, ViewY(label)+ViewHeight(label)+20, windowContentWidth-20, 30);
        [self.nextBtn setTitle:@"换一批" forState:UIControlStateNormal];
        [self.nextBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        self.nextBtn.layer.masksToBounds = YES;
        self.nextBtn.layer.borderWidth = 0.8;
        self.nextBtn.layer.cornerRadius = 5.0;
        self.nextBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        [self.nextBtn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        [self.botmView addSubview:self.nextBtn];
        [self.botmView addSubview:sexImg];
        [self.botmView addSubview:label];
        [self.botmView addSubview:button];
       
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
#pragma mark - 换一批
-(void)nextClick
{
      _page++;
    
    [self loadDataPage:_page count:3];
  
}
#pragma 会员登录状态 执行下面方法
#pragma mark-------------------IS_LIST == Member -------------------------------
- (void)loadData
{
    self.houseID = [NSString stringWithFormat:@"%@",[[LXUserTool sharedUserTool] getKeeper]];
    NSString *url = [NSString stringWithFormat:@"%@",houseDetailUrl(self.houseID)];
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
     manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak NewGuanjiaViewController *weakSelf= self;
    [manger GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *dicty= (NSDictionary *)responseObject;
           NSDictionary *dataDict = dicty[@"data"];
         if (dicty !=nil) {
             weakSelf.detailModel = [[YXHouseModel alloc]init];
             [_detailModel setValuesForKeysWithDictionary:[dicty objectForKey:@"data"]];
            
         }
         YXHouseModel *model = [[YXHouseModel alloc]init];
         model.name = dataDict[@"name"];
         model.mobile =dataDict[@"mobile"];
         model.goods_count = dataDict[@"goods_count"];
         model.partner_count = dataDict[@"partner_count"];
         model.avatar = dataDict [@"avatar"];
         model.order_count = dataDict[@"order_count"];
         model.advantage = dataDict[@"advantage"];
         self.keerJintong = model.advantage;
         self.phonTitle = model.mobile;
         NSArray * sellersArr = dataDict[@"sellers"];
         for (NSDictionary *sellerDict in sellersArr)
         {
             model.nickname = sellerDict[@"nickname"];
             model.address =sellerDict[@"address"];
             model.company =sellerDict[@"name"];
             self.keerAddress = model.address;
             self.addRessFirstStr = model.company;
            [self initView:_detailModel];
             
             if ([YXTools stringReturnNull:model.company]) {
                 _addRess.text = @"Ta好像忘了填写该信息";
             }else
             {
                 _addRess.text =[NSString stringWithFormat:@"%@",model.company];
             }
             //公司地址
             if ([YXTools stringReturnNull:model.address]) {
                 
                 [_addRessView setContentText:@"暂无信息"];
             }else
             {
                 
                 [_addRessView setContentText:[NSString stringWithFormat:@"%@",model.address]];
                 
             }
             
         }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}
-(void)initView:(YXHouseModel *)houser
{
    YXMemberHouseData *memberData = [[YXMemberHouseData alloc] init];
    if (houser.sellers.count>0) {
        memberData = [houser.sellers objectAtIndex:0];
    }
    //头像视图 背景
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, 200)];
    bgView.contentMode = UIViewContentModeScaleAspectFill;
    bgView.image = [UIImage imageNamed:@"个人背景"];
    bgView.clipsToBounds = YES;
    bgView.userInteractionEnabled = YES;
    [_scrollView addSubview:bgView];
    UIImageView *phoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ViewWidth(_scrollView)-100)/2, 30, 90, 90)];
  
    [phoneImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",WLHTTP,houser.avatar]] placeholderImage:[UIImage imageNamed:@"默认图2.png"]];
    phoneImageView.userInteractionEnabled = YES;
    phoneImageView.layer.masksToBounds=YES;
    phoneImageView.layer.cornerRadius = 45.0;
    [bgView addSubview:phoneImageView];
    
    /**
      管理员 昵称
     */
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(ViewX(phoneImageView)+ViewWidth(phoneImageView)/4, ViewY(phoneImageView)+ViewHeight(phoneImageView)+10,200, 30)];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    if ([YXTools stringReturnNull:houser.name]) {
        
        _nameLabel.text = @"用户昵称";
    }else
    {
        _nameLabel.text =houser.name;
    }
    [bgView addSubview:_nameLabel];
    
    //透明层 label 自适应
    /**
     *  获取网络字段的长度，动态调宽
     */
    NSDictionary *addDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect  addFrame = [self.addRessFirstStr boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:addDict context:nil];
    UIView *aphaView = [[UIView alloc]initWithFrame:CGRectMake(windowContentWidth/2-ViewWidth(phoneImageView), ViewY(_nameLabel)+ViewHeight(_nameLabel)+5, addFrame.size.width+10, 30)];
    //设置透明层的中心点
    aphaView.center = CGPointMake(self.view.centerX, aphaView.center.y);
    aphaView.backgroundColor = [UIColor grayColor];
    aphaView.alpha =0.5;
    aphaView.layer.masksToBounds = YES;
    aphaView.layer.cornerRadius = 15;

     _addRess = [[UILabel alloc]init];
     _addRess.font = [UIFont systemFontOfSize:13];
     _addRess.textColor = [UIColor whiteColor];
     _addRess.text = self.addRessFirstStr;
     _addRess.frame = CGRectMake(10, 5, addFrame.size.width, addFrame.size.height);
    [aphaView addSubview:_addRess];
    [bgView addSubview:aphaView];
    
    //签名
    UIView *motoView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewY(bgView)+ViewHeight(bgView), ViewWidth(_scrollView), 60)];
    motoView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:motoView];
    
    //  格言 =houser.motto
    if ([YXTools stringReturnNull:houser.motto]) {
        UILabel *motoLabel = [YXTools allocLabel:[NSString stringWithFormat:@"Ta好像忘了填写该信息"] font:systemFont(15) textColor:[UIColor grayColor] frame:CGRectMake(Begin_X, 0, ViewWidth(motoView)-Begin_X*2, 60) textAlignment:0];
        [motoView addSubview:motoLabel];
    } else {
        UILabel *motoLabel = [YXTools allocLabel:[NSString stringWithFormat:@"“%@”",houser.motto] font:systemFont(15) textColor:[UIColor grayColor] frame:CGRectMake(Begin_X, 0, ViewWidth(motoView)-Begin_X*2, 60) textAlignment:0];
        [motoView addSubview:motoLabel];
    }
    
    //1.view
    _bussiness = [[YXAutoEditVIew alloc]initWithFrame1:CGRectMake(0, ViewY(motoView)+ViewHeight(motoView)+20, ViewWidth(_scrollView), 40)];
    _bussiness.leftImageView.image = [UIImage imageNamed:@"ste_call_icon"];
    _bussiness.titleLable.text = @"Ta的电话";
    [_bussiness setContentText:houser.mobile];
    [_scrollView addSubview:_bussiness];
    //获取电话 字段 添加点击事件 实现拨打电话
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goPlayPhone:)];
    [_bussiness addGestureRecognizer:tap1];
    UIImageView * goIcon1 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_bussiness) - 30, (ViewHeight(_bussiness) - 17) / 2 , 10, 17)];
    goIcon1.backgroundColor = [UIColor whiteColor];
    goIcon1.image = [UIImage imageNamed:@"矩形-32"];
    [_bussiness addSubview:goIcon1];
    [_scrollView addSubview:_bussiness];
    
    //2.view
    _steShopView = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewY(_bussiness)+ViewHeight(_bussiness), ViewWidth(_bussiness), 40)];
    _steShopView.titleLable.text =@"Ta的部落";
    _steShopView.leftImageView.image = [UIImage imageNamed:@"ste_shop_icon"];
    if ([NSString stringWithFormat:@"%@",houser.goods_count].length == 0) {
        [_steShopView setContentText:[NSString stringWithFormat:@"暂未产品信息"]];
    }else
    {
        [_steShopView setContentText:[NSString stringWithFormat:@"产品数量%@",houser.goods_count]];
    }
    _steShopView.userInteractionEnabled = YES;
    //添加手势 部落信息
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToBuluo:)];
    [_steShopView addGestureRecognizer:tap2];
    UIImageView * goIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_steShopView) - 30, (ViewHeight(_steShopView) - 17) / 2 , 10, 17)];
    goIcon.backgroundColor = [UIColor whiteColor];
    goIcon.image = [UIImage imageNamed:@"矩形-32"];
    [_steShopView addSubview:goIcon];
    [_scrollView addSubview:_steShopView];
    
    //3.view
    _workTime = [[YXAutoEditVIew alloc] initWithFrame1:CGRectMake(0, ViewBelow(_steShopView), ViewWidth(_bussiness), 40)];
    _workTime.titleLable.text = @"Ta的合伙人";
    _workTime.leftImageView.image = [UIImage imageNamed:@"ste_shop_partner_icon"];
    if ([NSString stringWithFormat:@"%@",houser.partner_count].length == 0)
    {
        [_workTime setContentText:@"暂无合伙人"];
    }
    else
    {
        [_workTime setContentText:[NSString stringWithFormat:@"合伙人%@",houser.partner_count]];
    }
    [_scrollView addSubview:_workTime];
    //添加手势 部落信息
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goHehuoren:)];
    [_workTime addGestureRecognizer:tap3];
    UIImageView * goIcon2 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_workTime) - 30, (ViewHeight(_workTime) - 17) / 2 , 10, 17)];
    goIcon2.backgroundColor = [UIColor whiteColor];
    goIcon2.image = [UIImage imageNamed:@"矩形-32"];
    [_workTime addSubview:goIcon2];
    [_scrollView addSubview:_workTime];
   
    //4.view4
    _jinTong = [[YXAutoEditVIew alloc]initWithFrame1:CGRectMake(0, ViewY(_workTime)+ViewHeight(_workTime)+20, ViewWidth(_bussiness), 40)];
    _jinTong.titleLable.text = @"精通业务";
    _jinTong.leftImageView.image = [UIImage imageNamed:@"ste_shop_partner_icon"];
  
    [_scrollView addSubview:_jinTong];
    if ([YXTools stringReturnNull:houser.advantage]) {
        [_jinTong setContentText:@"暂无信息"];
    }else
    {
        [_jinTong setContentText:houser.advantage];
    }
    [_scrollView addSubview:_jinTong];
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jintongList:)];
    [_jinTong addGestureRecognizer:tap4];
    UIImageView * goIcon4 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_jinTong) - 30, (ViewHeight(_jinTong) - 17) / 2 , 10, 17)];
    goIcon4.backgroundColor = [UIColor whiteColor];
    goIcon4.image = [UIImage imageNamed:@"矩形-32"];
    [_jinTong addSubview:goIcon4];
    [_scrollView addSubview:_jinTong];
    
    
    //5. view5
    _servce = [[YXAutoEditVIew alloc]initWithFrame1:CGRectMake(0, ViewY(_jinTong)+ViewHeight(_jinTong), ViewWidth(_bussiness), 40)];
    _servce.titleLable.text = @"服务记录";
    _servce.leftImageView.image = [UIImage imageNamed:@"ste_serve_icon"];
    if ([YXTools stringReturnNull:houser.order_count]) {
        
        [_servce setContentText:@"暂无记录"];
    }else
    {
        [_servce setContentText:[NSString stringWithFormat:@"服务次数%@",houser.order_count]];
    }
    [_scrollView addSubview:_servce];
     UITapGestureRecognizer * tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(serve:)];
    [_servce addGestureRecognizer:tap5];
    UIImageView * goIcon5 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_servce) - 30, (ViewHeight(_servce) - 17) / 2 , 10, 17)];
    goIcon5.backgroundColor = [UIColor whiteColor];
    goIcon5.image = [UIImage imageNamed:@"矩形-32"];
    [_servce addSubview:goIcon5];
    [_scrollView addSubview:_servce];
    //6 view6
    _addRessView = [[YXAutoEditVIew alloc]initWithFrame1:CGRectMake(0, ViewY(_servce)+ViewHeight(_servce), ViewWidth(_bussiness), 40)];
    _addRessView.titleLable.text = @"公司地址";
    _addRessView.leftImageView.image = [UIImage imageNamed:@"ste_address_icon"];
    [_addRessView setContentText:@"服务记录"];
    [_scrollView addSubview:_addRessView];
    UITapGestureRecognizer * tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adress:)];
    [_addRessView addGestureRecognizer:tap6];
    UIImageView * goIcon6 = [[UIImageView alloc] initWithFrame:CGRectMake(ViewWidth(_addRessView) - 30, (ViewHeight(_addRessView) - 17) / 2 , 10, 17)];
    goIcon6.backgroundColor = [UIColor whiteColor];
    goIcon6.image = [UIImage imageNamed:@"矩形-32"];
    [_addRessView addSubview:goIcon6];
    [_scrollView addSubview:_addRessView];
    
//    //绑定按钮
//    self.bangDingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.bangDingBtn.frame = CGRectMake(0, ViewY(_addRessView)+ViewHeight(_addRessView)+20, windowContentWidth, 40);
//    self.bangDingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//    [self.bangDingBtn setTitle:@"绑定我，为你服务" forState:UIControlStateNormal];
//    self.bangDingBtn.backgroundColor = [UIColor orangeColor];
//    [self.bangDingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
 
    [_scrollView addSubview:self.bangDingBtn];
    
    if (_isBind == [self.houseID intValue])  //绑定管家
    {
        self.bangDingBtn.hidden = YES;      //如果绑定管家 隐藏button
        
    }else if (_isBind == [self.houseID intValue]==0)
    {
    
    // [self.bangDingBtn addTarget:self action:@selector(boundClick:) forControlEvents:UIControlEventTouchUpInside];
    
    }

}
#pragma mark - view-touchUp点击事件
-(void)goPlayPhone:(UITapGestureRecognizer*)play
{
    NSLog(@"哈哈");
    
    if ([self judgeString:_phonTitle]) {
        NSString * telString = [NSString stringWithFormat:@"tel:%@", _phonTitle];
        NSURL * telUrl = [NSURL URLWithString:telString];
        [[UIApplication sharedApplication] openURL:telUrl];
    } else {
        [[LXAlterView sharedMyTools] createTishi:@"失败,请重试!"];
    }
    
}
#pragma mak -部落信息
-(void)goToBuluo:(UITapGestureRecognizer *)buluo
{
    NSLog(@"部落信息");
    
    ZFJSteShopOtherVC *vc = [[ZFJSteShopOtherVC alloc]init];
    vc.assistant_id =self.houseID;
    vc.assistant_mobile = self.detailModel.mobile;
    [self.navigationController pushViewController:vc animated:YES];

}
// 合伙人信息
-(void)goHehuoren:(UITapGestureRecognizer *)hehuo
{
    NSLog(@"合伙人");
        
}
//精通业务
-(void)jintongList:(UITapGestureRecognizer*)jinton
{
    KeepViewController *kep = [[KeepViewController alloc]init];
    kep.type = typeYeWu;
    
    if ([YXTools stringReturnNull:self.keerJintong]) { //防止self.keeperJintong为null时蹦，做判断
        kep.keeperJing = @"暂无信息";
    }else
    {
        kep.keeperJing = self.keerJintong;
    }
    kep.navTitle = @"精通业务";
    [self.navigationController pushViewController:kep animated:YES];
    
}
// 服务
-(void)serve:(UITapGestureRecognizer*)servre
{
    NSLog(@"服务");
    GuanJiaServiceRecoredViewController *serview = [[GuanJiaServiceRecoredViewController alloc]init];
    serview.userId =self.houseID;
    [self.navigationController pushViewController:serview animated:YES];
    
}
//公司地址
-(void)adress:(UITapGestureRecognizer*)address
{
    KeepViewController *kep = [[KeepViewController alloc]init];
    kep.type = typeAddRess;
    kep.keepAdress = self.keerAddress;
    kep.navTitle = @"公司地址";
    [self.navigationController pushViewController:kep animated:YES];
}
//#pragma mark 绑定按钮
//-(void)boundClick:(UIButton *)button
//{
//    
//    NSString *userId = [[LXUserTool alloc]getUid];
//    //传 会员id 和管家id
//    NSDictionary *parmDict =@{@"member_id":userId,@"assistant_id":self.houseID};
//    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
//    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manger POST:bindHouseUrl parameters:parmDict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dic =(NSDictionary *) responseObject;
//        NSString *msg = [dic objectForKey:@"msg"];  //上传参数成功 返回字段
//        if ([msg isEqualToString:@"操作成功"]) {
//            self.bangDingBtn.hidden = YES;   //绑定成功，隐藏按钮
//            [[LXAlterView sharedMyTools]createTishi:msg];
//            
//            [[NSUserDefaults standardUserDefaults]setObject:self.houseID forKey:@"assistant_id"];
//            [[NSUserDefaults standardUserDefaults]setObject:_model.mobile forKey:AssistantPhone];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            
//        }else if(msg)
//        {
//            [[LXAlterView sharedMyTools]createTishi:msg];
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//         [[LXAlterView sharedMyTools] createTishi:@"网洛请求失败"];
//    }];
//    
//    
//}

@end

