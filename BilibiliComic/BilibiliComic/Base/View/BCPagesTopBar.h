//
//  BCPagesTopBar.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNavigationBarProtocol.h"

typedef NS_ENUM(NSUInteger, PagesTopBarType) {
    PagesTopBarTypeHome,
    PagesTopBarTypeRank
};

@interface BCPagesTopBar : UIView

@property (nonatomic,assign) PagesTopBarType         topBarType;
@property (nonatomic,assign) HomeNavigationBarStyle  topBarStyle;
@property (nonatomic,assign) NSUInteger              currentIndex;

@property (nonatomic,copy)   NSArray                 *itemTitles;

@property (nonatomic,strong) UIView                  *slider;

-(void)showSelectedIndex:(NSUInteger)index;

@end

