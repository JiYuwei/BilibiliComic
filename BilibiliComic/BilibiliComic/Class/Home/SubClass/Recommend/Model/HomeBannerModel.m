//
//  HomeBannerModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/8.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeBannerModel.h"

@implementation HomeBannerModel

+ (NSDictionary *)objectClassInArray {
    return @{@"data" : [BannerData class]};
}

-(BOOL)isEqualToHomeBannerModel:(HomeBannerModel *)model
{
    return [self.data isEqualToArray:model.data];
}

#pragma mark - NSObject

-(BOOL)isEqual:(id)object
{
    if ([self class] == [object class]) {
        return [self isEqualToHomeBannerModel:(HomeBannerModel *)object];
    }
    else{
        return [super isEqual:object];
    }
}

-(NSUInteger)hash
{
    return self.data.hash;
}

@end


@implementation BannerData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idField":@"id",};
}

-(BOOL)isEqual:(id)object
{
    if ([self class] == [object class]) {
        return self.idField == ((BannerData *)object).idField;
    }
    return NO;
}

@end
