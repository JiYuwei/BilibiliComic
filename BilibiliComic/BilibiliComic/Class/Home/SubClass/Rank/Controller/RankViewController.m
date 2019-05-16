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

@property (nonatomic,strong) PagesTopBar *rankPagesTopBar;

@property (nonatomic,strong) UIScrollView *rankScrollView;
@property (nonatomic,strong) NSMutableArray <UITableView *>   *rankTableViews;
@property (nonatomic,strong) NSMutableArray <RankListModel *> *rankListModels;

@end

@implementation RankViewController
{
    NSUInteger Capacity;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Capacity = self.rankPagesTopBar.itemTitles.count;
    
    [self initRankPagesTopBar];
    [self initRankTableViews];
    
    [self retrieveRankData];
}

#pragma mark - Data

-(void)retrieveRankData
{
    for (NSInteger i = 0; i < Capacity; i++) {
        [self retrieveRankDataAtIndex:i allowCache:YES];
    }
}

-(void)retrieveRankDataAtIndex:(NSUInteger)index allowCache:(BOOL)cache
{
    BOOL isHot = index < 2;
    NSString *url = isHot ? HOME_HOT : HOME_FANS;
    NSDictionary *parameters = isHot ? @{@"type":@(index)} : @{};
    
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:^{
        [self.rankTableViews[index].mj_header endRefreshing];
        [self.rankTableViews[index].mj_footer endRefreshingWithNoMoreData];
        [self.rankTableViews[index] reloadData];
    } needCache:cache requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        self.rankListModels[index] = [RankListModel mj_objectWithKeyValues:json];
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        if (needCache) {
            self.rankListModels[index] = [RankListModel mj_objectWithKeyValues:cachedJson];
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
    CGFloat    width    = self.rankScrollView.vWidth;
    CGFloat    height   = self.rankScrollView.vHeight;
    
    for (NSUInteger i = 0; i < Capacity; i++) {
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
    NSUInteger index = [self.rankTableViews indexOfObject:tableView];

    if (tableView == self.rankTableViews.lastObject) {
        return self.rankListModels.lastObject.fansData.comics.count;
    }
    else{
        return self.rankListModels[index].rankData.count;
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RankListViewCell class]) forIndexPath:indexPath];
    cell.rank = indexPath.row + 1;
    
    NSUInteger index = [self.rankTableViews indexOfObject:tableView];
    
    if (tableView == self.rankTableViews.lastObject) {
        cell.fansComics = self.rankListModels.lastObject.fansData.comics[indexPath.row];
    }
    else{
        cell.rankData = self.rankListModels[index].rankData[indexPath.row];
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
        _rankScrollView.contentSize = CGSizeMake(BC_SCREEN_WIDTH * Capacity, 0);
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
        _rankTableViews = [NSMutableArray arrayWithCapacity:Capacity];
    }
    return _rankTableViews;
}

-(NSMutableArray<RankListModel *> *)rankListModels
{
    if (!_rankListModels) {
        _rankListModels = [NSMutableArray arrayWithCapacity:Capacity];
        for (NSInteger i = 0; i < Capacity; i++) {
            RankListModel *model = [[RankListModel alloc] init];
            [_rankListModels addObject:model];
        }
    }
    return _rankListModels;
}

@end
