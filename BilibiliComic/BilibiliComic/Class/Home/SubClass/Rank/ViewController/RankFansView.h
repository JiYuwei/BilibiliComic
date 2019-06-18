//
//  RankFansView.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/18.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reward_users;

static const CGFloat FansViewHeight = 30;

@interface RankFansView : UIView

@property (nonatomic,strong) NSArray <Reward_users *> *users;
@property (nonatomic,assign) NSInteger arrowDirection;

@end

