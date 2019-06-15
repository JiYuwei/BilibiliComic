//
//  BCHeaderView.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/24.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BCHeaderView.h"

@implementation BCHeaderView 

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupGradientView];
        self.bannerViewModel = [[HomeBannerViewModel alloc] initWithResponder:self];
    }
    return self;
}

#pragma mark - UI

-(void)setupGradientView
{
    UIImageView *gradientView = [[UIImageView alloc] initWithFrame:self.frame];
    gradientView.image = BCImage(@"home_bg_header_1200x800_");
    [self addSubview:gradientView];
}

#pragma mark - BCFlowViewDatasource

- (NSInteger)numberOfPagesInFlowView:(BCFlowView *)flowView
{
    return [self.bannerViewModel numberOfPages];
}

- (BCIndexBannerSubview *)flowView:(BCFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    return [self.bannerViewModel flowView:flowView customCellForPageAtIndex:index];
}

#pragma mark BCFlowViewDelegate

-(CGSize)sizeForPageInFlowView:(BCFlowView *)flowView
{
    CGFloat pageWidth = BC_SCREEN_WIDTH - LRPadding * 2;
    return CGSizeMake(pageWidth, pageWidth / 2);
}

-(void)didSelectCell:(BCIndexBannerSubview *)subView withSubViewIndex:(NSInteger)subIndex
{
    //Empty RAC_signalForSelecter -> RecomViewController
}

#pragma mark - LazyLoad

-(BCFlowView *)pageFlowView
{
    if (!_pageFlowView) {
        _pageFlowView = [[BCFlowView alloc] initWithFrame:CGRectMake(0, BC_NAV_HEIGHT + TopPadding, BC_SCREEN_WIDTH, self.vHeight - BC_NAV_HEIGHT - TopPadding)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0;
        _pageFlowView.leftRightMargin = LRPadding;
        _pageFlowView.topBottomMargin = LRPadding * 1.5;
        _pageFlowView.orginPageCount = 0;
        _pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView.autoTime = DefaultTimeInterval;
        _pageFlowView.orientation = BCFlowViewOrientationHorizontal;
        [self addSubview:_pageFlowView];
    }
    return _pageFlowView;
}

@end
