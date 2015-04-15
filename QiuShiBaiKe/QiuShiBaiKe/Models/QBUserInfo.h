//
//  QBUserInfo.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBUserInfo : NSObject

@property (copy, nonatomic) NSString* loginName;

@property (copy, nonatomic) NSString* header;

@property (copy, nonatomic) NSString* userId;

@property (copy, nonatomic) NSString* lastDevice;

@property (copy, nonatomic) NSString* state;

-(instancetype) initWithDictionary: (NSDictionary*) data;

@end
