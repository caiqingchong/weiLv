//
//  JYCDishDetailVC.m
//  WelLv
//
//  Created by lyx on 15/11/17.
//  Copyright (c) 2015年 WeiLvTechnology. All rights reserved.
//

#import "JYCDishDetailVC.h"
#import "UIImageView+WebCache.h"
#import "CollectionViewCell.h"
#import "JYCOrderVC.h"
#import "DishModel.h"
#define BannerHegit 150*HeightScale

@interface JYCDishDetailVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UILabel *disPlayLabel;
    UIView *line;
    UILabel *leftLabel;
    AFHTTPRequestOperationManager *manager;
    NSString *str2;
    
}
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UILabel *totaleNumebr;
@property(nonatomic,strong)UIButton *minusBtn;
@property(nonatomic,strong)UIButton *plusBtn;
@property(nonatomic,strong)NSMutableArray *image1;
@property(nonatomic,strong)NSMutableArray *image2;
@property(nonatomic,strong)NSMutableArray *image3;
@property(nonatomic,strong)NSMutableArray *image;
@end

@implementation JYCDishDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    _image1=[[NSMutableArray alloc]init];
    _image2=[[NSMutableArray alloc]init];
    _image3=[[NSMutableArray alloc]init];
    _image=[[NSMutableArray alloc]init];
    NSLog(@"%d",self.model.total);
    [self initData];
   
}
-(void)initData
{
    NSDictionary *dict=@{@"product_id":self.model.userid};
    NSLog(@"%@",dict);
    NSString *url=[DishDetailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self sendWith:url dict:dict];

}

-(void)sendWith:(NSString *)url dict:(NSDictionary *)dict
{
    manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"state"]integerValue]==1) {
          //  [_hud hide:YES];
            
            NSMutableDictionary *dict2=[[NSMutableDictionary alloc]init];
            dict2=dict[@"data"];
                NSLog(@"++++++%@",dict2);
           NSString *str=dict2[@"images"];
           str2=dict2[@"ingredients_images"];
               
           self.image1=[[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:str]
                    ;

          if ([self judgeString:str2]) {
            self.image2=[[WLSingletonClass defaultWLSingleton] wlJsonStringToDicOrArr:str2];
            for (id obj in self.image2) {
                imageModel *model=[[imageModel alloc]init];
                [model setValuesForKeysWithDictionary:obj];
                [self.image3 addObject:model];
                    }
                }
        [self createTopImage];
        [self.collectionView reloadData];
        }else {
            [[LXAlterView sharedMyTools]createTishi:@"刷新失败"];
           
            //[_hud hide:YES];
        

    }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

    }];
}


-(void)createTopImage
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, 150)];
   NSString *str=[NSString stringWithFormat:@"%@/%@",WLHTTP,self.image1[0]];
   
    [imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"default_bg_view_750_400"]];
    [self.view addSubview:imageView];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
   // [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget: self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    disPlayLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(imageView), windowContentWidth, 40)];
    disPlayLabel.text=@"食材展示";
    disPlayLabel.textColor=[UIColor blackColor];
    disPlayLabel.font=systemFont(18);
    [self.view addSubview:disPlayLabel];
    [self createCollectionView];
    
}
-(void)createCollectionView
{
   UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, ViewBelow(disPlayLabel), windowContentWidth, 110)collectionViewLayout:layout];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    //cell 的固定大小
   // layout.itemSize = CGSizeMake((windowContentWidth-30)/2, 150);
    //两个cell 之间 水平和竖直最小间隔0
    //layout.minimumInteritemSpacing = 10;
    //layout.minimumLineSpacing = 10;
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor whiteColor];
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
    self.collectionView.showsHorizontalScrollIndicator=NO;
    self.collectionView.showsVerticalScrollIndicator=NO;
    //水平方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.view addSubview:self.collectionView];
    line=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(self.collectionView), windowContentWidth, 1)];
    line.backgroundColor=bordColor;
    [self.view addSubview:line];
    [self createBotomUI];
}
-(void)createBotomUI
{
    UIView *ViewBtn=[[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(line), windowContentWidth, 40)];
    [self.view addSubview:ViewBtn];
    UILabel *priceLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 40)];
    priceLabel.text=[NSString stringWithFormat:@"￥%0.1f",[self.model.price floatValue]];
    priceLabel.textColor=[UIColor redColor];
    priceLabel.font=systemFont(15);
    [ViewBtn addSubview:priceLabel];
    UILabel *originLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(priceLabel), 0, 50, 40)];
    originLabel.textColor=[UIColor grayColor];
    originLabel.text=[NSString stringWithFormat:@"￥%0.1f",[self.model.original_price floatValue]];
    originLabel.font=systemFont(12);
    originLabel.textAlignment=NSTextAlignmentCenter;
    [ViewBtn addSubview:originLabel];
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(0, ViewHeight(originLabel)/2, ViewWidth(originLabel), 1)];
    line2.backgroundColor=[UIColor grayColor];
    [originLabel addSubview:line2];
    
    UILabel *numberLabel=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(originLabel)+10, 0, 80, 40)];
    numberLabel.text=[NSString stringWithFormat:@"仅剩%@份",self.model.number];
    numberLabel.textColor=[UIColor orangeColor];
    numberLabel.font=systemFont(15);
    [ViewBtn addSubview:numberLabel];
    self.minusBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth-100, 7.5, 25, 25)];
    
    [self.minusBtn addTarget:self action:@selector(minusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [ViewBtn addSubview:self.minusBtn];
    self.totaleNumebr=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(self.minusBtn)+5, ViewY(self.minusBtn)+6.5, 30, 12)];
     self.totaleNumebr.textColor=[UIColor grayColor];
     self.totaleNumebr.textAlignment=1;
     self.totaleNumebr.text=[NSString stringWithFormat:@"%d",self.model.total];
     self.totaleNumebr.font=systemFont(12);
    [ViewBtn addSubview: self.totaleNumebr];
    if (self.model.total==0) {
       [self.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少不可用"]forState:UIControlStateNormal];
    }else if(self.model.total>0)
    {
    [self.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少可用"]forState:UIControlStateNormal];
    }
    UIButton *plusBtn=[[UIButton alloc]initWithFrame:CGRectMake(ViewRight( self.totaleNumebr)+5, ViewY(self.minusBtn), 25, 25)];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(plusBtn:) forControlEvents:UIControlEventTouchUpInside];
    [ViewBtn addSubview:plusBtn];
    UILabel *returnLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, ViewBelow(ViewBtn), 40, 18)];
    returnLabel.text=@"返佣:";
    returnLabel.font=systemFont(14);
    returnLabel.textColor=[UIColor grayColor];
    [self.view addSubview:returnLabel];
    UILabel *returnNum=[[UILabel alloc]initWithFrame:CGRectMake(ViewRight(returnLabel), ViewY(returnLabel), 60, 18)];
    returnNum.textColor=[UIColor greenColor];
    returnNum.text=[NSString stringWithFormat:@"￥%@",self.model.commission];
    returnNum.font=systemFont(14);
    [self.view addSubview:returnNum];
    UILabel *tishiLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, windowContentHeight-80, windowContentWidth-10, 40)];
    tishiLabel.textColor=[UIColor grayColor];
    tishiLabel.text=@"提示:该店家消费需要预定,订单超时或接单后退款将扣15%!";
    tishiLabel.numberOfLines=0;
    tishiLabel.font=systemFont(10);
    [self.view addSubview:tishiLabel];
   
    UIView *botomView=[[UIView alloc]initWithFrame:CGRectMake(0, windowContentHeight-40, windowContentWidth, 40)];
    botomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:botomView];
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth, 1)];
    line3.backgroundColor=bordColor;
    [botomView addSubview:line3];
    leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, windowContentWidth/2, 40)];
    leftLabel.text=[NSString stringWithFormat:@"￥%0.1f",0.0];
    leftLabel.textColor=[UIColor redColor];
    [botomView addSubview:leftLabel];
   
    UIButton *orderBtn=[[UIButton alloc]initWithFrame:CGRectMake(windowContentWidth/2, 0, windowContentWidth/2, 40)];
    orderBtn.backgroundColor=[UIColor orangeColor];
    [orderBtn addTarget:self action:@selector(orderBtn) forControlEvents:UIControlEventTouchUpInside];
    [orderBtn setTitle:@"立即预订" forState:UIControlStateNormal];
    [orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [botomView addSubview:orderBtn];
    
    
}
-(void)orderBtn
{
    NSLog(@"1111+++");
    JYCOrderVC *vc=[[JYCOrderVC alloc]init];
    vc.arr=self.arr;
    vc.type=2;
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)minusBtn:(UIButton *)btn
{
    if (self.model.total==0) {
        //[self.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少不可用"]forState:UIControlStateNormal];
        return;
    }
   NSUInteger a=[self.arr indexOfObject:self.model];
    --self.model.total;
    [self.arr replaceObjectAtIndex:a withObject:self.model];
    if (self.model.total==0) {
       [self.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少不可用"]forState:UIControlStateNormal];
    }
    self.totaleNumebr.text=[NSString stringWithFormat:@"%d",self.model.total];
    if (self.cell.cellBlock) {
        self.cell.cellBlock(self.model.total,self.model,self.model.indexPath1);
    }
    float title=0;
    title=[self.model.price floatValue] *self.model.total;
    leftLabel.text=[NSString stringWithFormat:@"￥%0.1f",title];
    
}
-(void)plusBtn:(UIButton *)btn
{
    if (self.model.total==0) {
         ++ self.model.total;
        [self.arr removeAllObjects];
        [self.arr addObject:self.model];
        
    }else if(self.model.total>0){
    NSUInteger a=[self.arr indexOfObject:self.model];
       ++ self.model.total;
        
   
   [self.arr replaceObjectAtIndex:a withObject:self.model];
}
    float title=0;
    title=[self.model.price floatValue] *self.model.total;
    leftLabel.text=[NSString stringWithFormat:@"￥%0.2f",title];
    if (self.model.total>0) {
        [self.minusBtn setBackgroundImage:[UIImage imageNamed:@"减少可用"]forState:UIControlStateNormal];
    }

        self.totaleNumebr.text=[NSString stringWithFormat:@"%d",self.model.total];
    if (self.cell.cellBlock) {
        self.cell.cellBlock(self.model.total,self.model,self.model.indexPath1);
    }
}
#pragma mark -  <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self judgeString:str2]) {
        return self.image3.count;
    }
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
   
    if ([self judgeString:str2]) {
    imageModel *model=[[imageModel alloc]init];
    model=self.image3[indexPath.row];
    //NSLog(@"%@",model);
    NSString *str=[NSString stringWithFormat:@"%@/%@",WLHTTP,model.src];
    NSLog(@"%@",model.src);
    [cell1.imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    
    cell1.nameLabel.text = [NSString stringWithFormat:@"%@",model.describe];
    return cell1;
    }
    [cell1.imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"默认图3"]];
    cell1.nameLabel.text=@"";
    return cell1;
}

// 指定每一个item的大小, 这个代理方法会覆盖layout.itemSize = CGSizeMake(170, 120)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((windowContentWidth-30)/2, 110);
}


-(void)click
{
    self.navigationController.navigationBarHidden=NO;
    [self.navigationController popViewControllerAnimated:YES];
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
