//
//  HomeSearchBar.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeSearchBar.h"
#import "SearchCycleScrollView.h"
#import "HomeSearchModel.h"

@interface HomeSearchBar () <HomeNavigationBarProtocol>

@property (nonatomic,strong) UIView                 *shadowView;
@property (nonatomic,strong) UIImageView            *searchImageView;
@property (nonatomic,strong) SearchCycleScrollView  *searchCycleView;

@end

@implementation HomeSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self cusLayoutAllSubViews];
    }
    return self;
}

-(void)cusLayoutAllSubViews
{
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.top.equalTo(self).offset(7);
        make.bottom.equalTo(self).offset(-7);
        make.width.equalTo(self.searchImageView.mas_height);
    }];
    
    [self.searchCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchImageView.mas_right).offset(5);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-8);
    }];
}

#pragma mark - HomeNavigationBarProtocol

-(void)showNavigationBarStyle:(HomeNavigationBarStyle)style
{
    switch (style) {
        case HomeNavigationBarStyleDefault:
        {
            self.backgroundColor = DefaultBorderColor;
            self.searchImageView.image = UIImage(@"nav_search_s_ico");
        }
            break;
        case HomeNavigationBarStyleLightContent:
        {
            self.backgroundColor = DefaultContentBackColor;
            self.searchImageView.image = UIImage(@"home_whiteSearch_bar_16x16_");
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Setter

-(void)setSearchBarStyle:(HomeNavigationBarStyle)searchBarStyle
{
    if (_searchBarStyle != searchBarStyle) {
        _searchBarStyle = searchBarStyle;
        
        self.searchCycleView.cycleStyle = _searchBarStyle;
        [self showNavigationBarStyle:_searchBarStyle];
    }
}

-(void)setData:(NSArray<SearchData *> *)data
{
    if (data && ![_data isEqualToArray:data]) {
        _data = data;
        NSMutableArray *titleArray = [NSMutableArray array];
        for (SearchData *item in _data) {
            [titleArray addObject:item.title];
        }
        self.searchCycleView.placeHolders = titleArray;
    }
}

#pragma mark - LazyLoad

-(UIView *)shadowView
{
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.backgroundColor = DefaultContentBackColor;
        [self addSubview:_shadowView];
    }
    return _shadowView;
}

-(UIImageView *)searchImageView
{
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc] initWithImage:UIImage(@"common_search_ico_24x24_")];
        [self addSubview:_searchImageView];
    }
    return _searchImageView;
}

-(SearchCycleScrollView *)searchCycleView
{
    if (!_searchCycleView) {
        _searchCycleView = [[SearchCycleScrollView alloc] init];
        _searchCycleView.interval = DefaultTimeInterval;
        [self addSubview:_searchCycleView];
    }
    return _searchCycleView;
}

@end
