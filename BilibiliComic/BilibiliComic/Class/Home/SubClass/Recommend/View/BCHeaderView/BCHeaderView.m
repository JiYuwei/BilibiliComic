//
//  BCHeaderView.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/24.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BCHeaderView.h"
#import "BCFlowView.h"
#import "HomeBannerModel.h"

@interface BCHeaderView () <BCFlowViewDataSource,BCFlowViewDelegate>

@property (nonatomic,strong) BCFlowView *pageFlowView;

@end

@implementation BCHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - Setter

-(void)setHomeBannerModel:(HomeBannerModel *)homeBannerModel
{
    if (homeBannerModel && _homeBannerModel != homeBannerModel) {
        _homeBannerModel = homeBannerModel;
        [self.pageFlowView reloadData];
    }
}

#pragma mark - BCFlowViewDatasource

- (NSInteger)numberOfPagesInFlowView:(BCFlowView *)flowView
{
    return self.homeBannerModel.data.count;
}

- (BCIndexBannerSubview *)flowView:(BCFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    BCIndexBannerSubview *bannerView = (BCIndexBannerSubview *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[BCIndexBannerSubview alloc] init];
        bannerView.coverView.backgroundColor = [UIColor darkGrayColor];
    }
    //在这里下载网络图片
    NSString *imgURL = self.homeBannerModel.data[index].img2;
        [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:PlaceHolderIMG];
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
        _pageFlowView = [[BCFlowView alloc] initWithFrame:CGRectMake(0, BC_NAV_HEIGHT + TopPadding, BC_SCREEN_WIDTH, self.vHeight - BC_NAV_HEIGHT - TopPadding)];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0;
        _pageFlowView.leftRightMargin = LRPadding;
        _pageFlowView.topBottomMargin = LRPadding * 1.5;
        _pageFlowView.orginPageCount = 0;
        _pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView.autoTime = 3.0;
        _pageFlowView.orientation = BCFlowViewOrientationHorizontal;
        [self addSubview:_pageFlowView];
    }
    return _pageFlowView;
}

@end
