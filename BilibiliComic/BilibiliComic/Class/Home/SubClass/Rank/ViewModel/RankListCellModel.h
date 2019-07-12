//
//  RankListCellModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/7/12.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseViewModel.h"

@class RankData,RankComics;

@interface RankListCellModel : BaseViewModel

@property (nonatomic,assign) NSInteger rank;

-(void)fillDataWithRankData:(RankData *)list;
-(void)fillDataWithRankComics:(RankComics *)list;

@end

