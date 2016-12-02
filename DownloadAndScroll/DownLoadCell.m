//
//  DownLoadCell.m
//  DownloadAndScroll
//
//  Created by dn210 on 16/12/1.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "DownLoadCell.h"
#import "Masonry.h"


@interface DownLoadCell()

//下载进度条
@property (nonatomic,weak)UIView *downLoadLineView;

//下载按钮
@property (nonatomic,weak)UIButton *downLoadButton;

//下载显示的进度条
@property (nonatomic,weak)UIView *showLineView;


@end


@implementation DownLoadCell


//在此初始化方法内对cell进行设置
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setUpUI];
        
        
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    
    
    //1-下载按钮
    UIButton *downLoadButton = [[UIButton alloc] init];
    
    self.downLoadButton = downLoadButton;
    
    [downLoadButton setBackgroundImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    
    [downLoadButton sizeToFit];
    
    [self.contentView addSubview:downLoadButton];
    
    [downLoadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-20);
        
    }];
    
    //点击下载之后
    [downLoadButton addTarget:self action:@selector(Download) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    //2-下载进度条
    UIView *downLoadLineView = [[UIView alloc] init];
    
    self.downLoadLineView = downLoadLineView;
    
    downLoadLineView.backgroundColor = [UIColor lightGrayColor];
    
    [self.contentView addSubview:downLoadLineView];
    
    [downLoadLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.leading.trailing.equalTo(self.contentView);
        
        make.bottom.equalTo(self.contentView).offset(-100);
        
        make.height.equalTo(@2);
        
    }];
    
    
    //3-下载显示的进度条
    UIView *showLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 100 -2 ,0, 2)];
    
    self.showLineView = showLineView;
    
    showLineView.backgroundColor = [UIColor redColor];
    
    [self.contentView addSubview:showLineView];
    
    
}

-(void)setModel:(DownloadModel *)model
{
    _model = model;
    
    if (model.isAlpha == YES)
    {
        //初始时禁掉交互
        self.userInteractionEnabled = YES;
        
        //初始时为半透明
        self.alpha = 1;
    }
    else
    {
        //初始时禁掉交互
        self.userInteractionEnabled = NO;
        
        //初始时为半透明
        self.alpha = 0;
    }
}


//点击下载之后
-(void)Download
{
    
    //1-进度条显示正在下载
    [UIView animateWithDuration:1 animations:^{
        
        
        CGRect showDownRect = self.showLineView.frame;
        
        showDownRect.size.width = self.contentView.frame.size.width;
        
        self.showLineView.frame = showDownRect;
        
        
    } completion:^(BOOL finished) {
        
        //发通知通知当前cell移动
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ScrollMove" object:self userInfo:nil];
    }];
    
    
}
@end
