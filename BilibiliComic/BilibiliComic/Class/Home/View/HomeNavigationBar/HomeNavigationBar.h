//
//  HomeNavigationBar.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/12.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNavigationBarProtocol.h"
#import "BCPagesTopBar.h"
#import "HomeSearchBar.h"

@interface HomeNavigationBar : UIView

@property (nonatomic,assign) HomeNavigationBarStyle navBarStyle;

@property (nonatomic,strong) BCPagesTopBar      *pagesTopBar;
@property (nonatomic,strong) HomeSearchBar    *searchBar;
@property (nonatomic,strong) UIButton         *timeLineBtn;

@end
