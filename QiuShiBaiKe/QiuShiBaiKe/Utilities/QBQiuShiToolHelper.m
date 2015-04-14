//
//  QBQiuShiToolHelper.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-13.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBQiuShiToolHelper.h"
#import "QBNetworkGlobalData.h"

@implementation QBQiuShiToolHelper

+ (CGSize) stringSizeWithSize:(CGSize)size andContent:(NSString *)content withFont:(UIFont *)font {
    NSDictionary *dic = @{NSFontAttributeName : font};
    return [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

+ (NSURL*) imageUrlWithQBId: (NSString*)qiubaiID withImageName: (NSString*) imageName {
    NSString *id04 = [qiubaiID substringWithRange: NSMakeRange(0, 5)];
    NSString *urlStr = [NSString stringWithFormat:QiuShiBaiKe_GetSmallImage, id04, qiubaiID, imageName];
    return [NSURL URLWithString: urlStr];
}

+ (NSURL*) headerImageUrlByUserId:(NSString*) userId withImageName:(NSString*) imageName {
    if(nil == userId || userId.length == 0)
        return nil;
    
    NSString *id04 = [userId substringWithRange: NSMakeRange(0, 4)];
    NSString *urlStr = [NSString stringWithFormat:QiuShiBaiKe_GetUserHeader, id04, userId, imageName];
    return [NSURL URLWithString: urlStr];
}

@end
