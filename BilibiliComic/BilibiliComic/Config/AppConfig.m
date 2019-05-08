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


#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    NSMutableString *md5String = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5String appendFormat:@"%02x",result[i]];
    }
    return [md5String copy];
}

@end

