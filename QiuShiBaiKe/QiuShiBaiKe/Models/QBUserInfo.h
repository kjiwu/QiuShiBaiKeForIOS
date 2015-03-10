//
//  QBUserInfo.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBUserInfo : NSObject

@property (strong, nonatomic) NSString* loginName;

@property (strong, nonatomic) NSString* header;

@property (strong, nonatomic) NSString* userId;

@property (strong, nonatomic) NSString* lastDevice;

@property (strong, nonatomic) NSString* state;

-(instancetype) initWithDictionary: (NSDictionary*) data;

@end
