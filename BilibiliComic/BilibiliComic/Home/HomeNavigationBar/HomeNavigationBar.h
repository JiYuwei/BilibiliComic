//
//  HomeNavigationBar.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/12.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNavigationBarProtocol.h"
#import "HomePagesTopBar.h"
#import "HomeSearchBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeNavigationBar : UIView

@property (nonatomic,assign) HomeNavigationBarStyle navBarStyle;

@property (nonatomic,strong) HomePagesTopBar  *pagesTopBar;
@property (nonatomic,strong) HomeSearchBar    *searchBar;
@property (nonatomic,strong) UIButton         *timeLineBtn;

@end

NS_ASSUME_NONNULL_END
