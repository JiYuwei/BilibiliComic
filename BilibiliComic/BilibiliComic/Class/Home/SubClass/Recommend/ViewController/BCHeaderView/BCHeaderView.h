//
//  BCHeaderView.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/24.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBannerViewModel.h"

static const CGFloat TopPadding = 18;
static const CGFloat LRPadding  = 20;

#define HeaderViewHeight (BC_SCREEN_WIDTH - LRPadding * 2) / 2 + BC_NAV_HEIGHT + TopPadding

@interface BCHeaderView : UIView

@property (nonatomic,strong) HomeBannerViewModel *bannerViewModel;

-(void)reloadData;
-(void)startBgColorChanged;

@end


