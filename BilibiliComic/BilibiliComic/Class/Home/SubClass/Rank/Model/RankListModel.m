//
//  RankListModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RankListModel.h"

@implementation RankListModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"rankData":@"data",
             @"fansData":@"data"};
}

+ (NSDictionary *)objectClassInArray {
    return @{@"rankData" : [RankData class],
             @"fansData" : [FansData class]};
}

@end


@implementation RankData

+ (NSDictionary *)objectClassInArray {
    return @{@"styles" : [RankStyles class]};
}

@end

@implementation FansData

+ (NSDictionary *)objectClassInArray {
    return @{@"comics" : [RankComics class]};
}

@end

@implementation RankComics

+ (NSDictionary *)objectClassInArray {
    return @{@"styles" : [RankStyles class],
             @"reward_users" : [Reward_users class]};
}

@end

@implementation Reward_users

@end

@implementation RankStyles

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idField":@"id",};
}

@end
