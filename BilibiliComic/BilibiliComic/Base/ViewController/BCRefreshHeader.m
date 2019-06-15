//
//  BCRefreshHeader.m
//  ParentsWeekend
//
//  Created by 纪宇伟 on 2019/2/24.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BCRefreshHeader.h"

@implementation BCRefreshHeader

//Overwrite
-(void)prepare
{
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 17; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"comic_pull_loading_%zd_180x60_", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 17; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"comic_pull_loading_%zd_180x60_", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    [self setTitle:@"正在加载数据" forState:MJRefreshStateRefreshing];
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.stateLabel.hidden = YES;
    self.lastUpdatedTimeLabel.hidden = YES;
}

@end
