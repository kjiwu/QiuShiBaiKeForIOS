//
//  QBTableViewCell.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-13.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBItemTouchDelegate.h"

@class QBQiuShiItem;

#define kSubViewGap 10
#define kUsernameFontSize 12.0
#define kContentFontSize 17.0
#define kHeaderImageWidth 48
#define kHeaderImageHeight kHeaderImageWidth
#define kOtherLabelFontSize kUsernameFontSize
#define kButtonSizeWidth 24
#define kButtonSizeHeight kButtonSizeWidth


@interface QBTableViewCell : UITableViewCell{
    UIImageView *header;
    UILabel *username;
    UILabel *content;
    
    UIButton *btnUp;
    UIButton *btnDown;
    UIButton *btnComment;
    
    UILabel *up;
}

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, retain) QBQiuShiItem *item;

@property (nonatomic, weak) id<QBItemTouchDelegate> delegate;

@property (nonatomic, assign) BOOL showButtons;

@end
