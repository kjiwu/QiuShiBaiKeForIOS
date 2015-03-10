//
//  QBVoteInfo.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QBVoteInfo : NSObject

@property (assign) int down;

@property (assign) int up;

-(instancetype) initWithDictionary: (NSDictionary*) data;

@end
