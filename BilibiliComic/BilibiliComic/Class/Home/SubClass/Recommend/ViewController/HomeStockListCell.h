//
//  HomeStockListCell.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/2.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeStockCellModel.h"

static const CGFloat Padding = 18;

@interface HomeStockListCell : UITableViewCell

@property (nonatomic,strong) HomeStockCellModel *cellModel;

@property (nonatomic,strong) UIImageView *comicView;
//@property (nonatomic,strong) UIImageView *statusView;
@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UILabel     *subTitleLabel;
@property (nonatomic,strong) UILabel     *tagLabel;

@end
