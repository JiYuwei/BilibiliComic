//
//  HomeNavigationBar.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/12.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeNavigationBar.h"
#import "HomePagesTopBar.h"
#import "HomeSearchBar.h"

@interface HomeNavigationBar () <HomeNavigationBarProtocol>

@property (nonatomic,strong) UIView           *contentView;
@property (nonatomic,strong) HomePagesTopBar  *topBar;
@property (nonatomic,strong) HomeSearchBar    *searchBar;
@property (nonatomic,strong) UIButton         *timeLineBtn;

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
    
    [self.topBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
    }];
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.timeLineBtn.mas_left).offset(-10);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.greaterThanOrEqualTo(self.topBar.mas_right).offset(10);
        make.width.mas_equalTo(120);
    }];
    
    [self.timeLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-5);
        make.top.bottom.equalTo(self.contentView);
        make.width.equalTo(self.timeLineBtn.mas_height);
    }];
    
    [self layoutIfNeeded];
    
    self.searchBar.layer.cornerRadius = self.searchBar.bounds.size.height / 2;
    self.searchBar.layer.masksToBounds = YES;
    [self.searchBar openScrollMode];
    
    
    [[self.timeLineBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [UIView animateWithDuration:0.3 animations:^{
            if (self.navBarStyle == HomeNavigationBarStyleDefault) {
                self.navBarStyle = HomeNavigationBarStyleLightContent;
            }
            else{
                self.navBarStyle = HomeNavigationBarStyleDefault;
            }
        }];
    }];
}

#pragma mark - HomeNavigationBarProtocol

-(void)showNavigationBarStyle:(HomeNavigationBarStyle)style
{
    switch (style) {
        case HomeNavigationBarStyleDefault:
        {
            self.backgroundColor = [UIColor whiteColor];
            [self.timeLineBtn setImage:UIImage(@"home_gray_calendar_24x24_") forState:UIControlStateNormal];
        }
            break;
        case HomeNavigationBarStyleLightContent:
        {
            self.backgroundColor = [UIColor clearColor];
            [self.timeLineBtn setImage:UIImage(@"home_whiter_calendar_24x24_") forState:UIControlStateNormal];
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
        
        self.topBar.topBarStyle = _navBarStyle;
        self.searchBar.searchBarStyle = _navBarStyle;
        [self showNavigationBarStyle:_navBarStyle];
    }
}

#pragma mark - LazyLoad

-(UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
//        _contentView.backgroundColor = [UIColor blueColor];
        [self addSubview:_contentView];
    }
    return _contentView;
}

-(HomePagesTopBar *)topBar
{
    if (!_topBar) {
        _topBar = [[HomePagesTopBar alloc] init];
//        _topBar.backgroundColor = [UIColor cyanColor];
        _topBar.itemTitles = @[@"推荐",@"排行",@"新作"];
        [self.contentView addSubview:_topBar];
    }
    return _topBar;
}

-(HomeSearchBar *)searchBar
{
    if (!_searchBar) {
        _searchBar = [[HomeSearchBar alloc] init];
        [self.contentView addSubview:_searchBar];
    }
    return _searchBar;
}

-(UIButton *)timeLineBtn
{
    if (!_timeLineBtn) {
        _timeLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeLineBtn setImage:UIImage(@"home_gray_calendar_24x24_") forState:UIControlStateNormal];
//        [_timeLineBtn setImage:UIImage(@"home_whiter_calendar_24x24_") forState:UIControlStateHighlighted];
        [self.contentView addSubview:_timeLineBtn];
    }
    return _timeLineBtn;
}

@end
