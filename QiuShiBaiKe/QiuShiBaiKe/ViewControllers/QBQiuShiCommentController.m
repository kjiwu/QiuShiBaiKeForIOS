//
//  QBQiuShiCommentController.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-4-6.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBQiuShiCommentController.h"
#import "QBNetwork.h"
#import "QBQiuShiCommentItem.h"
#import "QBQiuShiItem.h"
#import "QBLabelTableViewCell.h"
#import "QBImageTableViewCell.h"
#import "QBQiuShiCommentTableViewCell.h"

@interface QBQiuShiCommentController ()<QBDownloadQiuShiDelegate>

@end


@implementation QBQiuShiCommentController {
    NSMutableArray *commentItems;
    NSMutableArray *cellHeights;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;
    QBNetwork *network = [[QBNetwork alloc] init];
    [network qiushiCommentsWithId:self.item.itemId];
    network.delegate = self;
    commentItems = [[NSMutableArray alloc] initWithCapacity: 10];
    cellHeights = [[NSMutableArray alloc] initWithCapacity: 10];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - QBDownloadQiuShiDelegate

- (void) downloadCommentCompleted:(NSArray *)items {
    [commentItems addObjectsFromArray:items];
    [self.tableView reloadData];
}

#pragma mark -UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return commentItems.count + 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    static NSString *identifier_image = @"identifier_image";
    static NSString *identifier_label = @"identifier_label";
    static NSString *identifier_comment = @"identifier_comment";
    
    if(indexPath.row == 0) {
        if(!self.item.haveImage) {
            cell = [tableView dequeueReusableCellWithIdentifier:identifier_label];
            if(!cell) {
                cell = [[QBLabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_label];
            }
        }
        else {
            cell = [tableView dequeueReusableCellWithIdentifier:identifier_image];
            if(!cell) {
                cell = [[QBImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_image];
            }
        }
        
        ((QBTableViewCell*)cell).showButtons = NO;
        ((QBTableViewCell*)cell).item = self.item;
        CGFloat height = ((QBTableViewCell*)cell).height;
        if(cellHeights.count <= indexPath.row) {
            [cellHeights insertObject:[NSNumber numberWithFloat:height] atIndex:indexPath.row];
        }
        else {
            [cellHeights replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:height]];
        }
    }
    else {
        QBQiuShiCommentItem *comment = [commentItems objectAtIndex:indexPath.row - 1];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier_comment];
        if(!cell) {
            cell = [[QBQiuShiCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier_comment];
        }
        ((QBQiuShiCommentTableViewCell*)cell).item = comment;
        
        if(cellHeights.count <= indexPath.row) {
            [cellHeights insertObject:[NSNumber numberWithFloat:((QBQiuShiCommentTableViewCell*)cell).height] atIndex:indexPath.row];
        }
        else {
            [cellHeights replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithFloat:((QBQiuShiCommentTableViewCell*)cell).height]];
        }
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(cellHeights.count == 0 || cellHeights.count <= indexPath.row)
        return 44;
    NSInteger row = indexPath.row;
    return [[cellHeights objectAtIndex: row] floatValue];
}

@end
