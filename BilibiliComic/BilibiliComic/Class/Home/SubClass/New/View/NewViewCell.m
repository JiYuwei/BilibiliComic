//
//  NewViewCell.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/21.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "NewViewCell.h"

static const CGFloat TitleFont = 17;
static const CGFloat TypeFont  = 15;

@interface NewViewCell ()

@property (nonatomic,strong) UIImageView *comicView;
@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UILabel     *typeLabel;

@end

@implementation NewViewCell

+(CGFloat)rowHeightForObject:(id)object inColumnWidth:(CGFloat)columnWidth
{
    CGFloat height = columnWidth * 1.33 + (TitleFont + TypeFont + 10);
    return height;
}

-(void)setIndex:(NSInteger)index
{
    [super setIndex:index];
    
    BOOL left = !(self.index % 2);
    
    [self.comicView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(left ? 10 : 5);
        make.right.equalTo(self).offset(left ? -5 : -10);
        make.height.mas_equalTo(self.comicView.mas_width).multipliedBy(1.33);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.comicView.mas_bottom).offset(10);
        make.left.equalTo(self).offset(left ? 10 : 5);
        make.right.equalTo(self).offset(left ? -5 : -10);
        make.height.mas_equalTo(TitleFont + 3);
    }];
    
    [self.typeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self).offset(left ? 10 : 5);
        make.right.equalTo(self).offset(left ? -5 : -10);
        make.height.mas_equalTo(TypeFont + 3);
    }];
    
    self.titleLabel.text = @"打工吧，魔王大人！";
    self.typeLabel.text = @"热血 奇幻";
}

#pragma mark - LazyLoad

-(UIImageView *)comicView
{
    if (!_comicView) {
        _comicView = [[UIImageView alloc] init];
        _comicView.backgroundColor = GRandomColor;
        _comicView.layer.cornerRadius = 5;
        _comicView.layer.masksToBounds = YES;
        [self addSubview:_comicView];
    }
    return _comicView;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:TitleFont];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:TypeFont];
        _typeLabel.textColor = DefaultContentLightColor;
        [self addSubview:_typeLabel];
    }
    return _typeLabel;
}

@end
