//
//  RecomListCell.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/2.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RecomListCell.h"

#define DefTitleFont  @"RecomListDefTitleFont"
#define SubTitleFont  @"RecomListSubTitleFont"

@interface RecomListCell ()

@property (nonatomic,strong) UIImageView *comicView;
@property (nonatomic,strong) UIImageView *statusView;
@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UILabel     *subTitleLabel;
@property (nonatomic,strong) UILabel     *tagLabel;

@end

@implementation RecomListCell
{
    CGFloat _defTitleFont;
    CGFloat _subTitleFont;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _defTitleFont = [PlistManager widthWithKey:DefTitleFont];
        _subTitleFont = [PlistManager widthWithKey:SubTitleFont];
        [self cusLayoutAllSubViews];
    }
    return self;
}

-(void)cusLayoutAllSubViews
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.comicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(18);
        make.right.equalTo(self.contentView).offset(-18);
        make.height.equalTo(self.comicView.mas_width).multipliedBy(0.55);
    }];
    
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.comicView);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(18);
        make.top.equalTo(self.comicView.mas_bottom).offset(6);
    }];

    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(18);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(6);
    }];

    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(18);
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(35, 20));
    }];
    
    [self layoutIfNeeded];
    
    self.comicView.layer.cornerRadius = self.comicView.vHeight / 20;
    self.comicView.layer.masksToBounds = YES;
    
    self.tagLabel.layer.cornerRadius = self.tagLabel.vHeight / 8;
    
    self.titleLabel.text = @"欢迎来到实力至上主义的教室";
    self.subTitleLabel.text = @"最新上架";
}

#pragma mark - LazyLoad

-(UIImageView *)comicView
{
    if (!_comicView) {
        _comicView = [[UIImageView alloc] init];
        _comicView.backgroundColor = GRandomColor;
        [self.contentView addSubview:_comicView];
    }
    return _comicView;
}

-(UIImageView *)statusView
{
    if (!_statusView) {
        _statusView = [[UIImageView alloc] init];
        _statusView.backgroundColor = GRandomColor;
        [self.comicView addSubview:_statusView];
    }
    return _statusView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:_defTitleFont];
//        _titleLabel.backgroundColor = GRandomColor;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.font = [UIFont systemFontOfSize:_subTitleFont];
        _subTitleLabel.textColor = [UIColor grayColor];
//        _subTitleLabel.backgroundColor = GRandomColor;
        [self.contentView addSubview:_subTitleLabel];
    }
    return _subTitleLabel;
}

-(UILabel *)tagLabel
{
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.layer.backgroundColor = GRandomColor.CGColor;
        [self.contentView addSubview:_tagLabel];
    }
    return _tagLabel;
}


@end
