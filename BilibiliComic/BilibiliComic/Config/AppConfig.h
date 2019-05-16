//
//  AppConfig.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/8.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject

/**
 获取当前时间戳

 @return 当前时间戳
 */
+ (NSString *)getCurrentTimestamp;


/**
 应用校验密匙

 @return 密匙
 */
+ (NSString *)getAppSign;

@end
