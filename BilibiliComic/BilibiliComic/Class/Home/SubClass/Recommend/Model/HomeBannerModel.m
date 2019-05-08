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

@end


@implementation BannerData

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idField":@"id",};
}

@end
