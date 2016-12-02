//
//  ViewController.m
//  DownloadAndScroll
//
//  Created by dn210 on 16/12/1.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "DownLoadCell.h"
#import "GameCell.h"
#import "DownloadModel.h"


//屏幕的长度(固定值)
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

//1-上面的播放View
@property (nonatomic,weak)UIView *playView;

//2-冲刺按钮
@property (nonatomic,weak)UIButton *runButton;

//3-普通按钮
@property (nonatomic,weak)UIButton *normalButton;

//4-挑战按钮
@property (nonatomic,weak)UIButton *challeageButton;

//5-collectionView的flowLayout
@property (nonatomic,weak)UICollectionViewFlowLayout *flowLayout;

//6-collectionView
@property (nonatomic,weak)UICollectionView *homeCollectionView;

//7-加载数据的数组
@property (nonatomic,strong)NSMutableArray<DownloadModel *> *mDataArray;


@end

@implementation ViewController

static NSString *DownloadIdentifier = @"DownLoadCell";

static NSString *GameIdentifier = @"GameCell";


-(NSMutableArray<DownloadModel *> *)mDataArray
{
    if (_mDataArray == nil)
    {
        _mDataArray = [NSMutableArray array];
        
        DownloadModel *model1 = [[DownloadModel alloc] initWithAlpha:YES andGameNum:@""];
        
        [_mDataArray addObject:model1];
        
        for (NSInteger i = 1; i <= 3; i++)
        {
            DownloadModel *model = [[DownloadModel alloc] initWithAlpha:NO andGameNum:[NSString stringWithFormat:@"%ld",i]];
            
            [_mDataArray addObject:model];
        }
    }
    
    return _mDataArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设计UI
    [self setUpUI];
    
    //设置位于中下部的collectionView
    [self setUpCollectionView];
    
    //接收通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(MoveCollection) name:@"ScrollMove" object:nil];
    
}


//接收通知运动
-(void)MoveCollection
{
        
        //2-Download界面慢慢消失
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        
    DownLoadCell * firstCell = (DownLoadCell *)[self.homeCollectionView cellForItemAtIndexPath:firstIndexPath];
    
        
    self.mDataArray[0].isAlpha = NO;
    
    for (NSInteger i = 1; i <= 3 ; i++)
    {
        self.mDataArray[i].isAlpha = YES;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
    
    GameCell *nextCell = (GameCell *)[self.homeCollectionView cellForItemAtIndexPath:indexPath];
    
    
    
    [UIView animateWithDuration:0.5 animations:^{
       
       
        [self.homeCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        firstCell.alpha = 0;
    
        nextCell.contentView.alpha = 1;
        
        nextCell.userInteractionEnabled = YES;
        
        
        
    } completion:^(BOOL finished) {
        
        [self.homeCollectionView reloadData];
    }];
    
}


-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


//设计UI
-(void)setUpUI
{
    
    //背景色
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    //1-上面的播放播放View
    UIView *playView = [[UIView alloc] init];
    
    self.playView = playView;
    
    playView.backgroundColor = [UIColor whiteColor];
    
    playView.alpha = 0.5;
    
    [self.view addSubview:playView];
    
    [playView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.view).offset(64);
        make.leading.trailing.equalTo(self.view);
        make.height.equalTo(@80);
    }];
    
    //2-3个按钮
    //2.1 冲刺按钮
    UIButton *runButton = [[UIButton alloc] init];
    
    self.runButton = runButton;
    
    [runButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [runButton setTitle:@"冲刺" forState:UIControlStateNormal];
    
    [runButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    [self.view addSubview:runButton];
    
    [runButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(playView.mas_bottom).offset(20);
    }];
    
    //2.2 普通按钮
    UIButton *normalButton = [[UIButton alloc] init];
    
    self.normalButton = normalButton;
    
    [normalButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [normalButton setTitle:@"普通" forState:UIControlStateNormal];
    
    [normalButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    [self.view addSubview:normalButton];
    
    [normalButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(runButton.mas_leading).offset(-70);
        make.top.equalTo(playView.mas_bottom).offset(20);
    }];
    
    //2.3 挑战按钮
    UIButton *challeageButton = [[UIButton alloc] init];
    
    self.challeageButton = challeageButton;
    
    [challeageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [challeageButton setTitle:@"挑战" forState:UIControlStateNormal];
    
    [challeageButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    
    [self.view addSubview:challeageButton];
    
    [challeageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(runButton.mas_trailing).offset(70);
        make.top.equalTo(playView.mas_bottom).offset(20);
    }];
    
}

//设置位于中下部的collectionView
-(void)setUpCollectionView
{
    //(1)实例化一个流水型布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.flowLayout = flowLayout;

    
    //设置列间距
    flowLayout.minimumLineSpacing = 50;
    
    
    //设置内边距
    flowLayout.sectionInset = UIEdgeInsetsMake(10, kScreenWidth/2 - 180/2, 0, 50);
    
    
    //设置cell的滚动方向(默认为垂直方向)
    //滚动方向改变之后,行内距和列内距设置就相反了
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //(2)利用flowLayout来实例化一个collectionView
    //暂时把frame设置为zero，待会利用手动方式设置Auto Layout
    UICollectionView *homeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    //设置背景
    homeCollectionView.backgroundColor = [UIColor clearColor];
    
    self.homeCollectionView = homeCollectionView;
    
    homeCollectionView.pagingEnabled = NO;
    homeCollectionView.bounces = NO;
    homeCollectionView.showsHorizontalScrollIndicator = NO;
    
    
    [self.view addSubview:homeCollectionView];
    
    
    //(3)设置collectionView的layout
    [homeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.runButton.mas_bottom).offset(20);
        make.bottom.equalTo(self.view).offset(0);
    }];
    
    
    
    homeCollectionView.dataSource = self;
    
    homeCollectionView.delegate = self;
    
    
    
    [homeCollectionView registerClass:[DownLoadCell class] forCellWithReuseIdentifier:DownloadIdentifier];
    
    [homeCollectionView registerClass:[GameCell class] forCellWithReuseIdentifier:GameIdentifier];
}
//布局子控件时设置flowLayout
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.flowLayout.itemSize = CGSizeMake(180, 250);
}

//实现collectionView的数据源方法
//1-组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//2-item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.mDataArray.count;
}

//3-item内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.item == 0)
    {
       DownLoadCell *cell = (DownLoadCell *)[collectionView dequeueReusableCellWithReuseIdentifier:DownloadIdentifier forIndexPath:indexPath];
        
        //cell.gameCount = self.mDataArray[indexPath.item];
        cell.model = self.mDataArray[indexPath.item];
        return cell;
   }
    else
    {
       GameCell *cell = (GameCell *)[collectionView dequeueReusableCellWithReuseIdentifier:GameIdentifier forIndexPath:indexPath];
        
        //cell.gameCount = self.mDataArray[indexPath.item];
        cell.model = self.mDataArray[indexPath.item];
        
        return cell;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
