//
//  HomeStockCellModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/14.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseViewModel.h"

@class StockList;

@interface HomeStockCellModel : BaseViewModel

-(void)fillDataWithStockList:(StockList *)list;

@end

