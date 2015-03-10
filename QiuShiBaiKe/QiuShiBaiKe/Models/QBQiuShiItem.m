//
//  QBQiuShiItem.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBQiuShiItem.h"
#import "QBUserInfo.h"
#import "QBVoteInfo.h"

@implementation QBQiuShiItem

@synthesize allowComment, itemId, image, commentCount, user, vote, content;

-(instancetype) initWithDictionary: (NSDictionary *)data {
    
    itemId = [data objectForKey: @"id"];
    image = [data objectForKey: @"image"];
    allowComment = [[data objectForKey: @"allow_comment"] integerValue] == 1 ? YES : NO;
    commentCount = (int)[[data objectForKey: @"comments_count"] integerValue];
    content = [data objectForKey: @"content"];
    user = [[QBUserInfo alloc] initWithDictionary: [data objectForKey: @"user"]];
    vote = [[QBVoteInfo alloc] initWithDictionary: [data objectForKey: @"vote"]];
    
    return self;
}

-(NSString*) description {
    return [NSString stringWithFormat: @"[item id:%@ image:%@ content:%@ user:%@ vote:%@]", itemId, image, content, user, vote];
}

@end
