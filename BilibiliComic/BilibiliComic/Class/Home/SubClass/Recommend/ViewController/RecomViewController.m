//
//  RecomViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RecomViewController.h"
#import "HomeStockViewModel.h"

@interface RecomViewController ()

@property (nonatomic,strong) HomeStockViewModel *homeStockViewModel;

@end

@implementation RecomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.mj_header.frame = CGRectMake(0, 0, BC_SCREEN_WIDTH, BC_NAV_HEIGHT);
    
    [self initTableHeaderview];
    
    self.homeStockViewModel = [[HomeStockViewModel alloc] initWithResponder:self];
}

#pragma mark - UI

-(void)initTableHeaderview
{
    self.mainTableView.tableHeaderView = self.bannerView;
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //Empty, RACSignalForSelecter -> HomeViewController;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.homeStockViewModel customNumberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.homeStockViewModel customCellForRowAtIndexPath:indexPath];
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.homeStockViewModel customHeightForRowAtIndexPath:indexPath];
}

#pragma mark - LazyLoad

-(BCHeaderView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[BCHeaderView alloc] initWithFrame:CGRectMake(0, 0, BC_SCREEN_WIDTH, HeaderViewHeight)];
        _bannerView.backgroundColor = DefaultBorderColor;
    }
    return _bannerView;
}

@end
