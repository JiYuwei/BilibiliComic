//
//  HomeBannerViewModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/6.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeBannerViewModel.h"
#import "HomeBannerModel.h"
#import "BCHeaderView.h"

@interface HomeBannerViewModel ()

@property (nonatomic,strong) HomeBannerModel  *model;
@property (nonatomic,weak)   BCHeaderView     *view;

@property (nonatomic,copy) NSArray <NSString *>  *imgURLs;
@property (nonatomic,copy) NSArray <UIColor *>   *colorBox;

@end

@implementation HomeBannerViewModel

-(instancetype)initWithResponder:(UIResponder *)responder
{
    if (self = [super initWithResponder:responder]) {
        [self retrieveBannerAllowCache:YES];
    }
    return self;
}

#pragma mark - OverWrite

-(void)initViewModelBinding
{
    @weakify(self)
    
    [[RACObserve(self, imgURLs) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.view.pageFlowView reloadData];
    }];
    
    [[RACObserve(self, colorBox) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.view.backgroundColor = self.colorBox.firstObject;
    }];
    
    [[self.view.pageFlowView rac_signalForSelector:@selector(scrollViewDidScroll:)] subscribeNext:^(RACTuple * _Nullable views) {
        @strongify(self)
        
        NSArray <UIColor *> *box = self.colorBox;
        
        if (box.count > 0) {
            UIScrollView *scrollView = (UIScrollView *)views.first;
            CGFloat offset = scrollView.contentOffset.x;
            
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
                
                self.view.backgroundColor = [UIColor colorWithRed:R green:G blue:B alpha:1];
            }
        }
    }];
}

#pragma mark - Public & Data 

-(void)retrieveBannerAllowCache:(BOOL)cache
{
    NSString *url = HOME_BANNER;
    NSDictionary *parameters = @{@"platform":APP_DEVICE};
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:^{
        NSMutableArray <NSString *> *imgURLs = [NSMutableArray array];
        NSMutableArray <UIColor *> *colorBox = [NSMutableArray array];
        for (BannerData *item in self.model.data) {
            [imgURLs addObject:item.img2];
            [colorBox addObject:[UIColor colorWithHexString:item.bg]];
        }
        self.imgURLs  = imgURLs;
        self.colorBox = colorBox;
    } needCache:cache requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        self.model = [HomeBannerModel mj_objectWithKeyValues:json];
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        self.model = [HomeBannerModel mj_objectWithKeyValues:cachedJson];
    }];
}

#pragma mark - HomeBannerDataProtocol

-(NSInteger)numberOfPages
{
    return self.imgURLs.count;
}

-(BCIndexBannerSubview *)flowView:(BCFlowView *)flowView customCellForPageAtIndex:(NSInteger)index
{
    BCIndexBannerSubview *bannerView = (BCIndexBannerSubview *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[BCIndexBannerSubview alloc] init];
        bannerView.coverView.backgroundColor = [UIColor darkGrayColor];
    }
    //在这里下载网络图片
    NSString *imgURL = self.imgURLs[index];
    [bannerView.mainImageView sd_setFadeImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:BCImage(@"comic_thumb_placeholder1_ico_343x192_")];
    
    return bannerView;
}

#pragma mark - LazyLoad

-(BCHeaderView *)view
{
    if (!_view) {
        if ([self.responder isKindOfClass:[BCHeaderView class]]) {
            _view = (BCHeaderView *)self.responder;
        }
    }
    return _view;
}

@end
