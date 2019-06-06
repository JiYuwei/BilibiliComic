//
//  HomeSearchViewModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/6.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeSearchViewModel.h"
#import "HomeSearchModel.h"
#import "SearchCycleScrollView.h"

@interface HomeSearchViewModel ()

@property (nonatomic,strong) HomeSearchModel       *model;
@property (nonatomic,weak)   SearchCycleScrollView *viewC;

@property (nonatomic,copy)   NSArray               *placeHolders;

@end

@implementation HomeSearchViewModel

-(instancetype)initWithBindingView:(id)viewC
{
    if (self = [super initWithBindingView:viewC]) {
        if ([viewC isKindOfClass:[SearchCycleScrollView class]]) {
            self.model = [[HomeSearchModel alloc] init];
            self.viewC = (SearchCycleScrollView *)viewC;
            [self executeViewModelBinding];
            [self retrieveSearchData];
        }
    }
    return self;
}

-(void)executeViewModelBinding
{
    RAC(self.viewC, placeHolders) = RACObserve(self, placeHolders);
}

#pragma mark - Data

-(void)retrieveSearchData
{
    NSString *url = HOME_RECOMMEND;
    NSDictionary *parameters = @{@"BanID":@0,
                                 @"JsonData":@"[{\"pool_id\":100006,\"num\":3}]"};
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:^{
        NSMutableArray *titleArray = [NSMutableArray array];
        for (SearchData *item in self.model.data) {
            [titleArray addObject:item.title];
        }
        self.placeHolders = titleArray;
    } needCache:YES requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        [self.model mj_setKeyValues:json];
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        if (needCache) {
            [self.model mj_setKeyValues:cachedJson];
        }
    }];
}

@end
