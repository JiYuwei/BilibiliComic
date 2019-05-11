//
//  HomeViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/2/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeNavigationBar.h"
#import "RecomViewController.h"
#import "RankViewController.h"
#import "NewViewController.h"
#import "HomeSearchModel.h"

@interface HomeViewController () <UIScrollViewDelegate>

@property (nonatomic,strong) HomeNavigationBar *homeNavBar;
@property (nonatomic,strong) UIScrollView *mainScrollView;

@property (nonatomic,copy,readonly) NSArray *childVCArray;

@end

@implementation HomeViewController
{
    NSArray *_childVCArray;
    CGFloat _currentAlpha;
    HomeNavigationBarStyle _currentStyle;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.homeNavBar.navBarStyle == HomeNavigationBarStyleLightContent) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    [self retrieveSearchData];
    [self initNavigationBar];
    [self initMainScrollView];
}

#pragma mark - Data

-(void)retrieveSearchData
{
    NSString *url = HOME_RECOMMEND;
    NSDictionary *parameters = @{@"BanID":@0,
                                 @"JsonData":@"[{\"pool_id\":100006,\"num\":3}]"};
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:nil needCache:YES requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        [self buildSearchDataWithJson:json];
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        if (needCache) {
            [self buildSearchDataWithJson:cachedJson];
        }
    }];
}

-(void)buildSearchDataWithJson:(NSDictionary *)json
{
    HomeSearchModel *homeSearchModel = [HomeSearchModel mj_objectWithKeyValues:json];
    self.homeNavBar.searchBar.data = homeSearchModel.data;
}

#pragma mark - UI

-(void)initNavigationBar
{
    self.homeNavBar.navBarStyle = HomeNavigationBarStyleLightContent;
    
    @weakify(self)
    [[RACObserve(self.homeNavBar, navBarStyle) distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self setNeedsStatusBarAppearanceUpdate];
    }];
    
    [[self.homeNavBar.pagesTopBar rac_signalForSelector:@selector(showSelectedIndex:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self)
        NSUInteger index = [x.first unsignedIntegerValue];
        CGFloat width = self.mainScrollView.vWidth;
        [self.mainScrollView setContentOffset:CGPointMake(width * index, 0) animated:YES];
    }];
}

-(void)initMainScrollView
{
    NSUInteger vCount  = self.childVCArray.count;
    CGFloat viewWidth  = self.mainScrollView.vWidth;
    CGFloat viewHeight = self.mainScrollView.vHeight;
    self.mainScrollView.contentSize = CGSizeMake(viewWidth * vCount, 0);
    
    [self.childVCArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaseViewController *childVC = [[[obj class] alloc] init];
        childVC.mainTableViewEnabled = YES;
        [self addChildViewController:childVC];
        childVC.view.frame = CGRectMake(viewWidth * idx, 0, viewWidth, viewHeight);
        [self.mainScrollView addSubview:childVC.view];
        [childVC didMoveToParentViewController:self];
    }];
    
    _currentAlpha = 1;
    _currentStyle = HomeNavigationBarStyleLightContent;
    
    RecomViewController *recomVC = (RecomViewController *)self.childViewControllers.firstObject;
    [[recomVC rac_signalForSelector:@selector(scrollViewDidScroll:)] subscribeNext:^(RACTuple * _Nullable x) {
        UIScrollView *scrollView = (UIScrollView *)x.first;
        [self recomTableViewDidScroll:scrollView];
    }];
}

#pragma mark - UIScrollViewDelegate

//RecomViewController, UITableView
-(void)recomTableViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY  = scrollView.contentOffset.y;
    CGFloat interval = 0.3;
    CGFloat alpha    = offsetY / BC_NAV_HEIGHT;
    if (alpha > interval + 1)    alpha = interval + 1;
    if (alpha < -(interval + 1)) alpha = -(interval + 1);
    
    if (alpha < -interval) {
        self.homeNavBar.navBarStyle = HomeNavigationBarStyleLightContent;
        self.homeNavBar.alpha = alpha + interval + 1;
    }
    else if (alpha > interval) {
        self.homeNavBar.navBarStyle = HomeNavigationBarStyleDefault;
        self.homeNavBar.alpha = alpha - interval;
    }
    else {
        self.homeNavBar.navBarStyle = HomeNavigationBarStyleLightContent;
        self.homeNavBar.alpha = 1;
    }
    
    _currentAlpha = self.homeNavBar.alpha;
    _currentStyle = self.homeNavBar.navBarStyle;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat alpha   = (offsetX / BC_SCREEN_WIDTH) < 1 ? (offsetX / BC_SCREEN_WIDTH) : 1;
//    NSLog(@"%.f",alpha);
    
    HomePagesTopBar *pagesTopBar = self.homeNavBar.pagesTopBar;
    UIView *slider = pagesTopBar.slider;
    CGFloat place = pagesTopBar.vWidth / pagesTopBar.itemTitles.count / 2;
    CGFloat percent = offsetX / BC_SCREEN_WIDTH * (pagesTopBar.itemTitles.count - 1);
    CGFloat x = place + place * percent;
    CGFloat y = slider.center.y;
    slider.center = CGPointMake(x, y);
    
    if (_currentStyle == HomeNavigationBarStyleDefault && _currentAlpha == 1) {
        return;
    }
    
    if (alpha > 0.05) {
        self.homeNavBar.navBarStyle = (alpha < 0.1) ? _currentStyle : HomeNavigationBarStyleDefault;
        self.homeNavBar.alpha = alpha;
    }
    else {
        self.homeNavBar.navBarStyle = _currentStyle;
        self.homeNavBar.alpha = _currentAlpha;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSUInteger index = (NSUInteger)(offsetX / scrollView.vWidth);
    [self.homeNavBar.pagesTopBar showSelectedIndex:index];
}

#pragma mark - LazyLoad

-(HomeNavigationBar *)homeNavBar
{
    if (!_homeNavBar) {
        _homeNavBar = [[HomeNavigationBar alloc] initWithFrame:CGRectMake(0, 0, BC_SCREEN_WIDTH, BC_NAV_HEIGHT)];
        [self.view addSubview:_homeNavBar];
    }
    return _homeNavBar;
}

-(UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BC_SCREEN_WIDTH, BC_SCREEN_HEIGHT - BC_TABBAR_HEIGHT)];
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.bounces = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        [self.view addSubview:_mainScrollView];
    }
    return _mainScrollView;
}

-(NSArray *)childVCArray
{
    if (!_childVCArray) {
        _childVCArray = @[[RecomViewController class],
                          [RankViewController class],
                          [NewViewController class]];
    }
    return _childVCArray;
}

@end
