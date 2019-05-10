//
//  SearchCycleScrollView.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNavigationBarProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchCycleScrollView : UIView

//滚动的时间间隔
@property (nonatomic,assign) NSTimeInterval interval;
//数据源
@property (nonatomic,copy) NSArray *placeHolders;

@property (nonatomic,assign) HomeNavigationBarStyle cycleStyle;

@end

NS_ASSUME_NONNULL_END
