//
//  HomeNavigationBarProtocol.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HomeNavigationBarStyle) {
    HomeNavigationBarStylePrepared      = -1,
    HomeNavigationBarStyleDefault       = 0,
    HomeNavigationBarStyleLightContent  = 1
};

@protocol HomeNavigationBarProtocol <NSObject>

-(void)showNavigationBarStyle:(HomeNavigationBarStyle)style;

@end

NS_ASSUME_NONNULL_END
