//
//  QBQiuShiItem.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QBUserInfo.h"
#import "QBVoteInfo.h"

@class QBUserInfo, QBVoteInfo;

@interface QBQiuShiItem : NSObject

@property (strong, nonatomic) NSString* itemId;

@property (strong, nonatomic) NSString* image;

@property (assign) BOOL allowComment;

@property (assign) int commentCount;

@property (strong, nonatomic) QBUserInfo* user;

@property (strong, nonatomic) QBVoteInfo* vote;

@property (strong, nonatomic) NSString* content;

-(instancetype) initWithDictionary: (NSDictionary*) data;

@end
