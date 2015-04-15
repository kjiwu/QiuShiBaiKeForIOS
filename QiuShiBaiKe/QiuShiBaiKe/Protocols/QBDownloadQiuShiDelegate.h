//
//  QBDownloadQiuShiDelegate.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-31.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol QBDownloadQiuShiDelegate<NSObject>

@optional
- (void) downloadQiuShiCompleted: (NSArray*) items;
- (void) downloadCommentCompleted:(NSArray *)items;

@end