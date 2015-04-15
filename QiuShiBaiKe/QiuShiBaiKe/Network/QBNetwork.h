//
//  QBNetwork.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBDownloadQiuShiDelegate.h"

@interface QBNetwork : NSObject<QBDownloadQiuShiDelegate>

+(QBNetwork*) sharedNetwork;

@property (nonatomic, weak) id<QBDownloadQiuShiDelegate> delegate;

@property (nonatomic, readonly) BOOL isLoading;


-(NSArray*) getQiuShiListWithPage:(int) page;

- (void) getQiuShiListWithPageAsync:(int) page;


-(void) qiushiCommentsWithId:(NSString*)id;

@end
