//
//  HomeNavigationBar.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/4/12.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "HomeNavigationBar.h"
#import "HomePagesTopBar.h"

@interface HomeNavigationBar ()

@property (nonatomic,strong) UIView           *contentView;
@property (nonatomic,strong) HomePagesTopBar  *topBar;

@end

@implementation HomeNavigationBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
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
        _topBar.topBarStyle = HomePagesTopBarStyleLightContent;
        [self.contentView addSubview:_topBar];
    }
    return _topBar;
}

@end
