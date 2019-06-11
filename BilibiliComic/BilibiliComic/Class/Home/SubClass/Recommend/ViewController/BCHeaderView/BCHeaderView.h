//
//  BCHeaderView.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/24.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBannerViewModel.h"
#import "BCFlowView.h"

static const CGFloat TopPadding = 18;
static const CGFloat LRPadding  = 20;

#define HeaderViewHeight (BC_SCREEN_WIDTH - LRPadding * 2) / 2 + BC_NAV_HEIGHT + TopPadding

@interface BCHeaderView : UIView <BCFlowViewDataSource,BCFlowViewDelegate>

@property (nonatomic,strong) HomeBannerViewModel *bannerViewModel;

@property (nonatomic,strong) BCFlowView *pageFlowView;

@end


