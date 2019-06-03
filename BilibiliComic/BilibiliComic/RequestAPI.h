//
//  RequestAPI.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/17.
//  Copyright © 2019 jyw. All rights reserved.
//

#ifndef RequestAPI_h
#define RequestAPI_h

#define ACCESS_KEY          [APP_KEY md5]
#define ACTION_KEY          @"appkey"
#define APP_KEY             @"da44a5d9227fa9ef"
#define APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_BUILD           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_DEVICE          @"phone"
#define APP_MOBI            @"iphone_comic"
#define APP_PLATFORM        @"ios"
#define APP_SIGN            [AppConfig getAppSign]
#define APP_STAT            @{@"appId":@0,@"version":@"1.9.0",@"abtest":@"",@"platform":@1}
#define APP_TS              [AppConfig getCurrentTimestamp]


#define HOME_HOSTURL @"https://manga.bilibili.com/twirp/comic.v1.Comic/"

#define HOME_RECOMMEND  @"Recommend"
#define HOME_BANNER     @"Banner"
#define HOME_PAGE       @"HomePage"
#define HOME_STOCK_URL  @"HomeStock"
#define HOME_HOT        @"HomeHot"
#define HOME_FANS       @"HomeFans"
#define HOME_NEW        @"HomeNew"
#define HOME_NEWORDER   @"NewOrder"

#endif /* RequestAPI_h */
