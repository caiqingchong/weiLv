//
//  FillOrderViewController.m
//  FillOrder
//
//  Created by WeiLv on 16/1/13.
//  Copyright © 2016年 WeiLv. All rights reserved.
//

#import "FillOrderViewController.h"

#import "ToppView.h"

#import "MidleView.h"

#import "NexttView.h"

#import "DownnView.h"

#import "CostView.h"

#import "PaymentViewController.h"

#import "TravelOrderDetailModel.h"

#import "CYYkViewController.h"

#import "YXWebDetailViewController.h"

#import "CYYkViewController.h"

#import "CYYLModel.h"

#import "LXTools.h"
#import "AffirmViewController.h"
#import "TravelAffirmModel.h"
#import "TravelAllHeader.h"

#import "LoginAndRegisterViewController.h"

#import "TravelCancelTitleView.h"



#define UISCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FillOrderViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

{
    NSString *firstName;
    //取消提示X
    NSInteger cancelTitleViewX;
    //取消提示Y
    NSInteger cancelTitleViewY;
    //取消提示宽
    NSInteger cancelTitleViewWidth;
    //取消提示高
    NSInteger cancelTitleViewHeight;
}

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic,strong) ToppView *topView;

@property (nonatomic,strong) MidleView *midleView;

@property (nonatomic,strong) NexttView *nextView;

@property (nonatomic,strong) DownnView *downView;

@property (nonatomic,strong) UIButton *affirmBtn;

@property (nonatomic,strong) UIView *grayView;

@property (nonatomic,assign) NSInteger numRow;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,assign) NSInteger pCount;

@property (nonatomic,strong) UILabel *nameLable;
//取消视图
@property (nonatomic, strong) TravelCancelTitleView *cancelTitleView;
//取消视图背景
@property (nonatomic, strong) UIView *cancelBackView;

//弹出框,用来显示费用明细
@property (nonatomic,strong) CostView *costView;

@property (nonatomic,assign) BOOL isAgree;

//出游人字典数组
@property (nonatomic, strong) NSMutableArray *peopleDicArray;


@property (nonatomic,strong) UITapGestureRecognizer *tap;


//转动菊花
@property (nonatomic,strong) MBProgressHUD *HUD;

//判断 admin_type 是否为空
@property (nonatomic,strong) NSString *admin_Type;

@end

@implementation FillOrderViewController


- (NSMutableArray *)peopleDicArray{
    
    if (!_peopleDicArray) {
        _peopleDicArray = [NSMutableArray array];
    }
    return _peopleDicArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据源
    self.dataArray = [NSMutableArray array];
    
    self.pCount = self.orderModel.adule;
    
    self.navigationItem.title = @"填写订单";
    //调用添加模块的方法
    [self layoutView];
    
    [self addLeftItem];
    // Do any additional setup after loading the view.
    
    
}
//添加加载换冲突
-(void)setProgressHUD{
    
    self.HUD = [[MBProgressHUD alloc]initWithView:self.view];
    _HUD.frame = self.view.bounds;
    _HUD.minSize = CGSizeMake(100, 100);
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.labelText = @"订单提交中,请稍候";
    [self.view addSubview:_HUD];
    [_HUD show:YES];
}



- (void)addLeftItem{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:(240/255.) green:(145/255.) blue:(40/255.) alpha:1];
}

- (void)leftItemAction:(UIBarButtonItem *)left{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    CYYkViewController *cyykVC = [[CYYkViewController alloc]init];
    cyykVC.sendBlock = ^ (NSArray *arr) {
        
        
        NSLog(@"%@",arr);
    };
}

/**
 *  添加界面相关模块
 */
- (void)layoutView{
    
    //创建背景 ScrollView
    self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - UISCREEN_HEIGHT / 6);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(0, UISCREEN_HEIGHT + (self.peopleDicArray.count + 2) * UISCREEN_HEIGHT / 13.5);
    self.scrollView.backgroundColor = [UIColor colorWithRed:222/255.0 green:229/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:self.scrollView];
    
    //添加 TopView
    self.topView = [[ToppView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height /5.4)];
    //产品标题
    NSString *titleStr = [NSString stringWithFormat:@"< %@ >",self.orderModel.product_name];
    self.topView.titleLable.text = titleStr;
    //出发时间
    NSString *leaveTimeStr = [NSString stringWithFormat:@"出发日期:%@ (余位%ld)",self.orderModel.f_time,(long)self.surplusCount];
    self.topView.dateLable.text = leaveTimeStr;
    self.topView.peopleLable.text = [NSString stringWithFormat:@"出游人数:%ld成人 %ld儿童",(long)self.orderModel.adule,(long)self.orderModel.child];
    
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.topView];

    
    
    if (_pCount <= 2 && self.dataArray.count == 0) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + UISCREEN_HEIGHT / 43, UISCREEN_WIDTH, UISCREEN_HEIGHT / 13.5 * (_pCount + 1)) style:UITableViewStylePlain];
        
    }else if(_pCount <= 2 && self.dataArray.count != 0){
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + UISCREEN_HEIGHT / 43, UISCREEN_WIDTH, UISCREEN_HEIGHT / 13.5 * (self.dataArray.count + 1)) style:UITableViewStylePlain];
        
    }else if(_pCount > 2 && self.dataArray.count == 0){
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + UISCREEN_HEIGHT / 43, UISCREEN_WIDTH, UISCREEN_HEIGHT / 4.5) style:UITableViewStylePlain];
        self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT - UISCREEN_HEIGHT / 8 + UISCREEN_HEIGHT / 4.5);
        
        
    }else if(_pCount > 2 && self.dataArray.count != 0){
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + UISCREEN_HEIGHT / 43, UISCREEN_WIDTH, UISCREEN_HEIGHT / 13.5 * (self.dataArray.count + 1)) style:UITableViewStylePlain];
        self.scrollView.contentSize = CGSizeMake(UISCREEN_WIDTH, UISCREEN_HEIGHT - UISCREEN_HEIGHT / 8 + UISCREEN_HEIGHT / 13.5 * (self.dataArray.count + 1));
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //注册 cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView reloadData];
    [self.scrollView addSubview:self.tableView];
    
    //添加 NextView
    self.nextView = [[NexttView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame) + UISCREEN_HEIGHT / 43, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height / 4.5)];
    
    
    self.nextView.userInteractionEnabled = YES;
   
    //TextFiled
    //姓名
    self.nextView.nameField.delegate = self;
    self.nextView.nameField.tag = 502;
    //电话
    self.nextView.teleField.delegate = self;
    self.nextView.teleField.tag = 503;
    self.nextView.teleField.keyboardType = UIKeyboardTypePhonePad;
    
    self.nextView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.nextView];
    
    //添加平台条款
    //确认已阅读条款按钮
    
    self.isAgree = YES;
    
    UIButton *affirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.affirmBtn = affirmBtn;
    affirmBtn.tag = 106;
   affirmBtn.frame = CGRectMake(UISCREEN_WIDTH / 35, CGRectGetMaxY(self.nextView.frame) + UISCREEN_WIDTH / 18,UISCREEN_WIDTH / 20, UISCREEN_WIDTH / 20);
    [affirmBtn setBackgroundImage:[UIImage imageNamed:@"同意"] forState:UIControlStateNormal];
    [affirmBtn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:affirmBtn];
    
    UILabel *readLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(affirmBtn.frame) + UISCREEN_WIDTH / 40, CGRectGetMaxY(self.nextView.frame) + UISCREEN_WIDTH / 30, UISCREEN_WIDTH / 2.3, UISCREEN_WIDTH / 10)];
    readLable.text = @"请在提交前确认您已阅读";
    readLable.textColor = [UIColor blackColor];
    readLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [self.scrollView addSubview:readLable];
    
    //进入平台条款明细
    UIButton *clauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clauseBtn.tag = 107;
    clauseBtn.frame = CGRectMake(CGRectGetMaxX(readLable.frame) - UISCREEN_WIDTH / 45, CGRectGetMinY(readLable.frame), UISCREEN_WIDTH / 6, UISCREEN_WIDTH / 10);
    [clauseBtn setTitle:@"平台条款" forState:UIControlStateNormal];
    [clauseBtn setTitleColor:[UIColor colorWithRed:61 / 255.0 green:136 / 255.0 blue:254 / 255.0 alpha:1] forState:UIControlStateNormal];
    clauseBtn.titleLabel.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
    [clauseBtn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:clauseBtn];
    
    //添加 DownView
    self.downView = [[DownnView alloc]initWithFrame:CGRectMake(0, UISCREEN_HEIGHT - 64 - UISCREEN_HEIGHT / 14, UISCREEN_WIDTH, UISCREEN_HEIGHT / 14)];
    [self.downView.totalBtn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.downView.referBtn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //显示总价
    CGFloat adultP = [self.adultPrice floatValue];
    CGFloat childP = [self.chidlPrice floatValue];
    CGFloat totalPrice = adultP * self.orderModel.adule + childP * self.orderModel.child;
    self.downView.totalLable.text = [NSString stringWithFormat:@"¥ %.2f",totalPrice];
    
    self.downView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.downView];
    
    
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSString* )arrayToJson:(NSArray *)arr

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

/**
 *  Button 关联事件
 */
- (void)clickButtonAction:(UIButton *)button
{
    if (button.tag == 106){
      
        if (_isAgree) {
            [self.affirmBtn setBackgroundImage:[UIImage imageNamed:@"未同意"] forState:UIControlStateNormal];
        }else{
            [self.affirmBtn setBackgroundImage:[UIImage imageNamed:@"同意"] forState:UIControlStateNormal];
        }
        _isAgree = !_isAgree;
        
    }else if(button.tag == 107){
//        NSLog(@"进入条款明细页");
        YXWebDetailViewController *webVC = [[YXWebDetailViewController alloc] init];
        webVC.WebTitle = @"重要条款";
        webVC.webContent = @"<p> <strong><span style=‘font-size:16px;’>特别提示：</span></strong>微旅平台的产品均由具备资质的产品供应商提供。产品供应商充分借用微旅平台，推出全方位的产品，产品的行程安排以及合同签订都是由合作产品供应商为您提供。 微旅平台作为您获取产品的地点，本协议的签署并不意味着微旅平台成为产品交易的参与者，对前述交易微旅平台仅提供技术支持，不对供应商行为的合法性、有效性及产品的真实性、合法性及有效性作任何明示或暗示的担保。在预订微旅平台的产品前，请您仔细阅读本须知，并注意本须知及产品页面中的其它重要条款也作为双方协议的补充内容。当您开始预订微旅平台产品时，即表明您已经仔细阅读并接受本协议的所有条款。</p><p><strong>第一条 相关概念及注解</strong></p><p> 1、旅游产品：以旅游酒店+交通+景点+餐饮+旅游用车+导游服务+签证（出境游）为核心，行程、交通方式、食宿标准、游览项目均有固定安排，既有专业导游带您游览经典景区，又不含任何强制购物和自费的项目。<br />2、签证产品：目前只针对持有中国大陆地区因私护照的客人提供服务，主要包含代为预约、签证材料制作整理、翻译或使领馆允许的代送服务。<br />3、邮轮产品：指海洋上的定线、定期航行的大型客运轮船，它是由包括有形的（如邮轮、邮轮服务设施、游乐项目等）和无形的（邮轮服务、游客感受等）两部分组成。<br />4、旅游消费者：指通过微旅平台预订由旅游供应商提供的旅游产品的用户，用户在微旅平台上预订旅游产品成功后，用户和旅游供应商之间建立合同关系。</p><p><strong>第二条 旅游产品内容及其标准</strong></p><p>1、旅游产品内容主要包含：目的地接待服务及其他服务。具体产品的最终包含内容以确认的订单约定内容为准。<br />2、微旅平台关于旅游产品的行程推荐仅为友情提示，不能作为约定条款。<br />3、旅游产品中约定的产品和服务内容，均为经过微旅平台严格考评筛选出的具备相关资质的旅游供应商提供，微旅平台只对其经营资质的合法性承担责任，不对其在您消费过程中可能涉及的具体产品和服务内容承担责任。</p><p><strong>第三条 签证产品内容及其标准</strong></p><p>1、签证产品是以客人提供所需的材料为前提。网上公布的所需材料为使领馆要求每位申请人提供的必备材料。使领馆根据个人的不同情况可能会要求增补其它材料时，申请人应及时提供效真实的材料。一旦增补材料，不能在原受理时间内出签，客人的行程可能会受影响。鉴于，上述情形并非供应商所能控制，客人因此产生的损失，供应商不承担任何赔偿责任。<br />2、如申请人办签过程中，领馆对申请人进行行政审核导致未能及时出签或拒绝出签的，申请人应及时告知供应商，客人应承担因此产生的全部损失，但供应商将协助申请人减少损失。<br />3、提供所有材料并不意味着使领馆一定颁发签证。如遇使领馆拒签，供应商所收的全部费用不予以退还。</p><p><strong>第四条 产品价格</strong></p><p>微旅平台展示的产品价格均为实际价格，您预订的所有产品价格，均以微旅平台上显示的金额为准。</p><p><strong>第五条 订单生效</strong></p><p>1、您在微旅平台上预订产品，并通过第三方支付完成付款后，您的订单立即生效。但如您未按要求完成支付，而此时微旅平台为您预留的产品价格、内容或标准等有发生变化，微旅平台对此不承担任何责任。 订单生效，即代表您与产品供应商的合作意向已经达成，你的变更、解除产品等的需求，将受到本协议第五条、第六条等相关条款的约束。订购合同成立后，您应按订单中约定的时间和上车地点出发。如您未按约定出发，则视您的这种行为构成违约，您应承担由此导致的损失并按照约定支付违约金。</p><p><strong>第六条 您主动更改已生效订单</strong></p><p> 订单生效后，您若需要更改该订单内的任何项目，请务必在旅游行程开始前通知您的更改需求。我们会尽量满足您的需求，但您必须全额承担因变更带来的损失及可能增加的费用。若您所预订的产品在目的地停留的日期部分或全部处在国家法定节假日或其它部分国际性、国家性、地方性重大节日期间，鉴于资源的特殊状况，已生效订单不可进行任何更改。</p><p><strong>第七条 您主动解除已生效订单</strong></p><p>1、旅游产品订单生效后，您因个人原因不能出行造成违约，须按照下列标准承担违约责任：<br />在行程开始前7日以内提出取消订单的按下列标准扣除必要的费用：<br />国内游订单：<br />1）行程开始前6日至4日，按旅游费用总额的20%；<br />2）行程开始前3日至1日，按旅游费用总额的40%；<br />3）行程开始当日，按旅游费用总额的60%。<br />出境游（含港澳台）订单：<br />在行程开始前30日以内提出解除合同的，按下列标准扣除必要的费用：<br />1）行程开始前29日至15日，按旅游费用总额的5%；<br />2）行程开始前14日至7日，按旅游费用总额的20%；<br />3）行程开始前6日至4日，按旅游费用总额的50%；<br />4）行程开始前3日至1日，按旅游费用总额的60%；<br />5）行程开始当日，按旅游费用总额的70%。</p><p>2、邮轮产品订单生效后，您因个人原因不能出行造成违约，须按照下列标准承担违约责任：<br />1）开航前90天前（含第90天）内通知取消,收2000元/人损失;<br />2）开航前89天至45天前（含第45天）内通知取消,收取团款的50%;<br />3）开航前44天至15天前（含第15天）内通知取消，收取团款的80%;<br />4）开航前14天（含第14天）内通知取消,或没有在开航时准时出现,或在开航后无论以任何理由放弃旅行,其必须支付100%团费。</p><p>3、签证产品订单生效后，您因个人原因不能出行造成违约，须按照下列标准承担违约责任：<br />订单生效后，若要主动解除已生效订单，您必须及时通知供应商解除所做预订，包括放弃整张订单、减少办理人数，同时您还须承担供应商处理该订单已经支出的其它必要费用：<br />已付款的订单，如未产生签证费用的，将全额退款。如已产生签证费用，所有费用将不予退还。</p><p><strong>第八条 因供应商原因取消您的已生效订单</strong></p><p>1、在您按要求付清旅游产品费用后，如因供应商原因，致使您旅游产品不能成行而取消的，供应商应须按照下列标准承担违约责任：<br />国内游订单：<br />在行程开始前7日以内提出解除合同的，或者旅游消费者在行程开始前7日以内收到旅游供应商不能成团通知，不同意转团、延期出行和改签线路的，旅游供应商应向旅游消费者退还已收取的全部旅游费用，并按下列标准向旅游消费者支付违约金： <br />1）行程开始前6日至4日，支付旅游费用总额10%的违约金；<br />2）行程开始前3日至1日，支付旅游费用总额15%的违约金；<br />3）行程开始当日，支付旅游费用总额20%的违约金。<br />出境游（含港澳台）订单：<br />在行程开始前30日以内提出解除合同的，或者旅游消费者在行程开始前30日以内收到旅游供应商不能成团通知，不同意转团、延期出行和改签线路的，旅游供应商应向旅游消费者退还已收取的全部旅游费用（不得扣除签证／签注等费用），并按下列标准向旅游者支付违约金：<br />1）行程开始前29日至15日，支付旅游费用总额2%的违约金；<br />2）行程开始前14日至7日，支付旅游费用总额5%的违约金；<Br />3）行程开始前6日至4日，支付旅游费用总额10%的违约金；<br />4）行程开始前3日至1日，支付旅游费用总额15%的违约金；<br />5）行程开始当日，支付旅游费用总额20%的违约金。<br />如按上述比例支付的违约金不足以赔偿旅游者的实际损失，旅行社应当按实际损失对旅游者予以赔偿；具体参见各省旅游局格式合同条款。</p><p>2、在您按要求付清所有签证费用后，如因供应商原因，致使您的签证无法办理而取消或不能按时出签的，供应商应当立即通知您，无条件退返您已支付的所有费用。  </p><p><strong>第九条 旅游产品使用权的变更</strong></p><p> 在您按要求付清旅游产品费用后，在行程开始前，须经旅游供应商同意，您可以将您预订的当地游产品使用权转让或赠送给具有参加本次旅游产品活动条件的第三人。变更后如有费用增加，须由您全额承担，否则旅游供应商有权拒绝您的变更要求。</p><p><strong>第十条 您的权利和义务</strong></p><p> 1、您应确保出行人身体条件适合本次外出旅游度假，如出行人为孕妇或有心脏病、高血压、呼吸系统疾病等病史，请在征得医院专业医生同意后出行。<br />2、您保证提供给微旅平台的证件、通讯联络方式等相关资料均真实有效。<br />3、度假期间，您应尊重当地的宗教信仰、民族习惯和风土人情，自觉保护当地自然环境。<br />4、您须通过微旅平台预订并通过微旅平台页面支付全部旅游款。但相关款项将直接汇入微旅平台帐户。如您需要退款请直接联系微旅平台为您配置的旅行管家，旅行管家将协助您完成退款事宜。<br />5、您在旅游过程中如对旅游供应商的服务质量有异议，应积极与旅游供应商沟通，争取在旅游过程中解决。<br />6、您可以选择通过微旅平台或旅游供应商电话进行投诉。<br />7、如您不遵守本须知的规定，恶意干扰微旅平台的正常运营，恶意预订、更改或退订旅游产品，微旅平台保留追究您个人责任的权利。</p><p><strong>第十一条 相关责任</strong></p><p> 您在旅游中出现下列情况，微旅平台应协助办理，结果由您承担。<br />1、您在旅游中应注意人身财产安全，妥善保管自己的证件及行李物品， 如果发生人身意外、伤害或随身携带行李物品遗失、被盗、被抢等情况，微旅平台会积极协助办理，但无赔偿之责任；补办证件所产生的费用，由您自行承担。解决的依据应以相关机构的规定为准。您必须保留有关单据和证明文件。<br />2、您违反相关国家或地区的法律、法规而被罚、被拘留及被追究其他刑事、民事责任的，您应依法承担相关责任和费用。</p><p><strong>第十二条 不可抗力</strong></p><p> 1、旅游产品：以旅游酒店+交通+景点+餐饮+旅游用车+导游服务+签证（出境游）为核<br />心，行程、交通方式、食宿标准、游览项目均有固定安排，既有专业导游带您游览经典景区，又不含任何强制购物和自费的项目。<br />2、旅游消费者：指通过微旅平台预订由旅游供应商提供的旅游产品的微信用户，微信用户在微旅平台上预订旅游产品成功后，用户和旅游供应商之间建立合同关系。</p><p><strong>第十一条 不可抗力</strong></p><p> 1、因不可抗力(包括地震、台风、雷击、雪灾、水灾、火灾等自然原因,以及战争、政府行为、黑客攻击、电信部门技术管制等原因)和意外事件等原因不能履行或不能继续履行已生效订单约定内容的，双方均不承担违约责任，但法律另有规定的除外。<br />2、如果由于临时调价而导致的产品价格上涨，对于已成交的订单，不再向您收取涨价费用；对于已确认但未付款和未确认的订单，则以最新发布的价格为准。</p><p><strong>第十三条 关于旅行责任保险</strong></p><p>1、 责任险是对因旅行社责任引起的游客人身伤亡、财产遭受的损失及由此发生的相关费用的赔偿，对于游客，在实际发生意外时，“责任险”保障的主要是旅行社对游客出游期间依法应承担的各种民事赔偿责任，而这种责任由法院或相关仲裁机构裁决。这意味着意外发生后，旅行社是不包揽一切的，它只承担自己的责任。由于游客自身原因或其他方原因出险由游客自行负责，旅行社只提供道义上的协助。为了使游客获得更为全面的保障，我们强烈建议游客出游时根据个人意愿和需要自行投保个人险种。<br />2、 游客参加旅行社组织的旅游活动过程中，因旅行社原因引起的游客人身伤亡和财产损失，旅行社依据《旅行社投保旅行社责任保险的规定》承担责任。 <br />3、 游客参加旅行社组织的旅游活动过程中，由于游客个人过错导致的人身伤亡和财产损失，以及由此导致需支出的各种费用，旅行社不承担赔偿责任。<br />4、 游客在自行终止旅行社安排的旅游行程后，或在不参加双方约定的活动而自行活动的时间内，发生的人身、财产损害，旅行社不承担赔偿责任。</p>";
        [self.navigationController pushViewController:webVC animated:YES];
        
    }else if(button.tag == 108){
        //***************弹出框,显示费用明细***************
        if (_isAgree) {
           
            self.grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UISCREEN_WIDTH, UISCREEN_HEIGHT - UISCREEN_HEIGHT / 14 - 64)];
            UITapGestureRecognizer *grayTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gry:)];
            [self.grayView addGestureRecognizer:grayTap];
            _grayView.backgroundColor = [UIColor blackColor];
            _grayView.alpha = 0.5;
            [self.view addSubview:_grayView];
            self.downView.triangleImage.image = [UIImage imageNamed:@"订单明细按钮-副本"];
            self.costView = [[CostView alloc]initWithFrame:CGRectMake(0, UISCREEN_HEIGHT - UISCREEN_HEIGHT / 13 * 2 - 64 - UISCREEN_HEIGHT / 14, UISCREEN_WIDTH, UISCREEN_HEIGHT / 13 * 2)];
            self.costView.backgroundColor = [UIColor whiteColor];
            
            //数据展示
            CGFloat aPrice = [self.adultPrice floatValue];
            CGFloat cPrice = [self.chidlPrice floatValue];
            self.costView.aPriceLable.text = [NSString stringWithFormat:@"¥%.2f*%ld人",aPrice,(long)self.orderModel.adule];
            self.costView.cPriceLable.text = [NSString stringWithFormat:@"¥%.2f*%ld人",cPrice,(long)self.orderModel.child];
            
            [self.view addSubview:self.costView];
            
        }else{
            
            self.downView.triangleImage.image = [UIImage imageNamed:@"订单明细按钮-上"];
            [self.grayView removeFromSuperview];
            [self.costView removeFromSuperview];
            self.scrollView.alpha = 1.0;
            
        }
        _isAgree = !_isAgree;
    }else if(button.tag == 109){
     
        if ([[WLSingletonClass defaultWLSingleton] wlUserType]==WLMemberTypeNone) {
//            [[LXAlterView sharedMyTools] createTishi:@"至少选择1位常用游客"];
            LoginAndRegisterViewController *loginVC = [[LoginAndRegisterViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
            
        } else {
        
            BOOL isTeleRight = [self checkTelNumber:self.nextView.teleField.text];
            
            if (self.nextView.nameField.text.length !=0 && self.nextView.teleField.text.length != 0 && isTeleRight) {
                
                if (!_isAgree) {
                    [[LXAlterView sharedMyTools] createTishi:@"是否接受平台条款"];
                }else{
                    
                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                    
                    LXUserTool * userTool = [[LXUserTool alloc] init];
                    NSString *email = [userTool getEmail];
                    
                    if (email == nil) {
                        email = @"0";
                    }
                    
                    //获取出游人信息
                    
                    if ([self judgeString:self.orderModel.admin_type] == NO) {
                        self.admin_Type = [NSString stringWithFormat:@"null"];
                    }else{
                        self.admin_Type = [NSString stringWithFormat:@"%@",_orderModel.admin_type];
                    }
                    
                    DLog(@"%@",[[LXUserTool sharedUserTool]getUid]);
                    
                    
                    NSDictionary *dataMain = @{@"admin_type":_admin_Type,
                                               @"contacts":self.nextView.nameField.text,//联系人信息
                                               @"create_time":[NSString stringWithFormat:@"%ld",
                                                               (long)[[NSDate date] timeIntervalSince1970]],//创建时间
                                               @"email":@"0",
                                               @"is_comment":@"0",
                                               @"is_ticket":@"0",
                                               @"member_id":[[LXUserTool sharedUserTool]getUid],
//                                               //获取会员ID
//                                               
                                               @"group":[[LXUserTool alloc]getuserGroup],//获取身份性质
                                               @"order_source":@"iOS",
                                               @"order_status":@"0",
                                               @"phone":self.nextView.teleField.text,
                                               @"product_category":self.orderModel.route_type,   //确认过了
                                               @"product_id":self.orderModel.product_id,
                                               @"product_name":self.orderModel.product_name};
                    
                    
                    
                    NSDictionary *person_infoDic = @{@"people":self.peopleDicArray};
                    
                    NSString *dateStr = [self getTimestampWithStr:self.orderModel.f_time];
                    
                    NSDictionary * dataTravel = @{@"is_oldman":@"0",
                                                  @"is_adult":@"0",
                                                  @"is_foreign":@"0",
                                                  @"insurance":@"0",
                                                  @"adule":[NSString stringWithFormat:@"%ld",(long)self.orderModel.adule],
                                                  @"child":[NSString stringWithFormat:@"%ld",(long)self.orderModel.child],
                                                  @"adule_price":self.orderModel.adult_price,
                                                  @"child_price":self.orderModel.child_price,
                                                  @"f_city":self.orderModel.f_city,
                                                  @"f_time":dateStr,
                                                  @"order_id":@"99",
                                                  @"person_info":person_infoDic,
                                                  };
                    
                    NSDictionary *orderdata = @{@"dataMain":dataMain,@"dataTravel":dataTravel,@"product_id":self.orderModel.product_id,@"cat_id":@"1",@"group":@"member"};
                    
                    NSString *token = @"~0;id<zOD.{ll@]JKi(:";
                    NSString *user_id = [userTool getUid];
                    NSString *token1 = [token stringByAppendingString:user_id];
                    NSDictionary *parameters = nil;
                    
                    if (self.shop_id) {
                        
                    
                    parameters = @{@"member_id":user_id,
                                   @"orderdata":[self dictionaryToJson:orderdata],
                                   @"wltoken":[WXUtil md5:token1],
                                   @"store_id":self.shop_id
                                   };
                    }else{
                        parameters = @{@"member_id":user_id,
                                       @"orderdata":[self dictionaryToJson:orderdata],
                                       @"wltoken":[WXUtil md5:token1]};
                    }
                    
                    [self setProgressHUD];
                    
                    [manager POST:kTravelPostOrderUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                        
                        NSDictionary *orderDic = nil;
                        orderDic = dic[@"data"];
                        [self.HUD removeFromSuperview];
                        if ([[dic objectForKey:@"state"] integerValue] != 1) {
                            
                            [[LXAlterView sharedMyTools] createTishi:[dic objectForKey:@"msg"]];
                            
                        }else
                        {   [[LXAlterView sharedMyTools] createTishi:@"订单提交成功！"];
                            
                            //根据字段 order_status 判断产品的支付与确认状态
                            NSString *order_status = [NSString stringWithFormat:@"%@",orderDic[@"order_status"]];
                            
                            if ([order_status intValue] == 1 || [order_status intValue] == 0) {
                                PaymentViewController *payVC = [[PaymentViewController alloc] init];
                                
                                payVC.affirmModel = [[TravelAffirmModel alloc]init];
                                
                                payVC.affirmModel.order_id = orderDic[@"order_id"];
                                payVC.affirmModel.f_city_name = orderDic[@"f_city_name"];
                                payVC.affirmModel.f_time = [self getDateStr:orderDic[@"f_time"]];
                                payVC.affirmModel.adule = orderDic[@"adule"];
                                payVC.affirmModel.child = orderDic[@"child"];
                                payVC.affirmModel.order_price = orderDic[@"order_price"];
                                
                                payVC.orderPrice = orderDic[@"order_price"];
                                
                                payVC.affirmModel.orderContactPersonName = self.nextView.nameField.text;
                                payVC.affirmModel.orderContactPhone = self.nextView.teleField.text;
                                
                                payVC.affirmModel.product_name = orderDic[@"product_name"];
                                payVC.affirmModel.order_sn = orderDic[@"order_sn"];
                                
                                payVC.affirmModel.route_type = orderDic[@"route_type"];
                                [self.navigationController pushViewController:payVC animated:YES];
                                
                            } else if ([order_status intValue] == 90 || [order_status intValue] == 91 || [order_status intValue] == 92){
                                AffirmViewController *affirmVC = [[AffirmViewController alloc]init];
                                affirmVC.affirmModel = [[TravelAffirmModel alloc]init];
                                affirmVC.affirmModel.order_id = orderDic[@"order_id"];
                                affirmVC.affirmModel.f_city_name = orderDic[@"f_city_name"];
                                affirmVC.affirmModel.f_time = [self getDateStr:orderDic[@"f_time"]];;
                                affirmVC.affirmModel.adule = orderDic[@"adule"];
                                affirmVC.affirmModel.child = orderDic[@"child"];
                                affirmVC.affirmModel.order_price = orderDic[@"order_price"];
                                affirmVC.affirmModel.product_name = orderDic[@"product_name"];
                                affirmVC.affirmModel.order_sn = orderDic[@"order_sn"];
                                affirmVC.affirmModel.route_type = orderDic[@"route_type"];
                                [self.navigationController pushViewController:affirmVC animated:YES];
                            }
                            
                        }
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        [[LXAlterView sharedMyTools] createTishi:[NSString stringWithFormat:@"%@",error.domain]];
                    }];
                }
            } else {
                //            [[LXAlterView sharedMyTools] createTishi:@"请添加出游人或联系人信息"];
//                if (self.orderModel.adule == 1 && self.peopleDicArray.count < 1) {
//                    [[LXAlterView sharedMyTools] createTishi:@"至少选择1位常用游客"];
//                    return;
//                }else if (self.orderModel.adule >= 2 && self.peopleDicArray.count < 2) {
//                    [[LXAlterView sharedMyTools] createTishi:@"至少选择2位常用游客"];
//                    return;
//                }else
                
                if (self.nextView.nameField.text.length == 0) {
                    [[LXAlterView sharedMyTools] createTishi:@"请添加联系人姓名"];
                    return;
                } else if (self.nextView.teleField.text.length == 0) {
                    [[LXAlterView sharedMyTools] createTishi:@"请添加联系人手机"];
                    return;
                }else if (!isTeleRight) {
                    [[LXAlterView sharedMyTools] createTishi:@"请输入正确的手机号"];
                    
                    return;
                    
                }
            }
        }
    }
    
        
}
//异常
-(void)gry:(UITapGestureRecognizer *)tap
{
    self.downView.triangleImage.image = [UIImage imageNamed:@"订单明细按钮-上"];
    [self.grayView removeFromSuperview];
    [self.costView removeFromSuperview];
    self.scrollView.alpha = 1.0;

}

#pragma mark ---时间戳转换成时间字符串
-(NSString *)getDateStr:(NSString *)date
{
    NSString *str=date;//时间戳
    NSTimeInterval time=[str doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //    NSLog(@"date:%@",detaildate);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    //    DLog(@"开始时间===%@",currentDateStr);
    return currentDateStr;
}


#pragma mark *******TableView的数据源代理 ********
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_pCount <= 2 && self.dataArray.count) {
        return _pCount + 1;
    }else if(_pCount <= 2 && self.dataArray.count != 0){
        return self.dataArray.count + 1;
    }else if(_pCount > 2 && self.dataArray.count == 0){
        return 3;
    }else if(_pCount > 2 && self.dataArray.count != 0){
        return self.dataArray.count + 1;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        //出游人信息
        UILabel *infoLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 35, 0, UISCREEN_WIDTH / 5, UISCREEN_HEIGHT / 14)];
        infoLable.text = @"出游人信息";
        infoLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
        [cell addSubview:infoLable];
        
        UILabel *limitLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(infoLable.frame) + 8 , CGRectGetMinY(infoLable.frame), UISCREEN_WIDTH / 2.7, UISCREEN_HEIGHT / 14)];
        
        if (self.orderModel.adule <= 1) {
            limitLable.text = @"填写一位出游人即可";
        }else{
            limitLable.text = @"填写两位出游人即可";
        }
        
        limitLable.textColor = [UIColor grayColor];
        limitLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];

        
        
        UIImageView *pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(limitLable.frame) + UISCREEN_WIDTH / 8, UISCREEN_WIDTH / 32, UISCREEN_WIDTH / 16, UISCREEN_WIDTH / 16.8)];
       
        pictureView.image = [UIImage imageNamed:@"常用游客"];
        [cell addSubview:pictureView];
        UILabel *commenLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(pictureView.frame) + 5, CGRectGetMinY(limitLable.frame), UISCREEN_WIDTH / 6, UISCREEN_HEIGHT / 14)];
        commenLable.textColor = [UIColor orangeColor];
        commenLable.text = @"常用游客";
        commenLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
        [cell addSubview:commenLable];
        
        UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 35, UISCREEN_HEIGHT / 13.5 - 1, UISCREEN_WIDTH, 1)];
        lineLable.alpha = 0.3;
        lineLable.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:lineLable];

        
    }else{
        
        self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 35, 0, UISCREEN_WIDTH - UISCREEN_WIDTH / 35, UISCREEN_HEIGHT / 13.5)];
        self.nameLable.font = [UIFont systemFontOfSize:UISCREEN_WIDTH / 26];
        self.nameLable.textColor = [UIColor grayColor];
        [cell addSubview:self.nameLable];
        
        if (_pCount <= 2 && self.dataArray.count == 0) {
            
            self.nameLable.text = [NSString stringWithFormat:@"出游人%ld",indexPath.row];
            
            
        }else if(_pCount <= 2 && self.dataArray.count != 0){
            
            CYYLModel *model = self.dataArray[indexPath.row -1 ];
            self.nameLable.text = [NSString stringWithFormat:@"%@",model.to_username];
            
        }else if(_pCount > 2 && self.dataArray.count == 0){
            
            self.nameLable.text = [NSString stringWithFormat:@"出游人%ld",indexPath.row];
            
        }else if(_pCount > 2 && self.dataArray.count != 0){
            
            CYYLModel *model = self.dataArray[indexPath.row -1 ];
            
            self.nameLable.text = [NSString stringWithFormat:@"%@",model.to_username];
            
        }
        
        UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(UISCREEN_WIDTH / 35, UISCREEN_HEIGHT / 13.5 - 0.8, UISCREEN_WIDTH, 1)];
        lineLable.alpha = 0.3;
        lineLable.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:lineLable];

        
    }
    return cell;
    
}
#pragma mark ********返回行高*-********
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UISCREEN_HEIGHT / 13.5;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if ([[WLSingletonClass defaultWLSingleton] wlUserType]==WLMemberTypeNone) {
        
        
        if (UISCREEN_HEIGHT == 736) {
            cancelTitleViewWidth = 334;
            cancelTitleViewHeight = 166;
            cancelTitleViewX = UISCREEN_WIDTH/2 - 334/2;
            cancelTitleViewY = UISCREEN_HEIGHT/2 - 166/2;
        } else if (UISCREEN_HEIGHT == 667) {
            cancelTitleViewWidth = 300;
            cancelTitleViewHeight = 150;
            cancelTitleViewX = UISCREEN_WIDTH/2 - 300/2;
            cancelTitleViewY = UISCREEN_HEIGHT/2 - 150/2;
        } else if (UISCREEN_HEIGHT < 569) {
            cancelTitleViewWidth = 254;
            cancelTitleViewHeight = 128;
            cancelTitleViewX = UISCREEN_WIDTH/2 - 254/2;
            cancelTitleViewY = UISCREEN_HEIGHT/2 - 128/2;
        }
        
        self.cancelBackView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _cancelBackView.backgroundColor = [UIColor blackColor];
        _cancelBackView.alpha = 0.5;
        
        self.cancelTitleView = [[TravelCancelTitleView alloc]initWithFrame:CGRectMake(cancelTitleViewX, cancelTitleViewY, cancelTitleViewWidth, cancelTitleViewHeight)];
        self.cancelTitleView.titleLabel.text = @"温馨提示";
        self.cancelTitleView.secondLitleLable.text = @"请先登录再进行此操作!";
        [self.cancelTitleView.leftButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancelTitleView.rightButton setTitle:@"确认" forState:UIControlStateNormal];
        self.cancelTitleView.backgroundColor = [UIColor whiteColor];
        self.cancelTitleView.layer.masksToBounds = YES;
        self.cancelTitleView.layer.cornerRadius = 5;
        
        //添加事件
        //让我想想按钮
        [self.cancelTitleView.leftButton addTarget:self action:@selector(cancelLogin:) forControlEvents:UIControlEventTouchUpInside];
        
        //确定取消
        [self.cancelTitleView.rightButton addTarget:self action:@selector(goonLogin:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.navigationController.view addSubview:_cancelBackView];
        [self.navigationController.view addSubview:self.cancelTitleView];

        
    } else {
        
    
    CYYkViewController *cyykVC = [[CYYkViewController alloc]init];
    
    cyykVC.travelerCount = self.orderModel.adule;
    
    //出游人信息数组初始化
//    self.peopleDicArray = [NSMutableArray array];
    
    cyykVC.sendBlock = ^ (NSArray *passArr) {
        
        
        self.dataArray = [NSMutableArray arrayWithArray:passArr];
        
        [self layoutView];
        
        for (CYYLModel *model in passArr) {
            //缺少此行代码导致订单页出游人数与出游人信息不符
            self.peopleDicArray = nil;
            NSDictionary *peopleDic = @{@"to-id":model.to_id,@"t-name":model.to_username,@"t-tel":model.phone,@"t-zj":model.id_type,@"t-zjnum":model.id_number,@"t-sex":@"1"};
            
#pragma mark 把出游人信息添加到出游人数组里面
            
            [self.peopleDicArray addObject:peopleDic];
        }
        
        self.scrollView.contentSize = CGSizeMake(0, UISCREEN_HEIGHT + self.peopleDicArray.count * UISCREEN_HEIGHT / 13.5);
        
        [self.tableView reloadData];
        
    };
    
    UINavigationController *navigationNC = [[UINavigationController alloc]initWithRootViewController:cyykVC];
    cyykVC.orderModel = [[TravelOrderDetailModel alloc]init];
    cyykVC.orderModel = self.orderModel;
    
    [self presentViewController:navigationNC animated:YES completion:nil];
    }
    
}

#pragma mark ---- 取消按钮方法 ----
- (void)cancelLogin:(UIButton *)sender {
    [self.cancelTitleView removeFromSuperview];
    [self.cancelBackView removeFromSuperview];
}

#pragma mark ---- 确定登录方法 ----
- (void)goonLogin:(UIButton *)sender {
    [self.cancelBackView removeFromSuperview];
    [self.cancelTitleView removeFromSuperview];
    LoginAndRegisterViewController *loginVC = [[LoginAndRegisterViewController alloc]init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark ---时间字符串转时间戳
-(NSString *)getTimestampWithStr:(NSString *)dateStr
{
    NSDate *date = [self getDateWithStr:dateStr];
    NSString *timeint=[NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    return timeint;
}

#pragma mark 字符串转NSDate
-(NSDate *)getDateWithStr:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [dateFormatter dateFromString:dateStr];
    return date;
}

#pragma mark ***********TextFieldDelegate,用来控制键盘********

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    return YES;
}

//当键盘出现或改变时调用
- (void)keyboardShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    self.downView.frame = CGRectMake(0, UISCREEN_HEIGHT - 64 - UISCREEN_HEIGHT / 14-height, UISCREEN_WIDTH, UISCREEN_HEIGHT /14);

        self.scrollView.contentSize = CGSizeMake(0, UISCREEN_HEIGHT + (self.peopleDicArray.count + 4) * UISCREEN_HEIGHT / 13.5);
    self.scrollView.contentOffset = CGPointMake(_scrollView.frame.origin.x, _tableView.frame.origin.y + _tableView.frame.size.height);
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    return YES;
}

//当键盘隐藏的时候
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.downView.frame = CGRectMake(0, UISCREEN_HEIGHT - 64 - UISCREEN_HEIGHT / 14, UISCREEN_WIDTH, UISCREEN_HEIGHT / 14);
    self.scrollView.contentSize = CGSizeMake(0, UISCREEN_HEIGHT + (self.peopleDicArray.count + 2) * UISCREEN_HEIGHT / 13.5);
    self.scrollView.contentOffset = CGPointMake(_scrollView.frame.origin.x, _scrollView.frame.origin.y);
    
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
     self.scrollView.contentSize = CGSizeMake(0, UISCREEN_HEIGHT + (self.peopleDicArray.count + 2) * UISCREEN_HEIGHT / 13.5);
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.origin.x, [textField superview].frame.origin.y);
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTextFile)];
    [self.scrollView addGestureRecognizer:_tap];
}

#pragma mark *******隐藏键盘的操作************
-(void)hideTextFile
{
    
    UITextField *nameField = (UITextField *)[self.nextView viewWithTag:502];
    UITextField *teleField = (UITextField *)[self.nextView viewWithTag:503];
    [nameField resignFirstResponder];
    [teleField resignFirstResponder];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    self.scrollView.contentSize = CGSizeMake(0, UISCREEN_HEIGHT + (self.peopleDicArray.count) * UISCREEN_HEIGHT / 13.5);
    [self.scrollView removeGestureRecognizer:_tap];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
//    self.nextView = (NexttView *)[self.scrollView viewWithTag:501];
    if (textField == self.nextView.teleField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    
    return YES;
}

-(BOOL)checkTelNumber:(NSString *) telNumber
{
    //^1(3[0-9]|4[57]|5[012356789]|8[0-9]|7[0-7])\\d{8}$
    //手机号以13， 15，18开头，八个 \d 数字字符
    //NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *phoneRegex = @"^1(3[0-9]|4[57]|5[012356789]|8[0-9]|7[0-7])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:telNumber];
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
