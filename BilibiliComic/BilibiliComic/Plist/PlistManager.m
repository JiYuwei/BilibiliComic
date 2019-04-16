//
//  PlistManager.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "PlistManager.h"

@implementation PlistManager

+(instancetype)sharedManager
{
    static PlistManager *manager = nil;
    kDISPATCH_ONCE(^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    return [PlistManager sharedManager];
}

#pragma mark - Public

+(CGFloat)widthWithKey:(NSString *)key
{
    return [[PlistManager sharedManager] widthWithKey:key];
}

#pragma mark - Private

-(CGFloat)widthWithKey:(NSString *)key
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"UIWidthList" ofType:@"plist"];
    NSDictionary *widthDic = [NSDictionary dictionaryWithContentsOfFile:path];
    NSString *width = [NSString stringWithFormat:@"%lu",(unsigned long)BCSCREEN_WIDTH];
    NSNumber *widthNum = widthDic[key][width];
    
    return [widthNum floatValue];
}

@end
