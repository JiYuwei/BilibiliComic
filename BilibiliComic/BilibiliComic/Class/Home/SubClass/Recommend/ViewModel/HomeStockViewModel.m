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

static const NSUInteger PageCount = 10;

@interface HomeStockViewModel ()

@property (nonatomic,strong) HomeStockModel      *model;
@property (nonatomic,weak)   RecomViewController *recomVC;

@end

@implementation HomeStockViewModel

-(instancetype)initWithResponder:(UIResponder *)responder
{
    if (self = [super initWithResponder:responder]) {
        [self retrieveHomeStockDataAllowCache:YES];
    }
    return self;
}

-(void)executeViewModelBinding
{
    [super executeViewModelBinding];
    
    @weakify(self)
    [[RACObserve(self, list) skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        UITableView *mainView = self.recomVC.mainTableView;
        
        if ([mainView.mj_header isRefreshing]) {
            [mainView.mj_header endRefreshing];
            [mainView.mj_footer resetNoMoreData];
        }
        if ([mainView.mj_footer isRefreshing]) {
            NSString *seed = self.model.data.seed;
            if (seed && seed.integerValue == 0) {
                [mainView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
                [mainView.mj_footer endRefreshing];
            }
        }
    
        [mainView reloadData];
    }];
}

-(void)retrieveData
{
//    [self.recomVC.bannerView.bannerViewModel retrieveBannerAllowCache:NO];
    [self retrieveHomeStockDataAllowCache:NO];
}

-(void)loadMoreData
{
    [self loadMoreHomeStockData];
}

#pragma mark - Data

//下拉刷新
-(void)retrieveHomeStockDataAllowCache:(BOOL)cache
{
    NSString *url = HOME_STOCK_URL;
    NSDictionary *parameters = @{@"omitCards":@2,
                                 @"page_num":@1,
                                 @"seed":@0,
                                 };
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:^{
        self.list = self.model.data.list;
    } needCache:cache requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        self.model = [HomeStockModel mj_objectWithKeyValues:json];
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        if (needCache) {
            self.model = [HomeStockModel mj_objectWithKeyValues:cachedJson];
        }
    }];
}

//上拉加载
-(void)loadMoreHomeStockData
{
    NSString *url = HOME_STOCK_URL;
    StockData *data = self.model.data;
    NSUInteger page = data.list.count / PageCount + 1;
    NSDictionary *parameters = @{@"omitCards":@2,
                                 @"page_num":@(page),
                                 @"seed":@(data.seed.integerValue),
                                 };
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:^{
        self.list = self.model.data.list;
    } needCache:NO requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        HomeStockModel *homeStockModel = [HomeStockModel mj_objectWithKeyValues:json];
        [self addMoreEntriesWithModel:homeStockModel];
    } failure:nil];
}

-(void)addMoreEntriesWithModel:(HomeStockModel *)homeStockModel
{
    NSMutableArray <List *> *list = [NSMutableArray arrayWithArray:self.model.data.list];
    [list addObjectsFromArray:homeStockModel.data.list];
    self.model.data.list = list;
    self.model.data.seed = homeStockModel.data.seed;
}

#pragma mark - LazyLoad

-(RecomViewController *)recomVC
{
    if (!_recomVC) {
        if ([self.responder isKindOfClass:[RecomViewController class]]) {
            _recomVC = (RecomViewController *)self.responder;
        }
    }
    return _recomVC;
}

@end
