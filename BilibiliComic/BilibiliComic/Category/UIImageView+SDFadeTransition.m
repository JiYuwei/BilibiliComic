//
//  UIImageView+SDFadeTransition.m
//  BilibiliComic
//
//  Created by JYW on 2019/5/10.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "UIImageView+SDFadeTransition.h"
#import "UIImage+ReSize.h"

@implementation UIImageView (SDFadeTransition)

-(void)sd_setFadeImageWithURL:(NSURL *)url
{
    [self sd_setFadeImageWithURL:url placeholderImage:nil options:SDWebImageAvoidAutoSetImage | SDWebImageScaleDownLargeImages progress:nil completed:nil];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self sd_setFadeImageWithURL:url placeholderImage:placeholder options:SDWebImageAvoidAutoSetImage | SDWebImageScaleDownLargeImages progress:nil completed:nil];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self sd_setFadeImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setFadeImageWithURL:url placeholderImage:nil options:SDWebImageAvoidAutoSetImage | SDWebImageScaleDownLargeImages progress:nil completed:completedBlock];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setFadeImageWithURL:url placeholderImage:placeholder options:SDWebImageAvoidAutoSetImage | SDWebImageScaleDownLargeImages progress:nil completed:completedBlock];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setFadeImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

-(void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock)completedBlock
{
    @weakify(self)
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        @strongify(self)
        if (image) {
            if (cacheType == SDImageCacheTypeNone) {
                CGSize reSize = self.vSize;
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    UIImage *reSizedImage = [image reSizeImage:reSize];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self fadeTransWithImage:reSizedImage];
                    });
                    
                    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:url];
                    [[SDImageCache sharedImageCache] removeImageForKey:key withCompletion:^{
                        [[SDWebImageManager sharedManager] saveImageToCache:reSizedImage forURL:url];
                    }];
                });
            }
            else
            if (cacheType == SDImageCacheTypeMemory) {
                self.image = image;
            }
            else {
                [self fadeTransWithImage:image];
            }
        }
        if (completedBlock) {
            completedBlock(image, error, cacheType, url);
        }
    }];
}

-(void)fadeTransWithImage:(UIImage *)image
{
    [UIView transitionWithView:self duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.image = image;
    } completion:nil];
}

@end
