//
//  UIImage+ReSize.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/17.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "UIImage+ReSize.h"

@implementation UIImage (ReSize)

- (UIImage *)reSizeImage:(CGSize)reSize scale:(CGFloat)scale
{
    NSData  *data        = UIImageJPEGRepresentation(self, scale);
    UIImage *resultImage = [UIImage imageWithData:data];
    
    UIGraphicsBeginImageContext(reSize);
    [resultImage drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

@end
