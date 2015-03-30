//
//  QBNetwork.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBNetwork.h"

@interface QBNetwork()

@end

@implementation QBNetwork


+(QBNetwork*) sharedNetwork {
    
    static dispatch_once_t onceToken;
    static QBNetwork* sharedNetwork;
    
    dispatch_once(&onceToken, ^{
        sharedNetwork = [[QBNetwork alloc] init];
    });
    
    return sharedNetwork;
    
}

-(NSArray*) getQiuShiList {
    
    NSString* urlStr = [NSString stringWithFormat:QiuShiBaiKe_GetData, [NSNumber numberWithInt: 1], [NSNumber numberWithInt:QiuShiBaiKe_GetCount]];
    NSURL* url = [NSURL URLWithString: urlStr];
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL: url cachePolicy: NSURLRequestReloadIgnoringLocalCacheData timeoutInterval: 5];
    
    __autoreleasing NSError* error;
    __autoreleasing NSURLResponse* response;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &error];
    
    if(error) {
        NSLog(@"%@", error);
        return nil;
    }
    
    __autoreleasing NSError* jsonError;
    NSDictionary* items = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &jsonError];
    
    if(jsonError) {
        NSLog(@"%@", jsonError);
        return nil;
    }
    
    return [items objectForKey: @"items"];
}

@end
