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
    [self initTableHeaderview];
    [self initRecomListCell];
}

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

#pragma mark - UITableViewDataSource & Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecomListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RecomListCell class]) forIndexPath:indexPath];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DefaultViewHeight;
}

@end
