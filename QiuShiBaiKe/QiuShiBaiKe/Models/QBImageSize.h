//
//  QBImageSize.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-1.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QBImageSize : NSObject

@property (nonatomic, assign) CGSize smallSize;

@property (nonatomic, assign) CGSize bigSize;

- (instancetype) initWithDictionary:(NSDictionary*) data;

@end
