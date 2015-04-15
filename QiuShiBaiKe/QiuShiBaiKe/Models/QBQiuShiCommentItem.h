//
//  QBQiuShiCommentItem.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-15.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QBUserInfo;

@interface QBQiuShiCommentItem : NSObject

@property (copy, nonatomic) NSString *content;

@property (strong, nonatomic) QBUserInfo *userInfo;

@property (copy, nonatomic) NSString *id;

@property (assign, nonatomic) int floor;

- (instancetype) initWithDictionary:(NSDictionary*) data;

@end
