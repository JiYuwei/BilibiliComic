//
//  BCIndexBannerSubview.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/24.
//  Copyright © 2019 jyw. All rights reserved.
//

/******************************
 
 可以根据自己的需要继承BCIndexBannerSubview
 
 ******************************/

#import <UIKit/UIKit.h>

@interface BCIndexBannerSubview : UIView

/**
 *  主图
 */
@property (nonatomic, strong) UIImageView *mainImageView;

/**
 *  阴影
 */
@property (nonatomic, strong) UIImageView *iconImage;

/**
 *  用来变色的view
 */
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, copy) void (^didSelectCellBlock)(NSInteger tag, BCIndexBannerSubview *cell);

/**
 设置子控件frame,继承后要重写
 
 @param superViewBounds 父视图大小
 */
- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds;



@end

