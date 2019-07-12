//
//  RankFansView.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/18.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat FansViewHeight = 30;

@interface RankFansView : UIView

@property (nonatomic,strong) NSMutableArray <UIImageView *> *fansAvatars;
@property (nonatomic,strong) UIImageView *fansArrow;

@end

