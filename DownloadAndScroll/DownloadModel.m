//
//  DownloadModel.m
//  DownloadAndScroll
//
//  Created by dn210 on 16/12/2.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import "DownloadModel.h"

@implementation DownloadModel

-(instancetype)initWithAlpha:(BOOL)alpha andGameNum:(NSString *)gameNum
{
    if (self = [super init])
    {
        _isAlpha = alpha;
        
        _gameNum = gameNum;
    }
    
    return self;
}


@end
