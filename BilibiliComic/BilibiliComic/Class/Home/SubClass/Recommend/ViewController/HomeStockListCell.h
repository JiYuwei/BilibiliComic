//
//  HomeStockListCell.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/2.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class List;

static const CGFloat Padding = 18;

@interface HomeStockListCell : UITableViewCell

@property (nonatomic,strong) List *homeStockList;

@end