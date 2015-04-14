//
//  QBQiuShiViewController.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-19.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QBDownloadQiuShiDelegate.h"
#import "QBItemTouchDelegate.h"


@interface QBQiuShiViewController : UITableViewController<QBDownloadQiuShiDelegate, QBItemTouchDelegate>

@end
