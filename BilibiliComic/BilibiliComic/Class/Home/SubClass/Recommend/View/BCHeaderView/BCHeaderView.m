//
//  BCHeaderView.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/24.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BCHeaderView.h"
#import "BCFlowView.h"

@interface BCHeaderView () <BCFlowViewDataSource,BCFlowViewDelegate>

@property (nonatomic,strong) BCFlowView *pageFlowView;
@property (nonatomic,copy)   NSArray    *advArray;

@end

@implementation BCHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.advArray = @[@"home_update_img_264x160_",
                          @"icon-status-error_210x154_",
                          @"icon-status-check_280x150_"];
        
        [self.pageFlowView reloadData];
    }
    return self;
}

#pragma mark - BCFlowViewDatasource
- (NSInteger)numberOfPagesInFlowView:(BCFlowView *)flowView
{
    return self.advArray.count;
}
- (BCIndexBannerSubview *)flowView:(BCFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    BCIndexBannerSubview *bannerView = (BCIndexBannerSubview *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[BCIndexBannerSubview alloc] initWithFrame:CGRectMake(0, 0, self.pageFlowView.vWidth, self.pageFlowView.vHeight)];
        bannerView.coverView.backgroundColor = [UIColor darkGrayColor];
    }
    //在这里下载网络图片
    //    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.advArray[index]] placeholderImage:nil];
    //加载本地图片
//    bannerView.mainImageView.image = [UIImage imageNamed:self.advArray[index]];
    bannerView.mainImageView.backgroundColor = GRandomColor;
    return bannerView;
}

#pragma mark BCFlowViewDelegate

-(void)didScrollToPage:(NSInteger)pageNumber inFlowView:(BCFlowView *)flowView
{
    
}

-(void)didSelectCell:(BCIndexBannerSubview *)subView withSubViewIndex:(NSInteger)subIndex
{
    
}

#pragma mark - LazyLoad

-(BCFlowView *)pageFlowView
{
    if (!_pageFlowView) {
        _pageFlowView = [[BCFlowView alloc] initWithFrame:CGRectMake(0, BC_NAV_HEIGHT + 20, BC_SCREEN_WIDTH, self.vHeight - BC_NAV_HEIGHT - 20)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0;
        _pageFlowView.leftRightMargin = 20;
        _pageFlowView.topBottomMargin = 60;
        _pageFlowView.orginPageCount = _advArray.count;
        _pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView.autoTime = 3.0;
        _pageFlowView.orientation = BCFlowViewOrientationHorizontal;
        [self addSubview:_pageFlowView];
    }
    return _pageFlowView;
}

@end
