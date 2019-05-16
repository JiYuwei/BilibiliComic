//
//  HomeSearchBar.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNavigationBarProtocol.h"

static const CGFloat TBMargin = 8;

@class SearchData;

@interface HomeSearchBar : UIView

@property (nonatomic,assign) HomeNavigationBarStyle searchBarStyle;
@property (nonatomic,copy) NSArray <SearchData *> *data;

@end
