//
//  NSMutableDictionary+AntiCrash.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/8/30.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "NSMutableDictionary+AntiCrash.h"

@implementation NSMutableDictionary (AntiCrash)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oM = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
        Method sM = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(anti_setObject:forKey:));
        method_exchangeImplementations(oM, sM);
        
        Method oN = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKeyedSubscript:));
        Method sN = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(anti_setObject:forKeyedSubscript:));
        method_exchangeImplementations(oN, sN);
    });
}

-(void)antiSetObjectAlert
{
    NSLog(@"⚠️ %@: Insert Object Can't Be nil",[self class]);
}

-(void)anti_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!anObject) {
        [self antiSetObjectAlert];
        return;
    }
    [self anti_setObject:anObject forKey:aKey];
}

-(void)anti_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (!obj) {
        [self antiSetObjectAlert];
        return;
    }
    [self anti_setObject:obj forKeyedSubscript:key];
}

@end
