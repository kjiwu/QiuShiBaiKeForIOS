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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray* data =[[QBNetwork sharedNetwork] getQiuShiList];
    for (NSDictionary* dic in data) {
        QBQiuShiItem* item = [[QBQiuShiItem alloc] initWithDictionary: dic];
        NSLog(@"%@", item);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
