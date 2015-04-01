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
#import "QBImageSize.h"

@class QBUserInfo, QBVoteInfo;

@interface QBQiuShiItem : NSObject

@property (strong, nonatomic) NSString* itemId;

@property (strong, nonatomic) NSString* image;

@property (assign, nonatomic) BOOL haveImage;

@property (assign, nonatomic) BOOL allowComment;

@property (assign, nonatomic) int commentCount;

@property (strong, nonatomic) QBUserInfo *user;

@property (strong, nonatomic) QBVoteInfo *vote;

@property (strong, nonatomic) NSString* content;

@property (strong, nonatomic) QBImageSize *imageSize;

-(instancetype) initWithDictionary: (NSDictionary*) data;

@end
