//
//  RankListViewCell.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RankData,RankComics;

@interface RankListViewCell : UITableViewCell

@property (nonatomic,assign) NSInteger  rank;

@property (nonatomic,strong) RankData   *rankData;
@property (nonatomic,strong) RankComics *fansComics;

@end


