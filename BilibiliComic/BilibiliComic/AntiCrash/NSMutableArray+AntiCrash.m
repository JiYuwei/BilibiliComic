//
//  NSMutableArray+AntiCrash.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/8/30.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "NSMutableArray+AntiCrash.h"

@implementation NSMutableArray (AntiCrash)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oM = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(insertObject:atIndex:));
        Method sM = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(anti_insertObject:atIndex:));
        method_exchangeImplementations(oM, sM);
        
        Method oN = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(setObject:atIndexedSubscript:));
        Method sN = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(anti_setObject:atIndexedSubscript:));
        method_exchangeImplementations(oN, sN);
    });
}

-(void)antiInserAlert
{
    NSLog(@"⚠️ %@: Insert Object Can't Be nil",[self class]);
}

-(void)anti_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject) {
        [self antiInserAlert];
        return;
    }
    [self anti_insertObject:anObject atIndex:index];
}

- (void)anti_setObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    if (!obj) {
        [self antiInserAlert];
        return;
    }
    [self anti_setObject:obj atIndexedSubscript:idx];
}

@end
