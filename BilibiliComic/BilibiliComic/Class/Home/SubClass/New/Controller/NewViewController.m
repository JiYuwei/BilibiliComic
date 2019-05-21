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

@interface NewViewController () <PSCollectionViewDataSource,PSCollectionViewDelegate>

@property (nonatomic,strong) PSCollectionView *newsCollectionView;

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
    
    self.newsCollectionView.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BC_SCREEN_WIDTH, 300)];
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
    cell.backgroundColor = GRandomColor;
    
    return cell;
}

-(CGFloat)collectionView:(PSCollectionView *)collectionView heightForRowAtIndex:(NSInteger)index
{
    return 300;
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

@end
