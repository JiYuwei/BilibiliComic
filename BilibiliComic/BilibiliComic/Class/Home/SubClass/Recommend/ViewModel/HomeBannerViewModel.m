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

@property (nonatomic,copy,readwrite) NSArray <NSString *>  *imgURLs;
@property (nonatomic,copy,readwrite) NSArray <UIColor *>   *colorBox;

@property (nonatomic,strong) HomeBannerModel  *model;
@property (nonatomic,weak)   BCHeaderView     *viewC;

@end

@implementation HomeBannerViewModel

-(instancetype)initWithBindingView:(id)viewC
{
    if (self = [super initWithBindingView:viewC]) {
        if ([viewC isKindOfClass:[BCHeaderView class]]) {
            self.model = [[HomeBannerModel alloc] init];
            self.viewC = (BCHeaderView *)viewC;
            [self executeViewModelBinding];
            [self retrieveBannerAllowCache:YES];
        }
    }
    return self;
}

-(void)executeViewModelBinding
{
    @weakify(self)
    [RACObserve(self, imgURLs) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.viewC reloadData];
    }];
    
    [RACObserve(self, colorBox) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.viewC startBgColorChanged];
    }];
}

#pragma mark - Data

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
        [self.model mj_setKeyValues:json];
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        [self.model mj_setKeyValues:cachedJson];
    }];
}

@end
