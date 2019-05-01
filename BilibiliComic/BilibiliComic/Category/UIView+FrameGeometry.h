//
//  UIView+FrameGeometry.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/1.
//  Copyright © 2019 jyw. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (FrameGeometry)

@property CGPoint vOrigin;
@property CGSize  vSize;

@property (readonly) CGPoint vBottomLeft;
@property (readonly) CGPoint vBottomRight;
@property (readonly) CGPoint vTopRight;

@property CGFloat vHeight;
@property CGFloat vWidth;

@property CGFloat vTop;
@property CGFloat vLeft;

@property CGFloat vBottom;
@property CGFloat vRight;

- (void)moveBy:(CGPoint)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInSize:(CGSize)aSize;

@end


