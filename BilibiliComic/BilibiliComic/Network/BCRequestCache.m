//
//  BCRequestCache.m
//  NetWorkRequestDemo
//
//  Created by 纪宇伟 on 2017/7/5.
//  Copyright © 2017年 jyw. All rights reserved.
//

#import "BCRequestCache.h"
#import "FMDB.h"

#define T_REQCACHE @"t_reqCache"
#define REQKEY     @"reqKey"
#define REQVALUE   @"reqValue"

static BCRequestCache *requestCache;


@interface BCRequestCache ()

@property(nonatomic,strong)FMDatabase *requestCacheDB;

@end


@implementation BCRequestCache

+(instancetype)sharedRequestCache
{
    if (!requestCache) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            requestCache = [[self alloc] init];
        });
    }
    
    return requestCache;
}

-(instancetype)init
{
    if (self = [super init]) {
        _requestCacheDB = [FMDatabase databaseWithPath:[self cachePath]];
        [self createTable];
    }
    
    return self;
}


#pragma mark - Public

+(NSDictionary *)jsonData2NSDictionary:(NSData *)jsonData
{
    NSError *error = nil;
    
    if (![jsonData isKindOfClass:[NSData class]]) {
        
        jsonData=[NSKeyedArchiver archivedDataWithRootObject:jsonData];
    }
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    if (error != nil)
    {
        if (jsonData == nil)
        {
            NSLog(@"%@", [error debugDescription]);
        }
        else
        {
            NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        }
        return nil;
    }
    
    return jsonObject;
}

+(NSDictionary *)jsonStr2NSDictionary:(NSString *)json
{
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self jsonData2NSDictionary:jsonData];
}

//查询缓存
-(NSDictionary *)getFromCache:(NSString *)requestKey
{
    NSString *reqValue = nil;
    
    if ([_requestCacheDB open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@='%@'",REQVALUE,T_REQCACHE,REQKEY,requestKey];
        FMResultSet *result = [_requestCacheDB executeQuery:sql];
        while ([result next]) {
            reqValue = [result stringForColumn:REQVALUE];
            break;
        }
        [_requestCacheDB close];
    }
    
    return [BCRequestCache jsonStr2NSDictionary:reqValue];
}

//添加缓存
-(BOOL)putToCache:(NSString *)requestKey jsonDict:(NSDictionary *)json
{
    return [self putToCache:requestKey cacheStr:[[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]];
}

-(BOOL)putToCache:(NSString *)requestKey jsonData:(NSData *)jsonData
{
    return [self putToCache:requestKey cacheStr:[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
}

-(BOOL)putToCache:(NSString *)requestKey cacheStr:(NSString *)cacheStr
{
    BOOL status = nil;
    
    if ([_requestCacheDB open]) {
        NSString *sql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@(%@,%@) VALUES (?,?)",T_REQCACHE,REQKEY,REQVALUE];
        status = [_requestCacheDB executeUpdate:sql,requestKey,cacheStr];
        [_requestCacheDB close];
    }

    return status;
}

//删除缓存
-(BOOL)removeFromCache:(NSString *)requestKey
{
    BOOL status = nil;
    
    if ([_requestCacheDB open]) {
        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE REQUEST_KEY = %@",T_REQCACHE,requestKey];
        status = [_requestCacheDB executeUpdate:sql];
        [_requestCacheDB close];
    }
    
    return status;
}


#pragma mark - Private

-(NSString *)cachePath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES).lastObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"requestCache.db"];
    
    return filePath;
}

-(BOOL)createTable {
    
    BOOL res = nil;
    
    if ([_requestCacheDB open]) {
        NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY AUTOINCREMENT NOT NULL, %@ char(32) UNIQUE, %@ varchar(10000))",T_REQCACHE,REQKEY,REQVALUE];
        BOOL res = [_requestCacheDB executeUpdate:sqlStr];
        if (!res) {
            NSLog(@"error when creating database table");
        }
        [_requestCacheDB close];
    }
    
    return res;
}

@end
