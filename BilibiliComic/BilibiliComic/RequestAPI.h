//
//  RequestAPI.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/17.
//  Copyright © 2019 jyw. All rights reserved.
//

#ifndef RequestAPI_h
#define RequestAPI_h

#define ACTION_KEY          @"appkey"
#define APP_KEY             @"da44a5d9227fa9ef"
#define APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define APP_BUILD           [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define APP_DEVICE          @"phone"
#define APP_MOBI            @"iphone_comic"
#define APP_PLATFORM        @"ios"
#define APP_SIGN            @"8b0557572b23caf9394c8006e655e968"
#define APP_TS              @"1556785571"


#define HOSTURL @"https://manga.bilibili.com"

#define HOME_STOCK_URL @"/twirp/comic.v1.Comic/HomeStock"

#endif /* RequestAPI_h */
