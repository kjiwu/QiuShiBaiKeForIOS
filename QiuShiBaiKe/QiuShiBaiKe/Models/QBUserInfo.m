//
//  QBUserInfo.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBUserInfo.h"

#define Default_Header @"default.png";
#define Default_Name NSLocalizedString(@"Default_Username", nil)

@implementation QBUserInfo

@synthesize loginName, header, userId, lastDevice, state;

-(instancetype) initWithDictionary:(NSDictionary *)data {
    
    loginName  = Default_Name;
    header     = Default_Header;
    userId     = @"";
    lastDevice = @"";
    state      = 0;


    if([NSNull null] != (id)data) {
        loginName  = [data objectForKey: @"login"];
        header     = [data objectForKey: @"icon"];
        userId     = [data objectForKey: @"id"];
        lastDevice = [data objectForKey: @"last_device"];
        state      = [data objectForKey: @"state"];
    }

    return self;
}

-(NSString*) description {
    return [NSString stringWithFormat: @"[user id:%@ name:%@ image:%@ device:%@ state:%@]", userId, loginName, header, lastDevice, state];
}

@end
