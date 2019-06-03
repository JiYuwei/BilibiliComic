//
//  NewListModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/3.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "NewListModel.h"

@implementation NewListModel

+ (NSDictionary *)objectClassInArray {
    return @{@"data" : [NewListData class]};
}

@end


@implementation NewListData

+ (NSDictionary *)objectClassInArray {
    return @{@"styles" : [NewListStyles class]};
}

@end

@implementation NewListStyles

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idField":@"id",};
}

@end
