//
//  RankViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RankViewController.h"
#import "BCPagesTopBar.h"
#import "RankListViewModel.h"

static const CGFloat RankTopBarHeight = 40;

@interface RankViewController ()

@property (nonatomic,assign) NSUInteger     capacity;
@property (nonatomic,strong) BCPagesTopBar *rankPagesTopBar;
@property (nonatomic,strong) UIScrollView  *rankScrollView;

@property (nonatomic,strong) NSMutableArray <UITableView *>   *rankTableViews;
@property (nonatomic,strong) NSMutableArray <RankListViewModel *> *rankListViewModels;

@end

@implementation RankViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initRankPagesTopBar];
    [self initRankTableViews];
    [self initRankListViewModels];
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
    CGFloat width  = self.rankScrollView.vWidth;
    CGFloat height = self.rankScrollView.vHeight;
    
    for (NSUInteger i = 0; i < self.capacity; i++) {
        UITableView *rankTableView = [[UITableView alloc] initWithFrame:CGRectMake(width * i, 0, width, height) style:UITableViewStyleGrouped];
        rankTableView.backgroundColor = [UIColor whiteColor];
        rankTableView.dataSource = self;
        rankTableView.delegate = self;
        rankTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        rankTableView.showsHorizontalScrollIndicator = NO;
        rankTableView.showsVerticalScrollIndicator = NO;
        
        rankTableView.mj_header = [[BCRefreshHeader alloc] init];
        rankTableView.mj_footer = [[BCRefreshFooter alloc] init];
        
        if (@available(iOS 11.0, *)) {
            rankTableView.estimatedRowHeight = 0;
            rankTableView.estimatedSectionHeaderHeight = 0;
            rankTableView.estimatedSectionFooterHeight = 0;
            rankTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [self.rankScrollView addSubview:rankTableView];
        [self.rankTableViews addObject:rankTableView];
    }
}

-(void)initRankListViewModels
{
    for (NSInteger i = 0; i < self.capacity; i++) {
        RankListViewModel *viewModel = [[RankListViewModel alloc] initWithResponder:self index:i tableView:self.rankTableViews[i]];
        [self.rankListViewModels addObject:viewModel];
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger i = [self.rankTableViews indexOfObject:tableView];
    return [self.rankListViewModels[i] customNumberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger i = [self.rankTableViews indexOfObject:tableView];
    return [self.rankListViewModels[i] customCellForRowAtIndexPath:indexPath];
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger i = [self.rankTableViews indexOfObject:tableView];
    return [self.rankListViewModels[i] customHeightForRowAtIndexPath:indexPath];
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
        
        BCPagesTopBar *pagesTopBar = self.rankPagesTopBar;
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

-(NSUInteger)capacity
{
    if (!_capacity) {
        _capacity = self.rankPagesTopBar.itemTitles.count;
    }
    return _capacity;
}

-(BCPagesTopBar *)rankPagesTopBar
{
    if (!_rankPagesTopBar) {
        _rankPagesTopBar = [[BCPagesTopBar alloc] initWithFrame:CGRectMake(0, BC_NAV_HEIGHT, BC_SCREEN_WIDTH / 2, RankTopBarHeight)];
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
        _rankScrollView.contentSize = CGSizeMake(BC_SCREEN_WIDTH * self.capacity, 0);
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
        _rankTableViews = [NSMutableArray arrayWithCapacity:self.capacity];
    }
    return _rankTableViews;
}

-(NSMutableArray<RankListViewModel *> *)rankListViewModels
{
    if (!_rankListViewModels) {
        _rankListViewModels = [NSMutableArray arrayWithCapacity:self.capacity];
    }
    return _rankListViewModels;
}

@end
