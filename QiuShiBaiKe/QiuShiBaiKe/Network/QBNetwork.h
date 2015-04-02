//
//  QBNetwork.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QBNetworkGlobalData.h"
#import "QBDownloadQiuShiDelegate.h"
#import "QBQiuShiItem.h"
#import "QBUserInfo.h"
#import "QBVoteInfo.h"

@interface QBNetwork : NSObject<QBDownloadQiuShiDelegate>

+(QBNetwork*) sharedNetwork;

@property (nonatomic, weak) id<QBDownloadQiuShiDelegate> delegate;

@property (nonatomic, readonly) BOOL isLoading;


-(NSArray*) getQiuShiListWithPage:(int) page;

- (void) getQiuShiListWithPageAsync:(int) page;

@end
