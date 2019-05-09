//
//  RecomViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RecomViewController.h"
#import "BCHeaderView.h"
#import "HomeStockListCell.h"
#import "HomeBannerModel.h"
#import "HomeStockModel.h"

static const NSUInteger PageCount = 10;

@interface RecomViewController ()

@property (nonatomic,strong) HomeStockModel  *homeStockModel;

@property (nonatomic,strong) BCHeaderView *bannerView;

@end

@implementation RecomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.mj_header.frame = CGRectMake(0, 0, BC_SCREEN_WIDTH, BC_NAV_HEIGHT);
    
    [self retrieveBanner];
    [self retrieveHomePage];
    [self initTableHeaderview];
    [self initRecomListCell];
}

//首次获取轮播图
-(void)retrieveBanner
{
    NSString *url = HOME_BANNER;
    NSDictionary *parameters = @{@"platform":APP_DEVICE};
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:nil needCache:YES requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        if (json && [json[@"code"] integerValue] == 0) {
            self.bannerView.homeBannerModel = [HomeBannerModel mj_objectWithKeyValues:json];
        }
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        
    }];
}

//首次获取列表数据
- (void)retrieveHomePage
{
//    NSString *url = HOME_PAGE;
//    NSDictionary *parameters = @{@"page_num":@1};
//    [self retrieveDataWithURL:url parameters:parameters];
    [self retrieveData];
}

#pragma mark - OverWriteRetrieveData

-(void)retrieveData
{
    NSString *url = HOME_STOCK_URL;
    NSDictionary *parameters = @{@"omitCards":@2,
                                 @"page_num":@1,
                                 @"seed":@0,
                                 };
    [self retrieveDataWithURL:url parameters:parameters];
}

-(void)loadMoreData
{
    NSString *url = HOME_STOCK_URL;
    StockData *data = self.homeStockModel.data;
    NSUInteger page = data.list.count / PageCount + 1;
    NSDictionary *parameters = @{@"omitCards":@2,
                                 @"page_num":@(page),
                                 @"seed":@(data.seed.integerValue),
                                 };
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:^{
        NSString *seed = self.homeStockModel.data.seed;
        if (seed && seed.integerValue == 0) {
            [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            [self.mainTableView.mj_footer endRefreshing];
        }
        [self.mainTableView reloadData];
    } needCache:YES requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        if (json && [json[@"code"] integerValue] == 0) {
            HomeStockModel *homeStockModel = [HomeStockModel mj_objectWithKeyValues:json];
            [self addMoreEntriesWithModel:homeStockModel];
        }
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        if (needCache) {
            HomeStockModel *homeStockModel = [HomeStockModel mj_objectWithKeyValues:cachedJson];
            [self addMoreEntriesWithModel:homeStockModel];
        }
    }];
}

#pragma mark Private

-(void)retrieveDataWithURL:(NSString *)url parameters:(NSDictionary *)parameters
{
    [BCNetworkRequest retrieveJsonWithPrepare:nil finish:^{
        [self.mainTableView.mj_header endRefreshing];
        [self.mainTableView reloadData];
    } needCache:YES requestType:HTTPRequestTypePOST fromURL:url parameters:parameters success:^(NSDictionary *json) {
        if (json && [json[@"code"] integerValue] == 0 ){
            self.homeStockModel = [HomeStockModel mj_objectWithKeyValues:json];
        }
    } failure:^(NSError *error, BOOL needCache, NSDictionary *cachedJson) {
        if (needCache) {
            self.homeStockModel = [HomeStockModel mj_objectWithKeyValues:cachedJson];
        }
    }];
}

-(void)addMoreEntriesWithModel:(HomeStockModel *)homeStockModel
{
    NSMutableArray <List *> *list = [NSMutableArray arrayWithArray:self.homeStockModel.data.list];
    [list addObjectsFromArray:homeStockModel.data.list];
    self.homeStockModel.data.list = [list copy];
    self.homeStockModel.data.seed = homeStockModel.data.seed;
}

#pragma mark - UI
-(void)initTableHeaderview
{
    self.mainTableView.tableHeaderView = self.bannerView;
}

-(void)initRecomListCell
{
    [self.mainTableView registerClass:[HomeStockListCell class] forCellReuseIdentifier:NSStringFromClass([HomeStockListCell class])];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //Empty, RACSignalForSelecter -> HomeViewController;
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.homeStockModel.data.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeStockListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeStockListCell class]) forIndexPath:indexPath];
    cell.homeStockList = self.homeStockModel.data.list[indexPath.row];
    
    return cell;
}

#pragma mark UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DefaultViewHeight;
}

#pragma mark - LazyLoad

-(BCHeaderView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[BCHeaderView alloc] initWithFrame:CGRectMake(0, 0, BC_SCREEN_WIDTH, HeaderViewHeight)];
        _bannerView.backgroundColor = GRandomColor;
    }
    return _bannerView;
}

@end
