//
//  HomeStockModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/8.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeStockModel.h"

@implementation HomeStockModel

+ (NSDictionary *)objectClassInArray {
    return @{@"data" : [StockData class]};
}

@end


@implementation StockData

+ (NSDictionary *)objectClassInArray {
    return @{@"list" : [List class]};
}

@end

@implementation List

+ (NSDictionary *)objectClassInArray {
    return @{@"styles" : [Styles class]};
}

@end

@implementation Styles

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idField":@"id",};
}

@end
