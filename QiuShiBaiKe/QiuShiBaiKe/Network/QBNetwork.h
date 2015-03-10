//
//  QBNetwork.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBNetworkGlobalData.h"


@interface QBNetwork : NSObject

+(QBNetwork*) sharedNetwork;

-(NSArray*) getQiuShiList;

@end
