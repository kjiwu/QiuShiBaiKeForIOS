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

@synthesize delegate;
@synthesize isLoading;


+(QBNetwork*) sharedNetwork {
    
    static dispatch_once_t onceToken;
    static QBNetwork* sharedNetwork;
    
    dispatch_once(&onceToken, ^{
        sharedNetwork = [[QBNetwork alloc] init];
    });
    
    return sharedNetwork;
    
}

-(NSArray*) getQiuShiListWithPage:(int) page {
    NSURL* url = [self getURLWithPage: page];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL: url cachePolicy: NSURLRequestReloadIgnoringLocalCacheData timeoutInterval: 5];
    
    __autoreleasing NSError* error;
    __autoreleasing NSURLResponse* response;
    
    isLoading = YES;
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error: &error];
    
    isLoading = NO;
    
    if(error) {
        NSLog(@"%@", error);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: error.description delegate: nil cancelButtonTitle: @"Cancel" otherButtonTitles:@"OK", nil];
        [alert show];
        return nil;
    }
    
    return [self qiushiWithData: data];
}

- (void) getQiuShiListWithPageAsync:(int) page {
    NSURL* url = [self getURLWithPage: page];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL: url cachePolicy: NSURLRequestReloadIgnoringLocalCacheData timeoutInterval: 5];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    
    isLoading = YES;
    
    [NSURLConnection sendAsynchronousRequest: request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        isLoading = NO;
        if(connectionError) {
            [self getQiuShiListWithPageAsync:page];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(delegate) {
                    [delegate downloadCompleted: [self qiushiWithData: data]];
                }
            });
        }
    }];
}

- (NSURL*) getURLWithPage:(int) page {
    NSString* urlStr = [NSString stringWithFormat:QiuShiBaiKe_GetData, [NSNumber numberWithInt: page], [NSNumber numberWithInt:QiuShiBaiKe_GetCount]];
    return [NSURL URLWithString: urlStr];
}

- (NSArray*) qiushiWithData:(NSData*) data {
    __autoreleasing NSError* jsonError;
    NSDictionary* items = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &jsonError];
    
    if(jsonError) {
        NSLog(@"%@", jsonError);
        return nil;
    }
    
    NSArray *qiushi =[items objectForKey: @"items"];
    NSLog(@"%@", qiushi);
    
    NSMutableArray *qiushiItems = [[NSMutableArray alloc] init];
    for(int i = 0; i < qiushi.count; i++){
        NSDictionary *item = [qiushi objectAtIndex: i];
        QBQiuShiItem *qiushiItem = [[QBQiuShiItem alloc] initWithDictionary: item];
        [qiushiItems addObject: qiushiItem];
    }
    
    return [qiushiItems copy];
}

@end
