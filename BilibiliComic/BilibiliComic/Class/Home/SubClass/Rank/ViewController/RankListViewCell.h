//
//  RankListViewCell.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RankListCellModel.h"
#import "RankFansView.h"

static const CGFloat CellHeight = 155;
static const CGFloat Padding    = 10;
static const CGFloat Aspect     = 0.75;

@interface RankListViewCell : UITableViewCell

@property (nonatomic,strong) RankListCellModel *cellModel;

@property (nonatomic,strong) UILabel      *rankLabel;

@property (nonatomic,strong) UIImageView  *comicView;
@property (nonatomic,strong) UILabel      *titleLabel;

@property (nonatomic,strong) UILabel      *fansSrcLabel;
@property (nonatomic,strong) UILabel      *fansCountLabel;
@property (nonatomic,strong) RankFansView *fansView;

@property (nonatomic,strong) UILabel      *srcLabel;
@property (nonatomic,strong) UILabel      *typeLabel;
@property (nonatomic,strong) UILabel      *updateLabel;

@end


