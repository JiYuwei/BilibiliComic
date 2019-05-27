//
//  NewViewController.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "NewViewController.h"
#import "PSCollectionView.h"
#import "NewViewCell.h"
#import "NewFootView.h"

@interface NewViewController () <PSCollectionViewDataSource,PSCollectionViewDelegate>

@property (nonatomic,strong) PSCollectionView *newsCollectionView;
@property (nonatomic,strong) NewFootView      *footView;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNewsCollectionView];
}

#pragma mark - UI

-(void)initNewsCollectionView
{
    self.newsCollectionView.mj_header = [BCRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(retrieveNewsData)];
    
    self.newsCollectionView.footerView = self.footView;
}

#pragma mark - Data
                                         
-(void)retrieveNewsData
{
     
}

-(void)loadMoreNewsData
{
        
}
                                         
#pragma mark - PSCollectionViewDataSource

-(NSInteger)numberOfRowsInCollectionView:(PSCollectionView *)collectionView
{
    return 8;
}

-(PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView cellForRowAtIndex:(NSInteger)index
{
    NewViewCell *cell = (NewViewCell *)[collectionView dequeueReusableViewForClass:[NewViewCell class]];
    if (!cell) {
        cell = [[NewViewCell alloc] init];
    }
    [cell collectionView:collectionView fillCellWithObject:nil atIndex:index];
    
    return cell;
}

-(CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return [NewViewCell rowHeightForObject:nil inColumnWidth:collectionView.colWidth];
}

#pragma mark PSCollectionViewDelegate

-(Class)collectionView:(PSCollectionView *)collectionView cellClassForRowAtIndex:(NSInteger)index
{
    return [NewViewCell class];
}

-(void)collectionView:(PSCollectionView *)collectionView didSelectCell:(PSCollectionViewCell *)cell atIndex:(NSInteger)index
{
    NSLog(@"Select: %ld",index);
}

#pragma mark - LazyLoad

-(PSCollectionView *)newsCollectionView
{
    if (!_newsCollectionView) {
        _newsCollectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0, BC_NAV_HEIGHT, BC_SCREEN_WIDTH, BC_SCREEN_HEIGHT - BC_TABBAR_HEIGHT - BC_NAV_HEIGHT)];
        _newsCollectionView.collectionViewDataSource = self;
        _newsCollectionView.collectionViewDelegate = self;
        _newsCollectionView.showsVerticalScrollIndicator = NO;
        _newsCollectionView.showsHorizontalScrollIndicator = NO;
        _newsCollectionView.numColsPortrait = 2;
        [self.view addSubview:_newsCollectionView];
    }
    return _newsCollectionView;
}

-(NewFootView *)footView
{
    if (!_footView) {
        _footView = [[NewFootView alloc] initWithFrame:CGRectMake(0, 0, BC_SCREEN_WIDTH, 300)];
        [self.view addSubview:_footView];
    }
    return _footView;
}

@end
