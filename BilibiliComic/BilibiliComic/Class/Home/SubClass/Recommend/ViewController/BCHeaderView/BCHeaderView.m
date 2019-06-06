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

@end

@implementation BCHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupGradientView];
        self.bannerViewModel = [[HomeBannerViewModel alloc] initWithBindingView:self];
    }
    return self;
}

#pragma mark - Public

-(void)reloadData
{
    [self.pageFlowView reloadData];
}

-(void)startBgColorChanged
{
    self.backgroundColor = self.bannerViewModel.colorBox.firstObject;
    [[self.pageFlowView rac_signalForSelector:@selector(scrollViewDidScroll:)] subscribeNext:^(RACTuple * _Nullable x) {
        UIScrollView *scrollView = (UIScrollView *)x.first;
        [self changeBgColorWithContentOffSet:scrollView.contentOffset.x];
    }];
}

#pragma mark -

//轮播图背景色渐变
- (void)changeBgColorWithContentOffSet:(CGFloat)offset
{
    NSArray <UIColor *> *box = self.bannerViewModel.colorBox;
    
    const CGFloat pWidth     = BC_SCREEN_WIDTH - LRPadding * 2;
    const NSUInteger count   = box.count;
    
    CGFloat x = offset - pWidth * count;
    if (x < 0) x = x + pWidth * count;
    x = x / pWidth;
    
    if (count > 0) {
        NSInteger currentIndex = (NSInteger)floorf(x);
        NSInteger nextIndex    = currentIndex + 1;
        if (nextIndex >= count) nextIndex = 0;
        
        const CGFloat *CComp = CGColorGetComponents(box[currentIndex].CGColor);
        const CGFloat *NComp = CGColorGetComponents(box[nextIndex].CGColor);
        
        CGFloat R = CComp[0] + (NComp[0] - CComp[0]) * (x - currentIndex);
        CGFloat G = CComp[1] + (NComp[1] - CComp[1]) * (x - currentIndex);
        CGFloat B = CComp[2] + (NComp[2] - CComp[2]) * (x - currentIndex);
       
//        NSLog(@"%f,%f,%f",R,G,B);
        self.backgroundColor = [UIColor colorWithRed:R green:G blue:B alpha:1];
    }
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