//
//  QBNetworkGlobalData.h
//  QiuShiBaiKe
//
//  Created by wulei on 15-3-10.
//  Copyright (c) 2015年 wulei. All rights reserved.
//

#ifndef QiuShiBaiKe_QBNetworkGlobalData_h
#define QiuShiBaiKe_QBNetworkGlobalData_h

//获取糗事列表的地址
#define QiuShiBaiKe_GetCount 30
#define QiuShiBaiKe_GetData @"http://m2.qiushibaike.com/article/list/latest?page=%@&count=%@"

//获取糗事的大图片
#define QiuShiBaiKe_GetMeduimImage @"http://pic.qiushibaike.com/system/pictures/%@/%@/medium/%@"

//获取糗事的小图片
#define QiuShiBaiKe_GetSmallImage @"http://pic.qiushibaike.com/system/pictures/%@/%@/small/%@"

//获取好友的头像
#define QiuShiBaiKe_GetUserHeader @"http://pic.qiushibaike.com/system/avtnew/%@/%@/thumb/%@"


//获取糗事评论地址
#define QiuShiBaiKe_GetComments @"http://m2.qiushibaike.com/article/%@/comments?page=1&count=5000"

#endif
