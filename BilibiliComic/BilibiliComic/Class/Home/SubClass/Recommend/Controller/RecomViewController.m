//
//  RecomViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RecomViewController.h"
#import "BCHeaderView.h"
#import "RecomListCell.h"

@interface RecomViewController ()


@end

@implementation RecomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.mj_header.frame = CGRectMake(0, 0, BC_SCREEN_WIDTH, BC_NAV_HEIGHT);
    [self retrieveData];
    [self initTableHeaderview];
    [self initRecomListCell];
}

#pragma mark - OverWriteRetrieveData

-(void)retrieveData
{
    NSString *url = HOME_STOCK_URL;
    NSDictionary *parameters = @{@"omitCards":@2,
                                 @"page_num":@1,
                                 @"seed":@0,
                                 };
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:^{
        [self.mainTableView.mj_header endRefreshing];
    } needCache:YES requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        NSLog(@"json:%@",json);
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        NSLog(@"%@",error);
    }];
}

-(void)loadMoreData
{
    
}

#pragma mark - UI
-(void)initTableHeaderview
{
    BCHeaderView *headerView = [[BCHeaderView alloc] initWithFrame:CGRectMake(0, 0, BC_SCREEN_WIDTH, DefaultViewHeight)];
    headerView.backgroundColor = GRandomColor;
    self.mainTableView.tableHeaderView = headerView;
}

-(void)initRecomListCell
{
    [self.mainTableView registerClass:[RecomListCell class] forCellReuseIdentifier:NSStringFromClass([RecomListCell class])];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //Empty, RACSignalForSelecter -> HomeViewController;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecomListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecomListCell class]) forIndexPath:indexPath];
    
    return cell;
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DefaultViewHeight;
}

@end
