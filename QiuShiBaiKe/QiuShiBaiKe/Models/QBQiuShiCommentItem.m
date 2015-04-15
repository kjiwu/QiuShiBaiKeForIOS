//
//  QBQiuShiCommentItem.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-15.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBQiuShiCommentItem.h"
#import "QBUserInfo.h"


@interface QBQiuShiCommentItem ()

@end


@implementation QBQiuShiCommentItem

- (instancetype) initWithDictionary:(NSDictionary *)data {
    self = [super init];
    
    if(self) {
        self.content = [data objectForKey:@"content"];
        self.userInfo = [[QBUserInfo alloc] initWithDictionary:[data objectForKey:@"user"]];
        self.id = [data objectForKey:@"id"];
        self.floor = (int)[[data objectForKey:@"floor"] integerValue];
    }
    
    return  self;
}

@end
