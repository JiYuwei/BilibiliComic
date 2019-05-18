//
//  RankFansView.m
//  BilibiliComic
//
//  Created by 纪宇伟 on 2019/5/18.
//  Copyright © 2019 jyw. All rights reserved.
//

#import "RankFansView.h"
#import "RankListModel.h"

@interface RankFansView ()

@property (nonatomic,strong) UIImageView *fansCrown;
@property (nonatomic,strong) UILabel     *fansLabel;
@property (nonatomic,strong) NSMutableArray <UIImageView *> *fansAvatars;
@property (nonatomic,strong) UIImageView *fansArrow;

@property (nonatomic,assign,readonly) CGFloat realWidth;

@end

@implementation RankFansView
{
    CGFloat _realWidth;
}

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
            make.size.mas_equalTo(CGSizeMake(self.realWidth, self.realWidth));
        }];
        
        lastView = view;
    }];
    
    [self.fansArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.realWidth, self.realWidth));
    }];
}

#pragma mark - Setter

-(void)setUsers:(NSArray<Reward_users *> *)users
{
    if (users && _users != users) {
        _users = users;
        
        @weakify(self)
        [self.fansAvatars enumerateObjectsUsingBlock:^(UIImageView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
            @strongify(self)
            if (idx < self->_users.count) {
                NSString *avatarURL = self->_users[idx].avatar;
                [view sd_setFadeImageWithURL:[NSURL URLWithString:avatarURL]];
            }
        }];
    }
}

-(void)setArrowDirection:(NSInteger)arrowDirection
{
    _arrowDirection = arrowDirection;
    
    if (_arrowDirection < 0) {
        self.fansArrow.image = BCImage(@"sort_up_icon_24x24_");
    }
    else if (_arrowDirection == 0) {
        self.fansArrow.image = BCImage(@"sort_equal_icon_24x24_");
    }
    else if (_arrowDirection > 0) {
        self.fansArrow.image = BCImage(@"sort_down_icon_24x24_");
    }
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
            fansAvatar.layer.cornerRadius = self.realWidth / 2;
            fansAvatar.layer.masksToBounds = YES;
            [self addSubview:fansAvatar];
            [_fansAvatars addObject:fansAvatar];
        }
    }
    return _fansAvatars;
}

-(UIImageView *)fansArrow
{
    if (!_fansArrow) {
        _fansArrow = [[UIImageView alloc] init];
        [self addSubview:_fansArrow];
    }
    return _fansArrow;
}

-(CGFloat)realWidth
{
    if (_realWidth == 0) {
        _realWidth = (FansViewHeight) * (BC_SCREEN_WIDTH / 414);
    }
    return _realWidth;
}

@end
