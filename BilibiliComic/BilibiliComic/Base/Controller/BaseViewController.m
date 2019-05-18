//
//  BaseViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/2/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    if (self.mainTableViewEnabled) {
        [self initMainTableView];
        [self initMJRefresh];
    }
}

#pragma mark - GeneralUI

-(void)initMainTableView
{
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

-(void)initMJRefresh
{
    self.mainTableView.mj_header = [BCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(retrieveData)];
    self.mainTableView.mj_footer = [BCRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


-(void)retrieveData
{
    [self.mainTableView.mj_header performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
}

-(void)loadMoreData
{
    [self.mainTableView.mj_footer performSelector:@selector(endRefreshingWithNoMoreData) withObject:nil afterDelay:2];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"MainLine:%lu",indexPath.row+1];
    
    return cell;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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

#pragma mark - LazyLoad

-(UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, BC_SCREEN_WIDTH, BC_SCREEN_HEIGHT - BC_TABBAR_HEIGHT) style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        if (@available(iOS 11.0, *)) {
            _mainTableView.estimatedRowHeight = 0;
            _mainTableView.estimatedSectionHeaderHeight = 0;
            _mainTableView.estimatedSectionFooterHeight = 0;
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.view addSubview:_mainTableView];
    }
    return _mainTableView;
}

#pragma mark - MemoryWarning

-(void)didReceiveMemoryWarning
{
    [[SDWebImageManager sharedManager] cancelAll];
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
