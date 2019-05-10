//
//  UIImageView+SDFadeTransition.m
//  BilibiliComic
//
//  Created by JYW on 2019/5/10.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "UIImageView+SDFadeTransition.h"

@implementation UIImageView (SDFadeTransition)

-(void)sd_setFadeImageWithURL:(NSURL *)url
{
    [self sd_setFadeImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self sd_setFadeImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self sd_setFadeImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setFadeImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setFadeImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setFadeImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

-(void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDExternalCompletionBlock)completedBlock
{
    __weak typeof(self)wself = self;
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image && cacheType != SDImageCacheTypeMemory) {
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.25f];
            [animation setType:kCATransitionFade];
            animation.removedOnCompletion = YES;
            [wself.layer addAnimation:animation forKey:@"transition"];
        }
        if (completedBlock) {
            completedBlock(image, error, cacheType, url);
        }
    }];
    [self.layer removeAnimationForKey:@"transition"];
}

@end
