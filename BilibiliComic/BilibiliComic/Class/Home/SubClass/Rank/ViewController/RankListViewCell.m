//
//  RankListViewCell.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RankListViewCell.h"

static const CGFloat TitleFont = 17;
static const CGFloat SubFont   = 13;

@implementation RankListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self cusLayoutAllSubViews];
        self.cellModel = [[RankListCellModel alloc] initWithResponder:self];
    }
    return self;
}

-(void)cusLayoutAllSubViews
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(Padding);
    }];
    
    [self.comicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Padding);
        make.left.equalTo(self.contentView).offset(50);
        make.bottom.equalTo(self.contentView).offset(-Padding);
        make.width.equalTo(self.comicView.mas_height).multipliedBy(Aspect);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(Padding);
        make.left.equalTo(self.comicView.mas_right).offset(Padding);
        make.right.equalTo(self.contentView).offset(-Padding);
    }];
    
    NSString *fansCellID = [NSString stringWithFormat:@"%@_2",NSStringFromClass([RankListViewCell class])];
    
    if ([self.reuseIdentifier isEqualToString:fansCellID]) {
        [self.fansSrcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(Padding);
            make.left.equalTo(self.comicView.mas_right).offset(Padding);
            make.right.lessThanOrEqualTo(self.contentView).offset(-Padding);
            make.height.mas_equalTo(SubFont + 3);
        }];
        
        [self.fansCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fansSrcLabel.mas_bottom).offset(8);
            make.left.equalTo(self.comicView.mas_right).offset(Padding);
            make.right.lessThanOrEqualTo(self.contentView).offset(-Padding);
            make.height.mas_equalTo(SubFont + 3);
        }];
        
        [self.fansView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.comicView.mas_right).offset(Padding);
            make.right.equalTo(self.contentView).offset(-Padding);
            make.bottom.equalTo(self.contentView).offset(-Padding);
            make.height.mas_equalTo(FansViewHeight);
        }];
    }
    else {
        [self.srcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.comicView.mas_right).offset(Padding);
            make.right.lessThanOrEqualTo(self.contentView).offset(-Padding);
            make.height.mas_equalTo(SubFont + 3);
            make.bottom.equalTo(self.typeLabel.mas_top).offset(-8);
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.comicView.mas_right).offset(Padding);
            make.right.lessThanOrEqualTo(self.contentView).offset(-Padding);
            make.height.mas_equalTo(SubFont + 3);
            make.bottom.equalTo(self.updateLabel.mas_top).offset(-8);
        }];
        
        [self.updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.comicView.mas_right).offset(Padding);
            make.right.lessThanOrEqualTo(self.contentView).offset(-Padding);
            make.height.mas_equalTo(SubFont + 3);
            make.bottom.equalTo(self.contentView).offset(-Padding);
        }];
    }
}

#pragma mark - LazyLoad

-(UILabel *)rankLabel
{
    if (!_rankLabel) {
        _rankLabel = [[UILabel alloc] init];
        _rankLabel.textColor = RGBColor(198, 154, 118);
        _rankLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_rankLabel];
    }
    return _rankLabel;
}

-(UIImageView *)comicView
{
    if (!_comicView) {
        _comicView = [[UIImageView alloc] init];
        _comicView.backgroundColor = DefaultBorderColor;
        _comicView.layer.borderColor = DefaultBorderColor.CGColor;
        _comicView.layer.borderWidth = 0.5;
        [self.contentView addSubview:_comicView];
    }
    return _comicView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:TitleFont];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)fansSrcLabel
{
    if (!_fansSrcLabel) {
        _fansSrcLabel = [[UILabel alloc] init];
        _fansSrcLabel.font = [UIFont systemFontOfSize:SubFont];
        _fansSrcLabel.textColor = DefaultContentLightColor;
        [self.contentView addSubview:_fansSrcLabel];
    }
    return _fansSrcLabel;
}

-(UILabel *)fansCountLabel
{
    if (!_fansCountLabel) {
        _fansCountLabel = [[UILabel alloc] init];
        _fansCountLabel.font = [UIFont systemFontOfSize:SubFont];
        _fansCountLabel.textColor = DefaultContentLightColor;
        [self.contentView addSubview:_fansCountLabel];
    }
    return _fansCountLabel;
}

-(RankFansView *)fansView
{
    if (!_fansView) {
        _fansView = [[RankFansView alloc] init];
        [self.contentView addSubview:_fansView];
    }
    return _fansView;
}

-(UILabel *)srcLabel
{
    if (!_srcLabel) {
        _srcLabel = [[UILabel alloc] init];
        _srcLabel.font = [UIFont systemFontOfSize:SubFont];
        _srcLabel.textColor = DefaultContentLightColor;
        [self.contentView addSubview:_srcLabel];
    }
    return _srcLabel;
}

-(UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:SubFont];
        _typeLabel.textColor = DefaultContentLightColor;
        [self.contentView addSubview:_typeLabel];
    }
    return _typeLabel;
}

-(UILabel *)updateLabel
{
    if (!_updateLabel) {
        _updateLabel = [[UILabel alloc] init];
        _updateLabel.font = [UIFont systemFontOfSize:SubFont];
        _updateLabel.textColor = DefaultContentLightColor;
        [self.contentView addSubview:_updateLabel];
    }
    return _updateLabel;
}

@end
