//
//  RankViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RankViewController.h"
#import "PagesTopBar.h"
#import "RankListViewCell.h"
#import "RankListModel.h"

static const CGFloat    RankTopBarHeight = 40;

@interface RankViewController ()

@property (nonatomic,strong) RankListModel *rankListModel;

@property (nonatomic,strong) PagesTopBar *rankPagesTopBar;

@property (nonatomic,strong) UIScrollView *rankScrollView;
@property (nonatomic,strong) NSMutableArray <UITableView *> *rankTableViews;

@end

@implementation RankViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self retrieveRankData];
    
    [self initRankPagesTopBar];
    [self initRankTableViews];
}

#pragma mark - Data

-(void)retrieveRankData
{
    dispatch_apply(self.rankPagesTopBar.itemTitles.count, dispatch_get_global_queue(0, 0), ^(size_t index) {
        [self retrieveRankDataAtIndex:index allowCache:YES];
    });
}

-(void)retrieveRankDataAtIndex:(NSUInteger)index allowCache:(BOOL)cache
{
    NSArray *rankURLs   = @[HOME_HOT,HOME_HOT,HOME_FANS];
    NSDictionary *parameters = @{@"type":@(index)};
    
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:^{
        [self.rankTableViews[index].mj_header endRefreshing];
        [self.rankTableViews[index].mj_footer endRefreshingWithNoMoreData];
        [self.rankTableViews[index] reloadData];
    } needCache:cache requestType:HTTPRequestTypePOST fromURL:rankURLs[index] parameters:parameters success:^(NSDictionary *json) {
        self.rankListModel = [RankListModel mj_objectWithKeyValues:json];
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        if (needCache) {
            self.rankListModel = [RankListModel mj_objectWithKeyValues:cachedJson];
        }
    }];
}

#pragma mark - UI

-(void)initRankPagesTopBar
{
    @weakify(self)
    [[self.rankPagesTopBar rac_signalForSelector:@selector(showSelectedIndex:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        NSUInteger index = [x.first unsignedIntegerValue];
        CGFloat width = self.rankScrollView.vWidth;
        [self.rankScrollView setContentOffset:CGPointMake(width * index, 0) animated:YES];
    }];
}

-(void)initRankTableViews
{
    NSUInteger capacity = self.rankPagesTopBar.itemTitles.count;
    CGFloat    width    = self.rankScrollView.vWidth;
    CGFloat    height   = self.rankScrollView.vHeight;
    
    for (NSUInteger i = 0; i < capacity; i++) {
        UITableView *rankTableView = [[UITableView alloc] initWithFrame:CGRectMake(width * i, 0, width, height) style:UITableViewStyleGrouped];
        rankTableView.backgroundColor = [UIColor whiteColor];
        rankTableView.dataSource = self;
        rankTableView.delegate = self;
        rankTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        rankTableView.showsHorizontalScrollIndicator = NO;
        rankTableView.showsVerticalScrollIndicator = NO;
        
        rankTableView.mj_header = [BCRefreshHeader headerWithRefreshingBlock:^{
            [self retrieveRankDataAtIndex:i allowCache:NO];
        }];
        rankTableView.mj_footer = [BCRefreshFooter footerWithRefreshingBlock:nil];
        
        if (@available(iOS 11.0, *)) {
            rankTableView.estimatedRowHeight = 0;
            rankTableView.estimatedSectionHeaderHeight = 0;
            rankTableView.estimatedSectionFooterHeight = 0;
            rankTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [rankTableView registerClass:[RankListViewCell class] forCellReuseIdentifier:NSStringFromClass([RankListViewCell class])];
        
        [self.rankScrollView addSubview:rankTableView];
        [self.rankTableViews addObject:rankTableView];
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.rankTableViews.lastObject) {
        return self.rankListModel.fansData.comics.count;
    }
    return self.rankListModel.rankData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RankListViewCell class]) forIndexPath:indexPath];
    cell.rank = indexPath.row + 1;
    if (tableView == self.rankTableViews.lastObject) {
        cell.fansComics = self.rankListModel.fansData.comics[indexPath.row];
    }
    else{
        cell.rankData = self.rankListModel.rankData[indexPath.row];
    }
    return cell;
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.rankScrollView) {
        CGFloat offsetX = scrollView.contentOffset.x;
        
        PagesTopBar *pagesTopBar = self.rankPagesTopBar;
        UIView *slider = pagesTopBar.slider;
        CGFloat place = pagesTopBar.vWidth / pagesTopBar.itemTitles.count / 2;
        CGFloat percent = offsetX / BC_SCREEN_WIDTH * (pagesTopBar.itemTitles.count - 1);
        CGFloat x = place + place * percent;
        CGFloat y = slider.center.y;
        slider.center = CGPointMake(x, y);
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.rankScrollView) {
        CGFloat offsetX = scrollView.contentOffset.x;
        NSUInteger index = (NSUInteger)(offsetX / scrollView.vWidth);
        [self.rankPagesTopBar showSelectedIndex:index];
    }
}

#pragma mark - LazyLoad

-(PagesTopBar *)rankPagesTopBar
{
    if (!_rankPagesTopBar) {
        _rankPagesTopBar = [[PagesTopBar alloc] initWithFrame:CGRectMake(0, BC_NAV_HEIGHT, BC_SCREEN_WIDTH / 2, RankTopBarHeight)];
        _rankPagesTopBar.topBarType = PagesTopBarTypeRank;
        _rankPagesTopBar.itemTitles = @[@"人气榜",@"免费榜",@"应援榜"];
        [self.view addSubview:_rankPagesTopBar];
    }
    return _rankPagesTopBar;
}

-(UIScrollView *)rankScrollView
{
    if (!_rankScrollView) {
        _rankScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BC_NAV_HEIGHT + RankTopBarHeight, BC_SCREEN_WIDTH, BC_SCREEN_HEIGHT - BC_TABBAR_HEIGHT - BC_NAV_HEIGHT - RankTopBarHeight)];
        _rankScrollView.contentSize = CGSizeMake(BC_SCREEN_WIDTH * self.rankPagesTopBar.itemTitles.count, 0);
        _rankScrollView.showsVerticalScrollIndicator = NO;
        _rankScrollView.showsHorizontalScrollIndicator = NO;
        _rankScrollView.pagingEnabled = YES;
        _rankScrollView.bounces = NO;
        _rankScrollView.delegate = self;
        [self.view addSubview:_rankScrollView];
    }
    return _rankScrollView;
}

-(NSMutableArray<UITableView *> *)rankTableViews
{
    if (!_rankTableViews) {
        _rankTableViews = [NSMutableArray array];
    }
    return _rankTableViews;
}

@end
