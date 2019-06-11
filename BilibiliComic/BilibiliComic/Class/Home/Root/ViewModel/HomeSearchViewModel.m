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

@property (nonatomic,copy,readwrite) NSArray *placeHolders;

@property (nonatomic,strong) HomeSearchModel       *model;
@property (nonatomic,weak)   SearchCycleScrollView *view;

@end

@implementation HomeSearchViewModel

-(instancetype)initWithResponder:(UIResponder *)responder
{
    if (self = [super initWithResponder:responder]) {
        [self retrieveSearchData];
    }
    return self;
}

-(void)executeViewModelBinding
{
    @weakify(self)
    [RACObserve(self, placeHolders) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.view openScrollMode];
    }];
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
        self.model = [HomeSearchModel mj_objectWithKeyValues:json];
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        if (needCache) {
            self.model = [HomeSearchModel mj_objectWithKeyValues:cachedJson];
        }
    }];
}

#pragma mark - LazyLoad

-(SearchCycleScrollView *)view
{
    if (!_view) {
        if ([self.responder isKindOfClass:[SearchCycleScrollView class]]) {
            _view = (SearchCycleScrollView *)self.responder;
        }
    }
    return _view;
}

@end
