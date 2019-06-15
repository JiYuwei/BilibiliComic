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
    return @{@"list" : [StockList class]};
}

@end

@implementation StockList

+ (NSDictionary *)objectClassInArray {
    return @{@"styles" : [StockStyles class]};
}

@end

@implementation StockStyles

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"idField":@"id",};
}

@end
