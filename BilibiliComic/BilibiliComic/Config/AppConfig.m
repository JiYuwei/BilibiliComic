//
//  AppConfig.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/8.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig

+ (NSString *)getCurrentTimestamp {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [date timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

+ (NSString *)getAppSign
{
    NSString *sign = [NSString stringWithFormat:@"%@&%@&%@&%@&%@&%@&%@&%@",ACTION_KEY,APP_KEY,APP_BUILD,APP_DEVICE,APP_MOBI,APP_PLATFORM,APP_TS,APP_VERSION];
    return [sign md5];
}

@end

