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
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL: url cachePolicy: NSURLRequestReloadIgnoringLocalCacheData timeoutInterval: -1];
    
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
    
    NSArray *qiushi =[items objectForKey: @"items"];
    
    NSMutableArray *qiushiItems = [[NSMutableArray alloc] init];
    for(int i = 0; i < qiushi.count; i++){
        NSDictionary *item = [qiushi objectAtIndex: i];
        QBQiuShiItem *qiushiItem = [[QBQiuShiItem alloc] initWithDictionary: item];
        [qiushiItems addObject: qiushiItem];
    }
    
    return [qiushiItems copy];
}

@end
