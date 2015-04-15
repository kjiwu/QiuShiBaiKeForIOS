//
//  QBQiuShiCommentTableViewCell.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-15.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBQiuShiCommentTableViewCell.h"
#import "QBQiuShiToolHelper.h"
#import "QBQiuShiCommentItem.h"
#import "QBUserInfo.h"
#import "UIImageView+WebCache.h"

#define kHeaderImageWidth 48
#define kHeaderImageHeight kHeaderImageWidth
#define kLabelNameFontSize 12
#define kLabelContentFontSize 12
#define kLabelFloorFontSize 12
#define kSubViewGap 10


@interface QBQiuShiCommentTableViewCell () {
    UIImageView *header;
    UILabel *lblName;
    UILabel *lblContent;
    UILabel *lblFloor;
}

@end

@implementation QBQiuShiCommentTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self initSubViews];
    }
    return self;
}


#pragma mark -initSubViews

- (void) initSubViews {
    header = [[UIImageView alloc] init];
    [self.contentView addSubview:header];
    
    lblName = [[UILabel alloc] init];
    lblName.font = [UIFont systemFontOfSize:kLabelNameFontSize];
    lblName.textColor = [UIColor purpleColor];
    [self.contentView addSubview:lblName];
    
    lblContent = [[UILabel alloc] init];
    lblContent.font = [UIFont systemFontOfSize:kLabelContentFontSize];
    [self.contentView addSubview:lblContent];
    
    lblFloor = [[UILabel alloc] init];
    lblFloor.font = [UIFont systemFontOfSize:kLabelFloorFontSize];
    lblFloor.textColor = [UIColor purpleColor];
    [self.contentView addSubview:lblFloor];
}

#pragma mark -initSubViewsPosition

- (void) initSubViewsPosition {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    CGFloat tempHeight = kSubViewGap;
    
    header.frame = CGRectMake(kSubViewGap, kSubViewGap, kHeaderImageWidth, kHeaderImageHeight);
    NSURL *headerUrl = [QBQiuShiToolHelper headerImageUrlByUserId:self.item.userInfo.userId withImageName:self.item.userInfo.header];
    [header sd_setImageWithURL:headerUrl placeholderImage: [UIImage imageNamed:@"default"]];
    header.layer.cornerRadius = kHeaderImageWidth / 2;
    header.layer.masksToBounds = YES;
    
    CGSize nameSize = [QBQiuShiToolHelper stringSizeWithSize:CGSizeMake(screenSize.width - kSubViewGap, 0) andContent:self.item.userInfo.loginName withFont:lblName.font];
    lblName.frame = CGRectMake(kSubViewGap * 2 + kHeaderImageWidth, kSubViewGap, nameSize.width, nameSize.height);
    lblName.text = self.item.userInfo.loginName;
    tempHeight += nameSize.height + kSubViewGap;
    
    
    CGSize floorSize = [QBQiuShiToolHelper stringSizeWithSize:CGSizeMake(screenSize.width - kSubViewGap, 0) andContent:[NSString stringWithFormat:@"%d", self.item.floor] withFont:lblFloor.font];
    lblFloor.frame = CGRectMake(screenSize.width - kSubViewGap - floorSize.width, kSubViewGap, floorSize.width, floorSize.height);
    lblFloor.text = [NSString stringWithFormat:@"%d", self.item.floor];
    
    CGSize contentSize = [QBQiuShiToolHelper stringSizeWithSize:CGSizeMake(screenSize.width - kHeaderImageWidth - kSubViewGap * 3, 0) andContent:self.item.content withFont:lblContent.font];
    lblContent.frame = CGRectMake(kSubViewGap * 2 + kHeaderImageWidth, tempHeight, contentSize.width, contentSize.height);
    lblContent.text = self.item.content;
    lblContent.numberOfLines = 0;
    tempHeight += contentSize.height + kSubViewGap;
    
    self.height = kHeaderImageHeight + kSubViewGap * 2;
    if(tempHeight > self.height)
        self.height = tempHeight;
}

- (void) setItem:(QBQiuShiCommentItem *)item {
    _item = item;
    [self initSubViewsPosition];
}

@end
