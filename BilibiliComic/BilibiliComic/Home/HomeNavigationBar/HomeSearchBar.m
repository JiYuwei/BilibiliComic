//
//  HomeSearchBar.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/15.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeSearchBar.h"
#import "SearchCycleScrollView.h"

@interface HomeSearchBar ()

@property (nonatomic,strong) UIImageView            *searchImageView;
@property (nonatomic,strong) SearchCycleScrollView  *searchCycleView;

@end

@implementation HomeSearchBar

-(void)openScrollMode
{
    [self.searchCycleView openScrollMode];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = DefaultBorderColor;
        [self cusLayoutAllSubViews];
    }
    return self;
}

-(void)cusLayoutAllSubViews
{
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
        make.width.equalTo(self.searchImageView.mas_height);
    }];
    
    [self.searchCycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchImageView.mas_right).offset(5);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-8);
    }];
}

#pragma mark - LazyLoad

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
        _searchCycleView.interval = 3.0f;
        _searchCycleView.placeHolders = @[@"搜索示例1",@"搜索示例2",@"搜索示例3333333333"];
        [self addSubview:_searchCycleView];
    }
    return _searchCycleView;
}

@end
