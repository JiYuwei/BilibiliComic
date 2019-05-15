//
//  RankViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RankViewController.h"
#import "PagesTopBar.h"

static const CGFloat    RankTopBarHeight = 40;

@interface RankViewController ()

@property (nonatomic,strong) PagesTopBar *rankPagesTopBar;

@property (nonatomic,strong) UIScrollView *rankScrollView;
@property (nonatomic,strong) NSMutableArray <UITableView *> *rankTableViews;

@end

@implementation RankViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initRankPagesTopBar];
    [self initRankTableViews];
}

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

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
        _rankPagesTopBar.itemTitles = @[@"人气榜",@"应援榜",@"免费榜"];
        [self.view addSubview:_rankPagesTopBar];
    }
    return _rankPagesTopBar;
}

-(UIScrollView *)rankScrollView
{
    if (!_rankScrollView) {
        _rankScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, BC_NAV_HEIGHT + RankTopBarHeight, BC_SCREEN_WIDTH, BC_SCREEN_HEIGHT - BC_TABBAR_HEIGHT - BC_NAV_HEIGHT - RankTopBarHeight)];
        _rankScrollView.backgroundColor = GRandomColor;
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
