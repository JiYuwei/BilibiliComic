//
//  RankListViewCell.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/16.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RankListViewCell.h"
#import "RankListModel.h"

static const CGFloat TitleFont = 17;
static const CGFloat SubFont   = 14;

@interface RankListViewCell ()

@property (nonatomic,strong) UILabel     *rankLabel;

@property (nonatomic,strong) UIImageView *comicView;
@property (nonatomic,strong) UILabel     *titleLabel;

@property (nonatomic,strong) UILabel     *srcLabel;
@property (nonatomic,strong) UILabel     *typeLabel;
@property (nonatomic,strong) UILabel     *updateLabel;

@end

@implementation RankListViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self cusLayoutAllSubViews];
    }
    return self;
}

-(void)cusLayoutAllSubViews
{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
    }];
    
    [self.comicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(50);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.width.equalTo(self.comicView.mas_height).multipliedBy(0.75);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.comicView.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
    }];
    
    [self.srcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.comicView.mas_right).offset(10);
        make.right.lessThanOrEqualTo(self.contentView).offset(-10);
        make.height.mas_equalTo(SubFont + 3);
        make.bottom.equalTo(self.typeLabel.mas_top).offset(-8);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.comicView.mas_right).offset(10);
        make.right.lessThanOrEqualTo(self.contentView).offset(-10);
        make.height.mas_equalTo(SubFont + 3);
        make.bottom.equalTo(self.updateLabel.mas_top).offset(-8);
    }];
    
    [self.updateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.comicView.mas_right).offset(10);
        make.right.lessThanOrEqualTo(self.contentView).offset(-10);
        make.height.mas_equalTo(SubFont + 3);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

#pragma mark - Setter

-(void)setRank:(NSInteger)rank
{
    _rank = rank;
//    NSLog(@"%@",[UIFont familyNames]);
    BOOL topRank = (_rank <= 3);
    self.rankLabel.text = [NSString stringWithFormat:topRank?@"%ld":@"%02ld",_rank];
    self.rankLabel.font = [UIFont fontWithName:@"Impact MT Std" size:topRank?70:35];
}

-(void)setRankData:(RankData *)rankData
{
    if (rankData && _rankData != rankData) {
        _rankData = rankData;
        
        [self.comicView sd_setFadeImageWithURL:[NSURL URLWithString:_rankData.vertical_cover] placeholderImage:BCImage(@"comic_list_placeholder_162x216_")];
        
        self.titleLabel.text = _rankData.title;
        self.srcLabel.text = [_rankData.author componentsJoinedByString:@" "];
        NSMutableArray *types = [NSMutableArray array];
        for (RankStyles *type in _rankData.styles) {
            [types addObject:type.name];
        }
        self.typeLabel.text = [types componentsJoinedByString:@" "];
        NSString *updateStr = _rankData.last_short_title;
        BOOL pureNum = [updateStr mj_isPureInt];
        self.updateLabel.text = [NSString stringWithFormat:pureNum?@"更新至%@话":@"更新至%@",_rankData.last_short_title];
    }
}

-(void)setFansComics:(RankComics *)fansComics
{
    if (fansComics && _fansComics != fansComics) {
        _fansComics = fansComics;
        
        [self.comicView sd_setFadeImageWithURL:[NSURL URLWithString:_fansComics.vertical_cover] placeholderImage:BCImage(@"comic_list_placeholder_162x216_")];
        
        self.titleLabel.text = _fansComics.title;
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
        _comicView = [UIImageView fadeImageView];
        _comicView.backgroundColor = DefaultBorderColor;
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
