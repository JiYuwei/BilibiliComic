//
//  UIColor+HexColor.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/9.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HexColor)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *)colorWithHexString:(NSString *)color;

- (UIColor *)lightBackColor;

@end

NS_ASSUME_NONNULL_END
