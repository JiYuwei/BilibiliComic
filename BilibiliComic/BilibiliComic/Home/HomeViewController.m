//
//  HomeViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/2/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeNavigationBar.h"
#import "RecommendViewController.h"
#import "RankViewController.h"
#import "NewViewController.h"

@interface HomeViewController () <UIScrollViewDelegate>

@property (nonatomic,strong) HomeNavigationBar *homeNavBar;
@property (nonatomic,strong) UIScrollView *mainScrollView;

@property (nonatomic,copy,readonly) NSArray *childVCArray;

@end

@implementation HomeViewController
{
    NSArray *_childVCArray;
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
    [self initNavigationBar];
    [self initMainScrollView];
}

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
        CGFloat width = self.mainScrollView.bounds.size.width;
        [self.mainScrollView setContentOffset:CGPointMake(width * index, 0) animated:YES];
    }];
}

-(void)initMainScrollView
{
    NSUInteger vCount  = self.childVCArray.count;
    CGFloat viewWidth  = self.mainScrollView.bounds.size.width;
    CGFloat viewHeight = self.mainScrollView.bounds.size.height;
    self.mainScrollView.contentSize = CGSizeMake(viewWidth * vCount, 0);
    
    [self.childVCArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BaseViewController *childVC = [[[obj class] alloc] init];
        [self addChildViewController:childVC];
        childVC.view.frame = CGRectMake(viewWidth * idx, 0, viewWidth, viewHeight);
        [self.mainScrollView addSubview:childVC.view];
        [childVC didMoveToParentViewController:self];
    }];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat alpha   = (offsetX / BCSCREEN_WIDTH) < 1 ? (offsetX / BCSCREEN_WIDTH) : 1;
//    NSLog(@"%.f",alpha);
    
    HomePagesTopBar *pagesTopBar = self.homeNavBar.pagesTopBar;
    UIView *silder = pagesTopBar.silder;
    CGFloat place = pagesTopBar.bounds.size.width / pagesTopBar.itemTitles.count / 2;
    CGFloat percent = offsetX / BCSCREEN_WIDTH * (pagesTopBar.itemTitles.count - 1);
    CGFloat x = place + place * percent;
    CGFloat y = silder.center.y;
    silder.center = CGPointMake(x, y);
    
    BOOL defaultMode = alpha > 0.05;
    if (defaultMode) {
        self.homeNavBar.navBarStyle = (alpha < 0.1) ? HomeNavigationBarStyleLightContent : HomeNavigationBarStyleDefault;
        self.homeNavBar.alpha = alpha;
    }
    else {
        self.homeNavBar.alpha = 1;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSUInteger index = (NSUInteger)(offsetX / scrollView.bounds.size.width);
    [self.homeNavBar.pagesTopBar showSelectedIndex:index];
}

#pragma mark - LazyLoad

-(HomeNavigationBar *)homeNavBar
{
    if (!_homeNavBar) {
        _homeNavBar = [[HomeNavigationBar alloc] initWithFrame:CGRectMake(0, 0, BCSCREEN_WIDTH, BC_NAV_HEIGHT)];
        [self.view addSubview:_homeNavBar];
    }
    return _homeNavBar;
}

-(UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, BCSCREEN_WIDTH, BCSCREEN_HEIGHT - BC_TABBAR_HEIGHT)];
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
        _childVCArray = @[[RecommendViewController class],
                          [RankViewController class],
                          [NewViewController class]];
    }
    return _childVCArray;
}

@end
