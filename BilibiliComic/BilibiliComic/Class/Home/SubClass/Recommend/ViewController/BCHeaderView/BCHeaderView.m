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
    return self.bannerViewModel.imgURLs.count;
}

- (BCIndexBannerSubview *)flowView:(BCFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    BCIndexBannerSubview *bannerView = (BCIndexBannerSubview *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[BCIndexBannerSubview alloc] init];
        bannerView.coverView.backgroundColor = [UIColor darkGrayColor];
    }
    //在这里下载网络图片
    NSString *imgURL = self.bannerViewModel.imgURLs[index];
    [bannerView.mainImageView sd_setFadeImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:BCImage(@"comic_thumb_placeholder1_ico_343x192_")];

    //加载本地图片
//    bannerView.mainImageView.image = [UIImage imageNamed:self.advArray[index]];
//    bannerView.mainImageView.backgroundColor = GRandomColor;
    return bannerView;
}

#pragma mark BCFlowViewDelegate

-(CGSize)sizeForPageInFlowView:(BCFlowView *)flowView
{
    CGFloat pageWidth = BC_SCREEN_WIDTH - LRPadding * 2;
    return CGSizeMake(pageWidth, pageWidth / 2);
}

//-(void)didScrollToPage:(NSInteger)pageNumber inFlowView:(BCFlowView *)flowView
//{
//
//}

-(void)didSelectCell:(BCIndexBannerSubview *)subView withSubViewIndex:(NSInteger)subIndex
{
    
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
