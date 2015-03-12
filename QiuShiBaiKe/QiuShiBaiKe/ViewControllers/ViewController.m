//
//  ViewController.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "ViewController.h"

#import "QBNetwork.h"
#import "QBQiuShiItem.h"
#import "QBUserInfo.h"
#import "QBVoteInfo.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray* items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray* data =[[QBNetwork sharedNetwork] getQiuShiList];
    
    items = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dic in data) {
        QBQiuShiItem* item = [[QBQiuShiItem alloc] initWithDictionary: dic];
        [items addObject: item];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [items count];
    
}


- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSString* noImageIdentifier = @"NoImageIdentifier";
    NSString* imageIdentifier = @"ImageIdentifier";
    
    NSInteger row = indexPath.row;
    QBQiuShiItem* item = [items objectAtIndex: row];
    
    /*
    UITableViewCell* cell = nil;
    if([item.image  isEqual: @""]) {
        cell = [self.tableView dequeueReusableCellWithIdentifier: noImageIdentifier];
    }
    else {
        cell = [self.tableView dequeueReusableCellWithIdentifier: imageIdentifier];
    }
    
    UILabel* lblName = (UILabel*)[self.tableView viewWithTag: LabelName_Tag];
    lblName.text = item.user.loginName;
    
    UILabel* lblContent = (UILabel*)[self.tableView viewWithTag: LabelContent_Tag];
    lblContent.text = item.content;
    
    
    UIImageView* imageHeader = (UIImageView*)[self.tableView viewWithTag: ImageHeader_Tag];
    [imageHeader sd_setImageWithURL: [NSURL URLWithString: @""] placeholderImage: [UIImage imageNamed: @""]];
    
    
    NSString* id = [item.itemId substringWithRange: NSMakeRange(0, 4)];
    NSString* urlStr = [NSString stringWithFormat: GetImageURL_Formatter, id, item.itemId, item.image];
    
    UIImageView* image = (UIImageView*)[self.tableView viewWithTag: Image_Tag];
    [image sd_setImageWithURL: [NSURL URLWithString: urlStr] placeholderImage: [UIImage imageNamed: @""]];*/
    
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier: imageIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: imageIdentifier];
    }
    
    UILabel* lblName = (UILabel*)[self.tableView viewWithTag: LabelName_Tag];
    lblName.text = item.user.loginName;
    
    NSString* id = [item.itemId substringWithRange: NSMakeRange(0, 4)];
    NSString* urlStr = [NSString stringWithFormat: GetImageURL_Formatter, id, item.itemId, item.image];
    UIImageView* image = (UIImageView*)[self.tableView viewWithTag: Image_Tag];
    [image sd_setImageWithURL: [NSURL URLWithString: urlStr] placeholderImage: [UIImage imageNamed: @"default.jpg"]];
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
