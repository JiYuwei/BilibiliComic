//
//  HomeStockViewModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/6.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeStockViewModel.h"
#import "HomeBannerViewModel.h"
#import "RecomViewController.h"
#import "HomeStockListCell.h"
#import "HomeStockModel.h"

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

#pragma mark - OverWrite

-(void)initViewModelBinding
{
    [super initViewModelBinding];
    
    @weakify(self)
    [[RACObserve(self, model.data) skip:1] subscribeNext:^(id  _Nullable x) {
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

-(void)registerMainTableViewCell
{
    [self.recomVC.mainTableView registerClass:[HomeStockListCell class] forCellReuseIdentifier:NSStringFromClass([HomeStockListCell class])];
}

-(void)retrieveData
{
    [self.recomVC.bannerView.bannerViewModel retrieveBannerAllowCache:NO];
    [self retrieveHomeStockDataAllowCache:NO];
}

-(void)loadMoreData
{
    [self loadMoreHomeStockData];
}

#pragma mark - BCViewModelDataProtocol

-(NSInteger)customNumberOfRowsInSection:(NSInteger)section
{
    return self.model.data.list.count;
}

-(UITableViewCell *)customCellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    HomeStockListCell *cell = [self.recomVC.mainTableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeStockListCell class]) forIndexPath:indexPath];
    [cell.cellModel fillDataWithStockList:self.model.data.list[indexPath.row]];
    
    return cell;
}

#pragma mark - BCViewModelProtocol

-(CGFloat)customHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DefaultViewHeight;
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
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:nil needCache:cache requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
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
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:nil needCache:NO requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        HomeStockModel *homeStockModel = [HomeStockModel mj_objectWithKeyValues:json];
        [self addMoreEntriesWithModel:homeStockModel];
    } failure:nil];
}

-(void)addMoreEntriesWithModel:(HomeStockModel *)homeStockModel
{
    StockData *data = self.model.data;
    NSMutableArray <StockList *> *list = [NSMutableArray arrayWithArray:data.list];
    [list addObjectsFromArray:homeStockModel.data.list];
    data.list = list;
    data.seed = homeStockModel.data.seed;
    self.model.data = data;
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
