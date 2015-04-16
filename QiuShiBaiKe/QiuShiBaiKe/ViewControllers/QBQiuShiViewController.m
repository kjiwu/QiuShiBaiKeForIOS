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
#import "QBNetworkGlobalData.h"

static NSString* Identifier_Label = @"CustomLabelCell";
static NSString* Identifier_Image = @"CustomLabelWithImageCell";

#define LoadNewQiuShiDistance 5



@interface QBQiuShiViewController ()
{
    //UIRefreshControl *refreshControl;
}

@end

@implementation QBQiuShiViewController{
    NSMutableArray *qiushiItems;
    QBNetwork *network;
    int page;
    NSInteger selectedItemIndex;
    NSMutableArray *cellHeights;
    BOOL isRefreshing;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    network = [[QBNetwork alloc] init];
    network.delegate = self;
    
    self.tableView.allowsSelection = NO;
    [self initParams];
    [network getQiuShiListWithPageAsync: page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initParams {
    qiushiItems = [[NSMutableArray alloc] init];
    cellHeights = [[NSMutableArray alloc] init];
    page = 1;
    isRefreshing = NO;
}

- (void) refreshQiuShi {
    [self initParams];
    [network getQiuShiListWithPageAsync: page];
    isRefreshing = YES;
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在刷新糗事……"];
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
    NSInteger row = indexPath.row;
    QBQiuShiItem *item = [qiushiItems objectAtIndex:row];
    
    
    if(!item.haveImage) {
        cell = [tableView dequeueReusableCellWithIdentifier:Identifier_Label];
        if(!cell) {
            cell = [[QBLabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier_Label];
        }
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:Identifier_Image];
        if(!cell) {
            cell = [[QBImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier_Image];
        }
    }
    
    cell.showButtons = YES;
    cell.item = [qiushiItems objectAtIndex:row];
    cell.delegate = self;
    
    if(cellHeights.count <= row) {
        [cellHeights addObject:[NSNumber numberWithFloat:cell.height]];
    }
    else {
        [cellHeights replaceObjectAtIndex:row withObject:[NSNumber numberWithFloat:cell.height]];
    }
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(cellHeights.count == 0 || indexPath.row >= cellHeights.count)
        return 0;
    
    NSInteger row = indexPath.row;
    return [[cellHeights objectAtIndex:row] floatValue];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(cellHeights.count < LoadNewQiuShiDistance) return;
    
    CGFloat distance = self.tableView.contentSize.height - self.tableView.contentOffset.y;
    CGFloat loadNewDistance = 0;
    for(int i = (int)cellHeights.count - LoadNewQiuShiDistance; i < cellHeights.count; i++) {
        loadNewDistance += [cellHeights[i] floatValue];
    }
    
    int currentPage = (int)indexPath.row / QiuShiBaiKe_GetCount + 1;
    int totalPage = (int)qiushiItems.count / QiuShiBaiKe_GetCount;
    BOOL needLoad = totalPage == currentPage ? YES : NO;
    
    if((distance <= loadNewDistance) && needLoad) {
        [network getQiuShiListWithPageAsync: ++page];
    }
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

#pragma mark --QBDownloadQiuShiDelegate--

- (void) downloadQiuShiCompleted:(NSArray *)items {
    if(qiushiItems.count == 0) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新糗事"];
        [self.refreshControl addTarget:self action:@selector(refreshQiuShi) forControlEvents:UIControlEventValueChanged];
    }
    
    [qiushiItems addObjectsFromArray: items];
    [self.tableView reloadData];
    
    if(isRefreshing) {
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新糗事"];
        isRefreshing = NO;
    }
}

#pragma mark --QBItemTouchDelegate--

- (void) commentTouched:(id)sender withQiuShiItem:(QBQiuShiItem *)item {
    QBQiuShiCommentController *controller = [[QBQiuShiCommentController alloc] init];
    controller.navigationItem.title = @"评论";
    controller.item = item;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
