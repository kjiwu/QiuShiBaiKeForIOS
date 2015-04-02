//
//  QBQiuShiViewController.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-19.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "QBDownloadQiuShiDelegate.h"


#define HEADERIMAGE_TAG 1
#define NAMELABEL_TAG 2
#define CONTENTLABEL_TAG 3
#define GOODLABEL_TAG 4
#define COMMITLABEL_TAG 5
#define GOODBUTTON_TAG 6
#define BADBUTTON_TAG 7
#define COMMITBUTTON_TAG 8
#define IMAGECONTENT_TAG 9

#define LoadNewQiuShiDistance 200

@interface QBQiuShiViewController : UITableViewController<QBDownloadQiuShiDelegate>

@end
