//
//  QBImageTableViewCell.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-13.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBImageTableViewCell.h"
#import "QBQiuShiItem.h"
#import "QBQiuShiToolHelper.h"
#import "UIImageView+WebCache.h"

@interface QBImageTableViewCell ()
{
    UIImageView *contentImage;
}

@end

@implementation QBImageTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        contentImage = [[UIImageView alloc] init];
        [self.contentView addSubview:contentImage];
    }
    return  self;
}

- (void) setItem:(QBQiuShiItem *)item {
    [super setItem:item];
    
    CGFloat contentImage_y = up.frame.origin.y;
    CGSize size = item.imageSize.smallSize;
    contentImage.frame = CGRectMake(kSubViewGap, contentImage_y, size.width, size.height);
    
    CGRect upRect = up.frame;
    CGRect btnUpRect = btnUp.frame;
    CGRect btnDownRect = btnDown.frame;
    CGRect btnCommentRect = btnComment.frame;
    
    up.frame = CGRectMake(upRect.origin.x, upRect.origin.y + size.height + kSubViewGap, upRect.size.width, upRect.size.height);
    btnUp.frame = CGRectMake(btnUpRect.origin.x, btnUpRect.origin.y + size.height + kSubViewGap, btnUpRect.size.width, btnUpRect.size.height);
    btnDown.frame = CGRectMake(btnDownRect.origin.x, btnDownRect.origin.y + size.height + kSubViewGap, btnDownRect.size.width, btnDownRect.size.height);
    btnComment.frame = CGRectMake(btnCommentRect.origin.x, btnCommentRect.origin.y + size.height + kSubViewGap, btnCommentRect.size.width, btnCommentRect.size.height);
    self.height += size.height + kSubViewGap;
    
    NSURL* contentImageURL = [QBQiuShiToolHelper imageUrlWithQBId:item.itemId withImageName:item.image];
    [contentImage sd_setImageWithURL:contentImageURL placeholderImage:[UIImage imageNamed:@"defaultContent.jpg"]];
}

@end
