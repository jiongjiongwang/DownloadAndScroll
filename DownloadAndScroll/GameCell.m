//
//  GameCell.m
//  DownloadAndScroll
//
//  Created by dn210 on 16/12/1.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "GameCell.h"
#import "Masonry.h"

@interface GameCell()

@property (nonatomic,weak)UIView *starView;

@property (nonatomic,weak)UILabel *gameLabel;

@end

@implementation GameCell


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
    
    //1-下面的View
    UIView *starView = [[UIView alloc] init];
    
    self.starView = starView;
    
    
    starView.backgroundColor = [UIColor greenColor];
    
    [self.contentView addSubview:starView];
    
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.leading.trailing.bottom.equalTo(self.contentView);
        
        make.top.equalTo(self.contentView.mas_bottom).offset(-100);
        
    }];
    
    //2-上面的label
    UILabel *gameLabel = [[UILabel alloc] init];
    
    self.gameLabel = gameLabel;
    
    [gameLabel setTextAlignment:NSTextAlignmentCenter];
    
    [gameLabel setFont:[UIFont systemFontOfSize:25]];
    
    //[gameLabel setText:_gameCount];
    
    [self.contentView addSubview:gameLabel];
    
    [gameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.contentView.mas_centerX);
        
        make.centerY.equalTo(self.contentView.mas_centerY);
        
    }];
    
}


-(void)setModel:(DownloadModel *)model
{
    _model = model;
    
    if (model.isAlpha == 1)
    {
        //初始时禁掉交互
        self.userInteractionEnabled = YES;
        
        //初始时为半透明
        self.contentView.alpha = 1;
    }
    else
    {
        //初始时禁掉交互
        self.userInteractionEnabled = NO;
        
        //初始时为半透明
        self.contentView.alpha = 0.2;
    }
    
    [self.gameLabel setText:model.gameNum];
}



@end
