//
//  AvoidCrashStubProxy.h
//  https://github.com/chenfanfang/AvoidCrash
//
//  Created by chenfanfang on 2017/7/25.
//  Copyright © 2017年 chenfanfang. All rights reserved.
//

#import <Foundation/Foundation.h>


#define AvoidCrashNotification @"AvoidCrashNotification"
#define AvoidCrashIsiOS(version) ([[UIDevice currentDevice].systemVersion floatValue] >= version)


//user can ignore below define
#define AvoidCrashDefaultReturnNil  @"AvoidCrash default is to return nil to avoid crash."
#define AvoidCrashDefaultIgnore     @"AvoidCrash default is to ignore this operation to avoid crash."

#define AvoidCrashSeparator         @"================================================================"
#define AvoidCrashSeparatorWithFlag @"========================AvoidCrash Log=========================="


#ifdef DEBUG

#define NSLog(format, ...) printf("\n[%f] %s [第%d行] %s\n", [[NSDate date] timeIntervalSince1970], __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#define AvoidCrashLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])

#else

#define NSLog(format, ...)
#define AvoidCrashLog(...)

#endif

@interface AvoidCrashStubProxy : NSObject

- (void)proxyMethod;

@end
