//
//  HomeStockModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/8.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseModel.h"

@class StockData,List,Styles;

@interface HomeStockModel : BaseModel

@property (nonatomic, strong) StockData * data;

@end

@interface StockData : NSObject

@property (nonatomic, copy)   NSString * seed;
@property (nonatomic, copy)   NSArray <List *> * list;

@end

@interface List : NSObject

@property (nonatomic, copy)   NSString * img;
@property (nonatomic, copy)   NSArray <Styles *> * styles;
@property (nonatomic, copy)   NSString * sub_title;
@property (nonatomic, copy)   NSString * jump_value;
@property (nonatomic, assign) NSInteger  comic_id;
@property (nonatomic, copy)   NSString * title;

@end

@interface Styles : NSObject

@property (nonatomic, assign) NSInteger  idField;
@property (nonatomic, copy)   NSString * name;

@end

