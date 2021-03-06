//
//  SearchCycleScrollView.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeNavigationBarProtocol.h"

@interface SearchCycleScrollView : UIView

//滚动的时间间隔
@property (nonatomic,assign) NSTimeInterval interval;

@property (nonatomic,assign) HomeNavigationBarStyle cycleStyle;

-(void)openScrollMode;

@end
