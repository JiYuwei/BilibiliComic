//
//  HomePagesTopBar.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNavigationBarProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomePagesTopBar : UIView

@property (nonatomic,assign) HomeNavigationBarStyle  topBarStyle;
@property (nonatomic,assign) NSUInteger              currentIndex;

@property (nonatomic,copy)   NSArray                 *itemTitles;

@property (nonatomic,strong) UIView                  *slider;

-(void)showSelectedIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
