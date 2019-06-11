//
//  HomeStockViewModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/6.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseViewModel.h"

@class List;

@interface HomeStockViewModel : BaseViewModel

@property (nonatomic, copy) NSArray <List *> * list;

@end

