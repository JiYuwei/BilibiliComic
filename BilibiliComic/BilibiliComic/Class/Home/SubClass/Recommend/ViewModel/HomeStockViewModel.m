//
//  HomeStockViewModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/6.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeStockViewModel.h"
#import "HomeBannerViewModel.h"
#import "HomeStockModel.h"
#import "RecomViewController.h"

@interface HomeStockViewModel ()

@property (nonatomic,strong) HomeStockModel      *model;
@property (nonatomic,weak)   RecomViewController *recomVC;

@property (nonatomic,weak)   HomeBannerViewModel *bannerViewModel;

@end

@implementation HomeStockViewModel

-(instancetype)initWithResponder:(UIResponder *)responder
{
    if (self = [super initWithResponder:responder]) {
        
    }
    return self;
}

-(void)executeViewModelBinding
{
    
}

//-(void)retrieveData
//{
//    [self.bannerView.bannerViewModel retrieveBannerAllowCache:NO];
//    [self retrieveHomeStockDataAllowCache:NO];
//}
//
//-(void)loadMoreData
//{
//    [self loadMoreHomeStockData];
//}


@end
