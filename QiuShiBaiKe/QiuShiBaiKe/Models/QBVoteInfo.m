//
//  QBVoteInfo.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBVoteInfo.h"

@implementation QBVoteInfo

@synthesize down, up;

-(instancetype) initWithDictionary:(NSDictionary *)data {
    
    if([NSNull null] != (id)data) {
        down = (int)[[data objectForKey: @"down"] integerValue];
        up = (int)[[data objectForKey: @"up"] integerValue];
    }
    
    return self;
}

-(NSString*) description {
    return [NSString stringWithFormat: @"[vote down: %d, up: %d]", down, up];
}

@end
