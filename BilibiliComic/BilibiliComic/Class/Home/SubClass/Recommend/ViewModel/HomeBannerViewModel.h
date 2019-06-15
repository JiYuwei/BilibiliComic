//
//  HomeBannerViewModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/6.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseViewModel.h"

@class BCFlowView,BCIndexBannerSubview;

@protocol HomeBannerDataProtocol <NSObject>

-(NSInteger)numberOfPages;
-(BCIndexBannerSubview *)flowView:(BCFlowView *)flowView customCellForPageAtIndex:(NSInteger)index;

@end


@interface HomeBannerViewModel : BaseViewModel <HomeBannerDataProtocol>

-(void)retrieveBannerAllowCache:(BOOL)cache;

@end

