//
//  UIView+FrameGeometry.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/1.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "UIView+FrameGeometry.h"

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

@implementation UIView (FrameGeometry)

// Retrieve and set the vOrigin
- (CGPoint) vOrigin
{
    return self.frame.origin;
}

- (void) setVOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize)vSize
{
    return self.frame.size;
}

- (void)setVSize:(CGSize)vSize
{
    CGRect newframe = self.frame;
    newframe.size = vSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint)vBottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)vBottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)vTopRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat)vHeight
{
    return self.frame.size.height;
}

- (void)setVHeight:(CGFloat)vHeight
{
    CGRect newframe = self.frame;
    newframe.size.height = vHeight;
    self.frame = newframe;
}

- (CGFloat)vWidth
{
    return self.frame.size.width;
}

- (void)setVWidth:(CGFloat)vWidth
{
    CGRect newframe = self.frame;
    newframe.size.width = vWidth;
    self.frame = newframe;
}

- (CGFloat)vTop
{
    return self.frame.origin.y;
}

- (void)setVTop:(CGFloat)vTop
{
    CGRect newframe = self.frame;
    newframe.origin.y = vTop;
    self.frame = newframe;
}

- (CGFloat)vLeft
{
    return self.frame.origin.x;
}

- (void)setVLeft:(CGFloat)vLeft
{
    CGRect newframe = self.frame;
    newframe.origin.x = vLeft;
    self.frame = newframe;
}

- (CGFloat)vBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setVBottom:(CGFloat)vBottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = vBottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)vRight
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setVRight:(CGFloat)vRight
{
    CGFloat delta = vRight - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}

// Move via offset
- (void) moveBy: (CGPoint) delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

// Scaling
- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

// Ensure that both dimensions fit within the given size by scaling down
- (void) fitInSize: (CGSize) aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

@end
