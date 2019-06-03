//
//  NewViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "NewViewController.h"
#import "PSCollectionView.h"
#import "NewViewCell.h"
#import "NewFootView.h"
#import "NewListModel.h"
#import "NewOrderModel.h"

@interface NewViewController () <PSCollectionViewDataSource,PSCollectionViewDelegate>

@property (nonatomic,strong) NewListModel     *newsListModel;
@property (nonatomic,strong) NewOrderModel    *newsOrderModel;

@property (nonatomic,strong) PSCollectionView *newsCollectionView;
@property (nonatomic,strong) NewFootView      *footView;

@end

@implementation NewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initNewsCollectionView];
    [self retrieveNewsOrderData];
    [self retrieveNewsDataAllowCache:YES];
}

#pragma mark - UI

-(void)initNewsCollectionView
{
    self.newsCollectionView.mj_header = [BCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(retrieveNewsData)];
    
    self.newsCollectionView.footerView = self.footView;
}

#pragma mark - Data

-(void)retrieveNewsOrderData
{
    NSString *url = HOME_NEWORDER;
    NSDictionary *parameters = @{};
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:^{
        self.footView.data = self.newsOrderModel.data;
    } needCache:YES requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        self.newsOrderModel = [NewOrderModel mj_objectWithKeyValues:json];
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        if (needCache) {
            self.newsOrderModel = [NewOrderModel mj_objectWithKeyValues:cachedJson];
        }
    }];
}

-(void)retrieveNewsDataAllowCache:(BOOL)cache
{
    NSString *url = HOME_NEW;
    NSDictionary *parameters = @{@"page_num":@1};
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:^{
        [self.newsCollectionView.mj_header endRefreshing];
        [self.newsCollectionView reloadData];
        self.footView.loadMoreBtn.enabled = YES;
    } needCache:cache requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        self.newsListModel = [NewListModel mj_objectWithKeyValues:json];
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        if (needCache) {
            self.newsListModel = [NewListModel mj_objectWithKeyValues:cachedJson];
        }
    }];
}

-(void)retrieveNewsData
{
    [self retrieveNewsDataAllowCache:NO];
}

-(void)loadMoreNewsData
{
        
}
                                         
#pragma mark - PSCollectionViewDataSource

-(NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return self.newsListModel.data.count;
}

-(PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    NewViewCell *cell = (NewViewCell *)[collectionView dequeueReusableViewForClass:[NewViewCell class]];
    if (!cell) {
        cell = [[NewViewCell alloc] init];
    }
    [cell collectionView:collectionView fillCellWithObject:nil atIndex:index];
    cell.data = self.newsListModel.data[index];
    return cell;
}

-(CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return [NewViewCell rowHeightForObject:nil inColumnWidth:collectionView.colWidth];
}

#pragma mark PSCollectionViewDelegate

-(Class)collectionView:(PSCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index
{
    return [NewViewCell class];
}

-(void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    NSLog(@"Select: %ld",index);
}

#pragma mark - LazyLoad

-(PSCollectionView *)newsCollectionView
{
    if (!_newsCollectionView) {
        _newsCollectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0, BC_NAV_HEIGHT, BC_SCREEN_WIDTH, BC_SCREEN_HEIGHT - BC_TABBAR_HEIGHT - BC_NAV_HEIGHT)];
        _newsCollectionView.collectionViewDataSource = self;
        _newsCollectionView.collectionViewDelegate = self;
        _newsCollectionView.showsVerticalScrollIndicator = NO;
        _newsCollectionView.showsHorizontalScrollIndicator = NO;
        _newsCollectionView.numColsPortrait = 2;
        [self.view addSubview:_newsCollectionView];
    }
    return _newsCollectionView;
}

-(NewFootView *)footView
{
    if (!_footView) {
        _footView = [[NewFootView alloc] initWithFrame:CGRectMake(0, 0, BC_SCREEN_WIDTH, 420)];
        [self.view addSubview:_footView];
    }
    return _footView;
}

@end
