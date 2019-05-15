//
//  RankViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RankViewController.h"
#import "PagesTopBar.h"

static const CGFloat RankTopBarHeight = 40;

@interface RankViewController ()

@property (nonatomic,strong) PagesTopBar *rankPagesTopBar;

@property (nonatomic,strong) UIScrollView *rankScrollView;
@property (nonatomic,strong) NSMutableArray <UITableView *> *rankTableViews;

@end

@implementation RankViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.rankPagesTopBar;
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

@end
