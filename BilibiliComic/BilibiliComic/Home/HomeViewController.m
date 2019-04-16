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

@interface HomeViewController ()

@property (nonatomic,strong) HomeNavigationBar *homeNavBar;
@property (nonatomic,strong) UIScrollView *mainScrollView;

@property (nonatomic,copy) NSArray *childVCArray;

@end

@implementation HomeViewController

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
