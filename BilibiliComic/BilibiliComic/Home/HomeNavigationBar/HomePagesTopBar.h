//
//  HomePagesTopBar.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HomePagesTopBarStyle) {
    HomePagesTopBarStyleDefault,
    HomePagesTopBarStyleLightContent
};

@interface HomePagesTopBar : UIView

@property (nonatomic,copy)   NSArray               *itemTitles;
@property (nonatomic,assign) HomePagesTopBarStyle  topBarStyle;
@property (nonatomic,assign) NSUInteger            currentIndex;

@end

NS_ASSUME_NONNULL_END
