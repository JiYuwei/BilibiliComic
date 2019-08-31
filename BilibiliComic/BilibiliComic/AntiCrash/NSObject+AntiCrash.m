//
//  NSObject+AntiCrash.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/8/28.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "NSObject+AntiCrash.h"
#import "AntiCrashObject.h"

@implementation NSObject (AntiCrash)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oM = class_getInstanceMethod(self, @selector(methodSignatureForSelector:));
        Method sM = class_getInstanceMethod(self, @selector(anti_methodSignatureForSelector:));
        method_exchangeImplementations(oM, sM);
        
        Method oN = class_getInstanceMethod(self, @selector(forwardInvocation:));
        Method sN = class_getInstanceMethod(self, @selector(anti_forwardInvocation:));
        method_exchangeImplementations(oN, sN);
    });
}

#pragma mark - Class Method

+(NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

+(void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([AntiCrashObject respondsToSelector:anInvocation.selector]) {
        NSLog(@"⚠️ Not Found IMP: %@ +%@",anInvocation.target, NSStringFromSelector(anInvocation.selector));
        [anInvocation invokeWithTarget:[AntiCrashObject class]];
    }
    else {
        [self doesNotRecognizeSelector:anInvocation.selector];
    }
}

#pragma mark - Instance Method

-(NSMethodSignature *)anti_methodSignatureForSelector:(SEL)aSelector
{
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

-(void)anti_forwardInvocation:(NSInvocation *)anInvocation
{
    AntiCrashObject *obj = [AntiCrashObject new];
    if ([obj respondsToSelector:anInvocation.selector]) {
        NSLog(@"⚠️ Not Found IMP: %@ -%@",[anInvocation.target class], NSStringFromSelector(anInvocation.selector));
        [anInvocation invokeWithTarget:obj];
    }
    else {
        [self doesNotRecognizeSelector:anInvocation.selector];
    }
}

@end
