//
//  BCRequestCache.h
//  NetWorkRequestDemo
//
//  Created by 纪宇伟 on 2017/7/5.
//  Copyright © 2017年 jyw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCRequestCache : NSObject

+ (instancetype)sharedRequestCache;

+ (NSDictionary *)jsonData2NSDictionary:(NSData *)jsonData;
+ (NSDictionary *)jsonStr2NSDictionary:(NSString *)json;

- (NSDictionary *)getFromCache:(NSString *)requestKey;

- (BOOL)putToCache:(NSString *)requestKey jsonDict:(NSDictionary *)json;
- (BOOL)putToCache:(NSString *)requestKey jsonData:(NSData *)jsonData;
- (BOOL)putToCache:(NSString *)requestKey cacheStr:(NSString *)cacheStr;

- (BOOL)removeFromCache:(NSString *)requestKey;

@end
