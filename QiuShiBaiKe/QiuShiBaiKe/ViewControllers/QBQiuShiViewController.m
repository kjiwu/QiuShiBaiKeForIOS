//
//  QBQiuShiViewController.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-19.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBQiuShiViewController.h"
#import "UIImageView+WebCache.h"
#import "QBNetwork.h"
#import "QBQiuShiItem.h"

@interface QBQiuShiViewController ()

@end

@implementation QBQiuShiViewController{
    NSMutableArray *qiushiItems;
    QBNetwork *network;
    int page;
    
    BOOL navToCommit;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    network = [[QBNetwork alloc] init];
    network.delegate = self;
    
    qiushiItems = [[NSMutableArray alloc] init];
    self.tableView.allowsSelection = NO;
    
    page = 1;
    [network getQiuShiListWithPageAsync: page];
    navToCommit = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return qiushiItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier_label = @"CustomLabelCell";
    static NSString *identifier_image = @"CustomLabelWithImageCell";
    UITableViewCell* cell = nil;
    QBQiuShiItem *item = [qiushiItems objectAtIndex: indexPath.row];
    BOOL isImageCell = (nil == item.image || [[NSNull null] isEqual: item.image] || item.image.length == 0) ? NO : YES;
    
    if(!isImageCell)
        cell = [tableView dequeueReusableCellWithIdentifier:identifier_label];
    else
        cell = [tableView dequeueReusableCellWithIdentifier:identifier_image];
    
    UIImageView *headerImage = (UIImageView*) [cell viewWithTag: HEADERIMAGE_TAG];
    headerImage.layer.cornerRadius = headerImage.frame.size.width / 2;
    headerImage.layer.masksToBounds = YES;
    
    if(item.user){
        UIImage *defaultImage = [UIImage imageWithContentsOfFile: @"default"];
        NSURL *headerURL = [self getHeaderImage:item.user.userId withImage:item.user.header];
        if(headerURL){
            [headerImage sd_setImageWithURL:headerURL placeholderImage: defaultImage];
        }
    }
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag: NAMELABEL_TAG];
    if(nil != item.user)
        nameLabel.text = item.user.loginName;
    else
        nameLabel.text = NSLocalizedString(@"Default_Username", @"");
    
    UILabel *contentLabel = (UILabel*) [cell viewWithTag: CONTENTLABEL_TAG];
    contentLabel.text = item.content;
    
    UILabel *goodLabel = (UILabel*) [cell viewWithTag: GOODLABEL_TAG];
    if(item.vote)
        goodLabel.text = [NSString stringWithFormat: @"%d", item.vote.up];
    
    UILabel *commitLabel = (UILabel*)[cell viewWithTag: COMMITLABEL_TAG];
    commitLabel.text = [NSString stringWithFormat: @"%d", item.commentCount];
    
    if(isImageCell) {
        UIImageView *contentImage = (UIImageView*)[cell viewWithTag: IMAGECONTENT_TAG];
        UIImage *cImage = [UIImage imageNamed: @"defaultContent.jpg"];
        
        NSURL *urlImage = [self getImageURL: item.itemId withImageName: item.image];
        [contentImage sd_setImageWithURL:urlImage placeholderImage: cImage];
        
        CGRect rect = contentImage.frame;
        contentImage.frame = CGRectMake(rect.origin.x
                                        , rect.origin.y
                                        , item.imageSize.smallSize.width
                                        , item.imageSize.smallSize.height);
    }
    
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QBQiuShiItem *item = [qiushiItems objectAtIndex: indexPath.row];
    if(item.haveImage) {
        return 180 + item.imageSize.smallSize.height;
    }
    else {
        return 150 + [self getStringHeight: item.content];
    }
}

- (CGFloat) getStringHeight: (NSString*) value {
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString: value];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange: &range];
    
    return [value boundingRectWithSize: CGSizeMake(320, 0) options:NSStringDrawingUsesLineFragmentOrigin
                            attributes: dic context:nil].size.height + 32;
}


- (NSURL*) getImageURL: (NSString*)qiubaiID withImageName: (NSString*) imageName {
    NSString *id04 = [qiubaiID substringWithRange: NSMakeRange(0, 5)];
    NSString *urlStr = [NSString stringWithFormat:QiuShiBaiKe_GetSmallImage, id04, qiubaiID, imageName];
    return [NSURL URLWithString: urlStr];
}

- (NSURL*) getHeaderImage:(NSString*) userId withImage:(NSString*) imageName {
    if(nil == userId || userId.length == 0)
        return nil;
    
    
    NSString *id04 = [userId substringWithRange: NSMakeRange(0, 4)];
    NSString *urlStr = [NSString stringWithFormat:QiuShiBaiKe_GetUserHeader, id04, userId, imageName];
    return [NSURL URLWithString: urlStr];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    navToCommit =[segue.identifier isEqualToString: @"CommitSegue"] || [segue.identifier isEqualToString: @"CommitSegueWithImage"];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if(navToCommit) return;
    
    float distance = scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.frame.size.height);
    if(!network.isLoading && (distance <= 0)) {
        page++;
        [network getQiuShiListWithPageAsync: page];
    }
}

#pragma mark --QBDownloadQiuShiDelegate--

- (void) downloadCompleted:(NSArray *)items {
    [qiushiItems addObjectsFromArray: items];
    [self.tableView reloadData];
}

@end
