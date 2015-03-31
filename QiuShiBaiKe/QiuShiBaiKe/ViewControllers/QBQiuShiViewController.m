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
    
    NSArray *items;
    QBNetwork *network;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    network = [[QBNetwork alloc] init];
    items = [network getQiuShiList];
    self.tableView.allowsSelection = NO;
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
    return items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier_label = @"CustomLabelCell";
    static NSString *identifier_image = @"CustomLabelWithImageCell";
    UITableViewCell* cell = nil;
    QBQiuShiItem *item = [items objectAtIndex: indexPath.row];
    BOOL isImageCell = (nil == item.image || [[NSNull null] isEqual: item.image] || item.image.length == 0) ? NO : YES;
    
    if(!isImageCell)
        cell = [tableView dequeueReusableCellWithIdentifier:identifier_label forIndexPath:indexPath];
    else
        cell = [tableView dequeueReusableCellWithIdentifier:identifier_image forIndexPath:indexPath];
    
    UIImageView *headerImage = (UIImageView*) [cell viewWithTag: HEADERIMAGE_TAG];
    headerImage.layer.cornerRadius = headerImage.frame.size.width / 2;
    headerImage.layer.masksToBounds = YES;
    //UIImage *defaultImage = [UIImage imageWithContentsOfFile: @"default"];
    //[headerImage sd_setImageWithURL:[[NSURL alloc] init] placeholderImage: defaultImage];
    
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
        UIImage *cImage = [UIImage imageWithContentsOfFile: @"defaultContent.jpg"];
        [contentImage sd_setImageWithURL:[self getImageURL: item.itemId withImageName: item.image] placeholderImage: cImage];
        
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[self getImageURL: item.itemId withImageName: item.image]];
//        [NSURLConnection sendAsynchronousRequest:<#(NSURLRequest *)#> queue:nil completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            
//        }];
    }
    
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (NSURL*) getImageURL: (NSString*)qiubaiID withImageName: (NSString*) imageName {
    NSString *id04 = [qiubaiID substringWithRange: NSMakeRange(0, 4)];
    NSString *urlStr = [NSString stringWithFormat:QiuShiBaiKe_GetImage, id04, qiubaiID, imageName];
    return [NSURL URLWithString: urlStr];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
