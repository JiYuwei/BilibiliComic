//
//  RankListViewCell.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RankData,RankComics;

static const CGFloat CellHeight = 155;
static const CGFloat Padding    = 10;
static const CGFloat Aspect     = 0.75;

@interface RankListViewCell : UITableViewCell

@property (nonatomic,assign) NSInteger  rank;

@property (nonatomic,strong) RankData   *rankData;
@property (nonatomic,strong) RankComics *fansComics;

@end


