//
//  AntiCrashObject.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/8/29.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "AntiCrashObject.h"

@implementation AntiCrashObject

+(BOOL)resolveClassMethod:(SEL)sel
{
    return class_addMethod(object_getClass(self), sel, (IMP)anti_crash_alert, "v@:");
}

+(BOOL)resolveInstanceMethod:(SEL)sel
{
    return class_addMethod(self, sel, (IMP)anti_crash_alert, "v@:");
}

void anti_crash_alert(id self,SEL _cmd)
{
    printf("AntiCrashed\n");
}

@end
