//
//  ViewController.m
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-13.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import "ViewController.h"
#import "QBQiuShiItem.h"
#import "QBNetwork.h"
#import "QBUserInfo.h"
#import "QBVoteInfo.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray* items;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray* data =[[QBNetwork sharedNetwork] getQiuShiList];
    
    items = [[NSMutableArray alloc] init];
    
    for (NSDictionary* dic in data) {
        QBQiuShiItem* item = [[QBQiuShiItem alloc] initWithDictionary: dic];
        [items addObject: item];
    }
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
    
    return [items count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"CustomCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    UILabel* lblUsername = (UILabel*)[cell viewWithTag: 1];
    UILabel* lblContent =  (UILabel*)[cell viewWithTag: 2];
    
    NSInteger row = indexPath.row;
    QBQiuShiItem *item = [items objectAtIndex: row];
    
    lblUsername.text = item.user.loginName;
    lblContent.text = item.content;
    
    NSAttributedString* attrStr_name = [[NSAttributedString alloc] initWithString: lblUsername.text];
    lblUsername.attributedText = attrStr_name;
    NSRange range = NSMakeRange(0, attrStr_name.length);
    NSDictionary* dic = [attrStr_name attributesAtIndex: 0 effectiveRange: &range];
    
    // 计算文本的大小
    CGSize textSize_name = [lblUsername.text boundingRectWithSize:lblUsername.bounds.size // 用于计算文本绘制时占据的矩形块
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                                 attributes:dic        // 文字的属性
                                                    context:nil].size;
    
    NSAttributedString* attrStr_content = [[NSAttributedString alloc] initWithString: lblContent.text];
    lblContent.attributedText = attrStr_content;
    NSRange range_content = NSMakeRange(0, attrStr_content.length);
    NSDictionary* dic_content = [attrStr_content attributesAtIndex: 0 effectiveRange: &range_content];
    
    // 计算文本的大小
    CGSize textSize_content = [lblContent.text boundingRectWithSize:lblContent.bounds.size // 用于计算文本绘制时占据的矩形块
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                                      attributes:dic_content        // 文字的属性
                                                         context:nil].size;
    
    
    CGRect frame = CGRectMake(cell.frame.origin.x
                              , cell.frame.origin.y
                              , cell.frame.size.width
                              , textSize_name.height + textSize_content.height + 20);
    cell.frame = frame;
    
    return cell;
}


- (CGFloat) getStringHeight: (NSString*) string withFont: (UIFont*) font {

    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString: string];
    
    UILabel* lblContent = [[UILabel alloc] init];
    lblContent.font = font;
    lblContent.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary* dic = [attrStr attributesAtIndex: 0 effectiveRange: &range];
    
    // 计算文本的大小
    CGSize textSize = [lblContent.text boundingRectWithSize:lblContent.bounds.size // 用于计算文本绘制时占据的矩形块
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                               attributes:dic        // 文字的属性
                                                  context:nil].size;
    
    return  textSize.height;
    
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    return nil;
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
