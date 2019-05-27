//
//  NewFootView.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/27.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "NewFootView.h"

static const CGFloat BtnHeight = 40;

@interface NewFootView ()

@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UITableView *orderTableView;

@end

@implementation NewFootView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self cusLayoutAllSubViews];
    }
    return self;
}

-(void)cusLayoutAllSubViews
{
    [self.loadMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(75);
        make.right.equalTo(self).offset(-75);
        make.height.mas_equalTo(BtnHeight);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loadMoreBtn.mas_bottom).offset(30);
        make.left.equalTo(self).offset(18);
    }];
}

#pragma mark - LazyLoad

-(UIButton *)loadMoreBtn
{
    if (!_loadMoreBtn) {
        _loadMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loadMoreBtn.layer.backgroundColor = DefaultViewBackgroundColor.CGColor;
        _loadMoreBtn.layer.cornerRadius = BtnHeight / 2;
        _loadMoreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_loadMoreBtn setTitleColor:DefaultContentLightColor forState:UIControlStateNormal];
        [_loadMoreBtn setTitle:@"查看更多" forState:UIControlStateNormal];
        [_loadMoreBtn setTitle:@"～没有更多了哦～" forState:UIControlStateDisabled];
        [self addSubview:_loadMoreBtn];
    }
    return _loadMoreBtn;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.text = @"新作预约";
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
