//
//  HomeNavigationBar.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/12.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeNavigationBar.h"

@interface HomeNavigationBar () <HomeNavigationBarProtocol>

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation HomeNavigationBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.navBarStyle = HomeNavigationBarStylePrepared;
        self.navBarStyle = HomeNavigationBarStyleDefault;
        [self cusLayoutAllSubViews];
    }
    return self;
}

-(void)cusLayoutAllSubViews
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self).offset(BC_STATUS_HEIGHT);
    }];
    
    [self.pagesTopBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.timeLineBtn.mas_left).offset(-10);
        make.top.equalTo(self.contentView).offset(TBMargin);
        make.bottom.equalTo(self.contentView).offset(-TBMargin);
        make.left.equalTo(self.pagesTopBar.mas_right).offset(15).priorityLow();
        make.width.mas_lessThanOrEqualTo(150);
    }];
    
    [self.timeLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-5);
        make.top.bottom.equalTo(self.contentView);
        make.width.equalTo(self.timeLineBtn.mas_height);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - HomeNavigationBarProtocol

-(void)showNavigationBarStyle:(HomeNavigationBarStyle)style
{
    switch (style) {
        case HomeNavigationBarStyleDefault:
        {
            self.backgroundColor = [UIColor whiteColor];
            self.lineView.backgroundColor = DefaultBorderColor;
            [self.timeLineBtn setImage:BCImage(@"home_gray_calendar_24x24_") forState:UIControlStateNormal];
        }
            break;
        case HomeNavigationBarStyleLightContent:
        {
            self.backgroundColor = [UIColor clearColor];
            self.lineView.backgroundColor = [UIColor clearColor];
            [self.timeLineBtn setImage:BCImage(@"home_whiter_calendar_24x24_") forState:UIControlStateNormal];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Setter

-(void)setNavBarStyle:(HomeNavigationBarStyle)navBarStyle
{
    if (_navBarStyle != navBarStyle) {
        _navBarStyle = navBarStyle;
        
        self.pagesTopBar.topBarStyle = _navBarStyle;
        self.searchBar.searchBarStyle = _navBarStyle;
        [self showNavigationBarStyle:_navBarStyle];
    }
}

#pragma mark - LazyLoad

-(UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
    }
    return _contentView;
}

-(BCPagesTopBar *)pagesTopBar
{
    if (!_pagesTopBar) {
        _pagesTopBar = [[BCPagesTopBar alloc] init];
        _pagesTopBar.itemTitles = @[@"推荐",@"排行",@"新作"];
        [self.contentView addSubview:_pagesTopBar];
    }
    return _pagesTopBar;
}

-(HomeSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[HomeSearchBar alloc] init];
        _searchBar.clipsToBounds = YES;
        [self.contentView addSubview:_searchBar];
    }
    return _searchBar;
}

-(UIButton *)timeLineBtn
{
    if (!_timeLineBtn) {
        _timeLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_timeLineBtn];
    }
    return _timeLineBtn;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = DefaultBorderColor;
        [self addSubview:_lineView];
    }
    return _lineView;
}

@end
