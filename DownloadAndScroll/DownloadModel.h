//
//  DownloadModel.h
//  DownloadAndScroll
//
//  Created by dn210 on 16/12/2.
//  Copyright © 2016年 dn210. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadModel : NSObject

@property (nonatomic,assign)BOOL isAlpha;

@property (nonatomic,copy)NSString *gameNum;

-(instancetype)initWithAlpha:(BOOL)alpha andGameNum:(NSString *)gameNum;


@end
