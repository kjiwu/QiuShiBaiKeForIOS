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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier_label forIndexPath:indexPath];
    
    QBQiuShiItem *item = [items objectAtIndex: indexPath.row];
    
    //UIImageView *headerImage = (UIImageView*) [cell viewWithTag: HEADERIMAGE_TAG];
    //UIImage *defaultImage = [UIImage imageWithContentsOfFile: @"default"];
    //[headerImage sd_setImageWithURL:[[NSURL alloc] init] placeholderImage: defaultImage];
    
    UILabel *nameLabel = (UILabel*) [cell viewWithTag: NAMELABEL_TAG];
    nameLabel.text = item.user.loginName;
    
    UILabel *contentLabel = (UILabel*) [cell viewWithTag: CONTENTLABEL_TAG];
    contentLabel.text = item.content;
    
    UILabel *goodLabel = (UILabel*) [cell viewWithTag: GOODLABEL_TAG];
    goodLabel.text = [NSString stringWithFormat: @"%d", item.vote.up];
    
    UILabel *commitLabel = (UILabel*)[cell viewWithTag: COMMITLABEL_TAG];
    commitLabel.text = [NSString stringWithFormat: @"%d", item.commentCount];
    
    
    return cell;
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
