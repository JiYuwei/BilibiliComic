//
//  BCRefreshFooter.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/11.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BCRefreshFooter.h"

@implementation BCRefreshFooter

//Overwrite
-(void)prepare
{
    [super prepare];
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.stateLabel.textColor = RGBColor(200, 200, 200);
    [self setTitle:@"" forState:MJRefreshStateIdle];
    [self setTitle:@"" forState:MJRefreshStatePulling];
    [self setTitle:@"" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"" forState:MJRefreshStateRefreshing];
    [self setTitle:@"～没有更多了哦～" forState:MJRefreshStateNoMoreData];
}

@end
