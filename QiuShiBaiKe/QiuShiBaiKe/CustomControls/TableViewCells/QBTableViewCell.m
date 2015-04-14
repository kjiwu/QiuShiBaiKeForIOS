//
//  QBTableViewCell.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-13.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBTableViewCell.h"
#import "QBQiuShiToolHelper.h"
#import "QBQiuShiItem.h"
#import "UIImageView+WebCache.h"


@interface QBTableViewCell ()

@end


@implementation QBTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        [self initSubViews];
    }
    
    return self;
}

- (void) setItem:(QBQiuShiItem *)item {
    _item = item;
    [self initSubviewsPosition];
}


#pragma mark - init subviews

- (void) initSubViews {
    header = [[UIImageView alloc] init];
    [self.contentView addSubview:header];
    
    username = [[UILabel alloc] init];
    username.font = [UIFont systemFontOfSize: kUsernameFontSize];
    username.numberOfLines = 1;
    [self.contentView addSubview:username];
    
    content = [[UILabel alloc] init];
    content.font = [UIFont systemFontOfSize: kContentFontSize];
    content.numberOfLines = 0;
    content.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:content];
    
    btnUp = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [self.contentView addSubview:btnUp];
    
    btnDown = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [self.contentView addSubview:btnDown];
    
    btnComment = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [self.contentView addSubview:btnComment];
    
    up = [[UILabel alloc] init];
    up.font = [UIFont systemFontOfSize: kOtherLabelFontSize];
    [self.contentView addSubview: up];
}


#pragma mark - init subviews position

- (void) initSubviewsPosition {
    _height = 0;
    
    header.frame = CGRectMake(kSubViewGap, kSubViewGap, kHeaderImageWidth, kHeaderImageHeight);
    header.layer.cornerRadius = header.frame.size.width / 2;
    header.layer.masksToBounds = YES;
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    CGFloat username_x = header.frame.origin.x + CGRectGetWidth(header.frame) + kSubViewGap;
    CGSize username_size = [QBQiuShiToolHelper stringSizeWithSize: CGSizeMake(screenSize.width - kSubViewGap, 0) andContent:_item.user.loginName withFont:username.font];
    CGFloat username_y = header.center.y - username_size.height / 2;
    username.frame = CGRectMake(username_x, username_y, username_size.width, username_size.height);
    _height += kSubViewGap + header.frame.size.height + kSubViewGap;
    
    CGSize content_size = [QBQiuShiToolHelper stringSizeWithSize:CGSizeMake(screenSize.width - kSubViewGap, CGFLOAT_MAX) andContent:_item.content withFont:content.font];
    CGFloat content_x = kSubViewGap;
    CGFloat content_y = _height;
    content.frame = CGRectMake(content_x, content_y, content_size.width, content_size.height);
    _height += content_size.height + kSubViewGap;
    
    if(nil != _item.user) {
        NSURL *header_url = [QBQiuShiToolHelper headerImageUrlByUserId:_item.user.userId withImageName:_item.user.header];
        if(header_url) {
            UIImage *placeholderImage = [UIImage imageNamed:@"default"];
            [header sd_setImageWithURL:header_url placeholderImage:placeholderImage];
        }
        else {
            header.image = [UIImage imageNamed:@"default"];
        }
        
        username.text = _item.user.loginName;
    }
    
    content.text = _item.content;
    
    CGFloat up_x = kSubViewGap;
    CGFloat up_y = _height;
    up.text = [NSString stringWithFormat:@"%d 好笑  %d 评论", _item.vote.up, _item.commentCount];
    CGSize upSize = [QBQiuShiToolHelper stringSizeWithSize:CGSizeMake(screenSize.width - kSubViewGap * 2, CGFLOAT_MAX) andContent:up.text withFont:up.font];
    up.frame = CGRectMake(up_x, up_y, upSize.width, upSize.height);
    _height += upSize.height + kSubViewGap;
    
    [btnUp setImage: [UIImage imageNamed:@"good.png"] forState: UIControlStateNormal];
    btnUp.frame = CGRectMake(kSubViewGap, _height, kButtonSizeWidth, kButtonSizeHeight);
    [btnUp addTarget:self action:@selector(upOrDownClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnDown setImage: [UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
    btnDown.frame = CGRectMake(kSubViewGap * 3 + kButtonSizeWidth, _height, kButtonSizeWidth, kButtonSizeHeight);
    [btnDown addTarget:self action:@selector(upOrDownClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnComment setImage:[UIImage imageNamed:@"message.png"] forState:UIControlStateNormal];
    btnComment.frame = CGRectMake(kSubViewGap * 5 + kButtonSizeWidth * 2, _height, kButtonSizeWidth, kButtonSizeHeight);
    [btnComment addTarget:self action:@selector(commentClick) forControlEvents:UIControlEventTouchUpInside];
    
    _height += kButtonSizeHeight + kSubViewGap;
}

#pragma mark - comment click

- (void) commentClick {
    if(self.delegate) {
        if([self.delegate respondsToSelector:@selector(commentTouched:withQiuShiItem:)]) {
            [self.delegate commentTouched: btnComment withQiuShiItem:_item];
        }
    }
}

#pragma mark - up or down click

- (void) upOrDownClick:(id)sender {
    if(self.delegate && [self.delegate respondsToSelector: @selector(upOrDownTouched:withQiuShiItem:)]) {
        [self.delegate upOrDownTouched:sender withQiuShiItem:_item];
    }
}

@end
