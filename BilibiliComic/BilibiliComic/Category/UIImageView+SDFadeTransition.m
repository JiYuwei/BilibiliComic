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

+ (instancetype)fadeImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    manager.delegate = imageView;
    return imageView;
}

-(void)sd_setFadeImageWithURL:(NSURL *)url
{
    [self sd_setFadeImageWithURL:url placeholderImage:nil options:SDWebImageAvoidAutoSetImage progress:nil completed:nil];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self sd_setFadeImageWithURL:url placeholderImage:placeholder options:SDWebImageAvoidAutoSetImage progress:nil completed:nil];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options
{
    [self sd_setFadeImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setFadeImageWithURL:url placeholderImage:nil options:SDWebImageAvoidAutoSetImage progress:nil completed:completedBlock];
}

- (void)sd_setFadeImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDExternalCompletionBlock)completedBlock
{
    [self sd_setFadeImageWithURL:url placeholderImage:placeholder options:SDWebImageAvoidAutoSetImage progress:nil completed:completedBlock];
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
            if (cacheType == SDImageCacheTypeMemory) {
                self.image = image;
            }
            else {
                [UIView transitionWithView:self duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                    self.image = image;
                } completion:nil];
            }
        }
        if (completedBlock) {
            completedBlock(image, error, cacheType, url);
        }
    }];
}

-(CGSize)realImageSize
{
    CGFloat width = self.vWidth;
    CGFloat height = self.vHeight;
    CGFloat scale = BC_SCALE;
    
    CGSize reSize = CGSizeMake(width * scale, height * scale);
    
    return reSize;
}

#pragma msrk - SDWebImageManagerDelegate

-(UIImage *)imageManager:(SDWebImageManager *)imageManager transformDownloadedImage:(UIImage *)image withURL:(NSURL *)imageURL
{
    CGSize  reSize = [self realImageSize];
    CGFloat scale   = reSize.width / image.size.width;
    
    return [image reSizeImage:reSize scale:scale];
}

@end
