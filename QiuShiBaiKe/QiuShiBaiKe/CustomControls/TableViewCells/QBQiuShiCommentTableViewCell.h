//
//  QBQiuShiCommentTableViewCell.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-15.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QBQiuShiCommentItem;

@interface QBQiuShiCommentTableViewCell : UITableViewCell

@property (strong, nonatomic) QBQiuShiCommentItem *item;

@property (assign, nonatomic) CGFloat height;

@end
