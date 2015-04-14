//
//  QBQiuShiViewController.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-19.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "QBQiuShiViewController.h"
#import "QBNetwork.h"
#import "QBQiuShiItem.h"
#import "QBTableViewCell.h"
#import "QBLabelTableViewCell.h"
#import "QBImageTableViewCell.h"
#import "QBQiuShiCommentController.h"

static NSString* Identifier_Label = @"CustomLabelCell";
static NSString* Identifier_Image = @"CustomLabelWithImageCell";

#define LoadNewQiuShiDistance 200


@interface QBQiuShiViewController ()

@end

@implementation QBQiuShiViewController{
    NSMutableArray *qiushiItems;
    QBNetwork *network;
    int page;
    NSInteger selectedItemIndex;
    BOOL navToCommit;
    
    NSMutableArray *qiushiItemCells;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    network = [[QBNetwork alloc] init];
    network.delegate = self;
    
    qiushiItems = [[NSMutableArray alloc] init];
    self.tableView.allowsSelection = NO;
    
    qiushiItemCells = [[NSMutableArray alloc] init];
    
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
    QBTableViewCell* cell = nil;
    QBQiuShiItem *item = [qiushiItems objectAtIndex: indexPath.row];
    
    
    if(!item.haveImage) {
        cell = [tableView dequeueReusableCellWithIdentifier:Identifier_Label];
        if(!cell) {
            cell = [[QBLabelTableViewCell alloc] init];
        }
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:Identifier_Image];
        if(!cell) {
            cell = [[QBImageTableViewCell alloc] init];
        }
    }
    
    cell.item = [qiushiItems objectAtIndex:indexPath.row];
    cell.delegate = self;
    [qiushiItemCells addObject:cell];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(qiushiItemCells.count == 0)
        return 0;
    
    return ((QBTableViewCell*)[qiushiItemCells objectAtIndex:indexPath.row]).height;
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    navToCommit =[segue.identifier isEqualToString: @"CommitSegue"] || [segue.identifier isEqualToString: @"CommitSegueWithImage"];
    
    if(navToCommit) {
        
    }
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

#pragma mark --QBItemTouchDelegate--

- (void) commentTouched:(id)sender withQiuShiItem:(QBQiuShiItem *)item {
    QBQiuShiCommentController *controller = [[QBQiuShiCommentController alloc] init];
    controller.navigationItem.title = @"评论";
    [self.navigationController pushViewController:controller animated:YES];
}

@end
