//
//  HomeBannerViewModel.h
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/6.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomeBannerViewModel : BaseViewModel

@property (nonatomic,copy,readonly) NSArray <NSString *>  *imgURLs;
@property (nonatomic,copy,readonly) NSArray <UIColor *>   *colorBox;

-(void)retrieveBannerAllowCache:(BOOL)cache;

@end

