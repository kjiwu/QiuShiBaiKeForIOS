//
//  QBQiuShiToolHelper.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-13.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QBQiuShiToolHelper : NSObject

+ (CGSize) stringSizeWithSize:(CGSize)size andContent:(NSString *)content withFont:(UIFont *)font;

+ (NSURL*) imageUrlWithQBId: (NSString*)qiubaiID withImageName: (NSString*) imageName;

+ (NSURL*) headerImageUrlByUserId:(NSString*) userId withImageName:(NSString*) imageName;

@end
