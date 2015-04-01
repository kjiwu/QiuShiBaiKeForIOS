//
//  QBImageSize.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-1.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBImageSize.h"

@implementation QBImageSize

@synthesize smallSize, bigSize;

- (instancetype) initWithDictionary:(NSDictionary*) data {
    
    NSArray *small = [data objectForKey: @"s"];
    NSArray *big = [data objectForKey: @"m"];
    
    smallSize = CGSizeMake([[small objectAtIndex:0] floatValue], [[small objectAtIndex:1] floatValue]);
    bigSize = CGSizeMake([[big objectAtIndex:0] floatValue], [[big objectAtIndex:1] floatValue]);
    
    return self;
}

@end
