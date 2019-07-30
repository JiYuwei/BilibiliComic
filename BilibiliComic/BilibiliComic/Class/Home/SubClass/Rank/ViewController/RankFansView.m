//
//  RankFansView.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/18.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RankFansView.h"

@interface RankFansView ()

@property (nonatomic,strong) UIImageView *fansCrown;
@property (nonatomic,strong) UILabel     *fansLabel;

@end

static CGFloat _realWidth = 0;

@implementation RankFansView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self cusLayoutAllSubViews];
    }
    return self;
}

-(void)cusLayoutAllSubViews
{
    [self.fansCrown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self).offset(-3);
        make.size.mas_equalTo(CGSizeMake(FansViewHeight / 2, FansViewHeight / 2));
    }];
    
    [self.fansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fansCrown.mas_right).offset(5);
        make.bottom.equalTo(self).offset(-3);
        make.height.mas_equalTo(FansViewHeight / 2);
    }];
    
    __block UIImageView *lastView = nil;
    [self.fansAvatars enumerateObjectsUsingBlock:^(UIImageView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastView ? lastView.mas_right : self.fansLabel.mas_right).offset(lastView ? 3 : 0);
            make.bottom.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(RankFansView.realWidth, RankFansView.realWidth));
        }];
        
        lastView = view;
    }];
}

#pragma mark - LazyLoad

-(UIImageView *)fansCrown
{
    if (!_fansCrown) {
        _fansCrown = [[UIImageView alloc] initWithImage:BCImage(@"detail_feed_icon_24x24_")];
        [self addSubview:_fansCrown];
    }
    return _fansCrown;
}

-(UILabel *)fansLabel
{
    if (!_fansLabel) {
        _fansLabel = [[UILabel alloc] init];
        _fansLabel.textColor = RGBColor(198, 154, 118);
        _fansLabel.font = [UIFont systemFontOfSize:13];
        _fansLabel.text = @"最佳助攻：";
        [self addSubview:_fansLabel];
    }
    return _fansLabel;
}

-(NSMutableArray<UIImageView *> *)fansAvatars
{
    if (!_fansAvatars) {
        CGFloat screenWidth = BC_SCREEN_WIDTH;
        NSUInteger capacity = (screenWidth <= 320) ? 1 : 3;
        _fansAvatars = [NSMutableArray arrayWithCapacity:capacity];
        for (NSInteger i = 0; i < capacity; i++) {
            UIImageView *fansAvatar = [[UIImageView alloc] init];
            fansAvatar.layer.cornerRadius = RankFansView.realWidth / 2;
            fansAvatar.layer.masksToBounds = YES;
            fansAvatar.layer.borderColor = DefaultBorderColor.CGColor;
            fansAvatar.layer.borderWidth = 0.5;
            [self addSubview:fansAvatar];
            [_fansAvatars addObject:fansAvatar];
        }
    }
    return _fansAvatars;
}

+(CGFloat)realWidth
{
    if (_realWidth == 0) {
        _realWidth = (FansViewHeight) * (BC_SCREEN_WIDTH / 414);
    }
    return _realWidth;
}

@end
