//
//  NSArray+AntiCrash.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/8/29.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "NSArray+AntiCrash.h"

@implementation NSArray (AntiCrash)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray <NSString *> *clsList = @[@"__NSArray0",@"__NSSingleObjectArrayI",@"__NSArrayI",@"__NSArrayM"];
        for (NSString *cls in clsList) {
            Method oM = class_getInstanceMethod(NSClassFromString(cls), @selector(objectAtIndex:));
            Method sM = class_getInstanceMethod(NSClassFromString(cls), NSSelectorFromString([NSString stringWithFormat:@"%@_objectAtIndex:",cls]));
            method_exchangeImplementations(oM, sM);
            
            Method oN = class_getInstanceMethod(NSClassFromString(cls), @selector(objectAtIndexedSubscript:));
            Method sN = class_getInstanceMethod(NSClassFromString(cls), NSSelectorFromString([NSString stringWithFormat:@"%@_objectAtIndexedSubscript:",cls]));
            method_exchangeImplementations(oN, sN);
        }
    });
}

-(void)antiBeyondAlert:(NSInteger)index
{
    NSLog(@"⚠️ %@: Index %lu Beyond Bounds", [self class], index);
}

#pragma mark - Index

-(id)__NSArray0_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self __NSArray0_objectAtIndex:index];
    }
    [self antiBeyondAlert:index];
    return nil;
}

-(id)__NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self __NSSingleObjectArrayI_objectAtIndex:index];
    }
    [self antiBeyondAlert:index];
    return nil;
}

-(id)__NSArrayI_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self __NSArrayI_objectAtIndex:index];
    }
    [self antiBeyondAlert:index];
    return nil;
}

-(id)__NSArrayM_objectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self __NSArrayM_objectAtIndex:index];
    }
    [self antiBeyondAlert:index];
    return nil;
}

#pragma mark - IndexSubscript

-(id)__NSArray0_objectAtIndexedSubscript:(NSUInteger)idx
{
    if (idx < self.count) {
        return [self __NSArray0_objectAtIndexedSubscript:idx];
    }
    [self antiBeyondAlert:idx];
    return nil;
}

-(id)__NSSingleObjectArrayI_objectAtIndexedSubscript:(NSUInteger)idx
{
    if (idx < self.count) {
        return [self __NSSingleObjectArrayI_objectAtIndexedSubscript:idx];
    }
    [self antiBeyondAlert:idx];
    return nil;
}

-(id)__NSArrayI_objectAtIndexedSubscript:(NSUInteger)idx
{
    if (idx < self.count) {
        return [self __NSArrayI_objectAtIndexedSubscript:idx];
    }
    [self antiBeyondAlert:idx];
    return nil;
}

-(id)__NSArrayM_objectAtIndexedSubscript:(NSUInteger)idx
{
    if (idx < self.count) {
        return [self __NSArrayM_objectAtIndexedSubscript:idx];
    }
    [self antiBeyondAlert:idx];
    return nil;
}

@end
