//
//  RankListViewModel.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/6/18.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RankListViewModel.h"
#import "RanklistModel.h"
#import "RankListViewCell.h"
#import "RankViewController.h"

@interface RankListViewModel ()

@property (nonatomic,strong) RankListModel      *model;
@property (nonatomic,weak)   UITableView        *tableView;

@property (nonatomic,assign) NSUInteger          index;

@end

@implementation RankListViewModel

-(instancetype)initWithResponder:(UIResponder *)responder index:(NSUInteger)index tableView:(UITableView *)tableView
{
    if (self = [super init]) {
        self.responder = responder;
        self.index     = index;
        self.tableView = tableView;
        [self initViewModelBinding];
        [self registerMainTableViewCell];
        [self retrieveRankData];
    }
    return self;
}

#pragma mark - Overwrite

-(void)initViewModelBinding
{
    [self.tableView.mj_header setRefreshingBlock:^{
        [self retrieveRankDataAllowCache:NO];
    }];
    
    [[RACObserve(self, model) skip:1] subscribeNext:^(id  _Nullable x) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [self.tableView reloadData];
    }];
}

-(void)registerMainTableViewCell
{
    [self.tableView registerClass:[RankListViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"%@_%lu",NSStringFromClass([RankListViewCell class]),self.index]];
}

#pragma mark - Data

-(void)retrieveRankData
{
    [self retrieveRankDataAllowCache:YES];
}

-(void)retrieveRankDataAllowCache:(BOOL)cache
{
    BOOL isHot = self.index < 2;
    NSString *url = isHot ? HOME_HOT : HOME_FANS;
    NSDictionary *parameters = isHot ? @{@"type":@(self.index)} : @{};
    
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:nil needCache:cache requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        self.model = [RankListModel mj_objectWithKeyValues:json];
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        if (needCache) {
            self.model = [RankListModel mj_objectWithKeyValues:cachedJson];
        }
    }];
}

#pragma mark - BCViewModelDataProtocol

-(NSInteger)customNumberOfRowsInSection:(NSInteger)section
{
    if (self.index == 2) {
        return self.model.fansData.comics.count;
    }
    else{
        return self.model.rankData.count;
    }
    
    return 0;
}

-(UITableViewCell *)customCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankListViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@_%lu",NSStringFromClass([RankListViewCell class]),self.index] forIndexPath:indexPath];
    
    cell.cellModel.rank = indexPath.row + 1;
    
    if (self.index == 2) {
        [cell.cellModel fillDataWithRankComics:self.model.fansData.comics[indexPath.row]];
    }
    else{
        [cell.cellModel fillDataWithRankData:self.model.rankData[indexPath.row]];
    }
    
    return cell;
}

#pragma mark BCViewModelProtocol

- (CGFloat)customHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

@end
