//
//  QBItemTouchDelegate.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-14.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#ifndef QiuShiBaiKe_QBItemTouchDelegate_h
#define QiuShiBaiKe_QBItemTouchDelegate_h

#import <Foundation/Foundation.h>

@class QBQiuShiItem;

@protocol QBItemTouchDelegate <NSObject>

@optional

- (void) commentTouched:(id)sender withQiuShiItem:(QBQiuShiItem*) item;

- (void) upOrDownTouched:(id)sender withQiuShiItem:(QBQiuShiItem*) item;

@end

#endif
